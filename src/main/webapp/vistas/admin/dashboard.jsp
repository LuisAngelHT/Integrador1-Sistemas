<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="../includes/head-resources.jsp"%>
        <title>CITAS MEDICAS | Dashboard Admin</title>
    </head>

    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">

            <%@include file="../includes/header-admin.jsp"%>

            <c:set var="pageActive" value="dashboard" scope="request"/>
            <%@include file="../includes/sidebar-admin.jsp"%>

            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        Panel Administrativo
                        <small>Resumen y Actividad</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/srvDashboardAdmin"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <li class="active">Panel Principal</li>
                    </ol>
                </section>

                <section class="content">

                    <!-- CAJAS DE ESTADÍSTICAS -->
                    <div class="row">
                        <div class="col-lg-3 col-xs-6">
                            <div class="small-box bg-aqua">
                                <div class="inner">
                                    <h3>${totalCitasHoy != null ? totalCitasHoy : 0}</h3>
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
                                    <h3>${totalPacientes != null ? totalPacientes : 0}</h3>
                                    <p>Total Pacientes</p>
                                </div>
                                <div class="icon">
                                    <i class="ion ion-person-stalker"></i>
                                </div>
                                <a href="${pageContext.request.contextPath}/ControladorPaciente?accion=listarPacientes" class="small-box-footer">
                                    Gestionar <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-lg-3 col-xs-6">
                            <div class="small-box bg-yellow">
                                <div class="inner">
                                    <h3>${totalMedicos != null ? totalMedicos : 0}</h3>
                                    <p>Profesionales Activos</p>
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
                                    <h3>${citasPendientes != null ? citasPendientes : 0}</h3>
                                    <p>Citas Pendientes</p>
                                </div>
                                <div class="icon">
                                    <i class="ion ion-alert-circled"></i>
                                </div>
                                <a href="#" class="small-box-footer">Revisar <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>

                    <!-- TABLAS Y LISTAS -->
                    <div class="row">

                        <div class="col-lg-7">
                            <div class="box box-primary">
                                <div class="box-header with-border">
                                    <h3 class="box-title"><i class="fa fa-calendar"></i> Citas Programadas para Hoy</h3>
                                </div>
                                <div class="box-body">
                                    <c:choose>
                                        <c:when test="${not empty citasHoy}">
                                            <div class="table-responsive">
                                                <table class="table table-bordered table-hover table-striped">
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
                                                                <td><strong><fmt:formatDate value="${cita.HoraCita}" pattern="HH:mm"/></strong></td>
                                                                <td>${cita.NombrePaciente}</td>
                                                                <td>
                                                                    ${cita.NombreProfesional}<br>
                                                                    <small class="text-muted">${cita.NombreEspecialidad}</small>
                                                                </td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${cita.Estado == 'Confirmada'}">
                                                                            <span class="label label-success">${cita.Estado}</span>
                                                                        </c:when>
                                                                        <c:when test="${cita.Estado == 'Pendiente'}">
                                                                            <span class="label label-warning">${cita.Estado}</span>
                                                                        </c:when>
                                                                        <c:when test="${cita.Estado == 'Atendida'}">
                                                                            <span class="label label-info">${cita.Estado}</span>
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
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-info">
                                                <i class="icon fa fa-info-circle"></i> No hay citas programadas para hoy.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <!-- PACIENTES RECIENTES -->
                        <div class="col-lg-5">
                            <div class="box box-success">
                                <div class="box-header with-border">
                                    <h3 class="box-title"><i class="fa fa-user-plus"></i> Pacientes Recientes</h3>
                                    <div class="box-tools pull-right">
                                        <span class="label label-success">${pacientesEsteMes != null ? pacientesEsteMes : 0} nuevos</span>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <c:choose>
                                        <c:when test="${not empty pacientesRecientes}">
                                            <ul class="products-list product-list-in-box">
                                                <c:forEach var="p" items="${pacientesRecientes}">
                                                    <li class="item">
                                                        <div class="product-img">
                                                            <i class="fa fa-user-circle fa-2x text-primary"></i>
                                                        </div>
                                                        <div class="product-info">
                                                            <a href="#" class="product-title">
                                                                ${p.nombre} ${p.apellido}
                                                                <span class="label label-info pull-right">${p.sexo}</span>
                                                            </a>
                                                            <span class="product-description">
                                                                <strong>DNI:</strong> ${p.dni} | <strong>Nac:</strong> ${p.nacimiento}
                                                            </span>
                                                        </div>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-info">
                                                <i class="icon fa fa-info-circle"></i> No hay pacientes registrados recientemente.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="box-footer text-center">
                                    <a href="${pageContext.request.contextPath}/ControladorPaciente?accion=listarPacientes" class="uppercase">Ver todos los pacientes</a>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- FILA ADICIONAL: PROFESIONALES -->
                    <div class="row">

                        <!-- PROFESIONALES MÉDICOS -->
                        <div class="col-md-6">
                            <div class="box box-warning">
                                <div class="box-header with-border">
                                    <h3 class="box-title"><i class="fa fa-user-md"></i> Profesionales Médicos</h3>
                                    <div class="box-tools pull-right">
                                        <span class="badge bg-yellow">${totalMedicos}</span>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <c:choose>
                                        <c:when test="${not empty profesionalesMedicos}">
                                            <ul class="list-group">
                                                <c:forEach var="prof" items="${profesionalesMedicos}" varStatus="status">
                                                    <c:if test="${status.index < 5}">
                                                        <li class="list-group-item">
                                                            <i class="fa fa-user-md text-yellow"></i> ${prof.NombreCompleto}
                                                            <span class="pull-right text-muted">
                                                                <small>${prof.NombreEspecialidad}</small>
                                                            </span>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-warning">
                                                <i class="icon fa fa-warning"></i> No hay profesionales médicos registrados.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <!-- PROFESIONALES NO MÉDICOS -->
                        <div class="col-md-6">
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <h3 class="box-title"><i class="fa fa-users"></i> Profesionales No Médicos</h3>
                                    <div class="box-tools pull-right">
                                        <span class="badge bg-aqua">${totalNoMedicos}</span>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <c:choose>
                                        <c:when test="${not empty profesionalesNoMedicos}">
                                            <ul class="list-group">
                                                <c:forEach var="prof" items="${profesionalesNoMedicos}" varStatus="status">
                                                    <c:if test="${status.index < 5}">
                                                        <li class="list-group-item">
                                                            <i class="fa fa-user text-aqua"></i> ${prof.NombreCompleto}
                                                            <span class="pull-right text-muted">
                                                                <small>${prof.NombreEspecialidad}</small>
                                                            </span>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-info">
                                                <i class="icon fa fa-info-circle"></i> No hay profesionales no médicos registrados.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                    </div>

                </section>
            </div>

            <%-- Footer y Scripts --%>
            <%@include file="../includes/footer-admin.jsp"%>

        </div>
    </body>
</html>