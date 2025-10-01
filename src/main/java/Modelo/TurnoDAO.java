package Modelo;

import Config.conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TurnoDAO extends conexion {

    // --- 1. Listar Turnos ---
    public ArrayList<Turno> listar() {
        ArrayList<Turno> lista = new ArrayList<>();

        String sql = "SELECT t.IDTurno, t.DiaSemana, t.HoraInicio, t.HoraFin, u.Nombre, u.Apellido, p.IDProfesional "
                + "FROM Turnos t "
                + "INNER JOIN Profesionales p ON t.IDProfesional = p.IDProfesional "
                + "INNER JOIN Usuarios u ON p.IDUsuario = u.IDUsuario "
                + "ORDER BY t.IDProfesional, FIELD(t.DiaSemana, 'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'), t.HoraInicio";

        try (Connection cn = conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Turno turno = new Turno();
                turno.setIdTurno(rs.getInt("IDTurno"));
                turno.setIdProfesional(rs.getInt("IDProfesional"));
                turno.setDiaSemana(rs.getString("DiaSemana"));
                turno.setHoraInicio(rs.getString("HoraInicio"));
                turno.setHoraFin(rs.getString("HoraFin"));

                String nombreProf = rs.getString("Nombre") + " " + rs.getString("Apellido");
                turno.setNombreProfesional(nombreProf);

                lista.add(turno);
            }
        } catch (SQLException ex) {
            System.err.println("Error SQL al listar turnos: " + ex.getMessage());
        }
        return lista;
    }

    // --- 2. Registrar un nuevo Turno ---
    public int registrar(Turno turno) {
        int result = 0;
        String sql = "INSERT INTO Turnos (IDProfesional, DiaSemana, HoraInicio, HoraFin) VALUES (?, ?, ?, ?)";

        try (Connection cn = conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, turno.getIdProfesional());
            ps.setString(2, turno.getDiaSemana());
            ps.setString(3, turno.getHoraInicio());
            ps.setString(4, turno.getHoraFin());

            result = ps.executeUpdate();

        } catch (SQLException ex) {
            if (ex.getErrorCode() == 1062) {
                return -2;
            }
            System.err.println("Error SQL al registrar turno: " + ex.getMessage());
        }
        return result;
    }

    // --- 3. Obtener un turno por ID ---
    public Turno obtenerPorId(int idTurno) {
        Turno turno = null;
        String sql = "SELECT t.IDTurno, t.IDProfesional, t.DiaSemana, t.HoraInicio, t.HoraFin, "
                + "CONCAT(u.Nombre, ' ', u.Apellido) as NombreProfesional "
                + "FROM Turnos t "
                + "INNER JOIN Profesionales p ON t.IDProfesional = p.IDProfesional "
                + "INNER JOIN Usuarios u ON p.IDUsuario = u.IDUsuario "
                + "WHERE t.IDTurno = ?";

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idTurno);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    turno = new Turno();
                    turno.setIdTurno(rs.getInt("IDTurno"));
                    turno.setIdProfesional(rs.getInt("IDProfesional"));
                    turno.setDiaSemana(rs.getString("DiaSemana"));
                    turno.setHoraInicio(rs.getString("HoraInicio"));
                    turno.setHoraFin(rs.getString("HoraFin"));
                    turno.setNombreProfesional(rs.getString("NombreProfesional"));
                }
            }
        } catch (SQLException ex) {
            System.err.println("Error al obtener turno: " + ex.getMessage());
        }
        return turno;
    }

    // --- 4. Actualizar un turno existente ---
    public int actualizar(Turno turno) {
        int result = 0;
        String sql = "UPDATE Turnos SET IDProfesional=?, DiaSemana=?, HoraInicio=?, HoraFin=? WHERE IDTurno=?";

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, turno.getIdProfesional());
            ps.setString(2, turno.getDiaSemana());
            ps.setString(3, turno.getHoraInicio());
            ps.setString(4, turno.getHoraFin());
            ps.setInt(5, turno.getIdTurno());

            result = ps.executeUpdate();

        } catch (SQLException ex) {
            if (ex.getErrorCode() == 1062) {
                return -2; // Duplicado
            }
            System.err.println("Error al actualizar turno: " + ex.getMessage());
        }
        return result;
    }

    // --- 5. Eliminar turno ---
    public int eliminar(int idTurno) {
        int result = 0;
        String sql = "DELETE FROM Turnos WHERE IDTurno = ?";

        try (Connection cn = conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idTurno);
            result = ps.executeUpdate();

        } catch (SQLException ex) {
            if (ex.getErrorCode() == 1451) {
                return -1;
            }
            System.err.println("Error SQL al eliminar turno: " + ex.getMessage());
        }
        return result;
    }

    // --- 6. Filtrar turnos por turno (mañana/tarde) ---
    public ArrayList<Turno> filtrarPorTurno(String tipoTurno) {
        ArrayList<Turno> lista = new ArrayList<>();
        String condicionHora = "";

        // Mañana: 06:00 - 12:59, Tarde: 13:00 - 20:00
        if ("manana".equalsIgnoreCase(tipoTurno)) {
            condicionHora = "AND t.HoraInicio >= '06:00:00' AND t.HoraInicio < '13:00:00'";
        } else if ("tarde".equalsIgnoreCase(tipoTurno)) {
            condicionHora = "AND t.HoraInicio >= '13:00:00' AND t.HoraInicio <= '20:00:00'";
        }

        String sql = "SELECT t.IDTurno, t.DiaSemana, t.HoraInicio, t.HoraFin, u.Nombre, u.Apellido, p.IDProfesional "
                + "FROM Turnos t "
                + "INNER JOIN Profesionales p ON t.IDProfesional = p.IDProfesional "
                + "INNER JOIN Usuarios u ON p.IDUsuario = u.IDUsuario "
                + "WHERE 1=1 " + condicionHora + " "
                + "ORDER BY t.IDProfesional, FIELD(t.DiaSemana, 'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'), t.HoraInicio";

        try (Connection cn = conexion.getConnection(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Turno turno = new Turno();
                turno.setIdTurno(rs.getInt("IDTurno"));
                turno.setIdProfesional(rs.getInt("IDProfesional"));
                turno.setDiaSemana(rs.getString("DiaSemana"));
                turno.setHoraInicio(rs.getString("HoraInicio"));
                turno.setHoraFin(rs.getString("HoraFin"));

                String nombreProf = rs.getString("Nombre") + " " + rs.getString("Apellido");
                turno.setNombreProfesional(nombreProf);

                lista.add(turno);
            }
        } catch (SQLException ex) {
            System.err.println("Error al filtrar turnos: " + ex.getMessage());
        }
        return lista;
    }

    // --- 7. Listar profesionales por rol (2 y 3) ---
    public ArrayList<Profesional> listarPorRol(int... roles) {
        ArrayList<Profesional> lista = new ArrayList<>();

        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < roles.length; i++) {
            placeholders.append("?");
            if (i < roles.length - 1) {
                placeholders.append(",");
            }
        }

        String sql = "SELECT p.IDProfesional, CONCAT(u.Nombre, ' ', u.Apellido) as NombreCompleto "
                + "FROM Profesionales p "
                + "INNER JOIN Usuarios u ON p.IDUsuario = u.IDUsuario "
                + "WHERE u.idRol IN (" + placeholders + ") "
                + "ORDER BY NombreCompleto";

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {

            for (int i = 0; i < roles.length; i++) {
                ps.setInt(i + 1, roles[i]);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Profesional prof = new Profesional();
                    prof.setIdProfesional(rs.getInt("IDProfesional"));
                    prof.setNombreCompleto(rs.getString("NombreCompleto"));
                    lista.add(prof);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al listar profesionales: " + e.getMessage());
        }
        return lista;
    }

    // --- 8. Listar turnos con filtros opcionales ---
    public ArrayList<Turno> listarConFiltros(String filtroIdProfesional, String filtroDiaSemana, String filtroTurno) {
        ArrayList<Turno> lista = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT t.IDTurno, t.DiaSemana, t.HoraInicio, t.HoraFin, u.Nombre, u.Apellido, p.IDProfesional ");
        sql.append("FROM Turnos t ");
        sql.append("INNER JOIN Profesionales p ON t.IDProfesional = p.IDProfesional ");
        sql.append("INNER JOIN Usuarios u ON p.IDUsuario = u.IDUsuario ");
        sql.append("WHERE 1=1 ");

        // Agregar condiciones dinámicas
        if (filtroIdProfesional != null && !filtroIdProfesional.isEmpty()) {
            sql.append("AND t.IDProfesional = ? ");
        }
        if (filtroDiaSemana != null && !filtroDiaSemana.isEmpty()) {
            sql.append("AND t.DiaSemana = ? ");
        }
        if (filtroTurno != null && !filtroTurno.isEmpty()) {
            if ("manana".equalsIgnoreCase(filtroTurno)) {
                sql.append("AND t.HoraInicio >= '08:00:00' AND t.HoraInicio < '12:00:00' ");
            } else if ("tarde".equalsIgnoreCase(filtroTurno)) {
                sql.append("AND t.HoraInicio >= '12:00:00' AND t.HoraInicio <= '18:00:00' ");
            }
        }

        sql.append("ORDER BY t.IDProfesional, FIELD(t.DiaSemana, 'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'), t.HoraInicio");

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(sql.toString())) {

            int paramIndex = 1;

            // Asignar valores a los parámetros según los filtros activos
            if (filtroIdProfesional != null && !filtroIdProfesional.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(filtroIdProfesional));
            }
            if (filtroDiaSemana != null && !filtroDiaSemana.isEmpty()) {
                ps.setString(paramIndex++, filtroDiaSemana);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Turno turno = new Turno();
                    turno.setIdTurno(rs.getInt("IDTurno"));
                    turno.setIdProfesional(rs.getInt("IDProfesional"));
                    turno.setDiaSemana(rs.getString("DiaSemana"));
                    turno.setHoraInicio(rs.getString("HoraInicio"));
                    turno.setHoraFin(rs.getString("HoraFin"));
                    turno.setNombreProfesional(rs.getString("Nombre") + " " + rs.getString("Apellido"));
                    lista.add(turno);
                }
            }
        } catch (SQLException ex) {
            System.err.println("Error al listar turnos con filtros: " + ex.getMessage());
            ex.printStackTrace();
        }

        return lista;
    }

}
