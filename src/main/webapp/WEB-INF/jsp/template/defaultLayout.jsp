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
	<link rel="stylesheet" type="text/css" href="css\login.css">
	<link rel="stylesheet" type="text/css" href="css\dropzone.css">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/css/bootstrap-datetimepicker.min.css" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css\ace.min.css">
	<link rel="stylesheet" type="text/css" href="css\ace-mantis.css">
	<link rel="stylesheet" type="text/css" href="css\ace-skins.min.css">
	<script type="text/javascript" src="javascript_config.php"></script>
	<script type="text/javascript" src="javascript_translations.php"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js" integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="js\dropzone.min.js"></script>
	<script type="text/javascript" src="js\common.js"></script>
	<link rel="shortcut icon" href="images\favicon.ico" type="image/x-icon">
	<link rel="search" type="application/opensearchdescription+xml" title="MantisBT: Text Search" href="browser_search_plugin.php?type=text">
	<link rel="search" type="application/opensearchdescription+xml" title="MantisBT: Issue Id" href="browser_search_plugin-1.php?type=id">
	<script type="text/javascript" src="javascript_config.php"></script>
	<script type="text/javascript" src="javascript_translations.php"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js" integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw=" crossorigin="anonymous"></script>
</head>
<body class="login-layout light-login">
	<div class="main-container" id="main-container">
		<div class="main-content">
			<div class="row">
				<div class="col-md-offset-3 col-md-6 col-sm-10 col-sm-offset-1">
					<section id="site-content">
					    <tiles:insertAttribute name="body" />
					</section>
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
					</div>
				</div>
			</div>
	</div>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha256-KXn5puMvxCw+dAYznun+drMdG1IFl3agK0p/pqT9KAo=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.2/moment-with-locales.min.js" integrity="sha256-K+AZsAFjiBd4piqBmFzaxDsiQiHfREubm1ExNGW1JIA=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/js/bootstrap-datetimepicker.min.js" integrity="sha256-I8vGZkA2jL0PptxyJBvewDVqNXcgIhcgeqi+GD/aw34=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="js\ace-extra.min.js"></script>
	<script type="text/javascript" src="js\ace-elements.min.js"></script>
	<script type="text/javascript" src="js\ace.min.js"></script>
</body>
</html>
