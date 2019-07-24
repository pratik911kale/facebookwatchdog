package social.network;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import social.dao.MessageDAO;


@WebServlet("/RemoveMessage")
public class RemoveMessage extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    
    public RemoveMessage() 
    {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		doPost(request, response);
	}

	
	/**
	 * This class method is used for deleting message from facebook
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// This class method is used for deleting message from facebook
		
		/*   'Delete' Hyperlink Parameters are obtained           */
		String email = request.getParameter("email");
		String userEmail = request.getParameter("userEmail");
		int messageId = Integer.parseInt(request.getParameter("messageId"));
		String inputPage = request.getParameter("inputPage");
		
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Email in RemoveMessage: "+email);
		
		MessageDAO daoMess = new MessageDAO();
		
		
		int deleted = daoMess.deleteMessage(messageId);   // Message record is deleted from 'messagepost' table
		
		 System.out.println("Result in RemoveMessage :"+ deleted);
		 
		 int deletedMessLikes = daoMess.deleteMessageLikes(messageId);  // Message Likes records are deleted from 'messagelikes' table
		 
		 System.out.println("Message Likes Deleted: "+deletedMessLikes);
		 
		 int deletedMessComments = daoMess.deleteComments(messageId);   // Message Comments records are deleted from 'messagecomments' table
		 
		 System.out.println("Message Comments Deleted: "+deletedMessComments);
		 
		 response.sendRedirect(inputPage);
	}

}
