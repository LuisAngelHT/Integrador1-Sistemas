<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Citas Médicas | Dashboard Admin</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    
    <%-- Archivos CSS (Bootstrap y AdminLTE) --%>
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css" >
    <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css">
    <link href="dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="dist/css/skins/skin-blue.min.css">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    
    <%-- Barra Superior / Main Header (Lo he dejado aquí, pero se puede mover a un navbar.jsp si es complejo) --%>
    <header class="main-header">
        <a href="vistaAdmin.jsp" class="logo">
            <span class="logo-mini"><b>S</b>CM</span>
            <span class="logo-lg"><b>CITAS MÉDICAS</b></span>
        </a>
        <nav class="navbar navbar-static-top" role="navigation">
            <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>
            <%-- Aquí iría el menú de usuario (dropdown) --%>
        </nav>
    </header>
