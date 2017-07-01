<!-- Inicio Contenido -->
<div class="page-content">
	<div class="row">
		<div class="col-md-12 col-xs-12">
			<div class="widget-box widget-color-blue2">
				<div class="widget-header widget-header-small">
					<h4 class="widget-title lighter">
						<i class="ace-icon fa fa-edit"></i>
						Registro de Indicadores
					</h4>
				</div>
				<div class="widget-body dz-clickable">
					<div class="widget-main no-padding">
						<div class="table-responsive">
							<canvas id="chartCanvas"></canvas>
						</div>
					</div>
					<div class="widget-main no-padding">
						<div class="table-responsive">
							<div id="jstree"></div>
						</div>
					</div>
					<div class="widget-toolbox padding-8 clearfix">
						<input tabindex="12" type="button" class="btn btn-primary btn-white btn-round odom-regresar" value="Regresar">
						<input tabindex="13" type="button" class="btn btn-primary btn-white btn-round odom-actualizar-grafico" value="Actualizar Gr&aacute;fico">
					</div>
				</div>
			</div>
		</div>
		<!-- Inicio Modal -->
		<div id="modalRegistroDIV" class="modal fade">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		      	<table>
		      	<tr>
		      	<td>
		      	<img src="images/regionica_pie.png" height="45" alt="Region Ica">
		      	</td>
		      	<td>
		      	<h4 id="title-registro" class="modal-title">titulo</h4>
		      	</td>
		      	<td>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      	</td>
		      	</tr>
		      	</table>
		      </div>
		      <div class="modal-body">
		        <table>
		        <tr>
		        <td>Valor</td>
		        <td><input type="text" name="valor" id="valor" /></td>
		        </tr>
		        </table>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary odom-guardar">Guardar</button>
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- Fin Modal -->
		<!-- Inicio Modal Atributos -->
		<div id="modalAtributosDIV" class="modal fade">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		      	<table style="width: 100%;">
		      	<tr>
		      	<td style="width: 20%">
		      	<img src="images/regionica_pie.png" height="45" alt="Region Ica">
		      	</td>
		      	<td style="width: 30%">
		      	<h4 id="title-registro" class="modal-title">Modificar Atributos</h4>
		      	</td>
		      	<td style="width: 10%">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      	</td>
		      	</tr>
		      	</table>
		      </div>
		      <div class="modal-body">
		        <table>
		        <tr>
		        <td>Color</td>
		        <td><input type='text' id="color" name="color" /></td>
		        </tr>
		        <tr>
		        <td>Tipo</td>
		        <td>
		        	<select id="tipo" name="tipo">
		        		<option value="bar">Barra</option>
		        		<option value="line">Linea</option>
		        	</select>
		        </td>
		        </tr>
		        </table>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary odom-guardarAtributos">Guardar</button>
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- Fin Modal Atriburos -->
	</div>
</div>
<!-- Fin Contenido -->
<script type="text/javascript">
var titulo = '${indicador.descripcion}';
var objNode = null;
var selectedNode = null;
var typeNode = null;
var nodeToModify = null;

function refreshGrafico(){
	$.post('${pageContext.request.contextPath}/loadChartData', {"codigo" : '${grafico.indicador}'})
	.done(function (d) {
		var ctx = document.getElementById('chartCanvas').getContext('2d');
		
		if(!jQuery.isEmptyObject(d.data)){
			console.log(d)
		    window.myBar = new Chart(ctx, d);
		}
	})
	.fail(function (e) {
		//FIXME falta mensaje en caso falle la carga del modal
	});
}

