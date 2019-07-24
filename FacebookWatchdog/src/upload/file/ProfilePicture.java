package upload.file;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import social.bean.ProfileInfo;
import social.bean.UserInfo;
import social.dao.ProfileDAO;
import social.dao.UserDAO;
import social.network.TransactionManager;


@WebServlet("/ProfilePicture")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
                 maxFileSize=1024*1024*10,      // 10MB
                 maxRequestSize=1024*1024*50)   // 50MB

public class ProfilePicture extends HttpServlet 
{
	private static final String SAVE_DIR = "images2";
    TransactionManager tm = null;   
    
    public ProfilePicture() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}

	/**
	 * This method is used for uploading Profile Picture of user
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session1 = request.getSession(false);
        String email = (String)session1.getAttribute("Email");
        String imageName = null;
        // gets absolute path of the web application
        String appPath = request.getServletContext().getRealPath("");
        // constructs path of the directory to save uploaded file
        String savePath = appPath + File.separator + SAVE_DIR + File.separator + email + File.separator + "ProfilePicture";
        
        String savePath1 = appPath + File.separator + SAVE_DIR + File.separator + email;
        
        // creates the save directory if it does not exists
        File fileSaveDir = new File(savePath1);
        if (!fileSaveDir.exists()) 
        {
            fileSaveDir.mkdir();
        }
        
        String firstName = null;
        String lastName = null;
        UserDAO daoUser = new UserDAO();
        
        UserInfo user = new UserInfo();
        user.setEmail(email);
        
        UserInfo userInfo = daoUser.getUserRecord(user);
        
      
				firstName = userInfo.getFirst();
				lastName = userInfo.getLast();
			
       String extension = null;
        
        ProfileDAO pic = new ProfileDAO();
        ProfileInfo profile = pic.getProfileImage(email);
        
        	
        
        
        System.out.println("Profile Picture: "+savePath);
        
        // creates the save directory if it does not exists
        File fileSaveDir1 = new File(savePath);
        if (!fileSaveDir1.exists()) 
        {
            fileSaveDir1.mkdir();
        }
        
       
       
         for (Part part : request.getParts()) 
        {
            String fileName = extractFileName(part);
            
            imageName = fileName;
            
            extension = imageName.substring(imageName.indexOf('.')+1);
            
            if(extension.equals("jpg")  || extension.equals("jpeg") || extension.equals("png") || extension.equals("gif") || extension.equals("bmp"))
       	    {
            	
            	if(profile.getfirst()!=null)
         	   {
         		   String imageOld = profile.getpath();
         		   System.out.println("Image Name from Profile Database: "+imageOld);  
         		  
         		   File file = new File(savePath+File.separator+imageOld);
         		   if(file.delete())
         		   {
         			   System.out.println("File deleted....");
         		       pic.deletePic(email);
         		   }
         		   
         		   else
         			   System.out.println("File not deleted");
         		   
         		   
               }
            	
            part.write(savePath+File.separator+imageName);
            System.out.println("Profile Picture: "+fileName);
            
       	    } 
        }
         
         if(extension.equals("jpg")  || extension.equals("jpeg") || extension.equals("png") || extension.equals("gif") || extension.equals("bmp"))
    	 {
            ProfileDAO pic1 = new ProfileDAO();
            int result = pic1.insertPic(email, firstName, lastName, imageName);
            System.out.println("Result of Profile: "+result);
             
            response.sendRedirect("Profile.jsp");
    	 
         
        
    	 }
         else
         {
        	 StringBuffer sb = new StringBuffer("");
   		  
       		
   		  
       		sb.append("Profile.jsp");
       		sb.append("?message=Image file not valid or file is not image");
       		
       		  
       		  
       		String url = sb.toString();
       		  
       		String urlEncoded = response.encodeRedirectURL(url);
       		  
       		response.sendRedirect(urlEncoded);	
         }
        
	}
	
	private String extractFileName(Part part)
    {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename"))
            {
                return s.substring(s.indexOf("=") + 2, s.length()-1);
            }
        }
        return "";
    }

}
