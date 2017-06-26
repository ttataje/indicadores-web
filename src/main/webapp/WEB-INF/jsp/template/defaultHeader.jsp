<!-- Inicio Barra Navegacion  -->
<div id="navbar" class="navbar navbar-default navbar-collapse navbar-fixed-top noprint">
	<div id="navbar-container" class="navbar-container">
		<button id="menu-toggler" type="button" class="navbar-toggle menu-toggler pull-left hidden-lg" data-target="#sidebar">
			<span class="sr-only">Toggle sidebar</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
		</button>
		<div class="navbar-header">
			<a href="#" class="navbar-brand"><span class="smaller-75"> Sistema de Gesti&oacute;n de Indicadores </span></a>
			<button type="button" class="navbar-toggle navbar-toggle-img collapsed pull-right hidden-sm hidden-md hidden-lg" data-toggle="collapse" data-target=".navbar-buttons,.navbar-menu">
				<span class="sr-only">Toggle user menu</span>
				<img class="nav-user-photo" src="https://secure.gravatar.com/avatar/6961e2f6353cdc06d6f2b33a67d8ff72?d=identicon&amp;r=G&amp;s=32" alt="${usuario.rol }">
			</button>
		</div>
		<div class="navbar-buttons navbar-header navbar-collapse collapse">
			<ul class="nav ace-nav">
				<li class="grey">
					<a data-toggle="dropdown" href="#" class="dropdown-toggle">
						<img class="nav-user-photo" src="https://secure.gravatar.com/avatar/6961e2f6353cdc06d6f2b33a67d8ff72?d=identicon&amp;r=G&amp;s=32" alt="${usuario.rol }">
						<span class="user-info">${usuario.rol }</span>
						<i class="ace-icon fa fa-angle-down"></i>
					</a>
					<ul class="user-menu dropdown-menu dropdown-menu-right dropdown-yellow dropdown-caret dropdown-close">
						<li><a href="${pageContext.request.contextPath}/logout"><i class="ace-icon fa fa-sign-out"> </i> Salir</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</div>
<!-- Fin Barra Navegacion  -->