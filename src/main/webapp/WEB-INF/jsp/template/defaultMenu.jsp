<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8">
	<meta name="robots" content="noindex,follow">
	<title>Mi Vista - Sistema de Gesti&oacute;n de Indicadores</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<link rel="stylesheet" type="text/css" href="css\default.css">
	<link rel="stylesheet" type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css\common_config.css">
	<link rel="stylesheet" type="text/css" href="css\status_config.css">
	<link rel="stylesheet" type="text/css" href="css\dropzone.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/css/bootstrap-datetimepicker.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css\ace.min.css">
	<link rel="stylesheet" type="text/css" href="css\ace-mantis.css">
	<link rel="stylesheet" type="text/css" href="css\ace-skins.min.css">
	<link rel="shortcut icon" href="images\favicon.ico" type="image/x-icon">
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js" integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw=" crossorigin="anonymous"></script>
</head>
<body class="skin-3">
	<div id="navbar" class="navbar navbar-default navbar-collapse navbar-fixed-top noprint">
	<div id="navbar-container" class="navbar-container">
	<button id="menu-toggler" type="button" class="navbar-toggle menu-toggler pull-left hidden-lg" data-target="#sidebar">
		<span class="sr-only">Toggle sidebar</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
	</button>
	<div class="navbar-header">
		<a href="#" class="navbar-brand"><span class="smaller-75"> Sistema de Gesti&oacute;n de Indicadores </span></a>
		<button type="button" class="navbar-toggle navbar-toggle-img collapsed pull-right hidden-sm hidden-md hidden-lg" data-toggle="collapse" data-target=".navbar-buttons,.navbar-menu">
			<span class="sr-only">Toggle user menu</span><img class="nav-user-photo" src="https://secure.gravatar.com/avatar/6961e2f6353cdc06d6f2b33a67d8ff72?d=identicon&amp;r=G&amp;s=32" alt="Administrador">
		</button>
	</div>
	<div class="navbar-buttons navbar-header navbar-collapse collapse">
		<ul class="nav ace-nav">
			<li class="grey">
				<a data-toggle="dropdown" href="#" class="dropdown-toggle">
					<img class="nav-user-photo" src="https://secure.gravatar.com/avatar/6961e2f6353cdc06d6f2b33a67d8ff72?d=identicon&amp;r=G&amp;s=32" alt="administrador">
					<span class="user-info">administrador</span>
					<i class="ace-icon fa fa-angle-down"></i>
				</a>
				<ul class="user-menu dropdown-menu dropdown-menu-right dropdown-yellow dropdown-caret dropdown-close">
				<!-- 
					<li><a href="./usuario.html"><i class="ace-icon fa fa-user"> </i> Mi cuenta</a></li>
					<li class="divider"></li>
				-->
					<li><a href="./index.html"><i class="ace-icon fa fa-sign-out"> </i> Salir</a></li>
				</ul>
			</li>
			</ul>
			</div>
		</div>
	</div>
	<div class="main-container" id="main-container">
	<div id="sidebar" class="sidebar sidebar-fixed responsive compact ">
	<ul class="nav nav-list">
		<li class="active">
			<a href="./my_view_page.html">
				<i class="menu-icon fa fa-cubes"></i>
				<span class="menu-text"> Vista General </span>
			</a>
			<b class="arrow"></b>
		</li>
		<li>
			<a href="./registro_indicadores.html">
				<i class="menu-icon fa fa-tachometer"></i>
				<span class="menu-text"> Registro Indicadores </span>
			</a>
			<b class="arrow"></b>
		</li>
	</ul>
	<div id="sidebar" class="sidebar-toggle sidebar-collapse">
		<i data-icon2="ace-icon fa fa-angle-double-right" data-icon1="ace-icon fa fa-angle-double-left" class="ace-icon fa fa-angle-double-left"></i>
	</div>
</div>
<div class="main-content">
	<div id="breadcrumbs" class="breadcrumbs noprint">
		<ul class="breadcrumb">
		  <li>
		  <i class="fa fa-user home-icon active"></i>  
			  <a href="#">Administrador ( Telly Tataje ) </a>
			  <span class="label hidden-xs label-default arrowed">Administrador</span>
		  </li>
		</ul>
	</div>
<div class="page-content">
<div class="row">
	<img src="./images/regionica_front.png" />
</div>
</div>
</div>
<div class="clearfix"></div>
<div class="space-20"></div>
<div class="footer noprint">
<div class="footer-inner">
<div class="footer-content">
<div class="col-md-6 col-xs-12 no-padding">
</div>
<div class="col-md-6 col-xs-12">
<div class="pull-right" id="powered-by-mantisbt-logo">
<img src="images\regionica_pie.png" height="35" alt="Powered by smartcore an internet company.">
</div>
</div>
</div>
</div>
</div>
<a class="btn-scroll-up btn btn-sm btn-inverse display" id="btn-scroll-up" href="#">
<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
</a>
</div>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha256-KXn5puMvxCw+dAYznun+drMdG1IFl3agK0p/pqT9KAo=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.2/moment-with-locales.min.js" integrity="sha256-K+AZsAFjiBd4piqBmFzaxDsiQiHfREubm1ExNGW1JIA=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/js/bootstrap-datetimepicker.min.js" integrity="sha256-I8vGZkA2jL0PptxyJBvewDVqNXcgIhcgeqi+GD/aw34=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="js\ace-extra.min.js"></script>
	<script type="text/javascript" src="js\ace-elements.min.js"></script>
	<script type="text/javascript" src="js\ace.min.js"></script>

</body>
</html>















<!-- ---------------------------------------------- -->

<html>
 
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title><tiles:getAsString name="title" /></title>
    <link href="<c:url value='/static/css/bootstrap.css' />"  rel="stylesheet"></link>
    <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
</head>
  
<body>
        <header id="header">
            <tiles:insertAttribute name="header" />
        </header>
     
        <section id="sidemenu">
            <tiles:insertAttribute name="menu" />
        </section>
             
        <section id="site-content">
            <tiles:insertAttribute name="body" />
        </section>
         
        <footer id="footer">
            <tiles:insertAttribute name="footer" />
        </footer>
</body>
</html>