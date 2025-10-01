package Controladores;

import Modelo.*;
import Modelo.PacienteDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ControladorPaciente", urlPatterns = {"/ControladorPaciente"})
public class ControladorPaciente extends HttpServlet {

    private PacienteDAO Daopac = new PacienteDAO();
    private final String pagListarPacientes = "/vistas/admin/listarPacientes.jsp";
    private final String pagPrincipal = "/vistas/admin/vistaAdmin.jsp";

    // Constante local (puede estar en el DAO o aquí, pero debe ser consistente)
    private static final int REGISTROS_POR_PAGINA = 10;

    // Mantenemos processRequest como está, pero actualizamos la llamada a listarPacientes
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) { // Para la entrada inicial, evita NullPointerException
            accion = "listarPacientes";
        }

        switch (accion){
            case "vistaAdmin":
                request.getRequestDispatcher(pagPrincipal).forward(request, response);
                break;
            case "listarPacientes":
                listarPacientes(request, response);
                break;
            case "registrar":
                registrar(request, response); // Asumo que tienes este método implementado
                break;
            case "elliminar":
                eliminar(request, response); // Asumo que tienes este método implementado
                break;
            default:
                listarPacientes(request, response);
        }
    }

    private void listarPacientes(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    response.setContentType("text/html;charset=UTF-8");
    
    // **** NUEVO: Capturar el parámetro de búsqueda ****
    String dniBuscar = request.getParameter("dniBuscar");
    // Si el parámetro es null o vacío, se ignorará en el DAO.
    
    // 1. Obtener la página actual (si no existe, usa 1)
    int paginaActual = 1;
    String pageStr = request.getParameter("page");
    if (pageStr != null && !pageStr.isEmpty()) {
        try {
            paginaActual = Integer.parseInt(pageStr);
        } catch (NumberFormatException e) {
            // Si hay error en el número de página, se queda en 1
        }
    }
    
    // 2. Calcular total de registros y total de páginas
    // **** MODIFICADO: Llamar a contarPacientes con el DNI ****
    int totalRegistros = Daopac.contarPacientes(dniBuscar); 
    int totalPaginas = (int) Math.ceil((double) totalRegistros / REGISTROS_POR_PAGINA);

    // Ajustar la página actual para que no sea menor a 1 o mayor al total
    if (paginaActual < 1) paginaActual = 1;
    if (paginaActual > totalPaginas && totalPaginas > 0) paginaActual = totalPaginas;
    
    // 3. Calcular el OFFSET para la consulta SQL
    int offset = (paginaActual - 1) * REGISTROS_POR_PAGINA;
    
    // 4. Obtener la lista de pacientes paginada
    // **** MODIFICADO: Llamar a listarPacientesPaginado con el DNI ****
    request.setAttribute("paciente", Daopac.listarPacientesPaginado(offset, dniBuscar));
    
    // 5. Enviar atributos de paginación y búsqueda a la JSP
    request.setAttribute("paginaActual", paginaActual);
    request.setAttribute("totalPaginas", totalPaginas);
    request.setAttribute("totalRegistros", totalRegistros);
    // request.setAttribute("dniBuscado", dniBuscar); // Opcional, pero útil
    
    // Calcular el rango de visualización para el mensaje "Mostrando X a Y de Z entradas"
    int inicioRegistro = offset + 1;
    int finRegistro = Math.min(offset + REGISTROS_POR_PAGINA, totalRegistros);
    request.setAttribute("inicioRegistro", inicioRegistro);
    request.setAttribute("finRegistro", finRegistro);

    request.getRequestDispatcher(pagListarPacientes).forward(request, response);
}

    private void registrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Paciente pac = new Paciente();
        pac.setNombre(request.getParameter("nombres"));
        pac.setApellido(request.getParameter("apellidos"));
        pac.setDni(request.getParameter("dni"));
        pac.setNacimiento(request.getParameter("nacimiento"));
        pac.setSexo(request.getParameter("sexo"));
        pac.setTelefono(request.getParameter("telefono"));
        pac.setDireccion(request.getParameter("direccion"));
        int result = Daopac.registrar(pac);
        if (result > 0) {
            response.sendRedirect("ControladorPaciente?accion=listarPacientes");
        }
    }
    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int idPaciente=Integer.parseInt(request.getParameter("idPaciente"));
        int result=Daopac.eliminar(idPaciente);
        if(result>0){
            request.getSession().setAttribute("sucess", "Empleado con id "+idPaciente +" elimnado");
        }else{
            request.getSession().setAttribute("error",idPaciente);
        }
        response.sendRedirect("ControladorPaciente?accion=listarPacientes");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
