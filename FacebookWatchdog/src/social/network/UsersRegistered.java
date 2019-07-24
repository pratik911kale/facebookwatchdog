package social.network;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import social.bean.UserInfo;
import social.dao.UserDAO;


@WebServlet("/UsersRegistered")
public class UsersRegistered extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	TransactionManager tm = null;   
    
    public UsersRegistered() 
    {
        super();
       
    }

	
    /**
     * This class method is used for getting users list with same name searched by you 
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// This class method is used for getting users list with same name searched by you 
		
		String find = request.getParameter("find");
		System.out.println("Users Registered: "+find);
		StringBuffer sb = new StringBuffer("");
		String inputPage = request.getParameter("viewid");
		String userEmail = request.getParameter("userEmail");
		  
		sb.append(inputPage);
		sb.append("?userEmail=" + userEmail);
		
		  
		  
		String url = sb.toString();
		  
		String urlEncoded = response.encodeRedirectURL(url) ;
		  
		
 		
		
		
		UserInfo info = new UserInfo();
		UserDAO dao = new UserDAO();
		ArrayList<UserInfo> list = new ArrayList<UserInfo>();
		ArrayList<String> userList = new ArrayList<String>();
		HttpSession session1 = request.getSession(false);
		
		if(find.equals("")) // check if search bar is empty
		{
			
			response.sendRedirect(urlEncoded);	
		}
		
		else if(find.contains(" ")) // if search text box contains name with space character
		{
		   String first = find.substring(0,find.indexOf(" "));
		   String last = find.substring(find.indexOf(" ")+1, find.length());
		   String result="Failure";		   
		   info.setFirst(first);
		   info.setLast(last);
		   list = dao.getUserByName(info); // get users with same first and last name
		   int count = 0;
		   
			  while(count<list.size())     // if count is less than size of ArrayList object 'list'
			  {
				  System.out.println(" RS: "+list.get(count).getEmail());
				  userList.add(list.get(count).getEmail());  // Add user information object into ArrayList 'userList'
				  session1.setAttribute("userList", userList);
				  result="Success";
				  count++;
				  
			  }
			  
			  if(result.equals("Success"))
			  {
				  response.sendRedirect("Users.jsp");
			  }
			  else
			  {
				  response.sendRedirect(urlEncoded);	
			  }
			  
			
			     
	       
		  
		}
		else
		{
			String result="Failure";	
	      	info.setFirst(find);
	    	list = dao.getUserByName(info);
		    int count = 0;
		  
		    while(count<list.size())
			  {
				  System.out.println(" RS: "+list.get(count).getEmail());
				  userList.add(list.get(count).getEmail());
				  session1.setAttribute("userList", userList);
				  result="Success";
				  count++;
				  
			  }
			  
			  if(result.equals("Success"))
			  {
				  response.sendRedirect("Users.jsp");
			  }
			  else
			  {
				  response.sendRedirect(urlEncoded);	
			  }
			    
	     
		}
		
		
		
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
	}

}
