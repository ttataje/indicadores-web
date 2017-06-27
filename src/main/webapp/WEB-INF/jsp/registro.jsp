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
var nodeSelected = null;
window.chartColors = ${colors};

window.randomScalingFactor = function() {
	var num1 = 1000;
	var num2 = 9999999;
	return Math.floor(Math.random() * (num2-num1 + 1) + num1);
};

var arrayCollectionChildren = [
	{"codigo": 1, "text": "2017", "state" : { "opened" : true }, "type" : "folder", "children": 
		[
			{"codigo": 2, "parent" : 1, "text": "Marzo", "state" : { "opened" : true }, "type" : "folder", "children": 
			[
				{"codigo": 3, "parent" : 2, "text": "Exportacion", "state" : { "opened" : true }, "type" : "folder", "children": 
				[
					{"codigo": 4, "parent" : 3, "text": "Por Sectores", "state" : { "opened" : true }, "type" : "folder", "children": 
					[
						{"codigo": 5, "parent" : 4, "text": "EXPORTACIONES POR SECTORES ECON�MICOS 2000-2016 (Millones US$ FOB)","icon" : "glyphicon glyphicon-dashboard", "type" : "chart"},
						{"codigo": 6, "parent" : 4, "text": "EXPORTACIONES DE LOS SECTORES POR PRODUCTO 2015 (Millones US$ FOB)","icon" : "glyphicon glyphicon-dashboard", "type" : "chart"},
						{"codigo": 7, "parent" : 4, "text": "Sector Agr�cola", "state" : { "opened" : true }, "type" : "folder", "children": 
						[
							{"codigo": 8, "parent" : 7, "text": "EXPORTACIONES AGROPECUARIAS POR PRODUCTO 2015 (Millones US$ FOB)","icon" : "glyphicon glyphicon-dashboard", "type" : "chart"},
							{"codigo": 9, "parent" : 7, "text": "EXPORTACIONES AGROPECUARIAS POR PRODUCTO 2000-2016 (Millones US$ FOB)","icon" : "glyphicon glyphicon-dashboard", "type" : "chart"},
							{"codigo": 10, "parent" : 7, "text": "Uvas Frescas", "state" : { "opened" : true }, "type" : "folder", "children": 
							[
								{"codigo": 11, "parent" : 10, "text": "VOLUMEN EXPORTADO (t) Y PRECIO FOB (US$ / kg) DE LA UVA Campa�as 00/01-15/16","icon" : "glyphicon glyphicon-dashboard", "type" : "chart"},
								{"codigo": 12, "parent" : 10, "text": "PRECIOS (US$ / kg) Y VOL�MENES (t) MENSUALESDE LA DE LA EXPORTACI�N DE UVA Campa�as 14/15-16/17","icon" : "glyphicon glyphicon-dashboard", "type" : "chart"},
								{"codigo": 13, "parent" : 10, "text": "EXPORTACIONES DE UVA POR PA�S DE DESTINO Campa�as 00/01-15/16 (t)","icon" : "glyphicon glyphicon-dashboard", "type" : "chart"},
								{"codigo": 14, "parent" : 10, "text": "EXPORTACIONES DE UVA POR EMPRESA EXPORTADORA Campa�as 00/01-15/16 (t)","icon" : "glyphicon glyphicon-dashboard", "type" : "chart"},
							]},
							{"codigo": 15, "parent" : 7, "text": "Esp�rragos Frescos", "state" : { "opened" : true }, "type" : "folder", "children": [
								{"codigo": 16, "parent" : 15, "text": "VOLUMEN EXPORTADO (t) Y PRECIO FOB (US$ / kg) DEL ESP�RRAGO FRESCO 2000-2016","icon" : "glyphicon glyphicon-dashboard", "type" : "chart"},
								{"codigo": 17, "parent" : 15, "text": "PRECIOS (US$ / kg) Y VOL�MENES (t) MENSUALES DE LA EXPORTACI�N DE ESP�RRAGO FRESCO 2014-2016","icon" : "glyphicon glyphicon-dashboard", "type" : "chart"},
								{"codigo": 18, "parent" : 15, "text": "EXPORTACIONES DE ESP�RRAGO FRESCO POR PA�S DE DESTINO 2010-2016 (t)","icon" : "glyphicon glyphicon-dashboard", "type" : "chart"},
								{"codigo": 19, "parent" : 15, "text": "EXPORTACIONES DE ESP�RRAGO FRESCO POR EMPRESA EXPORTADORA 2010-2016 (t)","icon" : "glyphicon glyphicon-dashboard", "type" : "chart"}
							]},
						]},
					]},
				]},
			]},
		] },
	];

	
var arrayCollection = [{
	"text" : "Region Ica",
	"state" : { "opened" : true },
	"children" : arrayCollectionChildren
	}];


