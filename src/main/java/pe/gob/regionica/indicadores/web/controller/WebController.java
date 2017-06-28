package pe.gob.regionica.indicadores.web.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.client.RestTemplate;

import com.mysql.jdbc.StringUtils;

import pe.gob.regionica.indicadores.web.bean.Color;
import pe.gob.regionica.indicadores.web.bean.Grafico;
import pe.gob.regionica.indicadores.web.bean.Indicador;
import pe.gob.regionica.indicadores.web.bean.Usuario;
import pe.gob.regionica.indicadores.web.utils.WebConstants;

@Controller
@RequestMapping("/")
@SessionAttributes({"usuario","currentPage","colors"})
public class WebController {
	
	private final Logger log = LoggerFactory.getLogger(WebController.class);
	
    @RequestMapping(value = { "/"}, method = RequestMethod.GET)
    public String indexPage(ModelMap model) {
        return "login";
    }

    @RequestMapping(value = { "/login"}, method = RequestMethod.POST)
    public String login(HttpServletRequest request, ModelMap model) {
    	RestTemplate restTemplate = new RestTemplate();
    	restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
    	restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

    	String username = request.getParameter("username");
    	String clave = request.getParameter("password");

    	Map<String, String> vars = new HashMap<String, String>();
    	vars.put("username", username);
    	vars.put("clave", clave);
    	
    	try{
    		Usuario usuario = restTemplate.postForObject(WebConstants.restLogin, null, Usuario.class, vars);
	    	model.addAttribute("usuario", usuario);
	    	model.addAttribute("currentPage", "principal");
	    	
	    	Color[] colores = restTemplate.postForObject(WebConstants.restColor, null, Color[].class);
	    	if(colores != null){
	    		StringBuilder colors = new StringBuilder("{");
	    		for(int i = 0; i < colores.length; i++){
	    			colors.append(colores[i].getDescripcion());
	    			colors.append(": ");
	    			colors.append(colores[i].getColorRGB());
	    			if(i != colores.length - 1)
	    				colors.append(",");
	    		}
	    		colors.append("}");
	    		model.addAttribute("colors", colors);
	    	}
    	}catch(Exception e){
    		log.error(e.getMessage());
    		model.addAttribute("message", "Usuario y/o Contraseña son incorrectos");
    		return "login";
    	}
        return "principal";
    }
    

    @RequestMapping(value = { "/logout"}, method = RequestMethod.GET)
    public String logout(HttpServletRequest request) {
    	HttpSession session = request.getSession(false);
    	if(session != null){
    		session.invalidate();
    	}
        return "login";
    }
    
    @RequestMapping(value = { "/go"}, method = RequestMethod.POST)
    public String loadPage(HttpServletRequest request, ModelMap model) {
    	if(model.get("usuario") == null){
    		return "login";
    	}
    	String page = request.getParameter("page");
    	model.addAttribute("currentPage", page);
        return page;
    }
    
    @RequestMapping(value = { "/loadChart"}, method = RequestMethod.POST)
    public String loadChart(HttpServletRequest request, ModelMap model) {
    	String codigo = request.getParameter("codigo");
    	
    	RestTemplate restTemplate = new RestTemplate();
    	restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
    	restTemplate.getMessageConverters().add(new StringHttpMessageConverter());
    	
    	Map<String, String> vars = new HashMap<String, String>();
    	vars.put("codigo", codigo);
    	
    	try{
    		Grafico grafico = restTemplate.postForObject(WebConstants.restLoadGrafico, null, Grafico.class, vars);
	    	model.addAttribute("currentPage", "registro");
	    	model.addAttribute("grafico", grafico);
    	}catch(Exception e){
    		log.error(e.getMessage());
    		model.addAttribute("message", "No se pudo cargar el elemento seleccionado");
    		return "login";
    	}
    	
        return "grafico";
    }
    
    @RequestMapping(value = { "/getNode"}, method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<List<Indicador>> getNode(HttpServletRequest request, ModelMap model) {
    	String codigo = request.getParameter("codigo");

    	RestTemplate restTemplate = new RestTemplate();
    	restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
    	restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

    	Map<String, String> vars = new HashMap<String, String>();
    	vars.put("codigo", codigo);
    	
    	try{
    		Indicador[] indicadores = restTemplate.postForObject(WebConstants.restGetIndicador, null, Indicador[].class, vars);
	    	return new ResponseEntity<List<Indicador>>(Arrays.asList(indicadores), HttpStatus.ACCEPTED);
    	}catch(Exception e){
    		log.error(e.getMessage());
    		return new ResponseEntity<List<Indicador>>(ListUtils.EMPTY_LIST, HttpStatus.ACCEPTED);
    	}
    }
    
    @RequestMapping(value = { "/addNode"}, method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String,Object>> addNode(HttpServletRequest request, ModelMap model) {
    	Indicador padre = new Indicador();
    	padre.setCodigo(new Long(request.getParameter("padre")));
    	
    	Indicador indicador = new Indicador();
    	indicador.setPadre(padre);
    	indicador.setDescripcion(request.getParameter("text"));
    	indicador.setTipo(request.getParameter("type"));
    	indicador.setPosition(new Long(StringUtils.isNullOrEmpty(request.getParameter("position")) ? request.getParameter("position") : "1"));

    	RestTemplate restTemplate = new RestTemplate();
    	restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
    	restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

    	Map<String, Object> vars = new HashMap<String, Object>();
    	vars.put("indicador", indicador);
    	
    	try{
    		Long codigo = restTemplate.postForObject(WebConstants.restAddIndicador, null, Long.class, vars);
    		vars.clear();
    		vars.put("codigo", codigo);
	    	return new ResponseEntity<Map<String,Object>>(vars, HttpStatus.ACCEPTED);
    	}catch(Exception e){
    		log.error(e.getMessage());
    		return new ResponseEntity<Map<String,Object>>(MapUtils.EMPTY_MAP, HttpStatus.BAD_REQUEST);
    	}
    }
}
