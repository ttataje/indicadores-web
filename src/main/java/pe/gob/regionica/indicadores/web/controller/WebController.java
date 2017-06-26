package pe.gob.regionica.indicadores.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.client.RestTemplate;

import pe.gob.regionica.indicadores.web.bean.Grafico;
import pe.gob.regionica.indicadores.web.bean.Usuario;
import pe.gob.regionica.indicadores.web.utils.WebConstants;

@Controller
@RequestMapping("/")
@SessionAttributes({"usuario","currentPage"})
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
    
    @RequestMapping(value = { "/go"}, method = RequestMethod.GET)
    public String loadPage(HttpServletRequest request, ModelMap model) {
    	String page = request.getParameter("page");
    	model.addAttribute("currentPage", page);
        return page;
    }
    
    @RequestMapping(value = { "/loadChart"}, method = RequestMethod.GET)
    public String loadChart(HttpServletRequest request, ModelMap model) {
    	String codigo = request.getParameter("codigo");
    	
    	RestTemplate restTemplate = new RestTemplate();
    	restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
    	restTemplate.getMessageConverters().add(new StringHttpMessageConverter());
    	
    	Map<String, String> vars = new HashMap<String, String>();
    	vars.put("codigo", codigo);
    	
    	try{
    		Grafico grafico = restTemplate.postForObject(WebConstants.restGrafico, null, Grafico.class, vars);
	    	model.addAttribute("currentPage", "registro");
	    	model.addAttribute("grafico", grafico);
    	}catch(Exception e){
    		log.error(e.getMessage());
    		model.addAttribute("message", "No se pudo cargar el elemento seleccionado");
    		return "login";
    	}
    	
        return "grafico";
    }
    
}
