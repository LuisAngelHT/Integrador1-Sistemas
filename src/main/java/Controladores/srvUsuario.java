package Controladores;

import Modelo.DAOUsuario;
import Modelo.Usuario;
import Modelo.Rol;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "srvUsuario", urlPatterns = {"/srvUsuario"})
public class srvUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("accion");
        try {
            if (accion != null) {
                switch (accion) {
                    case "verificar":
                        verificar(request, response);
                        break;
                    case "cerrar":
                        cerrarsession(request, response);
                        break;
                    default:
                        response.sendRedirect("vistaLogin.jsp");
                        break;
                }
            } else {
                response.sendRedirect("vistaLogin.jsp");
            }
        } catch (Exception e) {
            try {
                this.getServletConfig().getServletContext().getRequestDispatcher("/mensaje.jsp").forward(request, response);

            } catch (Exception ex) {
                System.out.println("Error" + e.getMessage());
            }
        }

    }

    private void verificar(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession sesion;
        DAOUsuario dao;
        Usuario usuario;

        // 1. Obtiene los datos del formulario (Correo y Contraseña)
        usuario = this.obtenerUsuario(request);

        // 2. Llama al DAO para autenticar contra la Base de Datos
        dao = new DAOUsuario();
        usuario = dao.identificar(usuario); // <-- Aquí es donde se usa tu DAO

        if (usuario != null && usuario.getRol().getNombreRol().equals("Administrador")) {
            sesion = request.getSession();
            sesion.setAttribute("usuario", usuario);
            request.setAttribute("msje", "Bienvenido al sistema");
            this.getServletConfig().getServletContext().getRequestDispatcher("/vistas/admin/vistaAdmin.jsp").forward(request, response);
        } else if (usuario != null && usuario.getRol().getNombreRol().equals("Profesional Medico")) {
            sesion = request.getSession();
            sesion.setAttribute("profesional", usuario);
            this.getServletConfig().getServletContext().getRequestDispatcher("/vistas/medico/vistaProfesional.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Credenciales Incorrectas");
            request.getRequestDispatcher("vistaLogin.jsp").forward(request, response);
        }
    }

    private void cerrarsession(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession sesion = request.getSession();
        sesion.setAttribute("usuario", null);
        sesion.invalidate();
        response.sendRedirect("vistaLogin.jsp");

    }

    private Usuario obtenerUsuario(HttpServletRequest request) {
        Usuario u = new Usuario();
        u.setCorreo(request.getParameter("txtCorreo"));
        u.setContrasena(request.getParameter("txtPass"));
        return u;
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