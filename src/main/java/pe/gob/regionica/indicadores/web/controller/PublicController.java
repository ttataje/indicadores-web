package pe.gob.regionica.indicadores.web.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.ListUtils;
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import pe.gob.regionica.indicadores.web.bean.DetalleGrafico;
import pe.gob.regionica.indicadores.web.bean.Grafico;
import pe.gob.regionica.indicadores.web.bean.Indicador;
import pe.gob.regionica.indicadores.web.utils.WebConstants;

@Controller
public class PublicController {
	
	private final Logger log = LoggerFactory.getLogger(PublicController.class);
	
    @RequestMapping(value = { "/publico"}, method = RequestMethod.GET)
    public String index(ModelMap model) {
        return "public";
    }

    
    /*
     * 
     * Carga de Data de Cuadro
     * 
     */
    
    @RequestMapping(value = { "/publico/loadChartData"}, method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String,Object>> loadChartData(HttpServletRequest request, ModelMap model) {
    	Map<String,Object> response = new HashMap<String,Object>();
    	String codigo = request.getParameter("codigo");
    	
    	RestTemplate restTemplate = new RestTemplate();
    	restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
    	restTemplate.getMessageConverters().add(new StringHttpMessageConverter());
    	
    	Map<String, Object> vars = new HashMap<String, Object>();
    	vars.put("codigo", codigo);
    	
    	try{
    		Grafico grafico = restTemplate.postForObject(WebConstants.restLoadGrafico, null, Grafico.class, vars);
    		response.put("type", "stackedBar".equals(grafico.getTipo()) ? "bar" : grafico.getTipo());
    		if(grafico.getData().size() < 2){
    			response.put("data", MapUtils.EMPTY_MAP);
    		}else{
    			Map<String,Object> data = new HashMap<String,Object>();
    			List<String> labels = new ArrayList<String>();
    			DetalleGrafico detalleGrafico = (DetalleGrafico)grafico.getData().toArray()[0];
    			if("pie".equals(grafico.getTipo())){
    				// Grafico tipo pie
    			}else{
    				// Todos los otros graficos
    				// Obtenemos los Labels
    				vars = new HashMap<String, Object>();
    		    	vars.put("codigo", detalleGrafico.getCodigo());

    				DetalleGrafico[] listGroups = restTemplate.postForObject(WebConstants.restGetDetallePorPadre, null, DetalleGrafico[].class, vars);
    				// Cargamos los labels
    				for(int i = 0; i < listGroups.length; i++){
    					labels.add(listGroups[i].getDescripcion());
    				}
    				data.put("labels", labels);
    				vars = new HashMap<String, Object>();
    		    	vars.put("codigo", listGroups[0].getCodigo());
    		    	
					DetalleGrafico[] listLabel = restTemplate.postForObject(WebConstants.restGetDetallePorPadre, null, DetalleGrafico[].class, vars);

    				data.put("datasets", new ArrayList<Map<String,Object>>(listLabel.length));
    				List<Map<String,Object>> datasets = (List<Map<String,Object>>)data.get("datasets");
    				
    				// Creamos estructura de data
    				for(int i = 0; i < listLabel.length; i++){
    					Map<String,Object> itemDataSet = null;
    					try{
    						itemDataSet = datasets.get(i);
    					}catch(IndexOutOfBoundsException e){
    						itemDataSet = new HashMap<String,Object>();
    						datasets.add(itemDataSet);
    					}
    					itemDataSet = datasets.get(i);
    					
						if(!itemDataSet.containsKey("label") || !itemDataSet.get("label").equals(listLabel[i].getDescripcion())){
							itemDataSet.put("label", listLabel[i].getDescripcion());
							itemDataSet.put("backgroundColor", listLabel[i].getBorderColor() != null ? listLabel[i].getBorderColor() : "rgb(255,99,132)");
							itemDataSet.put("data", new ArrayList<BigDecimal>(listLabel.length));
						}
    				}
    				
    				for(int i = 0; i < listGroups.length; i++){
        				vars = new HashMap<String, Object>();
        		    	vars.put("codigo", listGroups[i].getCodigo());
        		    	
    					DetalleGrafico[] listData = restTemplate.postForObject(WebConstants.restGetDetallePorPadre, null, DetalleGrafico[].class, vars);
    					for(int j = 0; j < listData.length; j++){
    						Map<String,Object> itemDataSet = datasets.get(j);
    						// Obtenemos los valores
    	    				vars = new HashMap<String, Object>();
    	    		    	vars.put("codigo", listLabel[j].getCodigo());
    						DetalleGrafico[] listValues = restTemplate.postForObject(WebConstants.restGetDetallePorPadre, null, DetalleGrafico[].class, vars);
    						if(listValues != null){
    							((List<BigDecimal>)itemDataSet.get("data")).add(listValues[0].getValor());
    						}    						
    					}
    				}
    			}
    			response.put("data", data);
    		}
    		Map<String,Object> options = new HashMap<String,Object>();
    		
	    		Map<String,Object> title = new HashMap<String,Object>();
		    		title.put("display", Boolean.FALSE);
		    		title.put("text", "");
	    		options.put("title", title);

	    		Map<String,Object> tooltips = new HashMap<String,Object>();
		    		tooltips.put("mode", "index");
		    		tooltips.put("intersect", Boolean.FALSE);
	    		options.put("tooltips", tooltips);
	    		options.put("responsive", Boolean.TRUE);
	    		// Usado cuando es stackedBar
	    		if("stackedBar".equals(grafico.getTipo())){
		    		Map<String,Object> scales = new HashMap<String,Object>();
		    			List<Map<String,Object>> xAxes = new ArrayList<Map<String,Object>>();
		    				Map<String,Object> xAxes_stacked = new HashMap<String,Object>();
		    				xAxes_stacked.put("stacked", Boolean.TRUE);
		    				xAxes.add(xAxes_stacked);
		    			scales.put("xAxes", xAxes);
		    			List<Map<String,Object>> yAxes = new ArrayList<Map<String,Object>>();
		    				Map<String,Object> yAxes_stacked = new HashMap<String,Object>();
		    				yAxes_stacked.put("stacked", Boolean.TRUE);
		    			scales.put("yAxes", yAxes);
		    		options.put("scales", scales);
	    		}

    		response.put("options", options);
	    	return new ResponseEntity<Map<String,Object>>(response, HttpStatus.ACCEPTED);
    	}catch(Exception e){
    		log.error(e.getMessage());
    		model.addAttribute("message", "No se pudo cargar el elemento seleccionado");
    		return new ResponseEntity<Map<String,Object>>(MapUtils.EMPTY_MAP, HttpStatus.BAD_REQUEST);
    	}
    }

    @RequestMapping(value = { "/publico/getNode"}, method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<List<Map<String,Object>>> getNode(HttpServletRequest request, ModelMap model) {
    	String codigo = request.getParameter("codigo");

    	RestTemplate restTemplate = new RestTemplate();
    	restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
    	restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

    	Map<String, Object> vars = new HashMap<String, Object>();
    	vars.put("codigo", StringUtils.isEmpty(codigo) ? null : codigo);
    	
    	try{
    		Indicador[] indicadores = restTemplate.postForObject(WebConstants.restGetIndicadorPorPadre, null, Indicador[].class, vars);
    		if(indicadores.length > 0) {
    			List<Map<String, Object>> result = new ArrayList<Map<String,Object>>();
    			for(int i = 0; i < indicadores.length; i++){
	    				vars = new HashMap<String, Object>();
	    				vars.put("codigo", indicadores[i].getCodigo());
	    				vars.put("text", indicadores[i].getDescripcion());
	    				vars.put("type", indicadores[i].getTipo());
	    				vars.put("parent", indicadores[i].getPadre() != null ? indicadores[i].getPadre()  : "#");
	    				vars.put("children", indicadores[i].getChildren());
	    			if("chart".equals(indicadores[i].getTipo())){
	    				if(indicadores[i].getPublico()){
	    					result.add(vars);
	    				}
    				}else{
    					result.add(vars);
    				}
    			}
    			return new ResponseEntity<List<Map<String,Object>>>(result, HttpStatus.ACCEPTED);
    		}else{
    			throw new Exception("Blank Query");
    		}
    	}catch(Exception e){
    		log.error(e.getMessage());
    		return new ResponseEntity<List<Map<String,Object>>>(ListUtils.EMPTY_LIST, HttpStatus.BAD_REQUEST);
    	}
    }

}
