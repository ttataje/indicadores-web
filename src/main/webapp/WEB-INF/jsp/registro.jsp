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
						<input tabindex="12" type="button" class="btn btn-primary btn-white btn-round odom-show-imprimir" value="Vista Previa">
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
		      <div class="modal-body modal-body-canvas">
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
		<!-- Inicio Modal Print -->
		<div id="modalPrintDIV" class="modal fade">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		      	<table style="width: 100%">
		      	<tr>
		      	<td style="width: 20%">
		      	<img src="images/regionica_pie.png" height="45" alt="Region Ica">
		      	</td>
		      	<td style="width: 70%">
		      	<h4 id="title-print" class="modal-title">Vista Previa</h4>
		      	</td>
		      	<td  style="width: 10%">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      	</td>
		      	</tr>
		      	</table>
		      </div>
		      <div class="modal-body odom-pdf-source" style="overflow: auto;">
		        
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary odom-imprimir">Imprimir</button>
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!--  Fin Modal Print -->
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
var tipoGrafico = null;
var colors = ['rgb(255, 99, 132)','rgb(255, 159, 64)','rgb(255, 205, 86)','rgb(75, 192, 192)','rgb(54, 162, 235)','rgb(153, 102, 255)','rgb(201, 203, 207)',
	'rgb(255, 99, 132)','rgb(255, 159, 64)','rgb(255, 205, 86)','rgb(75, 192, 192)','rgb(54, 162, 235)','rgb(153, 102, 255)','rgb(201, 203, 207)',
	'rgb(255, 99, 132)','rgb(255, 159, 64)','rgb(255, 205, 86)','rgb(75, 192, 192)','rgb(54, 162, 235)','rgb(153, 102, 255)','rgb(201, 203, 207)',
	'rgb(255, 99, 132)','rgb(255, 159, 64)','rgb(255, 205, 86)','rgb(75, 192, 192)','rgb(54, 162, 235)','rgb(153, 102, 255)','rgb(201, 203, 207)'];
	

function openChartModify(codigo){
	var link = document.createElement('a');
	link.href = '${pageContext.request.contextPath}/loadChart?codigo='+codigo;
	document.body.appendChild(link);
	link.click(); 
}

