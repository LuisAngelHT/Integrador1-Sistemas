<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Left side column. contains the sidebar -->
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="${pageContext.request.contextPath}/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p>${usuario.nombre} ${usuario.apellido}</p>
                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>

        <!-- Sidebar Menu -->
        <ul class="sidebar-menu" data-widget="tree">
            <li class="header">MENÚ PRINCIPAL</li>
            
            <!-- Dashboard -->
            <li class="${pageActive == 'dashboard' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/srvDashboardAdmin">
                    <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                </a>
            </li>
            
            <!-- Citas -->
            <li class="${pageActive == 'citas' ? 'active' : ''}">
                <a href="#">
                    <i class="fa fa-calendar"></i> <span>Citas</span>
                </a>
            </li>
            
            <!-- Pacientes -->
            <li class="${pageActive == 'pacientes' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/ControladorPaciente?accion=listarPacientes">
                    <i class="fa fa-users"></i> <span>Pacientes</span>
                </a>
            </li>
            
            <!-- Profesionales (submenu) -->
            <li class="treeview ${pageActive == 'profesionales' ? 'active' : ''}">
                <a href="#">
                    <i class="fa fa-user-md"></i> <span>Profesionales</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
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
                    <li>
                        <a href="#">
                            <i class="fa fa-clock-o"></i> Turnos
                        </a>
                    </li>
                </ul>
            </li>
            
            <!-- Reportes -->
            <li class="${pageActive == 'reportes' ? 'active' : ''}">
                <a href="#">
                    <i class="fa fa-bar-chart"></i> <span>Reportes</span>
                </a>
            </li>
            
        </ul>
        <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
</aside>