var barChartData = {
        labels: ["2010", "2011", "2012", "2013", "2014", "2015", "2016"],
        datasets: [{
            label: 'CFG INVESTMENT',
            backgroundColor: window.chartColors.red,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ]
        }, {
            label: 'PESQUERA DIAMANTE',
            backgroundColor: window.chartColors.blue,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ]
        }, {
            label: 'AUSTRAL GROUP',
            backgroundColor: window.chartColors.green,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ]
        }, {
            label: 'PESQUERA EXALMAR',
            backgroundColor: window.chartColors.yellow,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ]
        }, {
            label: 'PESQUERA HAYDUK',
            backgroundColor: window.chartColors.purple,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ]
        }, {
            label: 'PESQUERA CENTINELA',
            backgroundColor: window.chartColors.grey,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ]
        }, {
            label: 'COPEINCA',
            backgroundColor: window.chartColors.orange,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ]
        }]

    };
$(function () {
	var title = "";
	var nextNode = 19;

	$("#modalDIV").modal("hide");
	
	$("#modalRegistroDIV").modal("hide");
	
	$('body').on('click','.odom-modificar',function(e){
		var ref = $('#jstree').jstree(true),
		sel = ref.get_selected();
		if(!sel.length) { return false; }
		sel = sel[0];
		var link = document.createElement('a');
		link.href = '${pageContext.request.contextPath}/loadChart?codigo='+sel.id;
		document.body.appendChild(link);
		link.click(); 
	});
	
	$('body').on('click','.odom-guardar',function(e){
		var ref = $('#jstree').jstree(true),
			sel = ref.get_selected();
		var nodeText = $("#descripcion");
		if(!sel.length) { return false; }
		sel = sel[0];
		nextNode = nextNode + 1;
		sel = ref.create_node(sel, {"codigo": nextNode, "parent" : sel, "text": nodeText, "state" : { "opened" : true }, "type" : "folder"}, 'last');
	});
	
	$('body').on('click','.odom-imprimir',function(e){
		alert('Imprimir!');
	});
	
	var ctx = document.getElementById('chartCanvas').getContext('2d');
	
    window.myBar = new Chart(ctx, {
        type: 'bar',
        data: barChartData,
        options: {
            title:{
                display: false,
                text:""
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


	$('#jstree').jstree({"plugins" : [ "contextmenu", "types", "search", "state", "wholerow" ],
	'core' : {
		'data' : arrayCollection
	},
	"check_callback" : true,
	'unique' : {
		'duplicate' : function (name, counter) {
			return name + ' ' + counter;
		}
	},	
	"contextmenu": {
		"items": function (node) {
			var tree = $('#jstree').jstree(true);
			var menu = {
				"Create": {
					"label": "Nuevo",
					"submenu" : {
						"Section": {
							"separator_after"	: true,
							"label": "Seccion",
							"action": function (obj) { 
								nodeSelected = obj;
								$('#title-registro').text("Agregar Seccion");
								$('#tr-tipo').hide();
								$("#modalRegistroDIV").modal("show");
							}
						},
						"Chart": {
							"label": "Grafico",
							"action": function (obj) { 
								nodeSelected = obj;
								$('#title-registro').text("Agregar Gr�fico");
								$('#tr-tipo').show();
								$("#modalRegistroDIV").modal("show"); 
							}
						}
					}
				},
				"Rename": {
					"label": "Renombrar",
					"action": function (data) { 
						nodeSelected = _node;
						modificar();
					}
				},
				"Delete": {
					"label": "Eliminar",
					"action": function (obj) { 
						nodeSelected = _node;
						eliminar();
					}
				},
				"Edit":{
					"label": "Modificar",
					"submenu" : {
						"Copy": {
							"separator_after"	: true,
							"label": "Copiar",
							"action": function (obj) { this.copy(obj); }
						},
						"Cut": {
							"separator_after"	: true,
							"label": "Cortar",
							"action": function (obj) { this.cut(obj); }
						},
						"Paste": {
							"label": "Pegar",
							"action": function (obj) { this.paste(obj); },
							"_disabled" : true
						}
					}
				}
			};
			
			if(node.children.length > 0){
				delete menu.Delete;
			}

			if(node.icon === "glyphicon glyphicon-dashboard") {
				delete menu.Create;
			}
			
			if(node.parent == "#"){
				return null;
			}
			
			if(rol == "Consultor"){
				return null;
			}
			
			return menu;
		}
	}
	});
	
	$('#jstree').bind("dblclick.jstree",function (e) {
		var li = $(e.target).closest("li");
		var item = li[0].id;
		var node = $('#jstree').jstree(true).get_node(item);

		if(node.icon === "glyphicon glyphicon-dashboard") {
			title = node.text;
			$('#title-modal').text(node.text);
			$("#modalDIV").modal("show");
			//alert("Grafico : [" + node.id + "] " + node.text + " / Padre : " + node.parent);
			
			if(rol == "Consultor"){
				$('.odom-modificar').hide();
			}else{
				$('.odom-modificar').show();
			}
			
            barChartData.datasets.forEach(function(dataset, i) {
                dataset.data = dataset.data.map(function() {
                    return randomScalingFactor();
                });
            });
            window.myBar.update();
		}
	});
	
});
</script>