package social.network;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import social.dao.CommentDAO;
import social.dao.MessageDAO;
import social.dao.ImagesDAO;


@WebServlet("/DeleteMessComment")
public class DeleteMessComment extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    
    public DeleteMessComment() 
    {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		doPost(request, response);
	}

	
	/**
	 * This class method is used for deleting comments on Posts uploaded by user 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		/*  This class method is used for deleting comments on Posts uploaded by user */
		
		/*   Hyperlink Parameters are obtained           */
		
        StringBuffer sb = new StringBuffer("");
		
        String userEmail = request.getParameter("userEmail");
		
		String email = request.getParameter("email");
		
		String inputPage = request.getParameter("inputPage");
		
		int messId = Integer.parseInt(request.getParameter("messId"));
		
		int commentId =Integer.parseInt(request.getParameter("commentId"));
		
		ImagesDAO daoPosts = new ImagesDAO();
		MessageDAO daoComments = new MessageDAO();
		
		
		
		int commentDeleted = daoComments.deleteComment(commentId);   /*   these method deletes comment           */
		System.out.println("Comment Deleted :"+commentDeleted);
		
		sb.append(inputPage);
		sb.append("?userEmail=" + userEmail);
		sb.append("&messId="+messId);
		sb.append("&inputPage="+inputPage);
	
		String url = sb.toString();
		  
		String urlEncoded = response.encodeRedirectURL(url) ;
		  
		response.sendRedirect(urlEncoded);
	}

}
