<!-- Inicio Contenido -->
<div class="row">
	<div class="col-md-12 col-xs-12">
		<form id="form" method="post" action="#" class="dropzone-form">
			<div class="widget-box widget-color-blue2">
				<div class="widget-header widget-header-small">
					<h4 class="widget-title lighter">
						<i class="ace-icon fa fa-edit"></i>
						Indicadores Socio Econ&oacute;micos
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
var objNode = null;
var selectedNode = null;
var tipoGrafico = null;
var colors = ['rgb(255, 99, 132)','rgb(255, 159, 64)','rgb(255, 205, 86)','rgb(75, 192, 192)','rgb(54, 162, 235)','rgb(153, 102, 255)','rgb(201, 203, 207)',
	'rgb(255, 99, 132)','rgb(255, 159, 64)','rgb(255, 205, 86)','rgb(75, 192, 192)','rgb(54, 162, 235)','rgb(153, 102, 255)','rgb(201, 203, 207)',
	'rgb(255, 99, 132)','rgb(255, 159, 64)','rgb(255, 205, 86)','rgb(75, 192, 192)','rgb(54, 162, 235)','rgb(153, 102, 255)','rgb(201, 203, 207)',
	'rgb(255, 99, 132)','rgb(255, 159, 64)','rgb(255, 205, 86)','rgb(75, 192, 192)','rgb(54, 162, 235)','rgb(153, 102, 255)','rgb(201, 203, 207)'];


$(function () {
	$("#modalDIV").modal("hide");
	
	$("#modalPrintDIV").modal("hide");
	
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
		body.empty();
		body.append("<div id='printAreaSIRI'></div>");
		body = $("#printAreaSIRI");
		
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
				var folder = [];
				var page = $("<div class='new_page'></div>");
				var div = $("<div style='position: relative; width: 297mm; min-height: 210mm; margin: 10mm auto; background: white;'></div>");
				var span = $("<span style='position: absolute; color: #000000; font-family: arial; font-weight: bold; display: inline; top: 350px; left: 63px; font-size: xx-large; -webkit-box-decoration-break: clone; box-decoration-break: clone;'>" + data.text + "</span>");
				var img = $("<img src='${pageContext.request.contextPath}/images/pdf_titulo.png' style='position: absolute; top: 10mm; width: 270mm; min-height: 190mm;'>")
				body.append(page);
				page.append(div);
				div.append(img);
				div.append(span)
			}else{
				var page = $("<div class='new_page'></div>");
				var div = $("<div style='width: 297mm; min-height: 210mm; padding: 20mm; margin: 10mm auto; background: white;'></div>");
				var span = $("<span style='font-family: arial; font-weight: bold; color: #000000; font-size: large;'>" + data.text + "</span>");
				var canvas = $("<canvas id='chart_"+ data.codigo + "'></canvas>");
				body.append(page);
				page.append(div);
				div.append(span);
				div.append(canvas);

				$.post('${pageContext.request.contextPath}/publico/loadChartData', {"codigo" : data.codigo})
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
		window.print(); 
	});
	
	$('#jstree').jstree({
			'core' : {
				'data' : {
					'url' : '${pageContext.request.contextPath}/publico/getNode',
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
			'plugins' : ['state','types','wholerow']
		})
		.on('loaded.jstree', function() {
			$('#jstree').jstree('open_all');
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
			$.post('${pageContext.request.contextPath}/publico/loadChartData', {"codigo" : node.original.codigo})
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
				}
			})
			.fail(function (e) {
				//FIXME falta mensaje en caso falle la carga del modal
			});
		}
	});

});
</script>