<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Lógica de Seguridad: Si no hay sesión, redirige al login
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("vistaLogin.jsp");
        return; 
    }
%>

<%-- 1. INCLUYE el <head>, CSS, y abre <body> y la estructura inicial (desde includes/header.jsp) --%>
<jsp:include page="includes/header.jsp"/>

<%-- La variable de sesión 'usuario' está disponible aquí --%>
<c:set var="usuario" value="${sessionScope.usuario}"/>

<%-- 2. INCLUYE el Menú Lateral (desde includes/sidebar-admin.jsp) --%>
<jsp:include page="includes/sidebar-admin.jsp"/>

<div class="content-wrapper">
    <section class="content-header">
        <h1>
            PANEL DE ADMINISTRACIÓN
            <small>Bienvenido al Sistema de Citas Médicas</small>
        </h1>
    </section>

    <section class="content">
        <div class="row">
            <div class="col-lg-3 col-xs-6">
                <div class="small-box bg-aqua">
                    <div class="inner"><h3>150</h3><p>Total Citas</p></div>
                    <div class="icon"><i class="ion ion-bag"></i></div>
                    <a href="#" class="small-box-footer">Más info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-xs-6">
                <div class="small-box bg-green">
                    <div class="inner"><h3>53<sup style="font-size: 20px">%</sup></h3><p>Total Pacientes</p></div>
                    <div class="icon"><i class="ion ion-stats-bars"></i></div>
                    <a href="#" class="small-box-footer">Más info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-xs-6">
                <div class="small-box bg-yellow">
                    <div class="inner"><h3>44</h3><p>Total Especialistas</p></div>
                    <div class="icon"><i class="ion ion-person-add"></i></div>
                    <a href="#" class="small-box-footer">Más info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-xs-6">
                <div class="small-box bg-red">
                    <div class="inner"><h3>65</h3><p>Unique Visitors</p></div>
                    <div class="icon"><i class="ion ion-pie-graph"></i></div>
                    <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
        </div>
    </section>
    </div>
<%-- 3. INCLUYE el footer, scripts JS, y cierra </body>/</html> (desde includes/footer.jsp) --%>
<jsp:include page="includes/footer.jsp"/>