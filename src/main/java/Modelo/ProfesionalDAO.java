package Modelo;

import Config.conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProfesionalDAO extends conexion {

    // --- Listar todos los profesionales ---
    public ArrayList<Profesional> listar() {
        ArrayList<Profesional> lista = new ArrayList<>();
        String sql = "SELECT p.IDProfesional, CONCAT(u.Nombre, ' ', u.Apellido) AS NombreCompleto "
                + "FROM Profesionales p "
                + "INNER JOIN Usuarios u ON p.IDUsuario = u.IDUsuario "
                + "ORDER BY NombreCompleto";

        try (Connection cn = getConnection(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Profesional prof = new Profesional();
                prof.setIdProfesional(rs.getInt("IDProfesional"));
                prof.setNombreCompleto(rs.getString("NombreCompleto"));
                lista.add(prof);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar profesionales: " + e.getMessage());
        }
        return lista;
    }

    // --- Listar profesionales por rol ---
    public ArrayList<Profesional> listarPorRol(int... roles) {
        ArrayList<Profesional> lista = new ArrayList<>();

        // Crear placeholders dinámicos
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
            System.err.println("Error al listar profesionales por rol: " + e.getMessage());
        }
        return lista;
    }
}

// Aquí irían otros métodos CRUD (registrar, actualizar, etc. de profesionales)
