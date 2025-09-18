package Modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import Config.conexion;

public class DAOUsuario extends conexion {

    // ==============================
    // MÉTODO LOGIN / IDENTIFICAR USUARIO
    // ==============================
    public Usuario identificar(Usuario user) throws Exception {
        Usuario usu = null;
        String sql = "SELECT U.IDUsuario, U.Nombre, U.Apellido, U.Correo, U.DNI, U.Telefono, "
                   + "R.IDRol, R.NombreRol "
                   + "FROM Usuarios U "
                   + "INNER JOIN Roles R ON U.IDRol = R.IDRol "
                   + "WHERE U.Correo = ? AND U.Contrasena = ?";

        try (Connection cn = conexion.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, user.getCorreo());
            ps.setString(2, user.getContrasena());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usu = new Usuario();
                    usu.setIdUsuario(rs.getInt("IDUsuario"));
                    usu.setNombre(rs.getString("Nombre"));
                    usu.setApellido(rs.getString("Apellido"));
                    usu.setCorreo(rs.getString("Correo"));
                    usu.setDni(rs.getString("DNI"));
                    usu.setTelefono(rs.getString("Telefono"));

                    Rol rol = new Rol();
                    rol.setIdRol(rs.getInt("IDRol"));
                    rol.setNombreRol(rs.getString("NombreRol"));
                    usu.setRol(rol);
                }
            }
        } catch (Exception e) {
            System.err.println("Error en identificar usuario: " + e.getMessage());
            throw e; 
        }
        return usu;
    }

    // ==============================
    // LISTAR TODOS LOS USUARIOS
    // ==============================
    public ArrayList<Usuario> listarUsuarios() {
        ArrayList<Usuario> lista = new ArrayList<>();
        String sql = "SELECT U.IDUsuario, U.Nombre, U.Apellido, U.Correo, U.DNI, U.Telefono, "
                   + "R.IDRol, R.NombreRol "
                   + "FROM Usuarios U "
                   + "INNER JOIN Roles R ON U.IDRol = R.IDRol "
                   + "ORDER BY U.IDUsuario";

        try (Connection cn = conexion.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario usu = new Usuario();
                usu.setIdUsuario(rs.getInt("IDUsuario"));
                usu.setNombre(rs.getString("Nombre"));
                usu.setApellido(rs.getString("Apellido"));
                usu.setCorreo(rs.getString("Correo"));
                usu.setDni(rs.getString("DNI"));
                usu.setTelefono(rs.getString("Telefono"));

                Rol rol = new Rol();
                rol.setIdRol(rs.getInt("IDRol"));
                rol.setNombreRol(rs.getString("NombreRol"));
                usu.setRol(rol);

                lista.add(usu);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lista;
    }
}

