package social.network;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import social.bean.LikeBean;
import social.bean.MessageLikeBean;
import social.dao.LikesDAO;
import social.dao.MessageDAO;
import social.dao.ImagesDAO;
import social.utility.GetTime;
import social.utility.IdDAO;
import social.utility.LikedOrNot;
import social.utility.PostLikes;


@WebServlet("/MessageLike")
public class MessageLike extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    
    public MessageLike() 
    {
        super();
       
    }

   
    /**
     * This class method is used for inserting Message Post like by user into table 'messagelikes'
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// This class method is used for inserting Message Post like by user into table 'messagelikes'
		
		 /*   'Like' Hyperlink Parameters are obtained           */
		String email = request.getParameter("email");
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Email in MessageLike.java: "+email);
		int messId = Integer.parseInt(request.getParameter("messId"));
		System.out.println("Message Id in MessageLike: "+ messId);
		
		String inputPage = request.getParameter("inputPage");
		
		MessageDAO daoMess = new MessageDAO();
		
		String userEmail = request.getParameter("userEmail");
		
		
		
		java.sql.Date dt1 = new java.sql.Date(System.currentTimeMillis());
	 	String date = dt1.toString();
		
		
		
		
		MessageLikeBean like = new MessageLikeBean();
		
		
		
		
		IdDAO daoId = new IdDAO();
		int likeId = daoId.getMessageLikeId();
		
		
		
		System.out.println("Like Id in MessageLike.java: "+likeId);
		
		
        String liked = daoMess.postLiked(email, messId);
		
		if(liked.equals("no"))
		{
		
		
		
		like.setId(likeId);
		like.setEmailFId(email);
		like.setMessageFId(messId);
		like.setTime(GetTime.getCurrentTimeStamp());
		like.setDate(dt1);
		
		int result1 = daoMess.insertMessLike(like);    // Insert like record into 'messagelikes' table for message uploaded by any user
		System.out.println("Result in Like.java: "+result1);
		}
		
		response.setContentType("text/javascript");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		

	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}

}
