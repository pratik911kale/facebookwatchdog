package social.network;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.classify.data.PostClass;









import social.bean.MessageBean;
import social.bean.Warning;
import social.dao.AccountBanDAO;
import social.dao.MessageDAO;
import social.dao.ImagesDAO;
import social.dao.ProfileDAO;
import social.dao.UserDAO;
import social.dao.WarningDAO;
import social.utility.Category;
import social.utility.CheckSentiment;
import social.utility.FolderOperations;
import social.utility.GetTime;
import social.utility.IdDAO;
import social.utility.CategoriesAPI;


@WebServlet("/InsertMessage")
public class InsertMessage extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	TransactionManager tm = null;   
   
    public InsertMessage() 
    {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		doPost(request,response);
	}

	
	/**
	 * This class method is used for inserting post messages uploaded by user
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		/*  This class method is used for inserting post messages uploaded by user */
		
		ImagesDAO daoPosts = new ImagesDAO();
		HttpSession session1 = request.getSession();
		
		  /*   Parameters from form are obtained           */
		String message = request.getParameter("message");
		
		String email = request.getParameter("email");
		
		String userEmail = request.getParameter("userEmail");
		
		String inputPage = request.getParameter("inputPage");
		
		String phone = (String)session1.getAttribute("Phone");
		
		MessageBean mess = new MessageBean();
		
		IdDAO daoId = new IdDAO();
		
		MessageDAO daoMess = new MessageDAO();
		
		int messId = daoId.getMessageId();
		
		java.sql.Date dt1 = new java.sql.Date(System.currentTimeMillis());
	 	String date = dt1.toString();
	 	
	 	
	 	String appPath = request.getServletContext().getRealPath("");
		
	 	 CheckSentiment chkSent = new CheckSentiment();    
	 	 
	 	 String messageNew = message.replaceAll("^ +| +$| (?= )", " ");
		    
		    String score = chkSent.getScore(messageNew.toLowerCase(), appPath);   // Message Sentiment is checked by scanning notepad files and online data
		    
		    System.out.println("Score for User Message: "+score);
		    
		    int index = score.indexOf('*');
		    
		    String firstScore = score.substring(0, index);
		    
		    String secondScore = score.substring(index+1, score.length());
		    
		    String status = firstScore;
		    
		    
		    
		
	    	
		    
		    // Sentiment of message is checked
		    if(secondScore.equals("worst") || secondScore.equals("riots") || secondScore.equals("crime"))
		    {
		    	status = secondScore;
		    }
		    else if(firstScore.equals("wrong"))
	    	{
	    	
		    	status = "negative";
	    		
	    	}
		   
		    if(message.toLowerCase().contains("kill") && !message.toLowerCase().contains("don't") && !message.toLowerCase().contains("do not") && !message.toLowerCase().contains("not"))
		    	status = "crime";
		    System.out.println("Status: "+status);
		    
		    
	 	
	 	ProfileDAO daoProfile = new ProfileDAO();
	 	PostClass messPost = new PostClass();
	 	
	 	 ArrayList<String> arrCategories = messPost.classifyPost(message.toLowerCase(), appPath);
	 	
	 	
	 	
	 	 // Message is classified into categories such as Sports,History etc. by calling classify() method
	 	 
	 	
	 	 
	 	
	 		 
	 	 
	 		 
	 		 
	 		ArrayList<String> categoriesAPI = CategoriesAPI.getCategory(messageNew);
	 		 
	 		
	 	 
	 	WarningDAO daoWarn = new WarningDAO();
	 	Warning warn = new Warning();
	 	
	 	int countCrime = 0;
	 	int countRiots = 0;
	 	int countWorst = 0;
	 	int countBad = 0;
	 	
	 	int countCrimeCategories = 0;
	 	String banAcc = "no";
	 	
	 	if(status.equals("riots"))  // check whether message status is riots
	 	{
	 		countRiots = daoWarn.getCountOfRiotsPosts(email);
	 		int cnt = countRiots + 1;
	 		
	 		// Set fields of Warning object 
	 		warn.setCategory("riots");
	 		warn.setDate(dt1);
	 		warn.setEmailFId(email);
	 		warn.setId(daoWarn.getWarningId());
	 		warn.setMessage("You have posted "+cnt+" Riot Messages");
	 		warn.setTime(GetTime.getCurrentTimeStamp());
	 		
	 		int insertedWarn = daoWarn.insertWarning(warn);  // Insert Warning message into 'warning' table
	 		countRiots = daoWarn.getCountOfRiotsPosts(email);
	 		 
	 		
	 		if(cnt > 3)
	 			banAcc = "yes";
	 	}
	 	else if(status.equals("worst"))
	 	{
	 		countWorst = daoWarn.getCountOfWorstPosts(email);
	 		int cnt = countWorst + 1;
	 		
	 	// Set fields of Warning object 
	 		warn.setCategory("worst");
	 		warn.setDate(dt1);
	 		warn.setEmailFId(email);
	 		warn.setId(daoWarn.getWarningId());
	 		warn.setMessage("You have posted "+cnt+" Worst Messages");
	 		warn.setTime(GetTime.getCurrentTimeStamp());
	 		
	 		int insertedWarn = daoWarn.insertWarning(warn);   // Insert Warning message into 'warning' table
	 		countWorst = daoWarn.getCountOfWorstPosts(email);
	 		if(cnt > 4)
	 			banAcc = "yes";
	 	}
	 	else if(status.equals("crime"))
	 	{
	 		countCrime = daoWarn.getCountOfCrimePosts(email);
	 		int cnt = countCrime + 1;
	 		
	 	// Set fields of Warning object 
	 		warn.setCategory("crime");
	 		warn.setDate(dt1);
	 		warn.setEmailFId(email);
	 		warn.setId(daoWarn.getWarningId());
	 		warn.setMessage("You have posted "+cnt+" Crime status Messages");
	 		warn.setTime(GetTime.getCurrentTimeStamp());
	 		
	 		int insertedWarn = daoWarn.insertWarning(warn);
	 		countCrime = daoWarn.getCountOfCrimePosts(email);
	 		if(cnt > 3)
	 			banAcc = "yes";
	 	}
	 	else if(status.equals("negative"))
	 	{
	 		countBad = daoWarn.getCountOfBadMessages(email);
	 		int cnt = countBad + 1;
	 		
	 	// Set fields of Warning object 
	 		warn.setCategory("bad");
	 		warn.setDate(dt1);
	 		warn.setEmailFId(email);
	 		warn.setId(daoWarn.getWarningId());
	 		warn.setMessage("You have posted "+cnt+" Bad status Messages");
	 		warn.setTime(GetTime.getCurrentTimeStamp());
	 		
	 		int insertedWarn = daoWarn.insertWarning(warn);    // Insert Warning message into 'warning' table
	 		countBad = daoWarn.getCountOfBadMessages(email);
	 		
	 		if(cnt > 7)
	 			banAcc = "yes";
	 	}
	 	

	 	if(banAcc.equals("yes"))  // check whether to ban user account due to malicious message limits crossed by user
	 	{
	 		UserDAO daoUser = new UserDAO();
	 		
	 	
	 		
	 		AccountBanDAO ban = new AccountBanDAO();
	 		
	 		int resultBanned = ban.banAccount(email,phone);
	 		System.out.println("Account Banned: "+resultBanned);
	 		
	
	 		int postsDeleted = daoPosts.deleteImages(email);
	 		System.out.println("Posts deleted: "+postsDeleted);
	 		
	 		int messagesDeleted = daoMess.deleteMessages(email);
	 		System.out.println("Messages deleted: "+messagesDeleted);
	 		
	 		int profileDeleted = daoProfile.deletePic(email);
	 		System.out.println("Profile deleted: "+profileDeleted);
	 		
	 		
	 		response.sendRedirect(request.getContextPath() + "/LogoutServlet");
	 		
	 		
	 	}
		
	 	else if(!message.equals(""))
		{
			
			
	 		int count = 0;
	 		
	 	// Set message object to insert into 'messagepost' table
	 		
	 		mess.setId(daoId.getMessageId());
            mess.setEmailFId(email);
			
			mess.setRecFId(userEmail);
			
			mess.setDate(dt1);
			
			mess.setTime(GetTime.getCurrentTimeStamp());
			
			mess.setMessage(messageNew);
			
			mess.setImageFId(0);
			mess.setStatus(status);
			
			StringBuffer categories = new StringBuffer("");
			
			
	 		
	 		while(count < arrCategories.size())
	 		{
	 		
	 		    if(count != 0)
	 		    	categories.append(',');
	 		    	
	 			categories.append(arrCategories.get(count));
			
			
	 			count++;
			
	 		}
	 		
	 		count = 0;
	 		
	 		while(count < categoriesAPI.size())
	 		{
	 			
	 			if(count != 0)
	 		    	categories.append(',');
	 			
	 			categories.append(categoriesAPI.get(count));
	 			
	 			count++;
	 			
	 		}
			
	 		 mess.setCategory(categories.toString());
	 		
			int resultInsert = daoMess.insertMessage(mess);  // insert  message into 'messagepost' table
			
			System.out.println("Result of Insert Message: "+resultInsert);
			
			count++;
			
	 		
			
			StringBuffer sb = new StringBuffer("");
			  
			
			  
			sb.append(inputPage);
			sb.append("?userEmail=" + userEmail);
			
			  
			  
			String url = sb.toString();
			  
			String urlEncoded = response.encodeRedirectURL(url);
			  
			response.sendRedirect(urlEncoded);	
			
		
			
		}
		
		else
		{
			
			StringBuffer sb = new StringBuffer("");
			  
			
			  
			sb.append(inputPage);
			sb.append("?userEmail=" + userEmail);
			
			  
			  
			String url = sb.toString();
			  
			String urlEncoded = response.encodeRedirectURL(url) ;
			  
			response.sendRedirect(urlEncoded);	
			
		}
		
	}

}
