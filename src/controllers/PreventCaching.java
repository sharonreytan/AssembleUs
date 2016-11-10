package controllers;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

public class PreventCaching implements Filter {
	@Override
    public void init(FilterConfig filterConfig) {
    }

    public void destroy() {
    }
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
           throws IOException, ServletException {
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        //force browser to not save cache for each request
        httpResponse.setHeader("Cache-Control", "no-cache");
        httpResponse.setDateHeader("Expires", 0);
        httpResponse.setHeader("Pragma", "no-cache");
        httpResponse.setDateHeader("Max-Age", 0);

        chain.doFilter(request, response);
    }

}