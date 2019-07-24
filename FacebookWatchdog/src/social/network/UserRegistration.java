package social.network;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import social.bean.*
;
import social.dao.UserDAO;

@WebServlet("/UserRegistration")
public class UserRegistration extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	private static final String SAVE_DIR = "images2";
	
    public UserRegistration() 
    {
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}
  
	
	/**
	 * This class method is used for registration of user in facebook portal created
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		// This class method is used for registration of user in facebook portal created
		
		HttpSession session = request.getSession();
		String appPath = request.getServletContext().getRealPath("");
		
		System.out.println("In User reg");
		
		// Form Parameters are obtained
		String first = request.getParameter("first");
		String last = request.getParameter("last");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String local = request.getParameter("local");
		String permanent = request.getParameter("permanent");
		String dob = request.getParameter("dob");
		String gender = request.getParameter("gender");
		UserDAO dao = new UserDAO();
		System.out.println(first+" "+last+" "+password+" "+email+" "+email+" "+phone+" "+local+" "+permanent+" "+dob+" "+gender);
		
				
		
			
		
		    UserInfo info = new UserInfo();
		    info.setEmail(email);
		    
		    info.setFirst(first);
		    info.setLast(last);
		    info.setPassword(password);
		    info.setLocal(local);
		    info.setPermanent(permanent);
		    info.setPhone(phone);
		    info.setDOB(dob);
		    info.setGender(gender);
		    DateTest dt = new DateTest();
		    System.out.println("<<<<<<<<<<<<<<");
		    System.out.println(UtilityEmail.emailOrNot(email) +": "+ UtilityPhone.numberOrNot(phone) +" : "+ (phone.length() == 10)+":"+dt.isValidDate(dob));

		    
		       String insert = dao.init(info);
		       System.out.println(insert);
		       if(insert.equals("success"))   // check whether user is already registered or not
		       {
		    	 String savePath = appPath + File.separator + SAVE_DIR + File.separator + email;
		    	 
		    	 File fileSaveDir = new File(savePath);
		    	 if (!fileSaveDir.exists()) 
		         {
		             fileSaveDir.mkdir();
		         }
		    	 
		         String savePath1 = appPath + File.separator + SAVE_DIR + File.separator + email + File.separator + "ProfilePicture";
		    	 
		    	
		    	 
		    	 File fileSaveDir1 = new File(savePath1);
		    	 if (!fileSaveDir1.exists()) 
		         {
		             fileSaveDir1.mkdir();
		         }
		    	 
		         response.sendRedirect("RegisterSuccess.jsp");
		    	 
		    	
			   }
		       
		       
		       else
		       {
		    	   
		    	   
		    	   StringBuffer sb = new StringBuffer("");
					  
					
					  
					sb.append("Register.jsp");
					sb.append("?message=User with same email address or Mobile Number already available");
					
					  
					  
					String url = sb.toString();
					  
					String urlEncoded = response.encodeRedirectURL(url) ;
					  
					response.sendRedirect(urlEncoded);	
		    	   
			   
			
	     	   }
		   
		 
		
		
	}

}
