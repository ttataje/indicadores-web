package pe.gob.regionica.indicadores.web.bean;

public class Response extends GenericBean{

	private static final long serialVersionUID = 1L;

	private String status;
	
	private String message;
	
	private Object object;

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Object getObject() {
		return object;
	}

	public void setObject(Object object) {
		this.object = object;
	}

}
