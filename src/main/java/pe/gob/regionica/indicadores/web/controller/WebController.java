package pe.gob.regionica.indicadores.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.ListUtils;
import org.apache.commons.collections.MapUtils;
import org.json.JSONObject;
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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.client.RestTemplate;

import pe.gob.regionica.indicadores.web.bean.DetalleGrafico;
import pe.gob.regionica.indicadores.web.bean.Grafico;
import pe.gob.regionica.indicadores.web.bean.Indicador;
import pe.gob.regionica.indicadores.web.bean.Usuario;
import pe.gob.regionica.indicadores.web.utils.WebConstants;

@Controller
@RequestMapping("/")
@SessionAttributes({ "usuario", "currentPage", "grafico", "indicador", "detalleGrafico" })
public class WebController {

	private final Logger log = LoggerFactory.getLogger(WebController.class);

	@RequestMapping(value = { "/" }, method = RequestMethod.GET)
	public String indexPage(ModelMap model) {
		return "login";
	}

	@RequestMapping(value = { "/login" }, method = RequestMethod.POST)
	public String login(HttpServletRequest request, ModelMap model) {
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

		String username = request.getParameter("username");
		String clave = request.getParameter("password");

		Map<String, String> vars = new HashMap<String, String>();
		vars.put("username", username);
		vars.put("clave", clave);

		try {
			Usuario usuario = restTemplate.postForObject(WebConstants.restLogin, null, Usuario.class, vars);
			model.addAttribute("usuario", usuario);
			model.addAttribute("currentPage", "principal");
			/*
			 * Color[] colores =
			 * restTemplate.postForObject(WebConstants.restColor, null,
			 * Color[].class); if(colores != null){ StringBuilder colors = new
			 * StringBuilder("{"); for(int i = 0; i < colores.length; i++){
			 * colors.append(colores[i].getDescripcion()); colors.append(": ");
			 * colors.append(colores[i].getColorRGB()); if(i != colores.length -
			 * 1) colors.append(","); } colors.append("}");
			 * model.addAttribute("colors", colors); }
			 */
		} catch (Exception e) {
			log.error(e.getMessage());
			model.addAttribute("message", "Usuario y/o Contraseña son incorrectos");
			return "login";
		}
		return "principal";
	}

	@RequestMapping(value = { "/logout" }, method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		return "login";
	}

	/*
	 * 
	 * Navegacion
	 * 
	 */

	@RequestMapping(value = { "/go" }, method = RequestMethod.POST)
	public String loadPage(HttpServletRequest request, ModelMap model) {
		if (model.get("usuario") == null) {
			return "login";
		}
		String page = request.getParameter("page");
		model.addAttribute("currentPage", page);
		return page;
	}

	@RequestMapping(value = { "/loadChart" }, method = RequestMethod.GET)
	public String loadChart(HttpServletRequest request, ModelMap model) {
		String codigo = request.getParameter("codigo");

		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

		Map<String, String> vars = new HashMap<String, String>();
		vars.put("codigo", codigo);

		try {
			Grafico grafico = restTemplate.postForObject(WebConstants.restLoadGrafico, null, Grafico.class, vars);
			Indicador indicador = restTemplate.postForObject(WebConstants.restGetIndicador, null, Indicador.class, vars);
			vars.put("codigo", String.valueOf(grafico.getCodigo()));
			DetalleGrafico[] detalleGrafico = restTemplate.postForObject(WebConstants.restGetDetallePorGrafico, null, DetalleGrafico[].class, vars);
			model.addAttribute("currentPage", "registro");
			model.addAttribute("grafico", grafico);
			model.addAttribute("indicador", indicador);
			model.addAttribute("detalleGrafico", detalleGrafico[0]);
			model.addAttribute("json_grafico", new JSONObject(grafico));
			model.addAttribute("json_detalleGrafico", new JSONObject(detalleGrafico[0]));
		} catch (Exception e) {
			log.error(e.getMessage());
			model.addAttribute("message", "No se pudo cargar el elemento seleccionado");
			return "login";
		}

		return "grafico";
	}
	
    /*
     * 
     * Carga de Data de Cuadro
     * 
     */
    
