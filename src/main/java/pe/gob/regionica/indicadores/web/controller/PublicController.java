package pe.gob.regionica.indicadores.web.controller;

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
		Map<String, Object> response = new HashMap<String, Object>();
		String codigo = request.getParameter("codigo");

		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

		Map<String, Object> vars = new HashMap<String, Object>();
		vars.put("codigo", codigo);

		try {
			Grafico grafico = restTemplate.postForObject(WebConstants.restLoadGrafico, null, Grafico.class, vars);
			response.put("grafico", grafico);
			DetalleGrafico detalleGrafico = restTemplate.postForObject(WebConstants.restGetDetallePorGrafico, null, DetalleGrafico.class, vars);
			response.put("detalleGrafico", detalleGrafico);
			return new ResponseEntity<Map<String, Object>>(response, HttpStatus.ACCEPTED);
		} catch (Exception e) {
			log.error(e.getMessage());
			model.addAttribute("message", "No se pudo cargar el elemento seleccionado");
			return new ResponseEntity<Map<String, Object>>(MapUtils.EMPTY_MAP, HttpStatus.BAD_REQUEST);
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
	    			/*if("chart".equals(indicadores[i].getTipo())){
	    				if(indicadores[i].getPublico()){
	    					result.add(vars);
	    				}
    				}else{*/
    					result.add(vars);
    				//}
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
