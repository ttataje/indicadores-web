<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
 
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8">
	<meta name="robots" content="noindex,follow">
	<title><tiles:getAsString name="title" /></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<link rel="stylesheet" type="text/css" href="css\default.css">
	<link rel="stylesheet" type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css\common_config.css">
	<link rel="stylesheet" type="text/css" href="css\status_config.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/css/bootstrap-datetimepicker.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css\ace.min.css">
	<link rel="stylesheet" type="text/css" href="css\ace-mantis.css">
	<link rel="stylesheet" type="text/css" href="css\ace-skins.min.css">
	<link rel="shortcut icon" href="images\favicon.ico" type="image/x-icon">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js" integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
	<style>
    canvas {
        -moz-user-select: none;
        -webkit-user-select: none;
        -ms-user-select: none;
    }
    </style>
</head>
<body class="skin-3">
	<header id="header">
	    <tiles:insertAttribute name="header" />
	</header>
	<div class="main-container" id="main-container">
		<section id="sidemenu">
		    <tiles:insertAttribute name="menu" />
		</section>
		<!-- Inicio Contenido -->
		<div class="main-content">     
		<section id="site-content">
		    <tiles:insertAttribute name="searchbar" />
		    <tiles:insertAttribute name="body" />
		</section>
		</div>
 
	
		<div class="clearfix"></div>
		<div class="space-20"></div>
		<div class="footer noprint">
			<footer id="footer">
			    <tiles:insertAttribute name="footer" />
			</footer>
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