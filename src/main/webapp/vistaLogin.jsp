<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Citas Médicas | Iniciar Sesión</title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

        <!-- Bootstrap 3.3.7 -->
        <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">
        <!-- Ionicons -->
        <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
        <!-- iCheck -->
        <link rel="stylesheet" href="plugins/iCheck/square/blue.css">
        <!-- Google Fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
        <!-- CSS personalizado -->
        <link rel="stylesheet" href="css/custom.css">
    </head>
    <body class="hold-transition login-page">

        <div class="login-box">
            <!-- Logo -->
            <div class="login-logo">
    <img src="dist/img/LogoLogin.png" alt="Centro de Salud La Libertad" class="logo-img">
    <h2 class="center-name">Centro de Salud La Libertad SJL</h2>
</div>

            <!-- Caja del login -->
            <div class="login-box-body">
                <p class="login-box-msg">INICIAR SESIÓN</p>

                <form id="loginForm" action="srvUsuario?accion=verificar" method="POST">
                    <!-- Campo Email -->
                    <div class="form-group has-feedback">
                        <div class="input-container">
                            <input type="text" name="txtCorreo" id="txtCorreo" class="form-control" placeholder="Correo Electrónico">
                            <!-- icono email (Bootstrap) -->
                            <span class="fa fa-envelope form-control-feedback"></span>
                        </div>
                        <small id="correo-error" class="error-msg">Email requerido</small>
                    </div>

                    <!-- Campo Password -->
                    <div class="form-group has-feedback">
                        <div class="input-container">
                            <input type="password" name="txtPass" id="txtPass" class="form-control" placeholder="Contraseña">
                            <!-- icono ojo -->
                            <span class="toggle-password fa fa-eye"></span>
                        </div>
                        <small id="pass-error" class="error-msg">La contraseña es incorrecta</small>
                    </div>



                    <!-- Botón -->
                    <div class="row">
                        <div class="col-xs-12">
                            <button type="submit" class="btn btn-primary btn-login">INGRESAR</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Scripts -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>
        <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="plugins/iCheck/icheck.min.js"></script>

        <script>
            // ===== iCheck inicial =====
            $(function () {
                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    radioClass: 'iradio_square-blue',
                    increaseArea: '20%'
                });
            });

            // ===== Mostrar/Ocultar contraseña =====
            document.querySelector(".toggle-password").addEventListener("click", function () {
                let input = document.getElementById("txtPass");
                if (input.type === "password") {
                    input.type = "text";
                    this.classList.remove("fa-eye");
                    this.classList.add("fa-eye-slash");
                } else {
                    input.type = "password";
                    this.classList.remove("fa-eye-slash");
                    this.classList.add("fa-eye");
                }
            });

            // ===== Validaciones y Loading =====
            const form = document.getElementById("loginForm");
            const correo = document.getElementById("txtCorreo");
            const pass = document.getElementById("txtPass");
            const btn = document.querySelector(".btn-login");

            form.addEventListener("submit", function (e) {
                let valido = true;

                // Validación correo
                if (correo.value.trim() === "") {
                    correo.classList.add("error");
                    correo.classList.remove("success");
                    document.getElementById("correo-error").style.display = "block";
                    valido = false;
                } else {
                    correo.classList.remove("error");
                    correo.classList.add("success");
                    document.getElementById("correo-error").style.display = "none";
                }

                // Validación contraseña
                if (pass.value.length < 8) {
                    pass.classList.add("error");
                    pass.classList.remove("success");
                    document.getElementById("pass-error").style.display = "block";
                    valido = false;
                } else {
                    pass.classList.remove("error");
                    pass.classList.add("success");
                    document.getElementById("pass-error").style.display = "none";
                }

                if (!valido) {
                    e.preventDefault();
                    return;
                }

                // Loading en el botón
                btn.disabled = true;
                btn.innerHTML = '<i class="fa fa-spinner fa-spin"></i> Ingresando...';
            });
        </script>

    </body>
</html>

