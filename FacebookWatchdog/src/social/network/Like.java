package social.network;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import social.bean.LikeBean;
import social.dao.*;
import social.utility.GetTime;
import social.utility.IdDAO;
import social.utility.LikedOrNot;
import social.utility.PostLikes;


@WebServlet("/Like")
public class Like extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
   
    public Like() 
    {
        super();
        
    }

	
    /**
     * This class method is used for inserting Image like by user into table 'likes'
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// This class method is used for inserting Image like by user into table 'likes'
		
		  /*   'Like' Hyperlink Parameters are obtained           */
		
		String email = request.getParameter("email");
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Email in Like.java: "+email);
		String imageName = request.getParameter("imageName");
		System.out.println("Image Path: "+ imageName);
		String inputPage = request.getParameter("inputPage");
		
		
		
		String userEmail = request.getParameter("userEmail");
		
		String str="images2"+ File.separator + userEmail + File.separator + imageName;
		
		java.sql.Date dt1 = new java.sql.Date(System.currentTimeMillis());
	 	String date = dt1.toString();
		
		
		
		 PostLikes pl = new PostLikes();
         int numberOfLikes = pl.getPostLikes(imageName, userEmail);
		
		LikeBean like = new LikeBean();
		
		LikesDAO daoLikes = new LikesDAO();
		IdDAO daoId = new IdDAO();
		ImagesDAO daoPosts = new ImagesDAO();
		
		int postId = daoPosts.getImageId(imageName, userEmail);  // Image Id of user is obtained
		
		System.out.println("Post Id in Like.java: "+postId);
		
		LikedOrNot lon = new LikedOrNot();
        String liked = lon.getLikedStatus(email, str, userEmail);
		
		if(liked.equals("no"))       
		{
		
		System.out.println("Post Id in like.java: "+daoPosts.getImageId(imageName, userEmail));
		
		like.setId(daoId.getLikeId());
		like.setEmailFId(email);
		like.setImageFId(daoPosts.getImageId(imageName, userEmail));
		like.setTime(GetTime.getCurrentTimeStamp());
		like.setDate(dt1);
		
		int result1 = daoLikes.insertLike(like);     // Insert like record into 'likes' table for image uploaded by any user
		System.out.println("Result in Like.java: "+result1);
		}
		
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
