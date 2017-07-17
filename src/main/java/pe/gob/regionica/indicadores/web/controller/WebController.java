package pe.gob.regionica.indicadores.web.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
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
@SessionAttributes({ "usuario", "currentPage", "grafico", "indicador" })
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
			Indicador indicador = restTemplate.postForObject(WebConstants.restGetIndicador, null, Indicador.class,
					vars);
			model.addAttribute("currentPage", "registro");
			model.addAttribute("grafico", grafico);
			model.addAttribute("indicador", indicador);
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

	@RequestMapping(value = { "/loadChartData" }, method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> loadChartData(HttpServletRequest request, ModelMap model) {
		Map<String, Object> response = new HashMap<String, Object>();
		String codigo = request.getParameter("codigo");

		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

		Map<String, Object> vars = new HashMap<String, Object>();
		vars.put("codigo", codigo);

		try {
			Grafico grafico = restTemplate.postForObject(WebConstants.restLoadGrafico, null, Grafico.class, vars);
			response.put("type", "stackedBar".equals(grafico.getTipo()) ? "bar" : grafico.getTipo());
			if (grafico.getData() != null) {

				Map<String, Object> data = new HashMap<String, Object>();
				List<String> labels = new ArrayList<String>();
				DetalleGrafico detalleGrafico = (DetalleGrafico) grafico.getData().toArray()[0];
				if ("pie".equals(grafico.getTipo())) {
					// Grafico tipo pie
				} else {
					// Todos los otros graficos
					// Obtenemos los Labels
					vars = new HashMap<String, Object>();
					vars.put("codigo", detalleGrafico.getCodigo());

					DetalleGrafico[] listGroups = restTemplate.postForObject(WebConstants.restGetDetallePorPadre, null,
							DetalleGrafico[].class, vars);
					// Cargamos los labels
					for (int i = 0; i < listGroups.length; i++) {
						labels.add(listGroups[i].getDescripcion());
					}
					data.put("labels", labels);
					vars = new HashMap<String, Object>();
					vars.put("codigo", listGroups.length > 0 ? listGroups[0].getCodigo() : -1);

					DetalleGrafico[] listLabel = restTemplate.postForObject(WebConstants.restGetDetallePorPadre, null,
							DetalleGrafico[].class, vars);

					data.put("datasets", new ArrayList<Map<String, Object>>(listLabel.length));
					List<Map<String, Object>> datasets = (List<Map<String, Object>>) data.get("datasets");

					// Creamos estructura de data
					for (int i = 0; i < listLabel.length; i++) {
						Map<String, Object> itemDataSet = null;
						try {
							itemDataSet = datasets.get(i);
						} catch (IndexOutOfBoundsException e) {
							itemDataSet = new HashMap<String, Object>();
							datasets.add(itemDataSet);
						}
						itemDataSet = datasets.get(i);

						if (!itemDataSet.containsKey("label")
								|| !itemDataSet.get("label").equals(listLabel[i].getDescripcion())) {
							itemDataSet.put("label", listLabel[i].getDescripcion());
							itemDataSet.put("backgroundColor", listLabel[i].getBorderColor() != null
									? listLabel[i].getBorderColor() : "rgb(255,99,132)");
							itemDataSet.put("data", new ArrayList<BigDecimal>(listLabel.length));
						}
					}

					for (int i = 0; i < listGroups.length; i++) {
						vars = new HashMap<String, Object>();
						vars.put("codigo", listGroups[i].getCodigo());

						DetalleGrafico[] listData = restTemplate.postForObject(WebConstants.restGetDetallePorPadre,
								null, DetalleGrafico[].class, vars);
						for (int j = 0; j < listData.length; j++) {
							Map<String, Object> itemDataSet = datasets.get(j);
							// Obtenemos los valores
							vars = new HashMap<String, Object>();
							vars.put("codigo", listLabel[j].getCodigo());
							DetalleGrafico[] listValues = restTemplate.postForObject(
									WebConstants.restGetDetallePorPadre, null, DetalleGrafico[].class, vars);
							if (listValues != null && listValues.length > 0) {
								((List<BigDecimal>) itemDataSet.get("data")).add(listValues[0].getValor());
							}else{
								((List<BigDecimal>) itemDataSet.get("data")).add(listData[0].getValor());
							}
						}
					}
				}
				response.put("data", data);
			}
			Map<String, Object> options = new HashMap<String, Object>();

			Map<String, Object> title = new HashMap<String, Object>();
			title.put("display", Boolean.FALSE);
			title.put("text", "");
			options.put("title", title);

			Map<String, Object> tooltips = new HashMap<String, Object>();
			tooltips.put("mode", "index");
			tooltips.put("intersect", Boolean.FALSE);
			options.put("tooltips", tooltips);
			options.put("responsive", Boolean.TRUE);
			// Usado cuando es stackedBar
			if ("stackedBar".equals(grafico.getTipo())) {
				Map<String, Object> scales = new HashMap<String, Object>();
				List<Map<String, Object>> xAxes = new ArrayList<Map<String, Object>>();
				Map<String, Object> xAxes_stacked = new HashMap<String, Object>();
				xAxes_stacked.put("stacked", Boolean.TRUE);
				xAxes.add(xAxes_stacked);
				scales.put("xAxes", xAxes);
				List<Map<String, Object>> yAxes = new ArrayList<Map<String, Object>>();
				Map<String, Object> yAxes_stacked = new HashMap<String, Object>();
				yAxes_stacked.put("stacked", Boolean.TRUE);
				scales.put("yAxes", yAxes);
				options.put("scales", scales);
			}

			response.put("options", options);
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

		String _codigo = request.getParameter("codigo");
		String tipo = request.getParameter("type");
		String padre = request.getParameter("padre");
		String grafico = request.getParameter("grafico");

		try {
			Map<String, Object> params = new HashMap<String, Object>();

			if (!StringUtils.isEmpty(_codigo)) {
				params.put("detalle.codigo", new Long(_codigo));
				params.put("detalle.grafico.codigo", null);
				params.put("detalle.padre.codigo", null);
			} else {
				params.put("detalle.codigo", null);
			}

			if (StringUtils.isEmpty(_codigo)) {
				if (StringUtils.isEmpty(padre)) {
					params.put("detalle.grafico.codigo", new Long(grafico));
					params.put("detalle.padre.codigo", null);
				} else {
					params.put("detalle.padre.codigo", new Long(padre));
					params.put("detalle.grafico.codigo", null);
				}
			}

			if (StringUtils.isEmpty(padre)) {
				params.put("detalle.grafico.codigo", new Long(grafico));
				params.put("detalle.padre.codigo", null);
			} else {
				params.put("detalle.padre.codigo", new Long(padre));
				params.put("detalle.grafico.codigo", null);
			}

			if ("folder".equals(tipo)) {
				params.put("detalle.descripcion", request.getParameter("text"));
				params.put("detalle.valor", null);
			} else {
				params.put("detalle.descripcion", null);
				params.put("detalle.valor", request.getParameter("text").indexOf(",") > -1
						? request.getParameter("text").replaceAll(",", ".") : request.getParameter("text"));
			}

			Long codigo = restTemplate.postForObject(WebConstants.restAddDetalleGrafico, null, Long.class, params);
			params.clear();
			params.put("codigo", codigo);
			return new ResponseEntity<Map<String, Object>>(params, HttpStatus.ACCEPTED);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<Map<String, Object>>(MapUtils.EMPTY_MAP, HttpStatus.BAD_REQUEST);
		}
	}

	@RequestMapping(value = { "/updateDetalle" }, method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateDetalle(HttpServletRequest request, ModelMap model) {
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

		String codigo = request.getParameter("codigo");
		String color = request.getParameter("color");
		String tipo = request.getParameter("tipo");

		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("detalle.codigo", new Long(codigo));
			params.put("detalle.borderColor", color);
			params.put("detalle.tipo", tipo);

			DetalleGrafico detalleGrafico = restTemplate.postForObject(WebConstants.restEditDetalleGrafico, null,
					DetalleGrafico.class, params);
			params.clear();
			params.put("detalleGrafico", detalleGrafico);
			return new ResponseEntity<Map<String, Object>>(params, HttpStatus.ACCEPTED);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<Map<String, Object>>(MapUtils.EMPTY_MAP, HttpStatus.BAD_REQUEST);
		}
	}
	
	@RequestMapping(value = { "/delDetalle" }, method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> delDetalle(HttpServletRequest request, ModelMap model) {
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

		String codigo = request.getParameter("codigo");

		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("detalle.codigo", new Long(codigo));

			DetalleGrafico detalleGrafico = restTemplate.postForObject(WebConstants.restDelDetalleGrafico, null, DetalleGrafico.class, params);
			params.clear();
			params.put("detalleGrafico", detalleGrafico);
			return new ResponseEntity<Map<String, Object>>(params, HttpStatus.ACCEPTED);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<Map<String, Object>>(MapUtils.EMPTY_MAP, HttpStatus.BAD_REQUEST);
		}
	}

	@RequestMapping(value = { "/getDetalle" }, method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> getDetalle(HttpServletRequest request, ModelMap model) {
		String codigo = request.getParameter("codigo");

		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

		Map<String, Object> vars = new HashMap<String, Object>();
		Grafico grafico = (Grafico) model.get("grafico");
		vars.put("codigo", StringUtils.isEmpty(codigo) ? grafico.getCodigo() : codigo);

		try {
			List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
			DetalleGrafico[] detalle = null;
			if (StringUtils.isEmpty(codigo)) {
				// Cargamos el primer nodo que se obtiene a partir del codigo
				// del grafico
				detalle = restTemplate.postForObject(WebConstants.restGetDetallePorGrafico, null,
						DetalleGrafico[].class, vars);
				vars = new HashMap<String, Object>();
				vars.put("codigo", detalle[0].getCodigo());
				vars.put("text", detalle[0].getDescripcion());
				vars.put("type", "root");
				vars.put("parent", "#");
				vars.put("children", detalle[0].getChildren());
				result.add(vars);
				return new ResponseEntity<List<Map<String, Object>>>(result, HttpStatus.ACCEPTED);
			} else {
				// Se cargan el resto de nodos
				detalle = restTemplate.postForObject(WebConstants.restGetDetallePorPadre, null, DetalleGrafico[].class,
						vars);
				if (detalle != null && detalle.length > 0) {
					for (int i = 0; i < detalle.length; i++) {
						vars = new HashMap<String, Object>();
						vars.put("codigo", detalle[i].getCodigo());
						vars.put("text", detalle[i].getDescripcion() != null ? detalle[i].getDescripcion()
								: detalle[i].getValor());
						vars.put("type", detalle[i].getPadre() == null ? "root"
								: (detalle[i].getDescripcion() != null ? "folder" : "value"));
						vars.put("parent", detalle[i].getPadre() != null ? detalle[i].getPadre() : "#");
						vars.put("children", detalle[i].getChildren());
						result.add(vars);
					}
					return new ResponseEntity<List<Map<String, Object>>>(result, HttpStatus.ACCEPTED);
				}
			}
			return new ResponseEntity<List<Map<String, Object>>>(result, HttpStatus.ACCEPTED);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<List<Map<String, Object>>>(ListUtils.EMPTY_LIST, HttpStatus.BAD_REQUEST);
		}
	}
}