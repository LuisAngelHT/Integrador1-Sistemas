<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<aside class="main-sidebar">
    <section class="sidebar">
        <div class="user-panel">
            <div class="pull-left image">
                <img src="${pageContext.request.contextPath}/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p>${usuario.nombre} ${usuario.apellido}</p>
                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>

        <ul class="sidebar-menu" data-widget="tree">
            <li class="header">MENÚ PRINCIPAL</li>

            <li class="${pageActive == 'dashboard' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/srvDashboardAdmin">
                    <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                </a>
            </li>

            <li class="${pageActive == 'citas' ? 'active' : ''}">
                <a href="#">
                    <i class="fa fa-calendar"></i> <span>Citas</span>
                </a>
            </li>

            <li class="${pageActive == 'pacientes' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/srvPaciente?accion=pacientes">
                    <i class="fa fa-users"></i> <span>Pacientes</span>
                </a>
            </li>

            <%-- CAMBIO CLAVE AQUÍ: Activa el treeview si la página es 'profesionales', 'turnos', o 'especialidades' --%>
            <li class="treeview ${pageActive == 'profesionales' || pageActive == 'turnos' || pageActive == 'especialidades' ? 'active menu-open' : ''}">
                <a href="#">
                    <i class="fa fa-user-md"></i> <span>Profesionales</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu" style="${pageActive == 'turnos' || pageActive == 'especialidades' ? 'display: block;' : ''}">
                    <li>
                        <a href="#">
                            <i class="fa fa-user-md"></i> Gestionar Profesionales
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa-stethoscope"></i> Especialidades
                        </a>
                    </li>
                    <li class="${pageActive == 'turnos' ? 'active' : ''}"> 
                        <a href="${pageContext.request.contextPath}/srvTurno?accion=turnos">
                            <i class="fa fa-clock-o"></i> Turnos
                        </a>
                    </li>
                </ul>
            </li>

            <li class="${pageActive == 'reportes' ? 'active' : ''}">
                <a href="#">
                    <i class="fa fa-bar-chart"></i> <span>Reportes</span>
                </a>
            </li>

        </ul>
    </section>
</aside>