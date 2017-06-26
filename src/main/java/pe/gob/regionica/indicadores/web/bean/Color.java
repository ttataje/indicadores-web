package pe.gob.regionica.indicadores.web.bean;

public class Color extends GenericBean {

	private static final long serialVersionUID = 1L;

	private Long codigo;

	private String descripcion;
	
	private Integer red;
	
	private Integer green;
	
	private Integer blue;

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

	public Integer getRed() {
		return red;
	}

	public void setRed(Integer red) {
		this.red = red;
	}

	public Integer getGreen() {
		return green;
	}

	public void setGreen(Integer green) {
		this.green = green;
	}

	public Integer getBlue() {
		return blue;
	}

	public void setBlue(Integer blue) {
		this.blue = blue;
	}
	
	public String getColorRGB(){
		return "'rgb("+red + "," + green + ","  + blue + ")'";
	}

}
