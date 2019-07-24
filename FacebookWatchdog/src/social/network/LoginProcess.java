package social.network;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import social.bean.UserInfo;
import social.dao.AccountBanDAO;
import social.dao.UserDAO;


@WebServlet("/LoginProcess")
public class LoginProcess extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	TransactionManager tm = null;   
    
    public LoginProcess()
    {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		
	}

	
	/**
	 * This class method is called for checking user inputs for Logging in
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// This class method is called for checking user inputs for Logging in
		
		/*   Parameters from form are obtained           */
		String emailPhone = request.getParameter("emailorphone");
		String password = request.getParameter("password");
		
		UserInfo info = new UserInfo();
		UserDAO dao = new UserDAO();
		UserInfo user = null;
		System.out.println(emailPhone + password);
		
		
		
		if(UtilityEmail.emailOrNot(emailPhone)) //  check whether user has entered email or not
		{
			
			info.setEmail(emailPhone);
			info.setPassword(password);
			String result = dao.initEmail(info);  // check whether user is registered or not
			
			AccountBanDAO banned = new AccountBanDAO();
	    	String isBanned = banned.checkBanEmail(emailPhone); // check whether email is banned or not
			
			if(result.equals("success") && !isBanned.equals("yes"))  // if user is registered
		    {
				UserDAO dao1 = new UserDAO();
				HttpSession session1 = request.getSession();
				user = dao1.getUser(info);
				
				  
		        	   
		        	  // set user details into Session Object for further reference
		         	   session1.setAttribute("Email",user.getEmail());
		         	   session1.setAttribute("FirstName",user.getFirst());
		         	   session1.setAttribute("LastName",user.getLast());
		         	   session1.setAttribute("Password",user.getPassword());
		         	   session1.setAttribute("LocalAddress",user.getLocal());
		         	   session1.setAttribute("PermanentAddress",user.getPermanent());
		         	   session1.setAttribute("Phone",user.getPhone());
		         	   session1.setAttribute("DOB",user.getDOB());
		         	   session1.setAttribute("Gender",user.getGender());
		         	   
		         	  
		           
				    
				   response.sendRedirect("Home.jsp");  // send user to home page of facebook
				
				
				
					
		    	
			}
		       
		       
		    else
		    {
		    	
		    	if(isBanned.equals("yes"))   // check if user is banned or not
		    	{
		    		
		    		 StringBuffer sb = new StringBuffer("");
					  
						
					  
						sb.append("UserLogin.jsp");
						sb.append("?message=Your account is banned");
						
						  
						  
						String url = sb.toString();
						  
						String urlEncoded = response.encodeRedirectURL(url) ;
						  
						response.sendRedirect(urlEncoded);	
		    		
		    		
		    		
		    	}
		    	else
		    	{
		    	
		    		 StringBuffer sb = new StringBuffer("");
					  
						
					  
						sb.append("UserLogin.jsp");
						sb.append("?message=Invalid Email or Password");
						
						  
						  
						String url = sb.toString();
						  
						String urlEncoded = response.encodeRedirectURL(url) ;
						  
						response.sendRedirect(urlEncoded);	
		    		
		    		
			
			
		    	}
	     	}
		}
		else   // if user has entered Phone number
		{
			
			info.setPhone(emailPhone);
			info.setPassword(password);
			String result = dao.initPhone(info);// check whether user is registered or not
			
			AccountBanDAO banned = new AccountBanDAO();
	    	String isBanned = banned.checkBanEmail(emailPhone);
			
			if(result.equals("success") && !isBanned.equals("yes"))   // if user is registered
		    {
				UserDAO dao1 = new UserDAO();
				HttpSession session1 = request.getSession();
				user = dao1.getPhone(info);
				
		        	   
				// set user details into Session Object for further reference
				   session1.setAttribute("Email",user.getEmail());
	         	   session1.setAttribute("FirstName",user.getFirst());
	         	   session1.setAttribute("LastName",user.getLast());
	         	   session1.setAttribute("Password",user.getPassword());
	         	   session1.setAttribute("LocalAddress",user.getLocal());
	         	   session1.setAttribute("PermanentAddress",user.getPermanent());
	         	   session1.setAttribute("Phone",user.getPhone());
	         	   session1.setAttribute("DOB",user.getDOB());
	         	   session1.setAttribute("Gender",user.getGender());
		         	   
		         	  
		         	   
		           
				   
	         	  response.sendRedirect("Home.jsp");
				
				
				
		    	
			}
		       
		       
		    else
		    {
		    	
		    	if(isBanned.equals("yes"))
		    	{
		    		 StringBuffer sb = new StringBuffer("");
					  
						
					  
						sb.append("UserLogin.jsp");
						sb.append("?message=Your account is banned");
						
						  
						  
						String url = sb.toString();
						  
						String urlEncoded = response.encodeRedirectURL(url) ;
						  
						response.sendRedirect(urlEncoded);	
		    	}
		    	
		    	else
		    	{
		    		 StringBuffer sb = new StringBuffer("");
					  
						
					  
						sb.append("UserLogin.jsp");
						sb.append("?message=Invalid Phone or Password");
						
						  
						  
						String url = sb.toString();
						  
						String urlEncoded = response.encodeRedirectURL(url) ;
						  
						response.sendRedirect(urlEncoded);	
		    	}
	     	}
		}
		
	}

}
