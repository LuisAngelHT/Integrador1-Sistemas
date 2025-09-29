<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>CITAS MEDICAS | Dashboard Admin</title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css">
        <link href="dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="dist/css/skins/skin-blue.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    </head>

    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">
            
            <!-- HEADER -->
            <header class="main-header">
                <a href="${pageContext.request.contextPath}/srvDashboardAdmin" class="logo">
                    <span class="logo-mini"><b>S</b>CM</span>
                    <span class="logo-lg"><b>CITAS MEDICAS</b></span>
                </a>
                <nav class="navbar navbar-static-top" role="navigation">
                    <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
                        <span class="sr-only">Toggle navigation</span>
                    </a>
                    <div class="navbar-custom-menu">
                        <ul class="nav navbar-nav">
                            <li class="dropdown user user-menu">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <img src="dist/img/admin.jpg" class="user-image" alt="User Image">
                                    <span class="hidden-xs">${usuario.nombre}</span>
                                </a>
                                <ul class="dropdown-menu">
                                    <li class="user-header">
                                        <img src="dist/img/admin.jpg" class="img-circle" alt="User Image">
                                        <p>
                                            Bienvenido - ${usuario.nombre}
                                            <small>Usted es ${usuario.rol.nombreRol}</small>
                                        </p>
                                    </li>
                                    <li class="user-footer">
                                        <div class="pull-right">
                                            <a href="srvUsuario?accion=cerrar" class="btn btn-default btn-flat">Cerrar Sesión</a>
                                        </div>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </nav>
            </header>
            
            <!-- SIDEBAR -->
            <aside class="main-sidebar">
                <section class="sidebar">
                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="dist/img/admin.jpg" class="img-circle" alt="User Image">
                        </div>
                        <div class="pull-left info">
                            <p>Bienvenido, ${usuario.nombre}</p>
                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>

                    <ul class="sidebar-menu" data-widget="tree">
                        <li class="header">MENÚ</li>
                        <li class="active">
                            <a href="${pageContext.request.contextPath}/srvDashboardAdmin">
                                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-calendar"></i> <span>Citas</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/srvPaciente?accion=listar">
                                <i class="fa fa-users"></i> <span>Pacientes</span>
                            </a>
                        </li>
                        <li class="treeview">
                            <a href="#">
                                <i class="glyphicon glyphicon-th-large"></i> <span>Profesionales</span>
                                <span class="pull-right-container">
                                    <i class="fa fa-angle-left pull-right"></i>
                                </span>
                            </a>
                            <ul class="treeview-menu">
                                <li><a href="#"><i class="fa fa-user-md"></i> <span>Profesionales</span></a></li>
                                <li><a href="#"><i class="fa fa-stethoscope"></i> <span>Especialidades</span></a></li>
                                <li><a href="#"><i class="fa fa-clock-o"></i> <span>Horarios</span></a></li>
                            </ul>
                        </li>
                    </ul>
                </section>
            </aside>

            <!-- CONTENIDO PRINCIPAL -->
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        Panel Administrativo
                        <small>Métricas y Actividad de Hoy</small>
                    </h1>
                </section>

                <section class="content">
                    
                    <!-- CAJAS DE ESTADÍSTICAS -->
                    <div class="row">
                        <div class="col-lg-3 col-xs-6">
                            <div class="small-box bg-aqua">
                                <div class="inner">
                                    <h3>${totalCitasHoy}</h3>
                                    <p>Citas Agendadas Hoy</p>
                                </div>
                                <div class="icon">
                                    <i class="ion ion-calendar"></i>
                                </div>
                                <a href="#" class="small-box-footer">Ver todas <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        
                        <div class="col-lg-3 col-xs-6">
                            <div class="small-box bg-green">
                                <div class="inner">
                                    <h3>${totalPacientes}</h3>
                                    <p>Total Pacientes Registrados</p>
                                </div>
                                <div class="icon">
                                    <i class="ion ion-person-stalker"></i>
                                </div>
                                <a href="${pageContext.request.contextPath}/srvPaciente?accion=listar" class="small-box-footer">Gestionar Pacientes <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        
                        <div class="col-lg-3 col-xs-6">
                            <div class="small-box bg-yellow">
                                <div class="inner">
                                    <h3>${totalMedicos}</h3>
                                    <p>Profesionales Médicos Activos</p>
                                </div>
                                <div class="icon">
                                    <i class="ion ion-ios-people"></i>
                                </div>
                                <a href="#" class="small-box-footer">Ver Listado <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        
                        <div class="col-lg-3 col-xs-6">
                            <div class="small-box bg-red">
                                <div class="inner">
                                    <h3>${citasPendientes}</h3>
                                    <p>Citas Pendientes de Confirmar</p>
                                </div>
                                <div class="icon">
                                    <i class="ion ion-alert-circled"></i>
                                </div>
                                <a href="#" class="small-box-footer">Revisar Citas <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- TABLAS Y LISTAS -->
                    <div class="row">
                        
                        <!-- CITAS DE HOY -->
                        <section class="col-lg-7 connectedSortable">
                            <div class="box box-primary">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Citas Programadas para Hoy</h3>
                                </div>
                                <div class="box-body">
                                    <c:choose>
                                        <c:when test="${not empty citasHoy}">
                                            <table class="table table-bordered table-hover table-condensed">
                                                <thead>
                                                    <tr>
                                                        <th>Hora</th>
                                                        <th>Paciente</th>
                                                        <th>Profesional</th>
                                                        <th>Estado</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="cita" items="${citasHoy}">
                                                        <tr>
                                                            <td><fmt:formatDate value="${cita.HoraCita}" pattern="HH:mm"/></td>
                                                            <td>${cita.NombrePaciente}</td>
                                                            <td>${cita.NombreProfesional} (${cita.NombreEspecialidad})</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${cita.Estado == 'Confirmada'}">
                                                                        <span class="label label-success">${cita.Estado}</span>
                                                                    </c:when>
                                                                    <c:when test="${cita.Estado == 'Pendiente'}">
                                                                        <span class="label label-warning">${cita.Estado}</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="label label-default">${cita.Estado}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-info">
                                                <i class="icon fa fa-info"></i> No hay citas programadas para hoy.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </section>
                        
                        <!-- PACIENTES RECIENTES -->
                        <section class="col-lg-5 connectedSortable">
                            <div class="box box-warning">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Nuevos Pacientes (${pacientesEsteMes} en el mes)</h3>
                                </div>
                                <div class="box-body">
                                    <c:choose>
                                        <c:when test="${not empty pacientesRecientes}">
                                            <ul class="products-list product-list-in-box">
                                                <c:forEach var="p" items="${pacientesRecientes}">
                                                    <li class="item">
                                                        <div class="product-img">
                                                            <i class="fa fa-user-circle fa-2x"></i>
                                                        </div>
                                                        <div class="product-info">
                                                            <a href="#" class="product-title">${p.nombre} ${p.apellido}</a>
                                                            <span class="product-description">
                                                                DNI: ${p.dni} | Nac: ${p.nacimiento}
                                                            </span>
                                                        </div>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-info">
                                                <i class="icon fa fa-info"></i> No hay pacientes registrados recientemente.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="box-footer text-center">
                                    <a href="${pageContext.request.contextPath}/srvPaciente?accion=listar" class="uppercase">Ver todos los pacientes</a>
                                </div>
                            </div>
                        </section>
                        
                    </div>
                    
                </section>
            </div>
            
            <!-- FOOTER -->
            <footer class="main-footer">
                <div class="pull-right hidden-xs">
                    Working...
                </div>
                <strong>Utepinos &copy; 2025 <a href="#">UTP</a>.</strong> Todos los derechos reservados.
            </footer>
            
            <div class="control-sidebar-bg"></div>
        </div>

        <!-- SCRIPTS -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>
        <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="dist/js/adminlte.min.js"></script>
    </body>
</html>