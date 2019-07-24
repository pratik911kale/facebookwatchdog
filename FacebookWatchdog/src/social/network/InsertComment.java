package social.network;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
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



import com.classify.data.Sentiment;

import social.bean.CommentBean;
import social.bean.ProfileInfo;
import social.bean.UserInfo;
import social.bean.Warning;
import social.dao.AccountBanDAO;
import social.dao.CommentDAO;
import social.dao.ImagesDAO;
import social.dao.MessageDAO;
import social.dao.ProfileDAO;
import social.dao.UserDAO;
import social.dao.WarningDAO;
import social.utility.CheckSentiment;
import social.utility.FolderOperations;
import social.utility.GetTime;
import social.utility.IdDAO;


@WebServlet("/InsertComment")
public class InsertComment extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	TransactionManager tm = null;
       
    
    public InsertComment() 
    {
        super();
        
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
          doPost(request, response);
	}

	
	/**
	 * This class method is used for inserting comments on images uploaded by user
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		/*  This class method is used for inserting comments on images uploaded by user */
	     StringBuffer sb = new StringBuffer("");
		 
	     HttpSession session1 = request.getSession(false);
	     
	     String phone = (String)session1.getAttribute("Phone");
	     
	     String finalScore = null;
		
	     /*   Parameters from form are obtained           */
	     
		String comment = request.getParameter("commentBox");
		System.out.println("comment in InsertComment: "+comment);
		
		String commentNew = comment.replaceAll("^ +| +$| (?= )", " ");
		
		String imageName = request.getParameter("image");
		System.out.println("comment in InsertComment: "+imageName);
		
		String userEmail = request.getParameter("userEmail");
		System.out.println("comment in InsertComment: "+userEmail);
		
		String email = request.getParameter("email");
		
		String inputPage = request.getParameter("inputPage");
		
		String input = request.getParameter("input");
		
		String oldComment = request.getParameter("oldComment");
		
		String appPath = request.getServletContext().getRealPath("");
       // constructs path of the directory to save uploaded file
       String savePath = "images2" + File.separator + userEmail;
       
       String imagePath = savePath + File.separator + imageName;
       
    // Profile Image of User is obtained
       String profileImage =null;
       ProfileDAO daoProfile = new ProfileDAO();
	    ProfileInfo profile = daoProfile.getProfileImage(email);
	    int count = 0;
	    	if(profile.getfirst()!=null)
			   profileImage = "images2"+ File.separator + email + File.separator + "ProfilePicture" + File.separator + profile.getpath();
			else
				profileImage = "images2"+ File.separator + "facebook-default.jpg";
		
	    
	    
	    System.out.println("Profile Image in InserComment.java: "+profileImage);
	    
	    
       
	    CheckSentiment chkSent = new CheckSentiment();      
	    
	    String score = chkSent.getScore(comment.toLowerCase(), appPath);       // Sentiment of comment is obtained from getScore(comment.toLowerCase()) method
	    
	    System.out.println("Score for User Comment: "+score);        
	    
	    int index = score.indexOf('*');
	    
	    String firstScore = score.substring(0, index);
	    
	    String secondScore = score.substring(index+1, score.length());
	    
	    String status = firstScore;
	    
	    if(secondScore.equals("worst") || secondScore.equals("riots") || secondScore.equals("crime"))
	    {
	    	status = secondScore;
	    }
	    else if(firstScore.equals("wrong"))
    	{
    	
	    	status = "negative";
    		
    	}
	   
	    
	    if(comment.toLowerCase().contains("kill") && !comment.toLowerCase().contains("don't") && !comment.toLowerCase().contains("do not") && !comment.toLowerCase().contains("not"))
	    	status = "crime";
	    
	    System.out.println("Status: "+status);
	    
	   
	    
       UserDAO daoUser = new UserDAO();
       UserInfo user = new UserInfo();
       user.setEmail(email);
       
       String firstName = null;
       String lastName = null;
       
       UserInfo userInfo = daoUser.getUserRecord(user);
       
      
			
				firstName = userInfo.getFirst();
				lastName = userInfo.getLast();
			
		 
       
		CommentBean commentInfo = new CommentBean();
		
		java.sql.Date dt1 = new java.sql.Date(System.currentTimeMillis());
	 	String date = dt1.toString();
		
		
		IdDAO daoId = new IdDAO();
		ImagesDAO daoPosts = new ImagesDAO();
		CommentDAO daoComments = new CommentDAO();
		
		
		
		
		if(!comment.equals("") && input==null)  // Check whether comment is empty or not and comment is for editing or not by checking input parameter value
		{
		
		     int id = daoId.getCommentId();
		
		     int postId = daoPosts.getImageId(imageName, userEmail);
		
		     
		     // Set Comment information in CommentBean Object
		     commentInfo.setId(id);
		     commentInfo.setImageFId(postId);
		     commentInfo.setEmailFId(email);
		     commentInfo.setComment(commentNew);
		     commentInfo.setTime(GetTime.getCurrentTimeStamp());
		     commentInfo.setDate(dt1);
		     commentInfo.setStatus(status);
		
		int resultInsert = daoComments.insertComment(commentInfo);    // Insert Comment in 'comments' table
		
		System.out.println("Result in InsertComment.java: "+resultInsert);
		
		
		response.setContentType("text/javascript");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();                    // get writer object to write on web page
		
		// display Comment and user Profile image and name in comment box down to image
		out.print("<a href="+"Profile.jsp?email="+email+"><img src="+profileImage+" height="+50+" width="+50+">"+"     "+firstName+" "+lastName+"</a>  "+comment);
		
		out.close();
		
		 
		
		}
		else if(input!=null && !comment.equals(""))  // if comment is for editing then execute these block
		{
			int commentId = Integer.parseInt( request.getParameter("commentId"));
			
			int resultUpdate = daoComments.updateComment(commentId, commentNew, GetTime.getCurrentTimeStamp(), dt1, status);
			
			System.out.println("Result of Update in InsertComment.java: "+resultUpdate);
			
			sb.append(inputPage);
			sb.append("?userEmail=" + userEmail);
			sb.append("&image="+imageName);
			sb.append("&inputPage="+inputPage);
			String url = sb.toString();
			  
			String urlEncoded = response.encodeRedirectURL(url) ;
			  
			response.sendRedirect(urlEncoded);
			
		}
		
		else
		{
			// if comment is empty then execute these block
		
		
		response.setContentType("text/javascript");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		
		out.close();
		}
	
	}

}
