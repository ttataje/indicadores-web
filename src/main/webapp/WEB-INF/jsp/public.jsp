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
		      <div class="modal-body">
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
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		      	<table>
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
		      <div class="modal-body odom-pdf-source">
		        
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
var countChart = 0;

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
				body.append("<div>" + data.text + "</div>");
			}else{
				body.append("<canvas id='chart_"+ data.codigo + "'></canvas>");
				$.post('${pageContext.request.contextPath}/loadChartData', {"codigo" : data.codigo})
				.done(function (d) {
					var ctx = document.getElementById('chart_'+data.codigo).getContext('2d');
					
					if(!jQuery.isEmptyObject(d.data) && d.data.datasets.length > 0){
					    window.myBar = new Chart(ctx, d);
					}
				})
				.fail(function (e) {
					//FIXME falta mensaje en caso falle la carga del modal
				});
			}
		}
		
		$("#modalPrintDIV").modal("show");
	});
	
	$('body').on('click','.odom-imprimir',function(e){
		var doc = new jsPDF();
	    doc.addHTML($('.odom-pdf-source')[0], 15, 15, {
	        'background': '#fff',
	      }, function() {
	        doc.save('output.pdf');
	    });
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

	$('#jstree').bind("dblclick.jstree",function (e) {
		var li = $(e.target).closest("li");
		var item = li[0].id;
		var node = $('#jstree').jstree(true).get_node(item);
		nodeToModify = node.original.codigo;
		
		if(node.type === "chart") {
			$.post('${pageContext.request.contextPath}/publico/loadChartData', {"codigo" : node.original.codigo})
			.done(function (d) {
				var ctx = document.getElementById('chartCanvas').getContext('2d');
				
				if(!jQuery.isEmptyObject(d.data)){
					console.log(d)
				    window.myBar = new Chart(ctx, d);

					$('#title-modal').text(node.text);
					$("#modalDIV").modal("show");
									
				}
			})
			.fail(function (e) {
				//FIXME falta mensaje en caso falle la carga del modal
			});
		}
	});

});
</script>