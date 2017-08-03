<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
 
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8">
	<meta name="robots" content="noindex,follow">
	<title></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<link rel="stylesheet" type="text/css" href="..\css\default.css">
	<link rel="stylesheet" type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="..\css\common_config.css">
	<link rel="stylesheet" type="text/css" href="..\css\status_config.css">
	<link rel="stylesheet" type="text/css" href="..\css\dropzone.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/css/bootstrap-datetimepicker.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="..\css\ace.min.css">
	<link rel="stylesheet" type="text/css" href="..\css\ace-mantis.css">
	<link rel="stylesheet" type="text/css" href="..\css\ace-skins.min.css">
	<link rel="shortcut icon" href="..\images\favicon.ico" type="image/x-icon">
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js" integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw=" crossorigin="anonymous"></script>

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/javascript-canvas-to-blob/3.8.0/js/canvas-to-blob.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>

	<style>
    canvas {
        -moz-user-select: none;
        -webkit-user-select: none;
        -ms-user-select: none;
    }
    .page-title {
    	position: relative;
    	background: url(${pageContext.request.contextPath}/images/pdf_titulo.png);
    	background-repeat: no-repeat;
    	background-position: center;
    	line-height: 1.4; 
    	padding: 137px 20px 1000px 469px;
    	width: 150px;
    	margin: 20px auto;
    }
    .page-title span {
    	position: absolute;
    	color: #000000;
    	font-family: arial;
    	font-weight: bold;
    	display: inline;
	    top: 350px;
	    left: 63px;
		font-size: xx-large;
    	-webkit-box-decoration-break: clone;
    	box-decoration-break: clone;
    }
    .title-chart{
    	font-family: arial;
    	font-weight: bold;
    	color: #000000;
    	font-size: large;
    }
    </style>
</head>
<body class="skin-3">
	<div class="main-container" id="main-container">
		<div class="main-content">     
		    <div class="page-content">
		    <tiles:insertAttribute name="body" />
			</div>
		</div>
 		<div class="clearfix"></div>
		<div class="space-20"></div>
		<a class="btn-scroll-up btn btn-sm btn-inverse display" id="btn-scroll-up" href="#">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>
	</div>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha256-KXn5puMvxCw+dAYznun+drMdG1IFl3agK0p/pqT9KAo=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.2/moment-with-locales.min.js" integrity="sha256-K+AZsAFjiBd4piqBmFzaxDsiQiHfREubm1ExNGW1JIA=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/js/bootstrap-datetimepicker.min.js" integrity="sha256-I8vGZkA2jL0PptxyJBvewDVqNXcgIhcgeqi+GD/aw34=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="..\js\ace-extra.min.js"></script>
	<script type="text/javascript" src="..\js\ace-elements.min.js"></script>
	<script type="text/javascript" src="..\js\ace.min.js"></script>
</body>
</html>