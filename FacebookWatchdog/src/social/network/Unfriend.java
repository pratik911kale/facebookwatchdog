package social.network;
import social.bean.*;
import social.dao.FriendsDAO;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/Unfriend")
public class Unfriend extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    
    public Unfriend() 
    {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}

	
	/**
	 * This class method is used for breaking friendship with user
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		// This class method is used for breaking friendship with user
		
		 /*   Parameters from form are obtained           */
		String inputPage = request.getParameter("viewid");
		HttpSession session1 = request.getSession();
		
		String userEmail = request.getParameter("userEmail");
		
		String myEmail = (String)session1.getAttribute("Email");
		
		Friends frnd = new Friends();
		frnd.setEmail1(myEmail);
		frnd.setEmail2(userEmail);
		
		FriendsDAO daoFriends = new FriendsDAO();
		int result = daoFriends.deleteFriends(frnd);  // delete friendship record from 'friends' table
		
		
			 request.setAttribute("UserEmail",userEmail);
	    	 
		     RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/UserProfile.jsp");
		     dispatcher.forward(request, response);
		 
		
		
	}

}
