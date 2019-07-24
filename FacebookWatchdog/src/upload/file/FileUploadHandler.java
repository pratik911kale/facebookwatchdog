package upload.file;

import java.io.File;
import java.io.IOException;


import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.classify.data.PostClass;



import social.bean.MessageBean;
import social.bean.ImageBean;
import social.bean.Warning;
import social.dao.AccountBanDAO;
import social.dao.AdultDetectionDAO;
import social.dao.MessageDAO;
import social.dao.ImagesDAO;
import social.dao.ProfileDAO;
import social.dao.UserDAO;
import social.dao.WarningDAO;
import social.utility.CategoriesAPI;
import social.utility.CheckSentiment;
import social.utility.FolderOperations;
import social.utility.GetTime;
import social.utility.IdDAO;
 
//@WebServlet("/UploadServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
                 maxFileSize=1024*1024*10,      // 10MB
                 maxRequestSize=1024*1024*50)   // 50MB
public class FileUploadHandler extends HttpServlet
{
 
   
    private static final String SAVE_DIR = "images2";
    public String fileName1; 
   
    
    /**
     * This method is used for uploading Images of user
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException
    {
    	
    	File file = null;
    	String imageName = null;
    	Hashtable<Object, Object> hash = new Hashtable<Object, Object>();
    	
    	boolean isNude = false;
    	
    	HttpSession session1 = request.getSession(false);
        String email = (String)session1.getAttribute("Email");
        ImageBean post = new ImageBean();
        ImagesDAO daoPost = new ImagesDAO();
        IdDAO idDAO = new IdDAO();
        String extension = null;
    	
        ImagesDAO daoPosts = new ImagesDAO();
        
        ProfileDAO daoProfile = new ProfileDAO();
        
    	String phone = (String)session1.getAttribute("Phone");
        
    	 // gets absolute path of the web application
        String appPath = request.getServletContext().getRealPath("");
        // constructs path of the directory to save uploaded file
        String savePath = appPath + File.separator + SAVE_DIR + File.separator + email;
         
        // creates the save directory if it does not exists
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) 
        {
            fileSaveDir.mkdir();
        }
        
    	
        
    	 List<FileItem> items = null;
		try 
		{
			items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		} 
		catch (FileUploadException e) 
		{
			
			e.printStackTrace();
		}
		
         for (FileItem item : items) 
         {
             if (item.isFormField()) 
             {
                
                 
                 hash.put(item.getFieldName(), item.getString());
                 
             }
             else
             {
            	 imageName = item.getName();
            	 
            	 extension = imageName.substring(imageName.indexOf('.')+1);
            	 
            	 System.out.println("Image uploaded: "+imageName.substring(imageName.indexOf('.')+1));
            	 
            	 if(extension.equals("jpg")  || extension.equals("jpeg") || extension.equals("png") || extension.equals("gif") || extension.equals("bmp"))
            	 {
            	   if( imageName.lastIndexOf("\\") >= 0 )
     			  {
     	               file = new File( savePath + "\\" + imageName.substring( imageName.lastIndexOf("\\"))) ;
     	          }
     			 else
     			 {
     	               file = new File( savePath + "\\" + imageName.substring(imageName.lastIndexOf("\\")+1)) ;
     	         }
     	           
            	 try 
     	         {
            		 String imageNamePresent = daoPost.selectImage(email, imageName);
            		 
            		 if(imageNamePresent.equals("no"))
                     {
            		      item.write(file);
                     }
				 } 
     	         catch (Exception e) 
				 {
						
					e.printStackTrace();
				 }
            	 }
             }
         }
    	
         String imageNamePresent = daoPost.selectImage(email, imageName);
         
         String message = (String)hash.get("message");
  	   String inputPage = (String)hash.get("inputPage");
  	   String userEmail = (String)hash.get("userEmail");
         
  	   if(extension.equals("jpg")  || extension.equals("jpeg") || extension.equals("png") || extension.equals("gif") || extension.equals("bmp"))
  	   {
  		   
  	   
         if(imageNamePresent.equals("no"))
         {
         
    	  
        
        java.sql.Date dt1 = new java.sql.Date(System.currentTimeMillis());
  	   String date = dt1.toString();
        
        
        int postId = idDAO.getPostId();
    
				/*
				 * try {
				 * 
				 * 
				 * SkinToneAveragedNudeDetector stnd2 = new SkinToneAveragedNudeDetector();
				 * stnd2.setIsPornDelta(35); // set porn threshold value for skin colors
				 * 
				 * isNude = stnd2.isNude(file); // this method checks if image is adult or not
				 * 
				 * System.out.println("Image is nude: " + isNude);
				 * 
				 * } catch (IOException ex) {
				 * Logger.getLogger(FileUploadHandler.class.getName()).log(Level.SEVERE, null,
				 * ex); }
				 */
        
        if(isNude == true)
        	file.delete();
        
