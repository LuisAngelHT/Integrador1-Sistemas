package Controladores;

import Modelo.DAOEstadisticas;
import Modelo.Paciente;
import Modelo.Usuario;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "srvDashboardAdmin", urlPatterns = {"/srvDashboardAdmin"})
public class srvDashboardAdmin extends HttpServlet {

    private static final String DASHBOARD_PAGE = "/vistas/admin/dashboard.jsp";
    private static final String LOGIN_PAGE = "vistaLogin.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(LOGIN_PAGE);
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario.getRol() == null || usuario.getRol().getIdRol() != 1) {
            request.setAttribute("error", "Acceso denegado. Solo administradores.");
            request.getRequestDispatcher(LOGIN_PAGE).forward(request, response);
            return;
        }

        String accion = request.getParameter("accion");

        try {
            if (accion == null || accion.equals("dashboard")) {
                cargarDashboard(request, response);
            } else {
                cargarDashboard(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error en srvDashboardAdmin: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar el dashboard: " + e.getMessage());
            request.getRequestDispatcher(DASHBOARD_PAGE).forward(request, response);
        }
    }

    private void cargarDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            DAOEstadisticas dao = new DAOEstadisticas();

            int totalCitasHoy = dao.getTotalCitasHoy();
            int totalPacientes = dao.getTotalPacientes();
            int totalMedicos = dao.getTotalMedicosActivos();
            int totalNoMedicos = dao.getTotalNoMedicosActivos();
            int citasPendientes = dao.getCitasPendientes();
            int pacientesEsteMes = dao.getPacientesEsteMes();

            ArrayList<Map<String, Object>> citasHoy = dao.getCitasHoy();
            ArrayList<Paciente> pacientesRecientes = dao.getPacientesRecientes(5);
            Map<String, Integer> citasPorEstado = dao.getCitasPorEstado();
            ArrayList<Map<String, Object>> profesionalesMedicos = dao.getProfesionalesMedicos();
            ArrayList<Map<String, Object>> profesionalesNoMedicos = dao.getProfesionalesNoMedicos();

            request.setAttribute("totalCitasHoy", totalCitasHoy);
            request.setAttribute("totalPacientes", totalPacientes);
            request.setAttribute("totalMedicos", totalMedicos);
            request.setAttribute("totalNoMedicos", totalNoMedicos);
            request.setAttribute("citasPendientes", citasPendientes);
            request.setAttribute("pacientesEsteMes", pacientesEsteMes);

            request.setAttribute("citasHoy", citasHoy);
            request.setAttribute("pacientesRecientes", pacientesRecientes);
            request.setAttribute("citasPorEstado", citasPorEstado);
            request.setAttribute("profesionalesMedicos", profesionalesMedicos);
            request.setAttribute("profesionalesNoMedicos", profesionalesNoMedicos);

            request.getRequestDispatcher(DASHBOARD_PAGE).forward(request, response);

        } catch (Exception e) {
            System.err.println("Error al cargar dashboard: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error al cargar estadísticas", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para el panel de administración - Dashboard";
    }
}