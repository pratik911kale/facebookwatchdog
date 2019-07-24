package social.network;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;



public class NoCacheFilter implements Filter 
{
    public void init(FilterConfig config) throws ServletException 
    {
        // If you have any <init-param> in web.xml, then you could get them
        // here by config.getInitParameter("name") and assign it as field.
    }
 
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException 
    {
        HttpServletResponse hsr = (HttpServletResponse) res;
        hsr.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        hsr.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        hsr.setDateHeader("Expires", 0); // Proxies.
        chain.doFilter(req, res);
    }
 
    @Override
    public void destroy() 
    {
        // If you have assigned any expensive resources as field of
        // this Filter class, then you could clean/close them here.
    }
 
}