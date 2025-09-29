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

                <!-- Manejo de errores del servidor -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <i class="fa fa-exclamation-triangle"></i> ${error}
                    </div>
                </c:if>

                <!-- Mensaje de éxito si existe -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <i class="fa fa-check-circle"></i> ${success}
                    </div>
                </c:if>

                <form id="loginForm" action="srvUsuario?accion=verificar" method="POST" novalidate>
                    <!-- Campo Email -->
                    <div class="form-group has-feedback">
                        <div class="input-container">
                            <input type="email" name="txtCorreo" id="txtCorreo" 
                                   class="form-control" placeholder="Correo Electrónico"
                                   aria-describedby="correo-error" required>
                            <!-- icono email (Bootstrap) -->
                            <span class="fa fa-envelope form-control-feedback" aria-hidden="true"></span>
                        </div>
                        <small id="correo-error" class="error-msg" role="alert">
                            <i class="fa fa-exclamation-triangle"></i> Email requerido
                        </small>
                    </div>

                    <!-- Campo Password -->
                    <div class="form-group has-feedback">
                        <div class="input-container">
                            <input type="password" name="txtPass" id="txtPass" 
                                   class="form-control" placeholder="Contraseña"
                                   aria-describedby="pass-error" required minlength="8">
                            <!-- icono ojo -->
                            <span class="toggle-password fa fa-eye" 
                                  aria-label="Mostrar/ocultar contraseña" 
                                  role="button" tabindex="0"></span>
                        </div>
                        <small id="pass-error" class="error-msg" role="alert">
                            <i class="fa fa-exclamation-triangle"></i> Contraseña requerida (mínimo 8 caracteres)
                        </small>
                    </div>

                    <!-- Botón -->
                    <div class="row">
                        <div class="col-xs-12">
                            <button type="submit" class="btn btn-primary btn-login" id="btnLogin">
                                INGRESAR
                            </button>
                        </div>
                    </div>
                </form>

                <!-- Enlaces adicionales (opcional) -->
                <div class="social-auth-links text-center" style="margin-top: 20px;">
                    <a href="#" class="text-center forgot-password">¿Olvidaste tu contraseña?</a>
                </div>
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
            const togglePassword = document.querySelector(".toggle-password");
            
            // Soporte para click y teclado
            function togglePasswordVisibility() {
                const input = document.getElementById("txtPass");
                if (input.type === "password") {
                    input.type = "text";
                    togglePassword.classList.remove("fa-eye");
                    togglePassword.classList.add("fa-eye-slash");
                    togglePassword.setAttribute("aria-label", "Ocultar contraseña");
                } else {
                    input.type = "password";
                    togglePassword.classList.remove("fa-eye-slash");
                    togglePassword.classList.add("fa-eye");
                    togglePassword.setAttribute("aria-label", "Mostrar contraseña");
                }
            }

            togglePassword.addEventListener("click", togglePasswordVisibility);
            togglePassword.addEventListener("keydown", function(e) {
                if (e.key === "Enter" || e.key === " ") {
                    e.preventDefault();
                    togglePasswordVisibility();
                }
            });

            // ===== Validaciones y Loading Mejoradas =====
            const form = document.getElementById("loginForm");
            const correo = document.getElementById("txtCorreo");
            const pass = document.getElementById("txtPass");
            const btn = document.getElementById("btnLogin");
            
            // Regex para validación de email
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            let isSubmitting = false;

            // Funciones de validación
            function validateEmail() {
                const correoError = document.getElementById("correo-error");
                if (correo.value.trim() === "") {
                    showFieldError(correo, correoError, "Email requerido");
                    return false;
                } else if (!emailRegex.test(correo.value)) {
                    showFieldError(correo, correoError, "Formato de email inválido");
                    return false;
                } else {
                    showFieldSuccess(correo, correoError);
                    return true;
                }
            }

            function validatePassword() {
                const passError = document.getElementById("pass-error");
                if (pass.value.length < 8) {
                    showFieldError(pass, passError, "Contraseña requerida (mínimo 8 caracteres)");
                    return false;
                } else {
                    showFieldSuccess(pass, passError);
                    return true;
                }
            }

            function showFieldError(field, errorElement, message) {
                field.classList.add("error");
                field.classList.remove("success");
                errorElement.innerHTML = '<i class="fa fa-exclamation-triangle"></i> ' + message;
                errorElement.style.display = "block";
            }

            function showFieldSuccess(field, errorElement) {
                field.classList.remove("error");
                field.classList.add("success");
                errorElement.style.display = "none";
            }

            function resetFormState() {
                btn.disabled = false;
                btn.classList.remove("loading");
                btn.innerHTML = "INGRESAR";
                isSubmitting = false;
            }

            // Validación en tiempo real
            correo.addEventListener("blur", validateEmail);
            correo.addEventListener("input", function() {
                if (correo.classList.contains("error")) {
                    validateEmail();
                }
            });

            pass.addEventListener("blur", validatePassword);
            pass.addEventListener("input", function() {
                if (pass.classList.contains("error")) {
                    validatePassword();
                }
            });

            // Manejo del envío del formulario
            form.addEventListener("submit", function (e) {
                // Prevenir envíos múltiples
                if (isSubmitting) {
                    e.preventDefault();
                    return;
                }

                // Validaciones
                const emailValid = validateEmail();
                const passValid = validatePassword();

                if (!emailValid || !passValid) {
                    e.preventDefault();
                    // Focus en el primer campo con error
                    const firstError = form.querySelector(".error");
                    if (firstError) {
                        firstError.focus();
                    }
                    return;
                }

                // Activar estado de carga
                isSubmitting = true;
                btn.disabled = true;
                btn.classList.add("loading");
                btn.innerHTML = '<i class="fa fa-spinner fa-spin"></i> Ingresando...';

                // Timeout de seguridad para resetear el botón si hay problemas
                setTimeout(function() {
                    if (isSubmitting) {
                        resetFormState();
                    }
                }, 30000); // 30 segundos
            });

            // Resetear estado si hay errores del servidor
            document.addEventListener("DOMContentLoaded", function() {
                if (document.querySelector(".alert-danger")) {
                    resetFormState();
                }
            });

            // Auto-dismiss alerts después de 5 segundos
            setTimeout(function() {
                const alerts = document.querySelectorAll(".alert");
                alerts.forEach(function(alert) {
                    $(alert).fadeOut(500);
                });
            }, 5000);
        </script>

    </body>
</html>

