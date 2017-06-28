package pe.gob.regionica.indicadores.web.utils;

import java.util.ResourceBundle;

import org.springframework.context.annotation.Configuration;

@Configuration
public class WebConstants {
	
	public static final ResourceBundle bundle = ResourceBundle.getBundle("rest");

	public static final String restServer = bundle.getString("rest-server");
	
	public static final String successful = "200";
	
	public static final String restColor = restServer + "/rest/color/list";
	
	public static final String restLogin = restServer + "/rest/usuario/login?username={username}&clave={clave}";
	
	public static final String restLoadGrafico = restServer + "/rest/grafico/cargar?codigo={codigo}";
	
	public static final String restAddGrafico = restServer + "/rest/grafico/guardar";
	
	public static final String restDelGrafico = restServer + "/rest/grafico/eliminar";
	
	public static final String restGetIndicador = restServer + "/rest/indicador/get?codigo={codigo}";
	
	public static final String restAddIndicador = restServer + "/rest/indicador/guardar";
	
	public static final String restDelIndicador = restServer + "/rest/indicador/eliminar";
}
