package pe.gob.regionica.indicadores.web.bean;

import java.math.BigDecimal;

public class DetalleGrafico extends GenericBean {

	private static final long serialVersionUID = 1L;

	private Long codigo;
	
	private Long grafico;
	
	private String data;

	private String attributes;

	public Long getCodigo() {
		return codigo;
	}

	public void setCodigo(Long codigo) {
		this.codigo = codigo;
	}

	public Long getGrafico() {
		return grafico;
	}

	public void setGrafico(Long grafico) {
		this.grafico = grafico;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getAttributes() {
		return attributes;
	}

	public void setAttributes(String attributes) {
		this.attributes = attributes;
	}

}
