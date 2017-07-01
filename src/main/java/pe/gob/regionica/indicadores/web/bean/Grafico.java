package pe.gob.regionica.indicadores.web.bean;

import java.util.Collection;

public class Grafico extends GenericBean {

	private static final long serialVersionUID = 1L;

	private Long codigo;

	private Long indicador;

	private String tipo;

	private Collection<DetalleGrafico> data;

	public Long getCodigo() {
		return codigo;
	}

	public void setCodigo(Long codigo) {
		this.codigo = codigo;
	}

	public Long getIndicador() {
		return indicador;
	}

	public void setIndicador(Long indicador) {
		this.indicador = indicador;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public Collection<DetalleGrafico> getData() {
		return data;
	}

	public void setData(Collection<DetalleGrafico> data) {
		this.data = data;
	}

}