$(function () {
	
	$("#modalRegistroDIV").modal("hide");
	$("#modalAtributosDIV").modal("hide");
	$("#color").spectrum({
		preferredFormat: "rgb",
	    color: "rgb(255,99,132)",
	    showPalette: true,
	    chooseText: "Seleccionar",
	    cancelText: "Cancelar",
	    change: function(color){
	    	$("#color").val(color.toRgbString());
	    }
	});	

	$('body').on('click','.odom-guardar',function(e){
		var txtValor = $("#valor");
		var nodeText = txtValor[0].value;
		var newNode = { 'padre' : objNode._model.data[selectedNode].original.codigo, 'text' : nodeText, 'type' : typeNode };
		
		$.post('${pageContext.request.contextPath}/addDetalle', newNode)
		.done(function (d) {
			newNode.codigo = d.codigo;
			objNode.create_node(objNode, newNode);
			txtValor.val("");
			objNode.refresh();
		})
		.fail(function (e) {
			objNode.refresh();
		});
		$("#modalRegistroDIV").modal("hide");
	});
	
	$('body').on('click','.odom-guardarAtributos',function(e){
		var color = $("#color").val();
		var tipo = $("#tipo").val();
		var codigo = objNode._model.data[selectedNode].original.codigo;
		var newNode = { 'codigo' : codigo, 'color' : color, 'tipo' : tipo };
		
		$.post('${pageContext.request.contextPath}/updateDetalle', newNode)
		.done(function (d) {
			newNode.codigo = d.codigo;
			objNode.create_node(objNode, newNode);
			objNode.refresh();
		})
		.fail(function (e) {
			objNode.refresh();
		});
		$("#modalAtributosDIV").modal("hide");
	});
	
	$('body').on('click','.odom-regresar',function(e){
		goTo('registro'); 
	});
	
	$('body').on('click','.odom-actualizar-grafico',function(e){
		refreshGrafico();
	});
	
	$('#jstree').jstree({
		'core' : {
			'data' : {
				'url' : '${pageContext.request.contextPath}/getDetalle',
				'data' : function (node) {
					return { 'codigo' : node.original != null ? node.original.codigo : null };
				}
			},
			'force_text' : true,
			'check_callback' : true,
			'themes' : {
				'stripes' : true
			}
		},
		'types' :{
			'root' :{
				icon : "fa fa-bar-chart"
			},
			'folder' :{
				icon : 'fa fa-archive'
			},
			'value' :{
				icon : 'fa fa-calculator'
			}
		},
		"contextmenu": {
			"items": function (node) {
				var tree = $('#jstree').jstree(true);
				var menu = {
					"create_node": {
						"label": "Nuevo",
						"submenu" : {
							"create_group": {
								"separator_after"	: true,
								"label": "Grupo",
								"action" : function(data){
									objNode = $.jstree.reference(data.reference);
										sel = objNode.get_selected();
									if(!sel.length) { return false; }
									selectedNode = sel;
									typeNode = 'folder';
									$('#title-registro').text("Agregar Grupo");
									$("#modalRegistroDIV").modal("show");
								}
							},
							"create_value": {
								"label": "Valor",
								"action" : function(data){
									objNode = $.jstree.reference(data.reference);
										sel = objNode.get_selected();
									if(!sel.length) { return false; }
									selectedNode = sel;
									typeNode = 'value';
									$('#title-registro').text("Agregar Valor");
									$("#modalRegistroDIV").modal("show"); 
								}
							}
						}
					},
					"modify_attributes": {
						"label": "Atributos",
						"action" : function(data){
							objNode = $.jstree.reference(data.reference);
								sel = objNode.get_selected();
							if(!sel.length) { return false; }
							selectedNode = sel;
							$("#modalAtributosDIV").modal("show");
						}
					},
					"rename_node": {
						"label": "Modificar",
						"action" : function(data){
							objNode = $.jstree.reference(data.reference);
								sel = objNode.get_selected();
							if(!sel.length) { return false; }
							selectedNode = sel;
							typeNode = objNode._model.data[sel].original.type;
							$('#valor').val(objNode._model.data[sel].original.text);
							$('#tr-tipo').hide();
							if( typeNode === 'folder'){
								$('#title-registro').text("Modificar Grupo");
							}else{
								$('#title-registro').text("Modificar Valor");
							}
							$("#modalRegistroDIV").modal("show");
						}
					},
					"delete_node": {
						"label": "Eliminar"
					}
				};
				
				var degree = tree.get_path(node.id).length;
				
				if(node.children.length > 0){
					delete menu.delete_node;
				}

				if(node.icon === "glyphicon glyphicon-dashboard") {
					delete menu.create_node;
				}

				if(node.parent == "#"){
					delete menu.delete_node;
					delete menu.edit_node;
					delete menu.rename_node;
					delete menu.create_node.submenu.create_chart;
				}
				
				var tipoGrafico = '${grafico.tipo}';
				
				if(tipoGrafico == 'bar' || tipoGrafico == 'stackedBar' || tipoGrafico == 'horizontalBar'){
					if(degree != 3){
						delete menu.modify_attributes;
					}					
				}else if(tipoGrafico == 'pie'){
					if(degree != 2){
						delete menu.modify_attributes;
					}
				}
				
				return menu;
			}
		},
		'plugins' : ['state','dnd','contextmenu','types','wholerow','search']
	})
	.on('loaded.jstree', function() {
		$('#jstree').jstree('open_all');
	})
	.on('delete_node.jstree', function (e, data) {
		/*
		$.get('?operation=delete_node', { 'id' : data.node.id })
			.fail(function () {
				data.instance.refresh();
			});
		*/
	})
	.on('rename_node.jstree', function (e, data) {
		/*
		$.get('?operation=rename_node', { 'id' : data.node.id, 'text' : data.text })
			.fail(function () {
				data.instance.refresh();
			});
		*/
	})
	.on('move_node.jstree', function (e, data) {
		/*
		$.get('?operation=move_node', { 'id' : data.node.id, 'parent' : data.parent, 'position' : data.position })
			.fail(function () {
				data.instance.refresh();
			});
		*/
	})
	.on('copy_node.jstree', function (e, data) {
		/*
		$.get('?operation=copy_node', { 'id' : data.original.id, 'parent' : data.parent, 'position' : data.position })
			.always(function () {
				data.instance.refresh();
			});
		*/
	})
	.on('changed.jstree', function (e, data) {
		/*
		if(data && data.selected && data.selected.length) {
			$.get('?operation=get_content&id=' + data.selected.join(':'), function (d) {
				$('#data .default').text(d.content).show();
			});
		}
		else {
			$('#data .content').hide();
			$('#data .default').text('Select a file from the tree.').show();
		}
		*/
	});
	
	refreshGrafico();
});
</script>