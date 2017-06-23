package pe.gob.regionica.indicadores.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class WebFilter implements Filter {
	
	FilterConfig filterConfig;
	
	private static final String METHOD_GET = "GET";
	
	@Override
	public void destroy() {
		this.filterConfig = null;
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)resp;
		HttpSession session = request.getSession(false);
		
		if(METHOD_GET.equalsIgnoreCase(request.getMethod())){
			if(request.getQueryString() != null && !request.getQueryString().endsWith("/index.html")){
				if(session != null){
					session.invalidate();
				}
				response.sendRedirect(request.getContextPath()+"/index.html");
			}
		}
		
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}

}
