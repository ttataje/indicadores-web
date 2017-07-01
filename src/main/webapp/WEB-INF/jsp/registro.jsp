<!-- Inicio Contenido -->
<div class="row">
	<div class="col-md-12 col-xs-12">
		<form id="form" method="post" action="#" class="dropzone-form">
			<div class="widget-box widget-color-blue2">
				<div class="widget-header widget-header-small">
					<h4 class="widget-title lighter">
						<i class="ace-icon fa fa-edit"></i>
						Configuraci&oacute;n de Indicadores
					</h4>
				</div>
				<div class="widget-body dz-clickable">
					<div class="widget-main no-padding">
						<div class="table-responsive">
							<div id="jstree"></div>
						</div>
					</div>
					<div class="widget-toolbox padding-8 clearfix">
						<input tabindex="12" type="button" class="btn btn-primary btn-white btn-round odom-imprimir" value="Imprimir">
					</div>
				</div>
			</div>
		</form>
		<!-- Inicio Modal -->
		<div id="modalDIV" class="modal fade">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		      	<table>
		      	<tr>
		      	<td>
		      	<img src="images/regionica_pie.png" height="45" alt="Region Ica">
		      	</td>
		      	<td>
		      	<h4 id="title-modal" class="modal-title">titulo</h4>
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
		        <canvas id="chartCanvas"></canvas>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary odom-modificar">Modificar</button>
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- Fin Modal -->
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
		        <td>Descripci&oacute;n</td>
		        <td><input type="text" name="descripcion" id="descripcion" /></td>
		        </tr>
		        <tr id="tr-tipo">
		        <td>Tipo Gr&aacute;fico</td>
		        <td>
		        <select id="tipo" name="tipo">
		        <option value="bar">Barras</option>
		        <option value="horizontalBar">Barras Horizontales</option>
		        <option value="stackedBar">Stacked Barras</option>
		        <option value="pie">Pie</option>
		        </select>
		        </td>
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
	</div>
</div>
<!-- Fin Contenido -->

<script type="text/javascript">
var rol = '${usuario.rol }';
var title = "";
var objNode = null;
var selectedNode = null;
var typeNode = null;
var countChart = 0;
var nodeToModify = null;

function openChartModify(codigo){
	var link = document.createElement('a');
	link.href = '${pageContext.request.contextPath}/loadChart?codigo='+codigo;
	document.body.appendChild(link);
	link.click(); 
}

