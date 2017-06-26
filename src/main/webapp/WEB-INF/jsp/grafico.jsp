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
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Fin Contenido -->
<script type="text/javascript">
	var getUrlParameter = function getUrlParameter(sParam) {
	    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
	        sURLVariables = sPageURL.split('&'),
	        sParameterName,
	        i;

	    for (i = 0; i < sURLVariables.length; i++) {
	        sParameterName = sURLVariables[i].split('=');

	        if (sParameterName[0] === sParam) {
	            return sParameterName[1] === undefined ? true : sParameterName[1];
	        }
	    }
	};
</script>
<script type="text/javascript">
	function convertToArrayChildren(labelDataset, chartDataset){
		var size = labelDataset.length;
		var children = [];
		var autoid = 0;
		for(var i = 0; i < size; i++){
			autoid = autoid + 1;
			children[i] = {"id" : autoid, "text": labelDataset[i], "state" : { "opened" : true }, "type" : "folder", "children": []};
			for(var k = 0; k < size; k++){
				autoid = autoid + 1;
				for(var j = 0; j < chartDataset.length; j++){
					children[i].children[k] = {"id" : autoid, "text": chartDataset[k].label, "state" : { "opened" : true }, "type" : "folder", "children": []};
					autoid = autoid + 1;
					children[i].children[k].children[0] = {"id": autoid, "parent" : autoid - 1, "text": chartDataset[k].data[i],"icon" : "glyphicon glyphicon-dashboard", "type" : "value"};
				}					
			}
		}
		return children;
	}
</script>
<script type="text/javascript">
window.chartColors = {
	red: 'rgb(255, 99, 132)',
	orange: 'rgb(255, 159, 64)',
	yellow: 'rgb(255, 205, 86)',
	green: 'rgb(75, 192, 192)',
	blue: 'rgb(54, 162, 235)',
	purple: 'rgb(153, 102, 255)',
	grey: 'rgb(201, 203, 207)'
};

window.randomScalingFactor = function() {
	var num1 = 1000;
	var num2 = 9999999;
	return Math.floor(Math.random() * (num2-num1 + 1) + num1);
};

var titulo = getUrlParameter('title');

var labelDataset = ["2010", "2011", "2012", "2013", "2014", "2015", "2016"];

var chartDataset = [{
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
   }];

var arrayChilden = convertToArrayChildren(labelDataset, chartDataset);
	
var arrayCollection = [{
	"text" : titulo,
	"state" : { "opened" : true },
	"children" : arrayChilden
	}];

var barChartData = {
        labels: labelDataset,
        datasets: chartDataset

    };
$(function () {
	
	$('body').on('click','.odom-regresar',function(e){
		var link = document.createElement('a');
		link.href = '${pageContext.request.contextPath}/registro_indicadores.html';
		document.body.appendChild(link);
		link.click(); 
	});
	
	var ctx = document.getElementById('chartCanvas').getContext('2d');
	
    window.myBar = new Chart(ctx, {
        type: 'bar',
        data: barChartData,
        options: {
            title:{
                display: true,
                text: titulo
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

	function crear() {
		var ref = $('#jstree').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { return false; }
		sel = sel[0];
		sel = ref.create_node(sel, {"type":"file"});
		if(sel) {
			ref.edit(sel);
		}
	};
	function modificar() {
		var ref = $('#jstree').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { return false; }
		sel = sel[0];
		ref.edit(sel);
	};
	function eliminar() {
		var ref = $('#jstree').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { return false; }
		ref.delete_node(sel);
	};


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
			var menu = {
				"Create": {
					"label": "Nuevo",
					"submenu" : {
						"Group": {
							"separator_after"	: true,
							"label": "Grupo",
							"action": function (obj) { this.group(obj); }
						},
						"Value": {
							"label": "Valor",
							"action": function (obj) { this.value(obj); }
						}
					}
				},
				"Edit": {
					"label": "Modificar",
					"action": function (obj) { this.edit(obj); }
				},
				"Delete": {
					"label": "Eliminar",
					"action": function (obj) { this.remove(obj); }
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
			
			return menu;
		}
	}
	});
	/*
	$('#jstree').bind("dblclick.jstree",function (e) {
		var li = $(e.target).closest("li");
		var item = li[0].id;
		var node = $('#jstree').jstree(true).get_node(item);

		if(node.icon === "glyphicon glyphicon-dashboard") {
			$('.modal-title').text(node.text);
			$("#modalDIV").modal("show");
			//alert("Grafico : [" + node.id + "] " + node.text + " / Padre : " + node.parent);
            barChartData.datasets.forEach(function(dataset, i) {
                dataset.data = dataset.data.map(function() {
                    return randomScalingFactor();
                });
            });
            window.myBar.update();
		}
	});
	*/
});
</script>