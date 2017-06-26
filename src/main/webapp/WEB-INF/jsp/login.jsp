<div id="login-div" class="login-container">
	<div class="space-12 hidden-480"></div>
	<a href="my_view_page.htm">
		<h1 class="center white">
			<img src="${pageContext.request.contextPath}/images/regionica_logo.png">
		</h1>
	</a>
	<div class="space-24 hidden-480"></div>
	<div class="position-relative">
		<div class="signup-box visible widget-box no-border" id="login-box">
			<div class="widget-body">
				<div class="widget-main">
					<h4 class="header lighter bigger">
						<i class="ace-icon fa fa-sign-in"></i>
				 		Inicio de sesi&oacute;n
				 	</h4>
					<div class="space-10"></div>

					<!-- Login Form BEGIN -->
					<form id="login-form" method="post" action="${pageContext.request.contextPath}/login">
					<fieldset>
						<label for="username" class="block clearfix">
							<span class="block input-icon input-icon-right">
								<input id="username" name="username" type="text" placeholder="Nombre de usuario" size="32" maxlength="191" value="" class="form-control autofocus">
								<i class="ace-icon fa fa-user"></i>
							</span>
						</label>
						<label for="password" class="block clearfix">
							<span class="block input-icon input-icon-right">
								<input id="password" name="password" type="password" placeholder="Contraseña" size="32" maxlength="1024" class="form-control ">
								<i class="ace-icon fa fa-lock"></i>
							</span>
						</label>
						<div class="space-10"></div>

						<input type="submit" class="width-40 pull-right btn btn-success btn-inverse bigger-110" value="iniciar sesión">
						<div class="clearfix">${message}</div>
					</fieldset>
					</form>
					<!-- Login Form END -->

				</div>
			</div>
		</div>
	</div>
</div>