$(function () {
	$("#modalDIV").modal("hide");
	
	$("#modalRegistroDIV").modal("hide");
	
	$('body').on('click','.odom-modificar',function(e){
		openChartModify(nodeToModify);
	});
	
	$('body').on('click','.odom-guardar',function(e){
		var txtDescripcion = $("#descripcion");
		var txtTipo = $("#tipo");
		var nodeText = txtDescripcion[0].value;
		var tipo = txtTipo[0].value;
		var newNode = { 'padre' : objNode._model.data[selectedNode].original.codigo, 'text' : nodeText, 'type' : typeNode };
		
		$.post('${pageContext.request.contextPath}/addNode', newNode)
		.done(function (d) {
			newNode.codigo = d.codigo;
			objNode.create_node(objNode, newNode);
			txtDescripcion.val("");
			objNode.refresh();
			// Tipo Grafico
			if(typeNode === "chart"){
				// Se crea el nodo grafico
				var newChart = { 'indicador' : newNode.codigo, 'tipo' : tipo};
				$.post('${pageContext.request.contextPath}/addChart', newChart)
				.done(function (d) {
					// Se crea el nodo principal para el detalle
					var newDetailChart = { 'grafico' : d.codigo, 'text' : nodeText, 'tipo' : 'folder'};
					$.post('${pageContext.request.contextPath}/addDetalle', newDetailChart);
					txtTipo.val("");					
				})
				.fail(function (e) {
					objNode.refresh();
				});
			}
		})
		.fail(function (e) {
			objNode.refresh();
		});
		$("#modalRegistroDIV").modal("hide");
	});
	
	$('body').on('click','.odom-imprimir',function(e){
		var ref = $('#jstree').jstree(true),
		sel = ref.get_selected();
		if(!sel.length) {
			alert("Debe seleccionar un nodo");
			return false; 
		}
		sel = sel[0];
		if(sel.padre == '#') {
			alert("No puede seleccionar el nodo principal");
			return false; 
		}
		
		var doc = new jsPDF();
		var cantProcess = 0;
		
		var chartIMG = [];
		
		document.getElementById('chartCanvas').toBlob(function(blob) {
			var reader = new window.FileReader();
			reader.readAsDataURL(blob); 
			reader.onloadend = function() {
				chartIMG[cantProcess] = reader.result;                
				cantProcess = cantProcess + 1;
			}
		});
		
		refreshData()
		
		document.getElementById('chartCanvas').toBlob(function(blob) {
			var reader = new window.FileReader();
			reader.readAsDataURL(blob); 
			reader.onloadend = function() {
				chartIMG[cantProcess] = reader.result;                
				cantProcess = cantProcess + 1;
			}
		});
		
		do{
			if(cantProcess == 2){
				doc.setFontSize(40);
				doc.text(30, 20, 'Cuadro 1');
				
				console.log(chartIMG[0]);
				doc.addImage(chartIMG[0], 'PNG', 15, 40, 180, 160);
				
			
				doc.addPage();
				refreshData()
				
				doc.setFontSize(40);
				doc.text(30, 20, 'Cuadro 2');
				
				console.log(chartIMG[1]);
				doc.addImage(chartIMG[1], 'PNG', 15, 40, 180, 160);
				
				doc.output('save','output.pdf');
			}
		}while(cantProcess < 2);
	});
	
	$('#jstree').jstree({
			'core' : {
				'data' : {
					'url' : '${pageContext.request.contextPath}/getNode',
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
					icon : "${pageContext.request.contextPath}/images/regionica_tree.png"
				},
				'folder' :{
					icon : 'fa fa-archive'
				},
				'chart' :{
					icon : 'fa fa-bar-chart'
				}
			},
			"contextmenu": {
				"items": function (node) {
					var tree = $('#jstree').jstree(true);
					var menu = {
						"create_node": {
							"label": "Nuevo",
							"submenu" : {
								"create_section": {
									"separator_after"	: true,
									"label": "Seccion",
									"action" : function(data){
										objNode = $.jstree.reference(data.reference);
											sel = objNode.get_selected();
										if(!sel.length) { return false; }
										selectedNode = sel;
										typeNode = 'folder';
										$('#title-registro').text("Agregar Secci\u00F3n");
										$('#tr-tipo').hide();
										$("#modalRegistroDIV").modal("show");
									}
								},
								"create_chart": {
									"label": "Grafico",
									"action" : function(data){
										objNode = $.jstree.reference(data.reference);
											sel = objNode.get_selected();
										if(!sel.length) { return false; }
										selectedNode = sel;
										typeNode = 'chart';
										$('#title-registro').text("Agregar Gr\u00E1fico");
										$('#tr-tipo').show();
										$("#modalRegistroDIV").modal("show"); 
									}
								}
							}
						},
						"rename_node": {
							"label": "Renombrar",
							"action" : function(data){
								objNode = $.jstree.reference(data.reference);
									sel = objNode.get_selected();
								if(!sel.length) { return false; }
								selectedNode = sel;
								typeNode = objNode._model.data[sel].original.type;
								$('#descripcion').val(objNode._model.data[sel].original.text);
								$('#tr-tipo').hide();
								if( typeNode === 'folder'){
									$('#title-registro').text("Modificar Secci\u00F3n");
								}else{
									$('#title-registro').text("Modificar Gr\u00E1fico");
								}
								$("#modalRegistroDIV").modal("show");
							}
						},
						"delete_node": {
							"label": "Eliminar"
						},
						"edit_node":{
							"label": "Modificar",
							"submenu" : {
								"copy_node": {
									"separator_after"	: true,
									"label": "Copiar"
								},
								"cut_node": {
									"separator_after"	: true,
									"label": "Cortar"
								},
								"paste_node": {
									"label": "Pegar",
									"_disabled" : true
								}
							}
						}
					};
					
					if(node.children.length > 0){
						delete menu.delete_node;
					}

					if(node.type === "chart") {
						delete menu.create_node;
					}

					if(node.parent === "#"){
						delete menu.delete_node;
						delete menu.edit_node;
						delete menu.rename_node;
						delete menu.create_node.submenu.create_chart;
					}
					
					if(rol === "Consultor"){
						return null;
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
	
	function refreshData(){
        barChartData.datasets.forEach(function(dataset, i) {
            dataset.data = dataset.data.map(function() {
                return randomScalingFactor();
            });
        });
        window.myBar.update();
	}

	$('#jstree').bind("dblclick.jstree",function (e) {
		var li = $(e.target).closest("li");
		var item = li[0].id;
		var node = $('#jstree').jstree(true).get_node(item);
		nodeToModify = node.original.codigo;
		
		if(node.type === "chart") {
			$.post('${pageContext.request.contextPath}/loadChartData', {"codigo" : node.original.codigo})
			.done(function (d) {
				var ctx = document.getElementById('chartCanvas').getContext('2d');
				
				if(!jQuery.isEmptyObject(d.data)){
					console.log(d)
				    window.myBar = new Chart(ctx, d);

					$('#title-modal').text(node.text);
					$("#modalDIV").modal("show");
					
					if(rol == "Consultor"){
						$('.odom-modificar').hide();
					}else{
						$('.odom-modificar').show();
					}					
				}else{
					openChartModify(node.original.codigo);
				}
			})
			.fail(function (e) {
				//FIXME falta mensaje en caso falle la carga del modal
			});
		}
	});

});
</script>