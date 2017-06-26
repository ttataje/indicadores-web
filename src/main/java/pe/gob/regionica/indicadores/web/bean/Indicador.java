package pe.gob.regionica.indicadores.web.bean;

import java.util.Collection;

public class Indicador extends GenericBean {

	private static final long serialVersionUID = 1L;

	private Long codigo;

	private String descripcion;

	private Indicador padre;

	private String tipo;

	private Collection<Indicador> children;

	public Long getCodigo() {
		return codigo;
	}

	public void setCodigo(Long codigo) {
		this.codigo = codigo;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public Indicador getPadre() {
		return padre;
	}

	public void setPadre(Indicador padre) {
		this.padre = padre;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public Collection<Indicador> getChildren() {
		return children;
	}

	public void setChildren(Collection<Indicador> children) {
		this.children = children;
	}
	
	
}
