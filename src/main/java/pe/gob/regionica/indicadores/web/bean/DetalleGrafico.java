package pe.gob.regionica.indicadores.web.bean;

import java.math.BigDecimal;

public class DetalleGrafico extends GenericBean {

	private static final long serialVersionUID = 1L;

	private Long codigo;
	
	private String descripcion;
	
	private Long grafico;
	
	private Long padre;
	
	private BigDecimal valor;
	
	private String tipo = "bar";
	
	private String label;
	
	private String borderColor;
	
	private Long borderWidth = new Long (2);

	private Boolean children = Boolean.FALSE;
	
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

	public Long getPadre() {
		return padre;
	}

	public void setPadre(Long padre) {
		this.padre = padre;
	}

	public BigDecimal getValor() {
		return valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

	public Boolean getChildren() {
		return children;
	}

	public void setChildren(Boolean children) {
		this.children = children;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getBorderColor() {
		return borderColor;
	}

	public void setBorderColor(String borderColor) {
		this.borderColor = borderColor;
	}

	public Long getBorderWidth() {
		return borderWidth;
	}

	public void setBorderWidth(Long borderWidth) {
		this.borderWidth = borderWidth;
	}

}
