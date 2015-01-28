package mil.af.orms.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class ResponseCharacterEncodingFilter implements Filter{
	private String encoding = "UTF-8";
	
	@Override
	public void destroy(){
		
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,FilterChain chain)throws IOException, ServletException{
		response.setCharacterEncoding(encoding);
		chain.doFilter(request, response);
	}
	
	@Override
	public void init(FilterConfig filterConfig)throws ServletException{
		String encoding = filterConfig.getInitParameter("encoding");
		if(encoding!=null){
			this.encoding = encoding;
		}
	}

}
