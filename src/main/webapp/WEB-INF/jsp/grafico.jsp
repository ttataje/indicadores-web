<style>
#copy-paste-box {
    border: 3px dashed #91917d;
    cursor: pointer;
    font-size: 21px;
    font-weight: 700;
    line-height: 136px;
    margin-top: 35px;
    margin-bottom: 35px;
    margin-right: 5px;
    margin-left: 5px;
    padding: 2px;
    text-transform: uppercase;
    border-radius: 6px;
}

#copy-paste-box {
    font-family: 'Open Sans Condensed',Arial,Helvetica,Verdana,sans-serif;
}

#copy-paste-box {
    text-align: center;
}

.row {
    margin-right: -15px;
    margin-left: -15px;
}
</style>
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
						<div id="copy-paste-box" class="row dz-clickable">
							<div id="copy-paste" class="col-lg-9 col-md-9 col-sm-9 col-xs-9">
								Copie y pegue su informaci&oacute;n aqu&iacute;
							</div><!-- /#copy-paste -->
						</div>
						<div id="chart-box" class="table-responsive">
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
						<input tabindex="13" type="button" class="btn btn-primary btn-white btn-round odom-guardar-grafico" value="Guardar">
					</div>
				</div>
				<!-- Inicio Ventana Alert -->
				<div class="alert alert-success">
					<button type="button" class="close" data-dismiss="alert">x</button>
					<strong>Perfecto!</strong> La informaci&oacute;n fu&eacute; almacenada correctamente.
				</div>
				<div class="alert alert-danger">
					<button type="button" class="close" data-dismiss="alert">x</button>
					<strong>Cuidado!</strong> Ocurri&oacute; un error inesperado al almacenar la informaci&oacute;n.
				</div>
				<div class="alert alert-warning">
					<button type="button" class="close" data-dismiss="alert">x</button>
					<strong>Ojo!</strong> No debe almacenar si aun no carga la informaci&oacute;n.
				</div>
				<div class="alert alert-info">
					<button type="button" class="close" data-dismiss="alert">x</button>
					<strong>Por favor!</strong> Primero debe copiar la informaci&oacute;n para poder pegar.
				</div>
				<!-- Fin Ventana Alert -->
			</div>
		</div>
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
		<!-- Fin Modal Atributos -->
	</div>
</div>
<!-- Fin Contenido -->
<script type="text/javascript">
var titulo = '${indicador.descripcion}';
var tipoGrafico = '${grafico.tipo}';
var grafico = ${json_grafico};
var detalleGrafico = ${json_detalleGrafico};
var data = [];

var copyPasteBox = $("#copy-paste-box");
var chartBox = $("#chart-box");

var alertOK = $(".alert-success");
var alertError = $(".alert-danger");
var alertErrorSize = $(".alert-warning");
var alertInfo = $(".alert-info")

var colors = ['rgb(255, 99, 132)','rgb(255, 159, 64)','rgb(255, 205, 86)','rgb(75, 192, 192)','rgb(54, 162, 235)','rgb(153, 102, 255)','rgb(201, 203, 207)',
	'rgb(255, 99, 132)','rgb(255, 159, 64)','rgb(255, 205, 86)','rgb(75, 192, 192)','rgb(54, 162, 235)','rgb(153, 102, 255)','rgb(201, 203, 207)',
	'rgb(255, 99, 132)','rgb(255, 159, 64)','rgb(255, 205, 86)','rgb(75, 192, 192)','rgb(54, 162, 235)','rgb(153, 102, 255)','rgb(201, 203, 207)',
	'rgb(255, 99, 132)','rgb(255, 159, 64)','rgb(255, 205, 86)','rgb(75, 192, 192)','rgb(54, 162, 235)','rgb(153, 102, 255)','rgb(201, 203, 207)'];
	

