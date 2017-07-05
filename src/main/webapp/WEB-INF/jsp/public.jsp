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
var objNode = null;
var selectedNode = null;
var countChart = 0;

$(function () {
	$("#modalDIV").modal("hide");
	
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