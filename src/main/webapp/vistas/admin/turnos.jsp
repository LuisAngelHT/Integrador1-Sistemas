<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="../includes/head-resources.jsp"%>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <title>CITAS MEDICAS | Gestión de Turnos</title>
    </head>

    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">

            <%@include file="../includes/header-admin.jsp"%>

            <c:set var="pageActive" value="profesionales" scope="request"/>
            <%@include file="../includes/sidebar-admin.jsp"%>

            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        Gestión de Turnos
                        <small>Definir disponibilidad semanal de profesionales</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/srvDashboardAdmin"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <li><a href="#"><i class="fa fa-user-md"></i> Profesionales</a></li>
                        <li class="active">Turnos</li>
                    </ol>
                </section>

                <section class="content">

                    <c:if test="${not empty sessionScope.mensaje}">
                        <script>
                            Swal.fire({
                                icon: '${sessionScope.tipoMensaje == "success" ? "success" : sessionScope.tipoMensaje == "warning" ? "warning" : "error"}',
                                title: '${sessionScope.tipoMensaje == "success" ? "¡Éxito!" : sessionScope.tipoMensaje == "warning" ? "Advertencia" : "Error"}',
                                text: '${sessionScope.mensaje}',
                                confirmButtonColor: '#3085d6'
                            });
                        </script>
                        <c:remove var="mensaje" scope="session"/>
                        <c:remove var="tipoMensaje" scope="session"/>
                    </c:if>

                    <!-- FILTROS -->
                    <div class="row" style="margin-bottom: 15px;">
                        <div class="col-xs-12">
                            <div class="box box-info collapsed-box">
                                <div class="box-header with-border">
                                    <h3 class="box-title"><i class="fa fa-filter"></i> Opciones de Filtrado</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                </div>
                                <form action="${pageContext.request.contextPath}/srvTurno" method="GET">
                                    <input type="hidden" name="accion" value="listar">
                                    <div class="box-body">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="filtroIdProfesional">Profesional:</label>
                                                    <select id="filtroIdProfesional" name="filtroIdProfesional" class="form-control">
                                                        <option value="">-- Todos los Profesionales --</option>
                                                        <c:forEach var="p" items="${profesionales}">
                                                            <option value="${p.idProfesional}" ${param.filtroIdProfesional == p.idProfesional ? 'selected' : ''}>
                                                                ${p.nombreCompleto}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="filtroDiaSemana">Día de la Semana:</label>
                                                    <select id="filtroDiaSemana" name="filtroDiaSemana" class="form-control">
                                                        <option value="">-- Todos los Días --</option>
                                                        <option value="lunes" ${param.filtroDiaSemana == 'lunes' ? 'selected' : ''}>Lunes</option>
                                                        <option value="martes" ${param.filtroDiaSemana == 'martes' ? 'selected' : ''}>Martes</option>
                                                        <option value="miércoles" ${param.filtroDiaSemana == 'miércoles' ? 'selected' : ''}>Miércoles</option>
                                                        <option value="jueves" ${param.filtroDiaSemana == 'jueves' ? 'selected' : ''}>Jueves</option>
                                                        <option value="viernes" ${param.filtroDiaSemana == 'viernes' ? 'selected' : ''}>Viernes</option>
                                                        <option value="sábado" ${param.filtroDiaSemana == 'sábado' ? 'selected' : ''}>Sábado</option>
                                                        <option value="domingo" ${param.filtroDiaSemana == 'domingo' ? 'selected' : ''}>Domingo</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="filtroTurno">Turno:</label>
                                                    <select id="filtroTurno" name="filtroTurno" class="form-control">
                                                        <option value="">-- Ambos Turnos --</option>
                                                        <option value="manana" ${param.filtroTurno == 'manana' ? 'selected' : ''}>Mañana (08:00 - 12:00)</option>
                                                        <option value="tarde" ${param.filtroTurno == 'tarde' ? 'selected' : ''}>Tarde (12:00 - 18:00)</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="box-footer">
                                        <button type="submit" class="btn btn-primary btn-sm"><i class="fa fa-search"></i> Aplicar Filtros</button>
                                        <a href="${pageContext.request.contextPath}/srvTurno?accion=listar" class="btn btn-default btn-sm"><i class="fa fa-eraser"></i> Limpiar</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- TABLA -->
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="box box-primary">
                                <div class="box-header with-border">
                                    <h3 class="box-title"><i class="fa fa-clock-o"></i> Lista de Turnos</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#modalRegistroTurno">
                                            <i class="fa fa-plus"></i> Añadir Turno
                                        </button>
                                    </div>
                                </div>

                                <div class="box-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover table-striped">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Profesional</th>
                                                    <th>Día</th>
                                                    <th>Hora Inicio</th>
                                                    <th>Hora Fin</th>
                                                    <th>Duración</th>
                                                    <th>Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:choose>
                                                    <c:when test="${not empty turnos}">
                                                        <c:forEach var="t" items="${turnos}">
                                                            <tr>
                                                                <td>${t.idTurno}</td>
                                                                <td>
                                                                    <i class="fa fa-user-md text-primary"></i>
                                                                    <strong>${t.nombreProfesional}</strong>
                                                                </td>
                                                                <td>
                                                                    <span class="label label-info">${t.diaSemana}</span>
                                                                </td>
                                                                <td><i class="fa fa-clock-o"></i> ${t.horaInicio}</td>
                                                                <td><i class="fa fa-clock-o"></i> ${t.horaFin}</td>
                                                                <td>
                                                                    <span class="label label-success" id="duracion-${t.idTurno}"></span>
                                                                    <script>
                                                                        (() => {
                                                                            const inicio = '${t.horaInicio}'.split(':');
                                                                            const fin = '${t.horaFin}'.split(':');
                                                                            const minutos = (parseInt(fin[0]) * 60 + parseInt(fin[1])) -
                                                                                    (parseInt(inicio[0]) * 60 + parseInt(inicio[1]));
                                                                            const horas = (minutos / 60).toFixed(1);
                                                                            document.getElementById('duracion-${t.idTurno}').textContent = horas + ' h';
                                                                        })();
                                                                    </script>
                                                                </td>
                                                                <td>
                                                                    <button class="btn btn-primary btn-xs"
                                                                            onclick="cargarDatosEdicion(${t.idTurno}, '${t.nombreProfesional}', '${t.diaSemana}', '${t.horaInicio}', '${t.horaFin}', ${t.idProfesional})">
                                                                        <i class="fa fa-pencil"></i>
                                                                    </button>
                                                                    <button class="btn btn-danger btn-xs"
                                                                            onclick="confirmarEliminacion(${t.idTurno})">
                                                                        <i class="fa fa-trash"></i>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <tr>
                                                            <td colspan="7" class="text-center">
                                                                <div class="alert alert-info">
                                                                    <i class="fa fa-info-circle"></i> No hay turnos registrados.
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>

            <!-- MODAL REGISTRO -->
            <div class="modal fade" id="modalRegistroTurno">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="${pageContext.request.contextPath}/srvTurno" method="POST" onsubmit="return validarHorario('regHoraInicio', 'regHoraFin')">
                            <input type="hidden" name="accion" value="registrar">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title"><i class="fa fa-plus-circle"></i> Registrar Nuevo Turno</h4>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="regIdProfesional">Profesional *</label>
                                    <select id="regIdProfesional" name="idProfesional" class="form-control" required>
                                        <option value="">Seleccione un profesional</option>
                                        <c:forEach var="p" items="${profesionales}">
                                            <option value="${p.idProfesional}">${p.nombreCompleto}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="regDiaSemana">Día de la Semana *</label>
                                    <select id="regDiaSemana" name="diaSemana" class="form-control" required>
                                        <option value="lunes">Lunes</option>
                                        <option value="martes">Martes</option>
                                        <option value="miércoles">Miércoles</option>
                                        <option value="jueves">Jueves</option>
                                        <option value="viernes">Viernes</option>
                                        <option value="sábado">Sábado</option>
                                        <option value="domingo">Domingo</option>
                                    </select>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="regHoraInicio">Hora Inicio *</label>
                                            <input type="time" id="regHoraInicio" name="horaInicio" class="form-control" min="08:00" max="18:00" required>
                                            <small class="text-muted">Entre 08:00 y 18:00</small>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="regHoraFin">Hora Fin *</label>
                                            <input type="time" id="regHoraFin" name="horaFin" class="form-control" min="08:00" max="18:00" required>
                                            <small class="text-muted">Entre 08:00 y 18:00</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-success"><i class="fa fa-save"></i> Registrar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- MODAL EDICIÓN -->
            <div class="modal fade" id="modalEdicionTurno">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="${pageContext.request.contextPath}/srvTurno" method="POST" onsubmit="return validarHorario('editHoraInicio', 'editHoraFin')">
                            <input type="hidden" name="accion" value="actualizar">
                            <input type="hidden" id="editIdTurno" name="idTurno">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title"><i class="fa fa-pencil"></i> Editar Turno</h4>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="editIdProfesional">Profesional *</label>
                                    <select id="editIdProfesional" name="idProfesional" class="form-control" required>
                                        <c:forEach var="p" items="${profesionales}">
                                            <option value="${p.idProfesional}">${p.nombreCompleto}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="editDiaSemana">Día de la Semana *</label>
                                    <select id="editDiaSemana" name="diaSemana" class="form-control" required>
                                        <option value="lunes">Lunes</option>
                                        <option value="martes">Martes</option>
                                        <option value="miércoles">Miércoles</option>
                                        <option value="jueves">Jueves</option>
                                        <option value="viernes">Viernes</option>
                                        <option value="sábado">Sábado</option>
                                        <option value="domingo">Domingo</option>
                                    </select>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="editHoraInicio">Hora Inicio *</label>
                                            <input type="time" id="editHoraInicio" name="horaInicio" class="form-control" min="08:00" max="18:00" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="editHoraFin">Hora Fin *</label>
                                            <input type="time" id="editHoraFin" name="horaFin" class="form-control" min="08:00" max="18:00" required>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Guardar Cambios</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <%@include file="../includes/footer-admin.jsp"%>
        </div>

        <script>
            function confirmarEliminacion(id) {
                Swal.fire({
                    title: '¿Estás seguro?',
                    text: "Esta disponibilidad será eliminada permanentemente.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Sí, eliminar',
                    cancelButtonText: 'Cancelar'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = '${pageContext.request.contextPath}/srvTurno?accion=eliminar&id=' + id;
                    }
                });
            }

            function cargarDatosEdicion(idTurno, nombreProf, dia, inicio, fin, idProfesional) {
                document.getElementById('editIdTurno').value = idTurno;
                document.getElementById('editHoraInicio').value = inicio;
                document.getElementById('editHoraFin').value = fin;
                document.getElementById('editIdProfesional').value = idProfesional;
                document.getElementById('editDiaSemana').value = dia;
                $('#modalEdicionTurno').modal('show');
            }

            function validarHorario(idInicio, idFin) {
                const inicioStr = document.getElementById(idInicio).value;
                const finStr = document.getElementById(idFin).value;

                if (!inicioStr || !finStr) {
                    Swal.fire('Advertencia', 'Debe seleccionar ambas horas.', 'warning');
                    return false;
                }
                if (inicioStr >= finStr) {
                    Swal.fire('Error', 'La hora de inicio debe ser menor que la de fin.', 'error');
                    return false;
                }
                return true;
            }
        </script>

    </body>
</html>