$(function () {
	
	$("#modalAtributosDIV").modal("hide");
	
	chartBox.hide();
	alertOK.hide();
	alertError.hide();
	alertErrorSize.hide();
	alertInfo.hide();

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

	$('body').on('click','.odom-guardarAtributos',function(e){
		var color = $("#color").val();
		var tipo = $("#tipo").val();
		
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
	
	$('body').on('click','.odom-guardar-grafico',function(e){
		if($.isArray(data) && data.length > 0){
			var item = {
						'data' : data,
						'attributes' : attributes
						};
			var info = JSON.stringify(item);
			$.post('${pageContext.request.contextPath}/saveDetalle', {'info' : info})
			.done(function (d) {
				alertOK.fadeTo(2000, 500).slideUp(500, function(){
					alertOK.slideUp(500);
				});
			})
			.fail(function (e) {
				alertError.fadeTo(2000, 500).slideUp(500, function(){
					alertError.slideUp(500);
				});
			});
		}else{
			alertErrorSize.fadeTo(2000, 500).slideUp(500, function(){
				alertErrorSize.slideUp(500);
			});
		}
	});
	
	$('body').on('click','.odom-regresar',function(e){
		goTo('registro'); 
	});
	
	var labelDataset = [];
	
	var chartDataset = [];
	
	var attributes = [];
	
	var chartData = {
	        labels: labelDataset,
	        datasets: chartDataset
	    };

	var ctx = document.getElementById('chartCanvas').getContext('2d');
	
	var chart = window.myBar;
	
	var typeGraph = tipoGrafico === 'stackedBar' ? 'bar' : (tipoGrafico === 'groupBar' ? 'bar' : tipoGrafico);
	if(tipoGrafico === 'pie'){
	    window.myBar = new Chart(ctx, {
	        type: typeGraph,
	        data: chartData,
	        options: {
				tooltips: {
					callbacks: {
						label: function(tooltipItem, data) {
							var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].toString();
								value = value.split(/(?=(?:...)*$)/);
								value = value.join(',');
							var datasetLabel =  data.labels[tooltipItem.index];
							return datasetLabel + ': ' + value;
						}
					}
				},
	            responsive: true,
	            pieceLabel: {
	            	render: 'percentage',
	            	fontColor: 'white',
	            	precision: 2
	            }
	        }
	    });
	}else if(tipoGrafico === 'stackedBar'){
	    window.myBar = new Chart(ctx, {
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
	            }
	        }
	    });			
	} else if(tipoGrafico === 'groupBar'){
	    window.myBar = new Chart(ctx, {
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
	            }
	        }
	    });			
	} else if(tipoGrafico === 'horizontalBar'){
	    window.myBar = new Chart(ctx, {
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
	    window.myBar = new Chart(ctx, {
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
		            }
               }
	    });
	}
	
	document.addEventListener('paste', function (evt) {
		var info = evt.clipboardData.getData('text/plain');
		if (info != null) {
			if(isChrome){
				clipRows = info.split(String.fromCharCode(13));
			}else{
				clipRows = info.split("\n");
			}

			// split rows into columns
			for (i=0; i<clipRows.length; i++) {
				clipRows[i] = clipRows[i].split(String.fromCharCode(9));
			}
			
			if($.isArray(clipRows) && clipRows.length > 1 && $.isArray(clipRows[0]) && clipRows[0].length > 1){
				data = clipRows;
				processInformation(data, window.myBar);
				copyPasteBox.hide();
				chartBox.show();
			}else{
				alertInfo.fadeTo(2000, 500).slideUp(500, function(){
					alertInfo.slideUp(500);
				});
			}
		}else{
			alertInfo.fadeTo(2000, 500).slideUp(500, function(){
				alertInfo.slideUp(500);
			});
		}
	});
	
	if(!(typeof detalleGrafico.data === "undefined")){
		data = JSON.parse(detalleGrafico.data);
		if($.isArray(data) && data.length > 0){
			processInformation(data, window.myBar);
			copyPasteBox.hide();
			chartBox.show();
		}
	}
	
	function processInformation(data, chart){
		labelDataset = [];
		chartDataset = [];
		
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
				chart = new Chart(ctx, {
			        type: typeGraph,
			        data: chartData,
		               options: {
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
		                   }
		               }
			    });
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
});
</script>