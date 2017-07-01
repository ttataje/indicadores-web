package pe.gob.regionica.indicadores.web.utils;

import java.util.ResourceBundle;

import org.springframework.context.annotation.Configuration;

@Configuration
public class WebConstants {
	
	public static final ResourceBundle bundle = ResourceBundle.getBundle("rest");

	public static final String restServer = bundle.getString("rest-server");
	
	public static final String restColor = restServer + "/rest/color/list";
	
	public static final String restLogin = restServer + "/rest/usuario/login?username={username}&clave={clave}";
	
	// Operaciones Grafico
	public static final String restLoadGrafico = restServer + "/rest/grafico/cargar?codigo={codigo}";
	
	public static final String restAddGrafico = restServer + "/rest/grafico/guardar?grafico.tipo={grafico.tipo}&grafico.indicador={grafico.indicador}";
	
	public static final String restDelGrafico = restServer + "/rest/grafico/eliminar?grafico.codigo={grafico.codigo}";
	
	// Operaciones DetalleGrafico
	public static final String restAddDetalleGrafico = restServer + "/rest/detalleGrafico/guardar?detalle.grafico.codigo={detalle.grafico.codigo}&detalle.padre.codigo={detalle.padre.codigo}&detalle.descripcion={detalle.descripcion}&detalle.valor={detalle.valor}";
	
	public static final String restEditDetalleGrafico = restServer + "/rest/detalleGrafico/modificar?detalle.codigo={detalle.codigo}&detalle.borderColor={detalle.borderColor}&detalle.tipo={detalle.tipo}";

	public static final String restDelDetalleGrafico = restServer + "/rest/detalleGrafico/eliminar?detalle.codigo={detalle.codigo}";
	
	public static final String restGetDetalleGrafico = restServer + "/rest/detalleGrafico/get?codigo={codigo}";
	
	public static final String restGetDetallePorPadre = restServer + "/rest/detalleGrafico/getByParent?codigo={codigo}";
	
	public static final String restGetDetallePorGrafico = restServer + "/rest/detalleGrafico/getByChart?codigo={codigo}";
	
	// Operaciones Indicadores
	public static final String restAddIndicador = restServer + "/rest/indicador/guardar?indicador.padre.codigo={indicador.padre.codigo}&indicador.descripcion={indicador.descripcion}&indicador.tipo={indicador.tipo}&indicador.position={indicador.position}";
	
	public static final String restEditIndicador = restServer + "/rest/indicador/modificar?indicador.codigo={indicador.codigo}&indicador.padre.codigo={indicador.padre.codigo}&indicador.descripcion={indicador.descripcion}&indicador.tipo={indicador.tipo}&indicador.position={indicador.position}";
	
	public static final String restDelIndicador = restServer + "/rest/indicador/eliminar?indicador.codigo={indicador.codigo}";

	public static final String restGetIndicador = restServer + "/rest/indicador/get?codigo={codigo}";

	public static final String restGetIndicadorPorPadre = restServer + "/rest/indicador/getByParent?codigo={codigo}";
}
