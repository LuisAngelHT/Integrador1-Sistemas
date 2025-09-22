<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Sistema | Iniciar Session</title>
        <!-- Tell the browser to be responsive to screen width -->
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

        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
        <style>
        body.login-page {
            /* Color de respaldo por si la imagen no carga */
            background-color: #2c3e50; 
            /* URL de la imagen de fondo*/
            background-image: url("https://i.pinimg.com/736x/57/35/20/573520dd3e12fff1397350e7e59f6c5b.jpg");
            /* Propiedades para evitar el efecto de mosaico y asegurar que la imagen cubra todo */
            background-repeat: no-repeat;
            background-size: cover; 
            background-position: center;
        }
        .login-box-msg {
            font-size: 20px;
            font-weight: bold
        }
        </style>
    </head>
    <body class="hold-transition login-page">
        <div class="login-box">
            <div class="login-logo">
                <a style="color: white; font-size: 45px" href="#"><b>CITAS MEDICAS</b></a>
            </div>
            
            <!-- /.login-logo -->
            <div class="login-box-body">
                <p class="login-box-msg">INICIAR SESION</p>

                <form action="srvUsuario?accion=verificar" method="POST">
                    <div class="form-group has-feedback">
                        <input type="text" name="txtCorreo" id="txtCorreo" value="" class="form-control"  placeholder="Correo Electronico">
                        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                    </div>
                    <div class="form-group has-feedback">
                        <input type="password" name="txtPass" id="txtPass" value="" class="form-control" placeholder="******">
                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                    </div>
                    <div class="row">
                        
                        <!-- /.col -->
                        <div class="col-xs-12">
                            <input type="submit" name="verificar" value="INGRESAR" class="btn btn-primary btn-block"/>
                        </div>
                        <!-- /.col -->
                    </div>
                </form>

                <div class="social-auth-links text-center">
                    <p>-- Verificación de Credenciales --</p>
                    <a href="#" class="btn btn-block btn-social btn-facebook btn-flat"><i class="fa fa-info"></i> Mensaje: 
                        ${msje}</a>
                </div>
                <!-- /.social-auth-links -->


            </div>
            <!-- /.login-box-body -->
        </div>
        <!-- /.login-box -->

        <!-- jQuery 3 -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>
        <!-- Bootstrap 3.3.7 -->
        <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
        <!-- iCheck -->
        <script src="plugins/iCheck/icheck.min.js"></script>
        <script>
            $(function () {
                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    radioClass: 'iradio_square-blue',
                    increaseArea: '20%' /* optional */
                });
            });
        </script>
    </body>
</html>

