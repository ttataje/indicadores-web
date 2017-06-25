package pe.gob.regionica.indicadores.web.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

@Configuration
@PropertySource("classpath:rest.properties")
public class WebConstants {

	@Value("${rest-server}")
	public static String restServer;
	
	public static String restLogin = restServer + "/rest/login";
}
