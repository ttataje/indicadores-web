package pe.gob.regionica.indicadores.web.bean;

import java.math.BigDecimal;
import java.util.Collection;

public class DetalleGrafico extends GenericBean {

	private static final long serialVersionUID = 1L;

	private Long codigo;
	
	private String descripcion;
	
	private Long grafico;
	
	private DetalleGrafico padre;
	
	private BigDecimal valor;
	
	private Collection<DetalleGrafico> children;

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

	public Long getGrafico() {
		return grafico;
	}

	public void setGrafico(Long grafico) {
		this.grafico = grafico;
	}

	public DetalleGrafico getPadre() {
		return padre;
	}

	public void setPadre(DetalleGrafico padre) {
		this.padre = padre;
	}

	public BigDecimal getValor() {
		return valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

	public Collection<DetalleGrafico> getChildren() {
		return children;
	}

	public void setChildren(Collection<DetalleGrafico> children) {
		this.children = children;
	}

}
