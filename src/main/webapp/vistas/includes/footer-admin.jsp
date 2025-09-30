<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Main Footer -->
<footer class="main-footer">
    <div class="pull-right hidden-xs">
        <b>Version</b> 1.0
    </div>
    <strong>Copyright &copy; 2025 <a href="#">Sistema Citas Médicas</a>.</strong> Todos los derechos reservados.
</footer>

<!-- Control Sidebar Background -->
<div class="control-sidebar-bg"></div>

<!-- Scripts necesarios -->
<script src="${pageContext.request.contextPath}/bower_components/jquery/dist/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/adminlte.min.js"></script>

<!-- Script para activar el menú tree -->
<script>
    $(document).ready(function() {
        $('.sidebar-menu').tree();
    });
</script>