package social.network;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import social.dao.CommentDAO;
import social.dao.ImagesDAO;


@WebServlet("/Delete")
public class Delete extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
  
    public Delete() 
    {
        super();
       
    }

	
    /**
     * This class method is used for deleting comments on images uploaded by user
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		/*  This class method is used for deleting comments on images uploaded by user */
		
		/*   Hyperlink Parameters are obtained           */
		
		StringBuffer sb = new StringBuffer("");
		
        String userEmail = request.getParameter("userEmail");             
		
		String email = request.getParameter("email");
		
		String inputPage = request.getParameter("inputPage");
		
		String imageName = request.getParameter("image");
		
		
		
		
		int commentId =Integer.parseInt(request.getParameter("commentId"));
		ImagesDAO daoPosts = new ImagesDAO();
		CommentDAO daoComments = new CommentDAO();
		
		
		/*   Post Id for Image by user is obtained           */
		int postId = daoPosts.getImageId(imageName, userEmail);
		
		int commentDeleted = daoComments.deleteComment(commentId);        /*   these method deletes comment           */
		System.out.println("Comment Deleted :"+commentDeleted);
		
		sb.append(inputPage);
		sb.append("?userEmail=" + userEmail);
		sb.append("&image="+imageName);
		sb.append("&inputPage="+inputPage);
		
		String url = sb.toString();
		  
		String urlEncoded = response.encodeRedirectURL(url) ;
		  
		response.sendRedirect(urlEncoded);
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}

}
