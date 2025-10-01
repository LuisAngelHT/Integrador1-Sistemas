package Modelo;

import Config.conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class PacienteDAO extends conexion {

    // Constante para definir el número de registros por página
    private static final int REGISTROS_POR_PAGINA = 10;

    // --- 1. Método para contar el total de registros ---
    public int contarPacientes(String dniBuscar) {
        String sql = "SELECT COUNT(*) FROM pacientes";

        // Si hay DNI, agregamos la cláusula WHERE
        if (dniBuscar != null && !dniBuscar.isEmpty()) {
            sql += " WHERE DNI LIKE ?";
        }

        int total = 0;
        try (Connection cn = conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

            if (dniBuscar != null && !dniBuscar.isEmpty()) {
                // Asignamos el DNI con comodines
                ps.setString(1, "%" + dniBuscar + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return total;
    }

    // --- 2. Método para listar pacientes con paginación ---
    public ArrayList<Paciente> listarPacientesPaginado(int offset, String dniBuscar) {
        ArrayList<Paciente> lista = new ArrayList<>();

        // Consulta SQL base: siempre paginada
        String sql = "SELECT * FROM pacientes ";

        // Si hay DNI, agregamos la cláusula WHERE
        if (dniBuscar != null && !dniBuscar.isEmpty()) {
            sql += "WHERE DNI LIKE ? "; // Usamos LIKE para ser más flexible, aunque con 8 dígitos puede ser =
        }

        // Agregar paginación al final
        sql += "LIMIT ? OFFSET ?";

        try (Connection cn = conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

            int paramIndex = 1;

            if (dniBuscar != null && !dniBuscar.isEmpty()) {
                // Asignamos el DNI con comodines para la búsqueda parcial
                ps.setString(paramIndex++, "%" + dniBuscar + "%");
            }

            ps.setInt(paramIndex++, REGISTROS_POR_PAGINA);
            ps.setInt(paramIndex++, offset);

            try (ResultSet rs = ps.executeQuery()) {
                // ... (Resto del código para llenar la lista 'pac' es el mismo)
                while (rs.next()) {
                    Paciente pac = new Paciente();
                    pac.setIdPaciente(rs.getInt("IDPaciente"));
                    pac.setNombre(rs.getString("Nombre"));
                    pac.setApellido(rs.getString("Apellido"));
                    pac.setDni(rs.getString("DNI"));
                    pac.setNacimiento(rs.getString("FechaNacimiento"));
                    pac.setSexo(rs.getString("Sexo"));
                    pac.setTelefono(rs.getString("Telefono"));
                    pac.setDireccion(rs.getString("Direccion"));
                    lista.add(pac);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lista;
    }

    public int registrar(Paciente pac) {
        int result = 0;
        try (Connection cn = conexion.getConnection()) {
            String sql = "INSERT INTO pacientes (Nombre,Apellido,DNI,FechaNacimiento,Sexo,Telefono,Direccion) VALUES (?,?,?,?,?,?,?)";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, pac.getNombre());
            ps.setString(2, pac.getApellido());
            ps.setString(3, pac.getDni());
            ps.setString(4, pac.getNacimiento());
            ps.setString(5, pac.getSexo());
            ps.setString(6, pac.getTelefono());
            ps.setString(7, pac.getDireccion());
            result = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return result;
    }
    public int eliminar(int idPaciente) {
        int result = 0;
        try (Connection cn = conexion.getConnection()) {
            String sql = "DELETE FROM pacientes WHERE IDPaciente = ?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setInt(1, idPaciente);
            result = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return result;
    }
}
