<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<aside class="main-sidebar">
    <section class="sidebar">
        <%-- Aquí iría el panel de usuario con la sesión, si aplica --%>
        
        <ul class="sidebar-menu" data-widget="tree">
            <li class="header">MENÚ</li>
            <li><a href="vistaAdmin.jsp"><i class="fa fa-home"></i> <span>Panel Administrativo</span></a></li>
            <li><a href="#"><i class="fa fa-users"></i> <span>Pacientes</span></a></li>
            <li><a href="#"><i class="fa fa-user-md"></i> <span>Profesionales</span></a></li>
            <li><a href="#"><i class="fa fa-calendar"></i> <span>Citas</span></a></li>
        </ul>
    </section>
</aside>