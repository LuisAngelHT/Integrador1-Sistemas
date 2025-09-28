<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    if (session.getAttribute("usuario") != null) {
%>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Citas Medicas</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css" >
        <!-- Font Awesome -->
        <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">

        <!-- Ionicons -->
        <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css">
        <!-- Theme style -->
        <link href="dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css"/>

        <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
              page. However, you can choose any other skin. Make sure you
              apply the skin class to the body tag so the changes take effect. -->
        <link rel="stylesheet" href="dist/css/skins/skin-blue.min.css">
        <link rel="stylesheet"
              href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    </head>

    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">

            <!-- Main Header -->
            <header class="main-header">
                <a href="#" class="logo">
                    <!-- mini logo (solo icono en sidebar reducido) -->
                    <span class="logo-mini">
                        <img src="icono.png" alt="CM" style="width:30px; height:30px;">
                    </span>

                    <!-- logo grande (texto + icono en estado normal) -->
                    <span class="logo-lg">
                        <img src="icono.png" alt="Logo" style="width:30px; height:30px; vertical-align:middle;">
                        <b>CITAS MEDICAS</b>
                    </span>
                </a>

                <!-- Header Navbar -->
                <nav class="navbar navbar-static-top" role="navigation">
                    <!-- Sidebar toggle button-->
                    <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
                        <span class="sr-only">Toggle navigation</span>
                    </a>
                    <!-- Navbar Right Menu -->
                    <div class="navbar-custom-menu">
                        <ul class="nav navbar-nav">
                            <!-- User Account Menu -->
                            <li class="dropdown user user-menu">
                                <!-- Menu Toggle Button -->
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <!-- The user image in the navbar-->
                                    <img src="dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
                                    <!-- hidden-xs hides the username on small devices so only the image appears. -->
                                    <span class="hidden-xs"> ${usuario.nombre}</span>
                                </a>
                                <ul class="dropdown-menu">
                                    <!-- The user image in the menu -->
                                    <li class="user-header">
                                        <img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">

                                        <p>                    
                                            Bienvenido - ${usuario.nombre}
                                            <small>Usted es, ${usuario.rol.nombreRol} </small>
                                        </p>
                                    </li>
                                    <!-- Menu Footer-->
                                    <li class="user-footer">
                                        <div class="pull-right">
                                            <a href="srvUsuario?accion=cerrar" class="btn btn-default btn-flat">Cerrar Session</a>
                                        </div>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </nav>
            </header>
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="main-sidebar">

                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">

                    <!-- Sidebar user panel (optional) -->
                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                        </div>
                        <div class="pull-left info">
                            <p>Bienvenido,  ${usuario.nombre} </p>
                            <!-- Status -->
                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>

                    <!-- Sidebar Menu -->
                    <ul class="sidebar-menu" data-widget="tree">
                        <li class="header">INICIO</li>

                        <!-- Inicio -->
                        <li>
                            <a href="${pageContext.request.contextPath}/ControladorPaciente?accion=vistaAdmin">
                                <i class="fa fa-home"></i> <span>Panel Administrativo</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <i class="fa fa-cart-arrow-down"></i> <span>Citas</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <i class="fa fa-area-chart"></i> <span>Pacientes</span>
                            </a>
                        </li>
                        <li class="treeview">
                            <a href="#"><i class="glyphicon glyphicon-th-large"></i> <span>Especialistas</span>
                                <span class="pull-right-container">
                                    <i class="fa fa-angle-left pull-right"></i>
                                </span>
                            </a>
                            <ul class="treeview-menu">
                                <li>
                                    <a href="">
                                        <i class="glyphicon glyphicon-th-large"></i> <span>Profesionales</span>
                                    </a>
                                </li>

                                <li>
                                    <a href="">
                                        <i class="glyphicon glyphicon-th-large"></i> <span>Especialidades</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <i class="glyphicon glyphicon-th-large"></i> <span>Horarios</span>
                                    </a>
                                </li>

                            </ul>
                        </li>
                    </ul>
                    <!-- /.sidebar-menu -->
                </section>
                <!-- /.sidebar -->
            </aside>

            <div class="content-wrapper">
                <section class="content">
                    <div class="container mt-3">
                        <div class="card">
                            <div class="card-body">
                                <h3>GESTOR DE PACIENTES</h3>
                                <hr>
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalFormulario">
                                    <i class="fa-solid fa-plus"></i>Nuevo
                                </button>
                                <br>
                                <br>
                                <form action="ControladorPaciente" method="GET" class="form-inline mb-3">
                                    <div class="input-group">
                                        <input type="text" 
                                               class="form-control" 
                                               placeholder="Buscar por DNI..." 
                                               name="dniBuscar" 
                                               value="${param.dniBuscar != null ? param.dniBuscar : ''}"
                                               maxlength="8" 
                                               pattern="\d{8}" 
                                               title="Ingrese 8 dígitos para buscar por DNI.">

                                        <div class="input-group-append">
                                            <button class="btn btn-outline-secondary" type="submit">
                                                <i class="fa fa-search"></i> Buscar
                                            </button>

                                            <c:if test="${param.dniBuscar != null && param.dniBuscar != ''}">
                                                <a href="ControladorPaciente?accion=listarPacientes" class="btn btn-outline-danger" title="Limpiar búsqueda">
                                                    <i class="fa fa-times"></i> Limpiar
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                    <input type="hidden" name="accion" value="listarPacientes">
                                </form>
                                <table class="table table-bordered table-striped mt-2">
                                    <thead>
                                        <tr>
                                            <th>IDPACIENTE</th>
                                            <th>NOMBRE</th>
                                            <th>APELLIDO</th>
                                            <th>DNI</th>
                                            <th>NACIMIENTO</th>
                                            <th>SEXO</th>
                                            <th>TELEFONO</th>
                                            <th>DIRECCION</th>
                                            <th>ACCIONES</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${paciente}" var="item">
                                            <tr>
                                                <td><fmt:formatNumber value="${item.idPaciente}" pattern="000"/></td>
                                                <td>${item.nombre}</td>
                                                <td>${item.apellido}</td>
                                                <td>${item.dni}</td>
                                                <td>${item.nacimiento}</td>
                                                <td>${item.sexo}</td>
                                                <td>${item.telefono}</td>
                                                <td>${item.direccion}</td>
                                                <td>
                                                    <a href="" class="btn-info btn-sm"> 
                                                        <i class="fa fa-edit"></i>
                                                    </a>
                                                    <a href="" class="btn btn-danger btn-sm"> 
                                                        <i class="fa fa-trash"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                    </tbody>
                                </table>
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <div>
                                        Mostrando ${inicioRegistro} a ${finRegistro} de ${totalRegistros} pacientes
                                    </div>

                                    <nav>
                                        <ul class="pagination pagination-sm">
                                            <li class="page-item <c:if test="${paginaActual == 1}">disabled</c:if>">
                                                <a class="page-link" href="ControladorPaciente?accion=listarPacientes&page=${paginaActual - 1}" aria-label="Anterior">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>

                                            <c:forEach begin="1" end="${totalPaginas}" var="i">
                                                <li class="page-item <c:if test="${paginaActual == i}">active</c:if>">
                                                    <a class="page-link" href="ControladorPaciente?accion=listarPacientes&page=${i}">${i}</a>
                                                </li>
                                            </c:forEach>

                                            <li class="page-item <c:if test="${paginaActual == totalPaginas}">disabled</c:if>">
                                                <a class="page-link" href="ControladorPaciente?accion=listarPacientes&page=${paginaActual + 1}" aria-label="Siguiente">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>

                </section>
                <!-- Modal para registrar paciente -->
            </div>
            <div class="modal fade" id="modalFormulario" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title" id="modalLabel">Nuevo Empleado</h3>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="ControladorPaciente" method="post">

                                <div style="display: flex; gap: 20px;">
                                    <div class="form-group" style="flex: 1;">
                                        <label>Nombres</label>
                                        <input name="nombres" type="text" class="form-control" maxlength="50" required="">
                                    </div>

                                    <div class="form-group" style="flex: 1;">
                                        <label>Apellidos</label>
                                        <input name="apellidos" type="text" class="form-control" maxlength="50" required="">
                                    </div>
                                </div>

                                <div style="display: flex; gap: 20px;">
                                    <div class="form-group" style="flex: 1;">
                                        <label>DNI</label>
                                        <input name="dni" type="text" class="form-control" maxlength="8" required="" pattern="\d{8}" title="El DNI debe tener 8 dígitos.">
                                    </div>

                                    <div class="form-group" style="flex: 1;">
                                        <label>Fecha de Nacimiento</label>
                                        <input name="nacimiento" type="date" class="form-control" required="">
                                    </div>
                                </div>

                                <div style="display: flex; gap: 20px;">
                                    <div class="form-group" style="flex: 1;">
                                        <label>Sexo</label>
                                        <select name="sexo" class="form-control" required="">
                                            <option value="">Seleccione...</option>
                                            <option value="M">Masculino (M)</option>
                                            <option value="F">Femenino (F)</option>
                                        </select>
                                    </div>

                                    <div class="form-group" style="flex: 1;">
                                        <label>Teléfono</label>
                                        <input name="telefono" type="tel" class="form-control" maxlength="15">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label>Dirección</label>
                                    <input name="direccion" type="text" class="form-control" maxlength="100" required="">
                                </div>

                                <div class="form-group">
                                    <input type="hidden" name="accion" value="registrar">
                                    <button class="btn btn-primary btn-sm">Registrar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Main Footer -->
            <footer class="main-footer">
                <!-- To the right -->
                <div class="pull-right hidden-xs">
                    Anything you want
                </div>
                <!-- Default to the left -->
                <strong>Copyright &copy; 2020 <a href="#">IDAT</a>.</strong> Todos los derechos reservados.
            </footer>

            <div class="control-sidebar-bg"></div>
        </div>

        <!-- ./wrapper -->

        <!-- REQUIRED JS SCRIPTS -->

        <!-- jQuery 3 -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>
        <!-- Bootstrap 3.3.7 -->
        <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
        <!-- AdminLTE App -->
        <script src="dist/js/adminlte.min.js"></script>

        <!-- Optionally, you can add Slimscroll and FastClick plugins.
             Both of these plugins are recommended to enhance the
             user experience. -->
    </body>
</html>
<%
    } else {
        response.sendRedirect("vistaLogin.jsp");
    }
%>