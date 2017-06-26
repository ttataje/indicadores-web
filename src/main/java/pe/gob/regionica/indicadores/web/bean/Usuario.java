package pe.gob.regionica.indicadores.web.bean;

public class Usuario extends GenericBean{

	private static final long serialVersionUID = 1L;
	private Long codigo;
	private String nombre;
	private String apellidoPaterno;
	private String apellidoMaterno;
	private String username;
	private String password;
	private String rol;

	public Usuario(){
		super();
	}

	public Usuario(Long codigo, String nombre, String apellidoPaterno, String apellidoMaterno, String username,
			String password, String rol) {
		super();
		this.codigo = codigo;
		this.nombre = nombre;
		this.apellidoPaterno = apellidoPaterno;
		this.apellidoMaterno = apellidoMaterno;
		this.username = username;
		this.password = password;
		this.rol = rol;
	}

	public Long getCodigo() {
		return codigo;
	}
	public void setCodigo(Long codigo) {
		this.codigo = codigo;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getApellidoPaterno() {
		return apellidoPaterno;
	}
	public void setApellidoPaterno(String apellidoPaterno) {
		this.apellidoPaterno = apellidoPaterno;
	}
	public String getApellidoMaterno() {
		return apellidoMaterno;
	}
	public void setApellidoMaterno(String apellidoMaterno) {
		this.apellidoMaterno = apellidoMaterno;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRol() {
		return rol;
	}
	public void setRol(String rol) {
		this.rol = rol;
	}

	
}