    @RequestMapping(value = { "/loadChartData"}, method = RequestMethod.POST)
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
			vars.put("codigo", grafico.getCodigo());
			DetalleGrafico[] detalleGrafico = restTemplate.postForObject(WebConstants.restGetDetallePorGrafico, null, DetalleGrafico[].class, vars);
			response.put("detalleGrafico", detalleGrafico[0]);
			return new ResponseEntity<Map<String, Object>>(response, HttpStatus.ACCEPTED);
		} catch (Exception e) {
			log.error(e.getMessage());
			model.addAttribute("message", "No se pudo cargar el elemento seleccionado");
			return new ResponseEntity<Map<String, Object>>(MapUtils.EMPTY_MAP, HttpStatus.BAD_REQUEST);
		}
    }


	/*
	 * 
	 * Mantenimiento de Indicadores
	 * 
	 */

	@RequestMapping(value = { "/getNode" }, method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> getNode(HttpServletRequest request, ModelMap model) {
		String codigo = request.getParameter("codigo");

		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

		Map<String, Object> vars = new HashMap<String, Object>();
		vars.put("codigo", StringUtils.isEmpty(codigo) ? null : codigo);

		try {
			Indicador[] indicadores = restTemplate.postForObject(WebConstants.restGetIndicadorPorPadre, null,
					Indicador[].class, vars);
			if (indicadores.length > 0) {
				List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
				for (int i = 0; i < indicadores.length; i++) {
					vars = new HashMap<String, Object>();
					vars.put("codigo", indicadores[i].getCodigo());
					vars.put("text", indicadores[i].getDescripcion());
					vars.put("type", indicadores[i].getTipo());
					vars.put("parent", indicadores[i].getPadre() != null ? indicadores[i].getPadre() : "#");
					vars.put("children", indicadores[i].getChildren());
					result.add(vars);
				}
				return new ResponseEntity<List<Map<String, Object>>>(result, HttpStatus.ACCEPTED);
			} else {
				throw new Exception("Blank Query");
			}
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<List<Map<String, Object>>>(ListUtils.EMPTY_LIST, HttpStatus.BAD_REQUEST);
		}
	}

	@RequestMapping(value = { "/addNode" }, method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> addNode(HttpServletRequest request, ModelMap model) {
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("indicador.padre.codigo", request.getParameter("padre"));
			params.put("indicador.descripcion", request.getParameter("text"));
			params.put("indicador.tipo", request.getParameter("type"));
			params.put("indicador.position", new Long(
					!StringUtils.isEmpty(request.getParameter("position")) ? request.getParameter("position") : "1"));

			Long codigo = restTemplate.postForObject(WebConstants.restAddIndicador, null, Long.class, params);
			params.clear();
			params.put("codigo", codigo);
			return new ResponseEntity<Map<String, Object>>(params, HttpStatus.ACCEPTED);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<Map<String, Object>>(MapUtils.EMPTY_MAP, HttpStatus.BAD_REQUEST);
		}
	}

	@RequestMapping(value = { "/delNode" }, method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> delNode(HttpServletRequest request, ModelMap model) {
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("indicador.codigo", request.getParameter("codigo"));

			Indicador indicador = restTemplate.postForObject(WebConstants.restDelIndicador, null, Indicador.class, params);
			params.clear();
			params.put("codigo", indicador.getCodigo());
			return new ResponseEntity<Map<String, Object>>(params, HttpStatus.ACCEPTED);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<Map<String, Object>>(MapUtils.EMPTY_MAP, HttpStatus.BAD_REQUEST);
		}
	}

	/*
	 * 
	 * Mantenimiento de Grafico
	 * 
	 */

	@RequestMapping(value = { "/addChart" }, method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> addChart(HttpServletRequest request, ModelMap model) {
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("grafico.indicador", request.getParameter("indicador"));
			params.put("grafico.tipo", request.getParameter("tipo"));

			Long codigo = restTemplate.postForObject(WebConstants.restAddGrafico, null, Long.class, params);
			params.clear();
			params.put("codigo", codigo);
			return new ResponseEntity<Map<String, Object>>(params, HttpStatus.ACCEPTED);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<Map<String, Object>>(MapUtils.EMPTY_MAP, HttpStatus.BAD_REQUEST);
		}
	}

	/*
	 * 
	 * Mantenimiento de Detalle Grafico
	 * 
	 */

	@RequestMapping(value = { "/addDetalle" }, method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> addDetalle(HttpServletRequest request, ModelMap model) {
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

		String grafico = request.getParameter("grafico");

		try {
			Map<String, Object> params = new HashMap<String, Object>();
			
			params.put("detalle.codigo", null);
			params.put("detalle.grafico.codigo", new Long(grafico));

			Long codigo = restTemplate.postForObject(WebConstants.restAddDetalleGrafico, null, Long.class, params);
			params.clear();
			params.put("codigo", codigo);
			return new ResponseEntity<Map<String, Object>>(params, HttpStatus.ACCEPTED);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<Map<String, Object>>(MapUtils.EMPTY_MAP, HttpStatus.BAD_REQUEST);
		}
	}
	
	@RequestMapping(value = { "/saveDetalle" }, method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> saveDetalle(HttpServletRequest request, ModelMap model) {
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		restTemplate.getMessageConverters().add(new StringHttpMessageConverter());
		
		DetalleGrafico detalleGrafico = (DetalleGrafico) model.get("detalleGrafico");

		String info = request.getParameter("info");

		try {
			JSONObject jsonObject = new JSONObject(info);
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("detalle.codigo", detalleGrafico.getCodigo());
			params.put("detalle.data", jsonObject.get("data"));
			params.put("detalle.attributes", jsonObject.get("attributes"));
			params.put("detalle.footer", jsonObject.get("footer"));

			detalleGrafico = restTemplate.postForObject(WebConstants.restSaveDetalleGrafico, null, DetalleGrafico.class, params);
			params.clear();
			params.put("detalleGrafico", detalleGrafico);
			return new ResponseEntity<Map<String, Object>>(params, HttpStatus.ACCEPTED);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<Map<String, Object>>(MapUtils.EMPTY_MAP, HttpStatus.BAD_REQUEST);
		}
	}

}