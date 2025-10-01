<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect(request.getContextPath() + "/vistaLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../includes/head-resources.jsp"%>
        <!-- SweetAlert2 -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <title>CITAS MEDICAS | Gestión de Pacientes</title>
    </head>

    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">

            <%@include file="../includes/header-admin.jsp"%>

            <c:set var="pageActive" value="pacientes" scope="request"/>
            <%@include file="../includes/sidebar-admin.jsp"%>

            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        Gestión de Pacientes
                        <small>Administrar pacientes del sistema</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/srvDashboardAdmin"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <li class="active">Pacientes</li>
                    </ol>
                </section>
                <!-- Mensajes con SweetAlert -->
                <c:if test="${not empty sessionScope.mensaje}">
                    <c:if test="${not empty mensaje}">
                        <script>
                            Swal.fire({
                                icon: '${tipoMensaje}',
                                title: '${mensaje}',
                                showConfirmButton: false,
                                timer: 2000
                            });
                        </script>
                        <%-- MUY IMPORTANTE: Se borran las variables de la sesión --%>
                        <c:remove var="mensaje" scope="session"/>
                        <c:remove var="tipoMensaje" scope="session"/>
                    </c:if>
                    <c:remove var="mensaje" scope="session"/>
                    <c:remove var="tipoMensaje" scope="session"/>
                </c:if>
                <section class="content">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title"><i class="fa fa-users"></i> Listado de Pacientes</h3>
                            <div class="box-tools pull-right">
                                <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#modalFormulario">
                                    <i class="fa fa-plus"></i> Nuevo Paciente
                                </button>
                            </div>
                        </div>

                        <div class="box-body">
                            <!-- Buscador -->
                            <form action="srvPaciente" method="GET" class="form-inline mb-3">
                                <div class="input-group">
                                    <input type="text" 
                                           class="form-control" 
                                           placeholder="Buscar por DNI..." 
                                           name="dniBuscar" 
                                           value="${param.dniBuscar}"
                                           maxlength="8" 
                                           pattern="\d{8}">
                                    <div class="input-group-btn">
                                        <button class="btn btn-default" type="submit">
                                            <i class="fa fa-search"></i> Buscar
                                        </button>
                                        <c:if test="${not empty param.dniBuscar}">
                                            <a href="srvPaciente?accion=pacientes" class="btn btn-warning">
                                                <i class="fa fa-times"></i> Limpiar
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                                <input type="hidden" name="accion" value="pacientes">
                            </form>

                            <!-- Tabla -->
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Nombre</th>
                                            <th>Apellido</th>
                                            <th>DNI</th>
                                            <th>Nacimiento</th>
                                            <th>Sexo</th>
                                            <th>Teléfono</th>
                                            <th>Dirección</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty paciente}">
                                                <c:forEach items="${paciente}" var="item">
                                                    <tr>
                                                        <td><fmt:formatNumber value="${item.idPaciente}" pattern="000"/></td>
                                                        <td>${item.nombre}</td>
                                                        <td>${item.apellido}</td>
                                                        <td>${item.dni}</td>
                                                        <td>${item.nacimiento}</td>
                                                        <td>
                                                            <span class="label ${item.sexo == 'M' ? 'label-info' : 'label-danger'}">
                                                                ${item.sexo == 'M' ? 'Masculino' : 'Femenino'}
                                                            </span>
                                                        </td>
                                                        <td>${item.telefono}</td>
                                                        <td>${item.direccion}</td>
                                                        <td>
                                                            <button class="btn btn-warning btn-xs" 
                                                                    onclick="editarPaciente(${item.idPaciente}, '${item.nombre}', '${item.apellido}', '${item.dni}', '${item.nacimiento}', '${item.sexo}', '${item.telefono}', '${item.direccion}')" 
                                                                    data-toggle="modal" 
                                                                    data-target="#modalEditar">
                                                                <i class="fa fa-edit"></i>
                                                            </button>
                                                            <button class="btn btn-danger btn-xs" 
                                                                    onclick="confirmarEliminar(${item.idPaciente}, '${item.nombre} ${item.apellido}')">
                                                                <i class="fa fa-trash"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="9" class="text-center">
                                                        <div class="alert alert-info">
                                                            <i class="fa fa-info-circle"></i> No se encontraron pacientes.
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Paginación -->
                            <c:if test="${totalPaginas > 1}">
                                <div class="row">
                                    <div class="col-sm-5">
                                        <div class="dataTables_info">
                                            Mostrando ${inicioRegistro} a ${finRegistro} de ${totalRegistros} pacientes
                                        </div>
                                    </div>
                                    <div class="col-sm-7">
                                        <div class="dataTables_paginate paging_simple_numbers pull-right">
                                            <ul class="pagination pagination-sm no-margin">
                                                <li class="${paginaActual == 1 ? 'disabled' : ''}">
                                                    <a href="srvPaciente?accion=pacientes&page=${paginaActual - 1}<c:if test='${not empty param.dniBuscar}'>&dniBuscar=${param.dniBuscar}</c:if>">&laquo;</a>
                                                    </li>
                                                <c:forEach begin="1" end="${totalPaginas}" var="i">
                                                    <li class="${paginaActual == i ? 'active' : ''}">
                                                        <a href="srvPaciente?accion=pacientes&page=${i}<c:if test='${not empty param.dniBuscar}'>&dniBuscar=${param.dniBuscar}</c:if>">${i}</a>
                                                        </li>
                                                </c:forEach>
                                                <li class="${paginaActual == totalPaginas ? 'disabled' : ''}">
                                                    <a href="srvPaciente?accion=pacientes&page=${paginaActual + 1}<c:if test='${not empty param.dniBuscar}'>&dniBuscar=${param.dniBuscar}</c:if>">&raquo;</a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                            </c:if>
                        </div>
                    </div>
                </section>
            </div>

            <!-- Modal Nuevo Paciente -->
            <div class="modal fade" id="modalFormulario">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><i class="fa fa-user-plus"></i> Nuevo Paciente</h4>
                        </div>
                        <form action="srvPaciente" method="post">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Nombres *</label>
                                            <input name="nombres" type="text" class="form-control" maxlength="50" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Apellidos *</label>
                                            <input name="apellidos" type="text" class="form-control" maxlength="50" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>DNI *</label>
                                            <input name="dni" type="text" class="form-control" maxlength="8" pattern="\d{8}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Fecha Nacimiento *</label>
                                            <input name="nacimiento" type="date" class="form-control" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Sexo *</label>
                                            <select name="sexo" class="form-control" required>
                                                <option value="">Seleccione...</option>
                                                <option value="M">Masculino</option>
                                                <option value="F">Femenino</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Teléfono</label>
                                            <input name="telefono" type="tel" class="form-control" maxlength="15">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Dirección *</label>
                                    <input name="direccion" type="text" class="form-control" maxlength="100" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="hidden" name="accion" value="registrar">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Registrar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- Modal Editar Paciente -->
            <div class="modal fade" id="modalEditar">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><i class="fa fa-edit"></i> Editar Paciente</h4>
                        </div>
                        <form action="srvPaciente" method="post">
                            <div class="modal-body">
                                <input type="hidden" name="idPaciente" id="editId">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Nombres *</label>
                                            <input name="nombres" id="editNombre" type="text" class="form-control" maxlength="50" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Apellidos *</label>
                                            <input name="apellidos" id="editApellido" type="text" class="form-control" maxlength="50" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>DNI *</label>
                                            <input name="dni" id="editDni" type="text" class="form-control" maxlength="8" pattern="\d{8}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Fecha Nacimiento *</label>
                                            <input name="nacimiento" id="editNacimiento" type="date" class="form-control" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Sexo *</label>
                                            <select name="sexo" id="editSexo" class="form-control" required>
                                                <option value="">Seleccione...</option>
                                                <option value="M">Masculino</option>
                                                <option value="F">Femenino</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Teléfono</label>
                                            <input name="telefono" id="editTelefono" type="tel" class="form-control" maxlength="15">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Dirección *</label>
                                    <input name="direccion" id="editDireccion" type="text" class="form-control" maxlength="100" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="hidden" name="accion" value="actualizar">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Actualizar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <%@include file="../includes/footer-admin.jsp"%>

        </div>
        <script>
// Función para cargar datos en el modal de edición
            function editarPaciente(id, nombre, apellido, dni, nacimiento, sexo, telefono, direccion) {
                document.getElementById('editId').value = id;
                document.getElementById('editNombre').value = nombre;
                document.getElementById('editApellido').value = apellido;
                document.getElementById('editDni').value = dni;
                document.getElementById('editNacimiento').value = nacimiento;
                document.getElementById('editSexo').value = sexo;
                document.getElementById('editTelefono').value = telefono;
                document.getElementById('editDireccion').value = direccion;
            }

// Función para confirmar eliminación con SweetAlert
            function confirmarEliminar(id, nombre) {
                Swal.fire({
                    title: '¿Estás seguro?',
                    text: '¿Deseas eliminar al paciente ' + nombre + '?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Sí, eliminar',
                    cancelButtonText: 'Cancelar'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'srvPaciente?accion=eliminar&id=' + id;
                    }
                });
            }
        </script>
    </body>
</html>