package Controladores;

import Modelo.Turno;
import Modelo.TurnoDAO;
import Modelo.ProfesionalDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "srvTurno", urlPatterns = {"/srvTurno"})
public class srvTurno extends HttpServlet {

    private final TurnoDAO daoTurno = new TurnoDAO();
    private final ProfesionalDAO daoProfesional = new ProfesionalDAO();
    private final String PAG_LISTAR_TURNOS = "/vistas/admin/turnos.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        
        if (accion == null || accion.isEmpty()) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
            case "turnos":
                listarTurnos(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            default:
                listarTurnos(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        switch (accion) {
            case "registrar":
                registrar(request, response);
                break;
            case "actualizar":
                actualizar(request, response);
                break;
            default:
                response.sendRedirect("srvTurno?accion=listar");
                break;
        }
    }

    private void listarTurnos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filtroIdProfesional = request.getParameter("filtroIdProfesional");
        String filtroDiaSemana = request.getParameter("filtroDiaSemana");
        String filtroTurno = request.getParameter("filtroTurno");
        
        boolean hayFiltros = (filtroIdProfesional != null && !filtroIdProfesional.isEmpty()) ||
                             (filtroDiaSemana != null && !filtroDiaSemana.isEmpty()) ||
                             (filtroTurno != null && !filtroTurno.isEmpty());
        
        List<Turno> turnos;
        
        if (hayFiltros) {
            turnos = daoTurno.listarConFiltros(filtroIdProfesional, filtroDiaSemana, filtroTurno);
        } else {
            turnos = daoTurno.listar();
        }
        
        request.setAttribute("turnos", turnos);
        request.setAttribute("profesionales", daoProfesional.listarPorRol(2, 3));
        
        request.getRequestDispatcher(PAG_LISTAR_TURNOS).forward(request, response);
    }

    private void registrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int idProfesional = Integer.parseInt(request.getParameter("idProfesional"));
            String diaSemana = request.getParameter("diaSemana");
            String horaInicio = request.getParameter("horaInicio");
            String horaFin = request.getParameter("horaFin");

            if (diaSemana == null || horaInicio == null || horaFin == null ||
                diaSemana.isEmpty() || horaInicio.isEmpty() || horaFin.isEmpty()) {
                request.getSession().setAttribute("mensaje", "Todos los campos son obligatorios.");
                request.getSession().setAttribute("tipoMensaje", "warning");
            } else if (horaInicio.compareTo(horaFin) >= 0) {
                request.getSession().setAttribute("mensaje", "La hora de inicio debe ser menor que la hora fin.");
                request.getSession().setAttribute("tipoMensaje", "warning");
            } else {
                Turno turno = new Turno();
                turno.setIdProfesional(idProfesional);
                turno.setDiaSemana(diaSemana);
                turno.setHoraInicio(horaInicio);
                turno.setHoraFin(horaFin);

                int result = daoTurno.registrar(turno);

                if (result > 0) {
                    request.getSession().setAttribute("mensaje", "Turno registrado exitosamente.");
                    request.getSession().setAttribute("tipoMensaje", "success");
                } else if (result == -2) {
                    request.getSession().setAttribute("mensaje", "Ya existe un turno con esos datos.");
                    request.getSession().setAttribute("tipoMensaje", "warning");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al registrar turno.");
                    request.getSession().setAttribute("tipoMensaje", "danger");
                }
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("mensaje", "Error en los datos proporcionados.");
            request.getSession().setAttribute("tipoMensaje", "danger");
        }

        response.sendRedirect("srvTurno?accion=listar");
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int idTurno = Integer.parseInt(request.getParameter("idTurno"));
            int idProfesional = Integer.parseInt(request.getParameter("idProfesional"));
            String diaSemana = request.getParameter("diaSemana");
            String horaInicio = request.getParameter("horaInicio");
            String horaFin = request.getParameter("horaFin");

            if (diaSemana == null || horaInicio == null || horaFin == null ||
                diaSemana.isEmpty() || horaInicio.isEmpty() || horaFin.isEmpty()) {
                request.getSession().setAttribute("mensaje", "Todos los campos son obligatorios.");
                request.getSession().setAttribute("tipoMensaje", "warning");
            } else if (horaInicio.compareTo(horaFin) >= 0) {
                request.getSession().setAttribute("mensaje", "La hora de inicio debe ser menor que la hora fin.");
                request.getSession().setAttribute("tipoMensaje", "warning");
            } else {
                Turno turno = new Turno();
                turno.setIdTurno(idTurno);
                turno.setIdProfesional(idProfesional);
                turno.setDiaSemana(diaSemana);
                turno.setHoraInicio(horaInicio);
                turno.setHoraFin(horaFin);

                int result = daoTurno.actualizar(turno);

                if (result > 0) {
                    request.getSession().setAttribute("mensaje", "Turno actualizado exitosamente.");
                    request.getSession().setAttribute("tipoMensaje", "success");
                } else if (result == -2) {
                    request.getSession().setAttribute("mensaje", "Ya existe un turno con esos datos.");
                    request.getSession().setAttribute("tipoMensaje", "warning");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al actualizar turno.");
                    request.getSession().setAttribute("tipoMensaje", "danger");
                }
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("mensaje", "Error en los datos proporcionados.");
            request.getSession().setAttribute("tipoMensaje", "danger");
        }

        response.sendRedirect("srvTurno?accion=listar");
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idTurno = Integer.parseInt(request.getParameter("id"));
            int result = daoTurno.eliminar(idTurno);

            if (result > 0) {
                request.getSession().setAttribute("mensaje", "Turno eliminado exitosamente.");
                request.getSession().setAttribute("tipoMensaje", "success");
            } else if (result == -1) {
                request.getSession().setAttribute("mensaje", "No se puede eliminar. Tiene citas asociadas.");
                request.getSession().setAttribute("tipoMensaje", "warning");
            } else {
                request.getSession().setAttribute("mensaje", "Error al eliminar turno.");
                request.getSession().setAttribute("tipoMensaje", "danger");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("mensaje", "ID de turno inválido.");
            request.getSession().setAttribute("tipoMensaje", "danger");
        }

        response.sendRedirect("srvTurno?accion=listar");
    }
}