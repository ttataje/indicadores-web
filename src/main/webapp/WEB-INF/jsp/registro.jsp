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
		  <div class="modal-dialog" role="document" style="width: 320mm">
		    <div class="modal-content" style="width: 320mm">
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
		        <option value="groupBar">Group Bar</option>
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
		  <div class="modal-dialog" role="document" style="width: 320mm">
		    <div class="modal-content" style="width: 320mm">
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
	
	var images = [];
	var controlLoad = {};

	$('body').on('click','.odom-show-imprimir',function(e){
		images = [];
		controlLoad = {};
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
		body.empty();
		
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
		var count = -1;
		
		if(!esMes && dataBase.type === 'folder'){
			var div = $("<div class='new_page' style='position: relative; width: 297mm; min-height: 210mm; margin: 10mm auto; background: white;'></div>");
			var span = $("<span style='position: absolute; color: #000000; font-family: arial; font-weight: bold; display: inline; top: 350px; left: 63px; font-size: xx-large; -webkit-box-decoration-break: clone; box-decoration-break: clone;'>" + dataBase.text + "</span>");
			var img = new Image();
			img.addEventListener('load', function(){
						            	var item = {};
										var canvas = document.createElement("canvas");
						            	canvas.width  = 1137;
						            	canvas.height = 639;
										var ctx = canvas.getContext("2d");
										ctx.drawImage(img, 0, 0);
										ctx.font = '20pt Arial';
										ctx.fillText(dataBase.text, 70, 330);
						            	item.img = canvas.toDataURL();
										images.push(item);
										generateExport(count, body, childrens);
								},false);
			img.src = '${pageContext.request.contextPath}/images/pdf_titulo.png';
			img.style.position = 'absolute';
			img.style.top = '10mm';
			img.style.width = '270mm';
			img.style.minHeight = '190mm';
			body.append(div);
			div.append(img);
			div.append(span)
		}else{
			if(dataBase.type === 'chart'){
				childrens.push(nodeSel.id);
			}
			generateExport(count, body, childrens);
		}

		$("#modalPrintDIV").modal("show");
	});
	
	function generateExport(i, body, childrens){
		var ref = $('#jstree').jstree(true);
		i++;
		if(i < childrens.length){
			var child = childrens[i];
			var nodeChild = ref._model.data[child];
			var data = nodeChild.original;

			if(data.type === 'folder'){
				var div = $("<div class='new_page' style='position: relative; width: 297mm; min-height: 210mm; margin: 10mm auto; background: white;'></div>");
				var span = $("<span style='position: absolute; color: #000000; font-family: arial; font-weight: bold; display: inline; top: 350px; left: 63px; font-size: xx-large; -webkit-box-decoration-break: clone; box-decoration-break: clone;'>" + data.text + "</span>");
				var img = new Image();
				img.addEventListener('load', function(){
							            	var item = {};
							            	item.type = 'folder';
							            	var canvas = document.createElement("canvas");
							            	canvas.width  = 1137;
							            	canvas.height = 639;
											var ctx = canvas.getContext("2d");
											ctx.drawImage(img, 0, 0);
											ctx.font = '20pt Arial';
											ctx.fillText(data.text, 70, 330);
							            	item.img = canvas.toDataURL();
							            	item.title = data.text;
											images.push(item);
											generateExport(i, body, childrens);
										},false);
				img.src = '${pageContext.request.contextPath}/images/pdf_titulo.png';
				img.style.position = 'absolute';
				img.style.top = '10mm';
				img.style.width = '270mm';
				img.style.minHeight = '190mm';
				body.append(div);
				div.append(img);
				div.append(span);
			}else{
				if(!controlLoad['chart_'+data.codigo]){
					controlLoad['chart_'+data.codigo] = true;
					var div = $("<div class='new_page' style='position:relative; width: 297mm; min-height: 210mm; padding: 20mm; margin: 10mm auto; background: white;'></div>");
					var span = $("<span style='font-family: arial; font-weight: bold; color: #000000; font-size: large;'>" + data.text + "</span>");
					var canvas = $("<canvas id='chart_"+ data.codigo + "' style='width: 270mm; min-height: 150mm;'></canvas>");
					body.append(div);
					div.append(span);
					div.append(canvas);

					$.post('${pageContext.request.contextPath}/loadChartData', {"codigo" : data.codigo})
					.done(function (d) {
		            	var item = {};
		            	item.type = 'chart';
		            	item.title = data.text;
		            	item.codigo = 'chart_'+data.codigo;
						images.push(item);
						writeChart(d, 'chart_'+data.codigo, true, i, body, childrens);
					})
					.fail(function (e) {
						//FIXME falta mensaje en caso falle la carga del modal
					});					
				}
			}
		}
	}

	$('body').on('click','.odom-imprimir',function(e){
		var pdf = new jsPDF('l', 'mm', 'a4');
		var control = -1;
		var recursiveFillPDF = function () {
			control++;
		    if (control < images.length) {
		    	var value = images[control];
				if(value != null){
					if(typeof(value.img) == 'string'){
						if(control != 0)
							pdf.addPage();
						var width = pdf.internal.pageSize.width;
						var height = pdf.internal.pageSize.height;
						pdf.addImage(value.img, 'PNG', 10, 10, width - 20, height - 20);
						recursiveFillPDF();
					}else{
						if(typeof(value.img) != 'undefined'){
							var reader = new window.FileReader();
							reader.readAsDataURL(value.img);
							reader.onloadend = function() {
								if(control != 0)
									pdf.addPage();
								base64data = reader.result;
								pdf.setFontSize(16);
								var width = pdf.internal.pageSize.width;
								var title = pdf.splitTextToSize(value.title, width - 40);
								pdf.text(20, 25, title);
					            pdf.addImage(base64data, 'PNG', 20, 30);
								recursiveFillPDF();
							}							
						}else{
							recursiveFillPDF();
						}
					}
				}else{
					recursiveFillPDF();
				}
		    } else {
		    	pdf.save('SIRI_' + (new Date()).getTime() + '.pdf');
		    }
		}

		recursiveFillPDF();	    
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
						}/*,
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
						}*/,
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
						}/*,
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
						}*/
					};
					/*
					if(node.children.length > 0){
						delete menu.delete_node;
					}*/
					delete menu.edit_node;
					delete menu.rename_node;

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
		var labelDataset = [];
		var chartDataset = [];
		
		if(tipoGrafico === 'pie'){
			for (i=0; i < data.length - 1; i++){
				labelDataset.push(data[i][0]);
			}
			var item = {}
			item.data = new Array();
			item.backgroundColor = new Array();
			item.label = 'Dataset 1';
			for (i=0; i < data.length - 1; i++) {
				item.backgroundColor.push(colors[i]);
				item.data.push(fixNumberExcel(data[i][1]));
			}
			chartDataset.push(item);
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
		}else if(tipoGrafico === 'groupBar'){
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
				for (c=1; c < data[0].length; c++) {
					var item = {}
					item.data = new Array();
					item.type = (c % 2 === 0) ? 'line' : 'bar';
					item.yAxisID = (c % 2 === 0) ? 'y-axis-2' : 'y-axis-1';
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

	function setImagesBlob(chart_id, blob){
		for(var i = 0; i < images.length; i++){
			if(images[i].codigo && images[i].codigo === chart_id){
				images[i].img = blob;
				break;
			}
		}
	}

	function writeChart(d,chart_id, toImage, count, body, childrens){
		var grafico = d.grafico;
		var detalleGrafico = d.detalleGrafico;
		tipoGrafico = grafico.tipo;
	      
	    $('.modal-body-canvas').empty();
		$('.modal-body-canvas').append('<canvas id="' + chart_id + '"></canvas>');
		$('.modal-body-canvas').append('<span id="pie_' + chart_id + '"></span>')

		var ctx = document.getElementById(chart_id).getContext('2d');
		var pie = document.getElementById("pie_" + chart_id);

		var labelDataset = [];
		
		var chartDataset = [];
		
		var data = JSON.parse(detalleGrafico.data);
		
		var attributes = [];
		
		var chartData = {
		        labels: labelDataset,
		        datasets: chartDataset
		    };
		
		var chart;
		
		var typeGraph = tipoGrafico === 'stackedBar' ? 'bar' : (tipoGrafico === 'groupBar' ? 'bar' : tipoGrafico);
		if(tipoGrafico === 'pie'){
			chart = new Chart(ctx, {
		        type: typeGraph,
		        data: chartData,
		        options: {
					tooltips: {
						callbacks: {
							label: function(tooltipItem, data) {
								var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].toString();
									value = value.split(/(?=(?:...)*$)/);
									value = value.join(',');
								var datasetLabel =  data.datasets[tooltipItem.datasetIndex].label;
								return datasetLabel + ': ' + value;
							}
						}
					},
					responsive: true,
		            pieceLabel: {
		            	render: 'percentage',
		            	fontColor: 'white',
		            	precision: 2
		            },
					animation: {
						onComplete: function(animation){
							if(toImage){
								var canvas = document.getElementById(chart_id);
								if (canvas.toBlob) {
								    canvas.toBlob(
								            function (blob) {
								            	setImagesBlob(chart_id, blob);
												generateExport(count, body, childrens);	
								            },
								            'image/png'
								        );
								}
							}
						}
					}
		        }
		    });
		}else if(tipoGrafico === 'stackedBar'){
			chart = new Chart(ctx, {
		        type: typeGraph,
		        data: chartData,
		        options: {
					tooltips: {
						mode: 'index',
						intersect: false,
						callbacks: {
							label: function(tooltipItem, data) {
								var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].toString();
									value = value.split(/(?=(?:...)*$)/);
									value = value.join(',');
								var datasetLabel =  data.datasets[tooltipItem.datasetIndex].label;
								return datasetLabel + ': ' + value;
							}
						}
					},
		            title:{
		                display: false,
		                text: 'Chart.js Horizontal Bar Chart'
		            },
		            responsive: true,
		            scales: {
		                xAxes: [{
		                    stacked: true,
		                    ticks:{}
		                }],
		                yAxes: [{
		                    stacked: true,
		                    ticks:{
		                    	beginAtZero: true,
		                    	userCallback: function(value,index,values){
		                    		value = value.toString();
		                    		value = value.split(/(?=(?:...)*$)/);
		                    		value = value.join(',');
		                    		return value;
		                    	}
		                    }
		                }]
		            },
                   animation: {
                	   onComplete: function(animation){
							if(toImage){
								var canvas = document.getElementById(chart_id);
								if (canvas.toBlob) {
								    canvas.toBlob(
								            function (blob) {
								            	setImagesBlob(chart_id, blob);
												generateExport(count, body, childrens);	
								            },
								            'image/png'
								        );
								}
							}
                	   }
                   }
		        }
		    });			
		}else if(tipoGrafico === 'groupBar'){
			chart = new Chart(ctx, {
		        type: typeGraph,
		        data: chartData,
		        options: {
					tooltips: {
						mode: 'index',
						intersect: false,
						callbacks: {
							label: function(tooltipItem, data) {
								var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].toString();
									value = value.split(/(?=(?:...)*$)/);
									value = value.join(',');
								var datasetLabel =  data.datasets[tooltipItem.datasetIndex].label;
								return datasetLabel + ': ' + value;
							}
						}
					},
		            title:{
		                display: false,
		                text: 'Chart.js Horizontal Bar Chart'
		            },
		            responsive: true,
		            scales: {
		                xAxes: [{
		                    ticks:{}
		                }],
		                yAxes: [{
		                    ticks:{
		                    	beginAtZero: true,
		                    	userCallback: function(value,index,values){
		                    		value = value.toString();
		                    		value = value.split(/(?=(?:...)*$)/);
		                    		value = value.join(',');
		                    		return value;
		                    	}
		                    }
		                }]
		            },
                   animation: {
                	   onComplete: function(animation){
							if(toImage){
								var canvas = document.getElementById(chart_id);
								if (canvas.toBlob) {
								    canvas.toBlob(
								            function (blob) {
								            	setImagesBlob(chart_id, blob);
												generateExport(count, body, childrens);	
								            },
								            'image/png'
								        );
								}
							}
                	   }
                   }
		        }
		    });			
		} else if(tipoGrafico === 'horizontalBar'){
			chart = new Chart(ctx, {
		        type: typeGraph,
		        data: chartData,
	               options: {
					   tooltips: {
							callbacks: {
								label: function(tooltipItem, data) {
									var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].toString();
										value = value.split(/(?=(?:...)*$)/);
										value = value.join(',');
									var datasetLabel =  data.datasets[tooltipItem.datasetIndex].label;
									return datasetLabel + ': ' + value;
								}
							}
					   },
	                   elements: {
	                       rectangle: {
	                           borderWidth: 2,
	                       }
	                   },
	                   responsive: true,
	                   legend: {
	                       position: 'top',
	                   },
	                   title: {
	                       display: false,
	                       text: 'Chart.js Horizontal Bar Chart'
	                   },
			            scales: {
			                xAxes: [{
			                    ticks:{}
			                }],
			                yAxes: [{
			                    ticks:{
			                    	beginAtZero: true,
			                    	userCallback: function(value,index,values){
			                    		value = value.toString();
			                    		value = value.split(/(?=(?:...)*$)/);
			                    		value = value.join(',');
			                    		return value;
			                    	}
			                    }
			                }]
			            },
	                   animation: {
	                	   onComplete: function(animation){
								if(toImage){
									var canvas = document.getElementById(chart_id);
									if (canvas.toBlob) {
									    canvas.toBlob(
									            function (blob) {
									            	setImagesBlob(chart_id, blob);
													generateExport(count, body, childrens);
									            },
									            'image/png'
									        );
									}
								}
	                	   }
	                   }
	               }
		    });
		} else {
			var combo = data[0].length > 2;
			if(combo){
				chart = new Chart(ctx, {
			        type: typeGraph,
			        data: chartData,
		               options: {
							tooltips: {
								callbacks: {
									label: function(tooltipItem, data) {
										var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].toString();
											value = value.split(/(?=(?:...)*$)/);
											value = value.join(',');
										var datasetLabel =  data.datasets[tooltipItem.datasetIndex].label;
										return datasetLabel + ': ' + value;
									}
								}
						   },
		                   responsive: true,
		                   hoverMode: 'index',
		                   stacked: false,
		                   legend: {
		                       position: 'top',
		                   },
		                   title: {
		                       display: false,
		                       text: 'Chart.js Bar Chart'
		                   },
		                   scales: {
		                       yAxes: [{
		                           type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
		                           display: true,
		                           position: "left",
		                           id: "y-axis-1",
								   ticks:{
										beginAtZero: true,
										userCallback: function(value,index,values){
											value = value.toString();
											value = value.split(/(?=(?:...)*$)/);
											value = value.join(',');
											return value;
										}
								   }
		                       }, {
		                           type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
		                           display: true,
		                           position: "right",
		                           id: "y-axis-2",

		                           // grid line settings
		                           gridLines: {
		                               drawOnChartArea: false, // only want the grid lines for one axis to show up
		                           },
				                    ticks:{
				                    	beginAtZero: true,
				                    	userCallback: function(value,index,values){
											if(value > 999){
												value = value.toString();
												value = value.split(/(?=(?:...)*$)/);
												value = value.join(',');
											}else{
												var tmp = value.toString();
												if(tmp.indexOf('.') > -1){
													value = Math.floor(value * 100) / 100;
												}
											}
				                    		return value;
				                    	}
				                    }
		                       }],
		                   },
		                   animation: {
		                	   onComplete: function(animation){
									if(toImage){
										var canvas = document.getElementById(chart_id);
										if (canvas.toBlob) {
										    canvas.toBlob(
										            function (blob) {
										            	setImagesBlob(chart_id, blob);
														generateExport(count, body, childrens);
										            },
										            'image/png'
										        );
										}
									}
		                	   }
		                   }
		               }
			    });
			}else{
				chart = new Chart(ctx, {
			        type: typeGraph,
			        data: chartData,
		               options: {
							tooltips: {
								callbacks: {
									label: function(tooltipItem, data) {
										var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].toString();
											value = value.split(/(?=(?:...)*$)/);
											value = value.join(',');
										var datasetLabel =  data.datasets[tooltipItem.datasetIndex].label;
										return datasetLabel + ': ' + value;
									}
								}
						   },
		                   responsive: true,
		                   legend: {
		                       position: 'top',
		                   },
		                   title: {
		                       display: false,
		                       text: 'Chart.js Bar Chart'
		                   },
				            scales: {
				                xAxes: [{
				                    ticks:{}
				                }],
				                yAxes: [{
				                    ticks:{
				                    	beginAtZero: true,
				                    	userCallback: function(value,index,values){
				                    		value = value.toString();
				                    		value = value.split(/(?=(?:...)*$)/);
				                    		value = value.join(',');
				                    		return value;
				                    	}
				                    }
				                }]
				            },
		                   animation: {
		                	   onComplete: function(animation){
									if(toImage){
										var canvas = document.getElementById(chart_id);
										if (canvas.toBlob) {
										    canvas.toBlob(
										            function (blob) {
										            	setImagesBlob(chart_id, blob);
														generateExport(count, body, childrens);
										            },
										            'image/png'
										        );
										}
									}
		                	   }
		                   }
		               }
			    });
			}
		}
		
		processInformation(data,chart);
		pie.value = detalleGrafico.footer;
	}
});
</script>