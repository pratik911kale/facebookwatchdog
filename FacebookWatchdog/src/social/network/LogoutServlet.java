package social.network;

import java.awt.Window;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/LogoutServlet")

public class LogoutServlet extends HttpServlet
{  
	
	/**
	 * This class method is called for Log Out of user
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)   // This class method is called for Log Out of user
                            throws ServletException, IOException 
    {  
    	 
    	response.setContentType("text/html");  
    	
    	HttpSession session1 = request.getSession(false);
        
        if(session1!=null)
        {
          
           session1.invalidate();
           response.sendRedirect("UserLogin.jsp");
        }
        
        
        
       
       
       
     
       
          
        //out.print("You are successfully logged out!");  
       // RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/UserLogin.jsp");
		//dispatcher.forward(request, response);
          
    }  
}