$(function () {
	$("#modalDIV").modal("hide");
	
	$("#modalRegistroDIV").modal("hide");
	
	$("#modalPrintDIV").modal("hide");
	
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
					var newDetailChart = { 'grafico' : d.codigo, 'text' : nodeText, 'type' : 'folder'};
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
	
	$('body').on('click','.odom-show-imprimir',function(e){
		var ref = $('#jstree').jstree(true);
		sel = ref.get_selected();
		if(!sel.length) {
			alert("Debe seleccionar un nodo");
			return false; 
		}
		sel = sel[0];
		var nodeSel = ref._model.data[sel];
		if(nodeSel.parent == '#') {
			alert("No puede seleccionar el nodo principal");
			return false; 
		}
		if(nodeSel.parent == '#') {
			alert("No puede seleccionar el nodo principal");
			return false; 
		}
		
		var body = $(".odom-pdf-source");
		var dataBase = nodeSel.original;
		
		try{
			var anio = parseInt(dataBase.text);
			if(!isNaN(anio)){
				alert("Favor seleccionar un mes del año ["+anio+"]");
				return false;
			} 
		}catch(e){}
		
		// limpiamos el cuerpo
		$(".odom-pdf-source").empty();
		
		var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
		var esMes = false;
		for(var i = 0; i < meses.length; i++){
			var select = dataBase.text.toUpperCase();
			var mes = meses[i].toUpperCase();
			if(select === mes){
				esMes = true;
				break;
			}
		}
		
		var childrens = nodeSel.children_d;
		for(var i = 0; i < childrens.length; i++){
			var child = childrens[i];
			var nodeChild = ref._model.data[child];
			var data = nodeChild.original;

			if(data.type === 'folder'){
				var div = $("<div class='new_page page-title' style='width: 297mm; min-height: 210mm; padding: 20mm; margin: 10mm auto; border: 1px #D3D3D3 solid; border-radius: 5px; box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);'></div>");
				body.append(div);
				div.append("<span>" + data.text + "</span>")
			}else{
				var div = $("<div class='new_page' style='width: 297mm; min-height: 210mm; padding: 20mm; margin: 10mm auto; border: 1px #D3D3D3 solid; border-radius: 5px; background: white; box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);'></div>");
				body.append(div);
				div.append("<div class='title-chart'>" + data.text + "</div>");
				div.append("<canvas id='chart_"+ data.codigo + "'></canvas>");

				$.post('${pageContext.request.contextPath}/loadChartData', {"codigo" : data.codigo})
				.done(function (d) {
					writeChart(d, 'chart_'+data.codigo);
				})
				.fail(function (e) {
					//FIXME falta mensaje en caso falle la carga del modal
				});
			}
		}
		
		$("#modalPrintDIV").modal("show");
	});
	
	$('body').on('click','.odom-imprimir',function(e){
		var pdf = new jsPDF('l', 'pt', 'a4');
		var elements = $('.new_page');
		var count = 0;
		var recursiveAddHtml = function () {
		    if (count < elements.length) {
		    	var element = elements.get(count);
		    	var x = 0, y = count * 20;
		        pdf.addHTML(element, x, y,  {background:"#ffffff"}, function () {
		        	count++;
		            pdf.addPage();
		            recursiveAddHtml();
		        });
		    } else {
		    	pdf.save('SIRI_' + (new Date()).getTime() + '.pdf');
		    }
		}

		recursiveAddHtml();
		/*
		$.each(items, function(index, value){
			doc.addHTML(value, options, {'background': '#fff'});
			if(items.length > index){
				doc.addPage();	
			}
		});
	    */
	    
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
										$("#descripcion").focus();
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
										$("#descripcion").focus();
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
								$("#descripcion").focus();
							}
						},
						"delete_node": {
							"label": "Eliminar",
							"action" : function(data){
								objNode = $.jstree.reference(data.reference);
								var ID = $.jstree.reference(data.reference);
									sel = objNode.get_selected();
								if(!sel.length) { return false; }
								selectedNode = sel;
								var $select = $('#'+ID.get_selected());
								tree.delete_node($select);
							}
						},
						"edit_node":{
							"label": "Modificar",
							"submenu" : {
								"copy_node": {
									"separator_after"	: true,
									"label": "Copiar",
									"action" : function(data){
										var ID = $.jstree.reference(data.reference);
										var $select = $('#'+ID.get_selected());
										tree.copy_node($select);
									}
								},
								"cut_node": {
									"separator_after"	: true,
									"label": "Cortar",
									"action" : function(data){
										var ID = $.jstree.reference(data.reference);
										var $select = $('#'+ID.get_selected());
										tree.cut_node($select);
									}
								},
								"paste_node": {
									"label": "Pegar",
									"_disabled" : true,
									"action" : function(data){
										var ID = $.jstree.reference(data.reference);
										var $select = $('#'+ID.get_selected());
										tree.paste_node($select);
									}
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
			'plugins' : ['state','contextmenu','types','wholerow','search']
		})
		.on('loaded.jstree', function() {
			$('#jstree').jstree('open_all');
		})
		.on('delete_node.jstree', function (e, data) {
			$.post('${pageContext.request.contextPath}/delNode', { 'codigo' : objNode._model.data[selectedNode].original.codigo })
				.fail(function () {
					data.instance.refresh();
				});
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
	
	function processInformation(data, chart){
		labelDataset = [];
		chartDataset = [];
		
		if(tipoGrafico === 'pie'){
			for (i=0; i < data[0].length; i++){
				labelDataset.push(data[0][i]);
			}
			for (i=1; i< data.length - 1; i++) {
				var item = {}
				item.data = new Array();
				item.backgroundColor = new Array();
				item.label = 'Dataset 1';
				for (j=0; j<data[i].length; j++) {
					item.backgroundColor = colors[i];
					item.data.push(fixNumberExcel(data[i][j]));
				}
				chartDataset.push(item);
			}
			window.myBar.data.labels = labelDataset;
			window.myBar.data.datasets = chartDataset;
		}else if(tipoGrafico === 'stackedBar'){
			for (i=1; i < data[0].length; i++){
				labelDataset.push(data[0][i]);
			}
			for (i=1; i< data.length - 1; i++) {
				var item = {}
				item.data = new Array();
				for (j=0; j<data[i].length; j++) {
					if(j==0){
						item.label = data[i][j];
						item.backgroundColor = colors[i];
					}else{
						item.data.push(fixNumberExcel(data[i][j]));
					}
				}
				chartDataset.push(item);
			}
		} else if(tipoGrafico === 'horizontalBar'){
			for (i=1; i< data.length - 1; i++) {
				var item = {}
				item.data = new Array();
				for (j=0; j<data[i].length; j++) {
					if(j==0){
						item.label = data[i][j];
						item.backgroundColor = colors[i];
					}else{
						item.data.push(fixNumberExcel(data[i][j]));
					}
				}
				chartDataset.push(item);
			}
		} else {
			var combo = data[0].length > 2;
			if(combo){
				for (i=1; i < data.length; i++){
					labelDataset.push(data[i][0]);
				}
				for (c=1; c < data[0].length - 1; c++) {
					var item = {}
					item.data = new Array();
					item.type = (c % 2 === 0) ? 'line' : 'bar';
					item.fill = item.type == 'bar';
					item.label = data[0][c];
					item.backgroundColor = colors[c];
					for (l=1; l < data.length -1; l++) {
						item.data.push(fixNumberExcel(data[l][c]));
					}
					chartDataset.push(item);
				}
			}else{
				for (i=1; i< data.length - 1; i++) {
					var item = {}
					item.data = new Array();
					for (j=0; j<data[i].length; j++) {
						if(j==0){
							item.label = data[i][j];
							item.backgroundColor = colors[i];
						}else{
							item.data.push(fixNumberExcel(data[i][j]));
						}
					}
					chartDataset.push(item);
				}
			}			
		}
		
		chart.data.labels = labelDataset;
		chart.data.datasets = chartDataset;
		chart.update();
	}
	
	function fixNumberExcel(n){
		var pos = n.lastIndexOf(',');
		if(pos == -1){
			return parseFloat(n);
		}else{
			var num = '';
			for(var i = 0; i < n.length; i++){
				var c = n.charAt(i);
				if(c != ','){
					num += c;
				}
			}
			var npos = pos - (n.length - num.length);
			num = num.slice(0, npos + 1) + "." + num.slice(npos + 1);
			return parseFloat(num);
		}
	}

	$('#jstree').bind("dblclick.jstree",function (e) {
		var li = $(e.target).closest("li");
		var item = li[0].id;
		var node = $('#jstree').jstree(true).get_node(item);
		nodeToModify = node.original.codigo;
		
		if(node.type === "chart") {
			$.post('${pageContext.request.contextPath}/loadChartData', {"codigo" : node.original.codigo})
			.done(function (d) {
				if(!(typeof d.detalleGrafico.data === "undefined") && !(d.detalleGrafico.data === null)){
					writeChart(d,'chartCanvas');
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

	function writeChart(d,chart_id){
		var grafico = d.grafico;
		var detalleGrafico = d.detalleGrafico;
		tipoGrafico = grafico.tipo;
	      
	    $('.modal-body-canvas').empty();
		$('.modal-body-canvas').append('<canvas id="chartCanvas"></canvas>');
	    
		var ctx = document.getElementById(chart_id).getContext('2d');

		var labelDataset = [];
		
		var chartDataset = [];
		
		var data = [];
		
		var attributes = [];
		
		var chartData = {
		        labels: labelDataset,
		        datasets: chartDataset
		    };
		
		var chart;
		
		var typeGraph = tipoGrafico === 'stackedBar' ? 'bar' : tipoGrafico;
		if(tipoGrafico === 'pie'){
			chart = new Chart(ctx, {
		        type: typeGraph,
		        data: chartData,
		        options: {
		            responsive: true
		        }
		    });
		}else if(tipoGrafico === 'stackedBar'){
			chart = new Chart(ctx, {
		        type: typeGraph,
		        data: chartData,
		        options: {
		            title:{
		                display: false,
		                text: 'Chart.js Horizontal Bar Chart'
		            },
		            tooltips: {
		                mode: 'index',
		                intersect: false
		            },
		            responsive: true,
		            scales: {
		                xAxes: [{
		                    stacked: true,
		                }],
		                yAxes: [{
		                    stacked: true
		                }]
		            }
		        }
		    });			
		} else if(tipoGrafico === 'horizontalBar'){
			chart = new Chart(ctx, {
		        type: typeGraph,
		        data: chartData,
	               options: {
	                   elements: {
	                       rectangle: {
	                           borderWidth: 2,
	                       }
	                   },
	                   responsive: true,
	                   legend: {
	                       position: 'right',
	                   },
	                   title: {
	                       display: false,
	                       text: 'Chart.js Horizontal Bar Chart'
	                   }
	               }
		    });
		} else {
			chart = new Chart(ctx, {
		        type: typeGraph,
		        data: chartData,
	               options: {
	                   responsive: true,
	                   legend: {
	                       position: 'top',
	                   },
	                   title: {
	                       display: false,
	                       text: 'Chart.js Bar Chart'
	                   }
	               }
		    });
		}
		
		processInformation(JSON.parse(detalleGrafico.data),chart);

	}
});
</script>