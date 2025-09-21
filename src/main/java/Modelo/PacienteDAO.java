
package Modelo;

import Config.conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class PacienteDAO extends conexion{
    public ArrayList<Paciente> listarPacientes() {
        ArrayList<Paciente> lista = new ArrayList<>();
        String sql = "SELECT * FROM pacientes";

        try (Connection cn = conexion.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

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
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lista;
    }
}
