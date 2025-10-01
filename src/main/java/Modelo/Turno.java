package Modelo;

public class Turno {

    private int idTurno;
    private int idProfesional;
    private String diaSemana;   // Corresponde al ENUM de la BD
    private String horaInicio;  // Usamos String para el formato TIME
    private String horaFin;     // Usamos String para el formato TIME

    // Campo extra para mostrar el nombre del profesional en el JSP
    private String nombreProfesional;

    public Turno() {
    }

    // Getters y Setters
    public int getIdTurno() {
        return idTurno;
    }
    // ... otros getters y setters básicos ...

    public void setIdTurno(int idTurno) {
        this.idTurno = idTurno;
    }

    public int getIdProfesional() {
        return idProfesional;
    }

    public void setIdProfesional(int idProfesional) {
        this.idProfesional = idProfesional;
    }

    public String getDiaSemana() {
        return diaSemana;
    }

    public void setDiaSemana(String diaSemana) {
        this.diaSemana = diaSemana;
    }

    public String getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(String horaInicio) {
        this.horaInicio = horaInicio;
    }

    public String getHoraFin() {
        return horaFin;
    }

    public void setHoraFin(String horaFin) {
        this.horaFin = horaFin;
    }

    public String getNombreProfesional() {
        return nombreProfesional;
    }

    public void setNombreProfesional(String nombreProfesional) {
        this.nombreProfesional = nombreProfesional;
    }
}
