package social.network;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import social.dao.LikesDAO;
import social.dao.MessageDAO;
import social.dao.ImagesDAO;
import social.utility.PostLikes;


@WebServlet("/MessageUnlike")
public class MessageUnlike extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    
    public MessageUnlike() 
    {
        super();
       
    }

	
    /**
     * This class method is used for Unliking message post
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// This class method is used for Unliking message post
		
		/*   'Unlike' Hyperlink Parameters are obtained           */
		String email = request.getParameter("email");
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Email in MessageUnlike.java: "+email);
		int messId = Integer.parseInt(request.getParameter("messId"));
		System.out.println("Mess Id: "+ messId);
		
		
		String userEmail = request.getParameter("userEmail");
		String inputPage = request.getParameter("inputPage");
		
		
		
		
		
		MessageDAO daoMess = new MessageDAO();
		int result = daoMess.deleteMessLike(email, messId);   // Delete message like record from 'messagelikes' table
		System.out.println("Result in MessageUnlike.java: "+result);
		
		response.setContentType("text/javascript");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}

}
