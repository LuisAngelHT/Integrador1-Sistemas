<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Citas Médicas | Iniciar Sesión</title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

        <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
        <link rel="stylesheet" href="plugins/iCheck/square/blue.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
        
        <link rel="stylesheet" href="css/custom.css">
    </head>
    <body class="hold-transition login-page">

        <div class="login-box">
            <div class="login-logo">
                <img src="dist/img/LogoLogin.png" alt="Centro de Salud La Libertad" class="logo-img">
                <h2 class="center-name">Centro de Salud La Libertad SJL</h2>
            </div>

            <div class="login-box-body">
                <p class="login-box-msg">INICIAR SESIÓN</p>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fa fa-exclamation-triangle"></i> ${error}
                    </div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="alert alert-success" role="alert">
                        <i class="fa fa-check-circle"></i> ${success}
                    </div>
                </c:if>

                <form id="loginForm" action="srvUsuario?accion=verificar" method="POST" novalidate>
                    
                    <div class="form-group has-feedback">
                        <div class="input-container">
                            <input type="email" name="txtCorreo" id="txtCorreo" 
                                   class="form-control" placeholder="Correo Electrónico"
                                   aria-describedby="correo-error" required
                                   value="<c:out value="${param.txtCorreo}"/>"> <%-- Retiene el valor --%>
                            
                            <span class="form-control-feedback" aria-hidden="true"><i class="fa fa-envelope"></i></span>
                        </div>
                        <small id="correo-error" class="error-msg" role="alert">
                            <i class="fa fa-exclamation-triangle"></i> Email requerido
                        </small>
                    </div>

                    <div class="form-group has-feedback">
                        <div class="input-container">
                            <input type="password" name="txtPass" id="txtPass" 
                                   class="form-control" placeholder="Contraseña"
                                   aria-describedby="pass-error" required minlength="8">
                            
                            <span class="toggle-password fa fa-eye" 
                                  aria-label="Mostrar/ocultar contraseña" 
                                  role="button" tabindex="0"></span>
                        </div>
                        <small id="pass-error" class="error-msg" role="alert">
                            <i class="fa fa-exclamation-triangle"></i> Contraseña requerida (mínimo 8 caracteres)
                        </small>
                    </div>

                    <div class="row">
                        <div class="col-xs-12">
                            <button type="submit" class="btn btn-primary btn-login" id="btnLogin">
                                INGRESAR
                            </button>
                        </div>
                    </div>
                </form>

                <div class="social-auth-links text-center" style="margin-top: 20px;">
                    <a href="#" class="text-center forgot-password">¿Olvidaste tu contraseña?</a>
                </div>
            </div>
        </div>

        <script src="bower_components/jquery/dist/jquery.min.js"></script>
        <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="plugins/iCheck/icheck.min.js"></script>

        <script>
            // Asegurarse de que el DOM esté completamente cargado antes de ejecutar JS
            document.addEventListener("DOMContentLoaded", function() {
                
                // Elementos del formulario
                const form = document.getElementById("loginForm");
                const correo = document.getElementById("txtCorreo");
                const pass = document.getElementById("txtPass");
                const btn = document.getElementById("btnLogin");
                const togglePassword = document.querySelector(".toggle-password");
                
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                let isSubmitting = false;
                const originalBtnText = btn.innerHTML;
                
                // ===================================
                // Funciones de Utilidad (Validación y Estado)
                // ===================================

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
                    btn.innerHTML = originalBtnText;
                    isSubmitting = false;
                }
                
                // Función para cambiar la visibilidad de la contraseña
                function togglePasswordVisibility() {
                    if (pass.type === "password") {
                        pass.type = "text";
                        togglePassword.classList.remove("fa-eye");
                        togglePassword.classList.add("fa-eye-slash");
                        togglePassword.setAttribute("aria-label", "Ocultar contraseña");
                    } else {
                        pass.type = "password";
                        togglePassword.classList.remove("fa-eye-slash");
                        togglePassword.classList.add("fa-eye");
                        togglePassword.setAttribute("aria-label", "Mostrar contraseña");
                    }
                }

                // ===================================
                // Validaciones
                // ===================================

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

                // ===================================
                // Event Listeners
                // ===================================
                
                // Toggle de Contraseña
                if (togglePassword) {
                    togglePassword.addEventListener("click", togglePasswordVisibility);
                    togglePassword.addEventListener("keydown", function(e) {
                        if (e.key === "Enter" || e.key === " ") {
                            e.preventDefault();
                            togglePasswordVisibility();
                        }
                    });
                }
                
                // Validación en tiempo real (Blur y Input)
                correo.addEventListener("blur", validateEmail);
                correo.addEventListener("input", function() { if (correo.classList.contains("error")) validateEmail(); });

                pass.addEventListener("blur", validatePassword);
                pass.addEventListener("input", function() { if (pass.classList.contains("error")) validatePassword(); });

                // Manejo del envío del formulario
                form.addEventListener("submit", function (e) {
                    if (isSubmitting) {
                        e.preventDefault();
                        return;
                    }

                    const emailValid = validateEmail();
                    const passValid = validatePassword();

                    if (!emailValid || !passValid) {
                        e.preventDefault();
                        const firstError = form.querySelector(".error");
                        if (firstError) {
                            firstError.focus();
                        }
                        return;
                    }

                    // 1. Activar estado de carga (Loading)
                    isSubmitting = true;
                    btn.disabled = true;
                    btn.classList.add("loading");
                    btn.innerHTML = 'INGRESANDO'; 

                    // 2. Timeout de seguridad para resetear el botón si hay problemas
                    setTimeout(function() {
                        if (isSubmitting) {
                            console.warn("El envío excedió el tiempo de espera. Restableciendo formulario.");
                            resetFormState();
                        }
                    }, 30000); 
                });

                // Inicializar el estado si hay errores del servidor al cargar la página
                if (document.querySelector(".alert-danger")) {
                    resetFormState();
                }

                // Auto-dismiss alerts después de 5 segundos (Usando jQuery)
                setTimeout(function() {
                    $(".alert").fadeOut(500, function() {
                        $(this).remove(); 
                    });
                }, 5000);
                
                // Inicialización de iCheck (si lo usas)
                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    radioClass: 'iradio_square-blue',
                    increaseArea: '20%'
                });
            });
        </script>

    </body>
</html>