package social.network;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import social.dao.LikesDAO;
import social.dao.ImagesDAO;
import social.utility.PostLikes;


@WebServlet("/Unlike")
public class Unlike extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
  
    public Unlike() 
    {
        super();
        
    }

    

    /**
     * This class method is used for Unliking Image
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		 // This class method is used for Unliking Image
		
		/*   'Unlike' Hyperlink Parameters are obtained           */
		String email = request.getParameter("email");
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Email in Unlike.java: "+email);
		String imageName = request.getParameter("imageName");
		System.out.println("Image Path: "+ imageName);
		
		
		String userEmail = request.getParameter("userEmail");
		String inputPage = request.getParameter("inputPage");
		
		 PostLikes pl = new PostLikes();
         int numberOfLikes = pl.getPostLikes(imageName, userEmail);
		
		ImagesDAO daoPosts = new ImagesDAO();
		int postId = daoPosts.getImageId(imageName, userEmail);
		
		LikesDAO daoLikes = new LikesDAO();
		int result = daoLikes.deleteLike(email, postId);   // Delete image like record from 'likes' table
		System.out.println("Result in Unlike.java: "+result);
		
		response.setContentType("text/javascript");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		
	     
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}
     
	public String getImageName(String imagePath)
	{
		String imageName = imagePath.substring(imagePath.lastIndexOf('\\')+1);
		System.out.println("Image Path: "+imageName);
		
        
		
		
		return imageName;
	}
}
