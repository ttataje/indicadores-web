package pe.gob.regionica.indicadores.web.bean;

import java.util.HashSet;
import java.util.Set;

public class Indicador extends GenericBean {

	private static final long serialVersionUID = 1L;

	private Long codigo;

	private String descripcion;
	
	private Long position;

	private Indicador padre;

	private String tipo;

	private Set<Indicador> children = new HashSet<Indicador>();

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
	
	public Long getPosition() {
		return position;
	}

	public void setPosition(Long position) {
		this.position = position;
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

	public Set<Indicador> getChildren() {
		return children;
	}

	public void setChildren(Set<Indicador> children) {
		this.children = children;
	}
	
	
}