        if(isNude == false)
        {
        	
        
        	 if(!message.equals(""))
             {
             	
             	PostClass messPost = new PostClass();
             	
             	String messageNew = message.replaceAll("^ +| +$| (?= )", " ");
             	 
     	    	ArrayList<String> arrCategories = messPost.classifyPost(messageNew, appPath);
         	 	
     	    	
     	    	
                 
     	 		 
     	    	ArrayList<String> categoriesAPI = CategoriesAPI.getCategory(messageNew);
             	
                 CheckSentiment chkSent = new CheckSentiment();
     		    
     		    String score = chkSent.getScore(messageNew.toLowerCase(), appPath);
     		    
     		    System.out.println("Score for User Message: "+score);
     		    
     		    int index = score.indexOf('*');
     		    
     		    String firstScore = score.substring(0, index);
     		    
     		    String secondScore = score.substring(index+1, score.length());
     		    
     		    String status = firstScore;
     		    
     		    if(secondScore.equals("worst") || secondScore.equals("riots")  || secondScore.equals("crime"))
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
             
             	
             	
                MessageBean mess = new MessageBean();
     		
     	       IdDAO daoId = new IdDAO();
     		
     	       MessageDAO daoMess = new MessageDAO();
     		
     		   int messId = daoId.getMessageId();
     		   
     		   
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
     			
     		 	else
     			{
     				
     		   
     		   int count = 0;
     		   
     		    mess.setId(messId);
     			
     			mess.setEmailFId(email);
     			
     			mess.setRecFId(userEmail);
     			
     			mess.setDate(dt1);
     			
     			mess.setTime(GetTime.getCurrentTimeStamp());
     			
     			mess.setMessage(messageNew);
     			
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
     			
     			mess.setImageFId(postId);
     			
     			mess.setStatus(status);
     			
     			
     			int resultInsert = daoMess.insertMessage(mess);
     			
     			System.out.println("Result of Insert Message in File Upload Handler: "+resultInsert);
     			
             
     			
             
             
             post.setId(postId);
             post.setEmailFId(email);
             post.setImageName(imageName);
             post.setTime(GetTime.getCurrentTimeStamp());
             post.setDate(dt1);
             post.setMessageFId(messId);
             
             int result = daoPost.insertImage(post);
             System.out.println("Result in FileUploadHandler: "+result);
             
             
             StringBuffer sb = new StringBuffer("");
     		  
     		
     		  
     		sb.append(inputPage);
     		sb.append("?message=Image with post has been uploaded successfully");
     		
     		  
     		  
     		String url = sb.toString();
     		  
     		String urlEncoded = response.encodeRedirectURL(url) ;
     		  
     		response.sendRedirect(urlEncoded);	
             
             }
             
            
             
              }
              
              
             else
             {
             	
                 
             	int i = 0;
                 post.setId(idDAO.getPostId());
                 post.setEmailFId(email);
                 post.setImageName(imageName);
                 post.setTime(GetTime.getCurrentTimeStamp());
                 post.setDate(dt1);
                 post.setMessageFId(i);
                 
                 int result = daoPost.insertImage(post);
                 System.out.println("Result in FileUploadHandler: "+result);
                 
                 
                 StringBuffer sb = new StringBuffer("");
       		  
         		
       		  
         		sb.append("Photos.jsp");
         		sb.append("?message=Image has been uploaded successfully");
         		
         		  
         		  
         		String url = sb.toString();
         		  
         		String urlEncoded = response.encodeRedirectURL(url) ;
         		  
         		response.sendRedirect(urlEncoded);	
             }
                
        
        }
        else
        {
        	
        	
        	AdultDetectionDAO daoAdultDetect = new AdultDetectionDAO();
        	
        	String available = daoAdultDetect.checkAdultRecord(email);
        	
        	int newCount = 0;
        	
        	if(available.equals("failure"))
        	{
        	
        		int adultCount = daoAdultDetect.getAdultCount(email);  // get count of adult images for user from database

        	    newCount = adultCount + 1;

        		// insert count of adult images for user into database
        		int inserted = daoAdultDetect.insertAdultCrime(email, newCount);  

        		System.out.println("Adult count inserted: "+inserted);
        	
        	}
        	else
        	{
        		int adultCount = daoAdultDetect.getAdultCount(email);  // get count of adult images for user from database

        	    newCount = adultCount + 1;
        	    
        	    int updated = daoAdultDetect.updateAdultRecord(email, newCount);
        	    
        	    System.out.println("Adult count updated: "+updated);
        	}
        	
        	if(newCount > 4)    // if count of adult image uploads is greater than 4, ban account of user
        	{
        		UserDAO daoUser = new UserDAO();
        		
        		daoPosts = new ImagesDAO();
        		
        		MessageDAO daoMess = new MessageDAO();
        		
        		daoProfile = new ProfileDAO();
        		
        	 	WarningDAO daoWarn = new WarningDAO();
    	 		
    	
    	 		
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
        	else
        	{
        		StringBuffer sb = new StringBuffer("");
        		sb.append("Photos.jsp");
        		sb.append("?message=Image uploaded by you is adult, so improve your behaviour");



        		String url = sb.toString();

        		String urlEncoded = response.encodeRedirectURL(url) ;

        		response.sendRedirect(urlEncoded);	
     		
        	}
        	
        }
        
         }
         
         else
         {
        	 StringBuffer sb = new StringBuffer("");
     		  
     		
     		  
     		sb.append("Photos.jsp");
     		sb.append("?message=Image with same name already available");
     		
     		  
     		  
     		String url = sb.toString();
     		  
     		String urlEncoded = response.encodeRedirectURL(url) ;
     		  
     		response.sendRedirect(urlEncoded);	
        	 
         }
         
  	   }
  	   else
  	   {
  		   
  		 StringBuffer sb = new StringBuffer("");
		  
  		
		  
  		sb.append("Photos.jsp");
  		sb.append("?message=Image file not valid or file is not image");
  		
  		  
  		  
  		String url = sb.toString();
  		  
  		String urlEncoded = response.encodeRedirectURL(url);
  		  
  		response.sendRedirect(urlEncoded);	
  	   }
         
       
    }
 
    /**
     * Extracts file name from HTTP header content-disposition
     */
    private String extractFileName(Part part)
    {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename"))
            {
            	fileName1 = s.substring(s.indexOf("=") + 2, s.length()-1);
            	
            	System.out.println(">>>>>>>>>>>>>>>FileName 1: "+fileName1);
                return s.substring(s.indexOf("=") + 2, s.length()-1);
            }
        }
        return "";
    }
}