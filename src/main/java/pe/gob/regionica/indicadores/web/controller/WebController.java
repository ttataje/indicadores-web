package pe.gob.regionica.indicadores.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;

import pe.gob.regionica.indicadores.common.bean.Response;
import pe.gob.regionica.indicadores.common.bean.Usuario;
import pe.gob.regionica.indicadores.web.utils.WebConstants;

@Controller
@RequestMapping("/")
public class WebController {
	
    @RequestMapping(value = { "/"}, method = RequestMethod.GET)
    public String indexPage(ModelMap model) {
        return "index";
    }

    @RequestMapping(value = { "/login"}, method = RequestMethod.POST)
    public String login(ModelMap model) {
    	RestTemplate restTemplate = new RestTemplate();
    	Response response = restTemplate.getForObject(WebConstants.restLogin, Response.class);
    	response.getStatus();
    	Usuario usuario = (Usuario)response.getObject();
    	model.put("usuario", usuario);
        return "principal";
    }
    

    @RequestMapping(value = { "/login"}, method = RequestMethod.POST)
    public String lPage(ModelMap model) {
    	RestTemplate restTemplate = new RestTemplate();
    	Response response = restTemplate.getForObject(WebConstants.restLogin, Response.class);
    	response.getStatus();
    	Usuario usuario = (Usuario)response.getObject();
    	model.put("usuario", usuario);
        return "principal";
    }
    
    @RequestMapping(value = { "/go"}, method = RequestMethod.GET)
    public String loadPage(ModelMap model) {
    	String page = (String)model.get("page");
        return page;
    }
    
}
