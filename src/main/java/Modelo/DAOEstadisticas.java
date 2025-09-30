package Modelo;

import Config.conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class DAOEstadisticas extends conexion {
    
    // ==============================
    // MÉTODO AUXILIAR PRIVADO (DRY)
    // ==============================
    private int getCount(String sql, String errorMsg) {
        int total = 0;
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
            System.err.println(errorMsg + e.getMessage());
            e.printStackTrace();
        }
        return total;
    }

    // ==============================
    // ESTADÍSTICAS GENERALES
    // ==============================
    
    public int getTotalCitasHoy() {
        String sql = "SELECT COUNT(*) as total FROM Citas WHERE FechaCita = CURDATE()";
        return getCount(sql, "Error en getTotalCitasHoy: ");
    }
    
    public int getTotalPacientes() {
        String sql = "SELECT COUNT(*) as total FROM Pacientes";
        return getCount(sql, "Error en getTotalPacientes: ");
    }
    
    public int getTotalMedicosActivos() {
        String sql = "SELECT COUNT(DISTINCT p.IDProfesional) as total " +
                     "FROM Profesionales p " +
                     "INNER JOIN Usuarios u ON p.IDUsuario = u.IDUsuario " +
                     "WHERE (u.Estado = 1 AND u.IDRol IN (2,3))";
        return getCount(sql, "Error en getTotalMedicosActivos: ");
    }
    
    public int getTotalNoMedicosActivos() {
        String sql = "SELECT COUNT(DISTINCT p.IDProfesional) as total " +
                     "FROM Profesionales p " +
                     "INNER JOIN Usuarios u ON p.IDUsuario = u.IDUsuario " +
                     "WHERE u.Estado = 1 AND u.IDRol = 3";
        return getCount(sql, "Error en getTotalNoMedicosActivos: ");
    }
    
    public int getCitasPendientes() {
        String sql = "SELECT COUNT(*) as total FROM Citas WHERE Estado = 'Pendiente'";
        return getCount(sql, "Error en getCitasPendientes: ");
    }
    
    public int getPacientesEsteMes() {
        String sql = "SELECT COUNT(*) as total FROM (" +
                     "  SELECT IDPaciente FROM Pacientes " +
                     "  ORDER BY IDPaciente DESC LIMIT 30" +
                     ") as ultimos";
        return getCount(sql, "Error en getPacientesEsteMes: ");
    }
    
    // ==============================
    // CITAS DEL DÍA
    // ==============================
    
    public ArrayList<Map<String, Object>> getCitasHoy() {
        ArrayList<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT c.IDCita, c.HoraCita, c.Estado, " +
                     "CONCAT(p.Nombre, ' ', p.Apellido) as NombrePaciente, " +
                     "CONCAT(u.Nombre, ' ', u.Apellido) as NombreProfesional, " +
                     "e.NombreEspecialidad " +
                     "FROM Citas c " +
                     "INNER JOIN Pacientes p ON c.IDPaciente = p.IDPaciente " +
                     "INNER JOIN Profesionales pr ON c.IDProfesional = pr.IDProfesional " +
                     "INNER JOIN Usuarios u ON pr.IDUsuario = u.IDUsuario " +
                     "INNER JOIN Especialidades e ON pr.IDEspecialidad = e.IDEspecialidad " +
                     "WHERE c.FechaCita = CURDATE() " +
                     "ORDER BY c.HoraCita";
        
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> cita = new HashMap<>();
                cita.put("IDCita", rs.getInt("IDCita"));
                cita.put("HoraCita", rs.getTime("HoraCita"));
                cita.put("Estado", rs.getString("Estado"));
                cita.put("NombrePaciente", rs.getString("NombrePaciente"));
                cita.put("NombreProfesional", rs.getString("NombreProfesional"));
                cita.put("NombreEspecialidad", rs.getString("NombreEspecialidad"));
                lista.add(cita);
            }
        } catch (Exception e) {
            System.err.println("Error en getCitasHoy: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }
    
    // ==============================
    // PACIENTES RECIENTES
    // ==============================
    
    public ArrayList<Paciente> getPacientesRecientes(int limite) {
        ArrayList<Paciente> lista = new ArrayList<>();
        String sql = "SELECT IDPaciente, Nombre, Apellido, DNI, FechaNacimiento, Sexo, Telefono, Direccion " +
                     "FROM Pacientes " +
                     "ORDER BY IDPaciente DESC " +
                     "LIMIT ?";
        
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            
            ps.setInt(1, limite);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Paciente p = new Paciente();
                    p.setIdPaciente(rs.getInt("IDPaciente"));
                    p.setNombre(rs.getString("Nombre"));
                    p.setApellido(rs.getString("Apellido"));
                    p.setDni(rs.getString("DNI"));
                    p.setNacimiento(rs.getString("FechaNacimiento"));
                    p.setSexo(rs.getString("Sexo"));
                    p.setTelefono(rs.getString("Telefono"));
                    p.setDireccion(rs.getString("Direccion"));
                    lista.add(p);
                }
            }
        } catch (Exception e) {
            System.err.println("Error en getPacientesRecientes: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }
    
    // ==============================
    // CITAS POR ESTADO
    // ==============================
    
    public Map<String, Integer> getCitasPorEstado() {
        Map<String, Integer> stats = new HashMap<>();
        String sql = "SELECT Estado, COUNT(*) as total FROM Citas GROUP BY Estado";
        
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                stats.put(rs.getString("Estado"), rs.getInt("total"));
            }
        } catch (Exception e) {
            System.err.println("Error en getCitasPorEstado: " + e.getMessage());
            e.printStackTrace();
        }
        return stats;
    }
    
    // ==============================
    // PROFESIONALES POR TIPO
    // ==============================
    
    public ArrayList<Map<String, Object>> getProfesionalesMedicos() {
        ArrayList<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT p.IDProfesional, " +
                     "CONCAT(u.Nombre, ' ', u.Apellido) as NombreCompleto, " +
                     "e.NombreEspecialidad, u.Telefono " +
                     "FROM Profesionales p " +
                     "INNER JOIN Usuarios u ON p.IDUsuario = u.IDUsuario " +
                     "INNER JOIN Especialidades e ON p.IDEspecialidad = e.IDEspecialidad " +
                     "WHERE u.Estado = 1 AND u.IDRol = 2 " +
                     "ORDER BY u.Apellido, u.Nombre";
        
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> prof = new HashMap<>();
                prof.put("IDProfesional", rs.getInt("IDProfesional"));
                prof.put("NombreCompleto", rs.getString("NombreCompleto"));
                prof.put("NombreEspecialidad", rs.getString("NombreEspecialidad"));
                prof.put("Telefono", rs.getString("Telefono"));
                lista.add(prof);
            }
        } catch (Exception e) {
            System.err.println("Error en getProfesionalesMedicos: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }
    
    public ArrayList<Map<String, Object>> getProfesionalesNoMedicos() {
        ArrayList<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT p.IDProfesional, " +
                     "CONCAT(u.Nombre, ' ', u.Apellido) as NombreCompleto, " +
                     "e.NombreEspecialidad, u.Telefono " +
                     "FROM Profesionales p " +
                     "INNER JOIN Usuarios u ON p.IDUsuario = u.IDUsuario " +
                     "INNER JOIN Especialidades e ON p.IDEspecialidad = e.IDEspecialidad " +
                     "WHERE u.Estado = 1 AND u.IDRol = 3 " +
                     "ORDER BY u.Apellido, u.Nombre";
        
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> prof = new HashMap<>();
                prof.put("IDProfesional", rs.getInt("IDProfesional"));
                prof.put("NombreCompleto", rs.getString("NombreCompleto"));
                prof.put("NombreEspecialidad", rs.getString("NombreEspecialidad"));
                prof.put("Telefono", rs.getString("Telefono"));
                lista.add(prof);
            }
        } catch (Exception e) {
            System.err.println("Error en getProfesionalesNoMedicos: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }
}