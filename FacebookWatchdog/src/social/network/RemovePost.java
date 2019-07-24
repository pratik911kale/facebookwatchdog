package social.network;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import social.bean.ImageBean;
import social.dao.ImagesDAO;


@WebServlet("/RemovePost")
public class RemovePost extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
   
    public RemovePost() 
    {
        super();
       
    }

 
    /**
     * This class method is used for deleting Image from facebook
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// This class method is used for deleting Image from facebook
		
		/*   'Delete' Hyperlink Parameters are obtained           */
		String email = request.getParameter("email");
		String userEmail = request.getParameter("userEmail");
		int messageFId = Integer.parseInt(request.getParameter("messageFId"));
		
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Email in RemoveImage: "+email);
		String imageName = request.getParameter("image");
		System.out.println("Image Name in RemovePost.java: "+ imageName);
		String appPath = request.getServletContext().getRealPath("");
        
		 // constructs Save Path where image is stored
        String savePath = appPath + File.separator + "images2" + File.separator + userEmail; 
        
		
		String inputPage = request.getParameter("inputPage");
		
		 File file = new File(savePath+File.separator+imageName);  // File class object is created
		  
		   if(file.delete()) // delete image file and if deleted then return 'true' value
		   {
			    System.out.println("File deleted....");
			    ImageBean post = new ImageBean();
				post.setEmailFId(userEmail);
				post.setImageName(imageName);
				post.setMessageFId(messageFId);
				
		        ImagesDAO daoPost = new ImagesDAO();
		        int result = daoPost.deleteImage(post);    // delete image record from 'images' table
		        System.out.println("Result in RemovePost :"+ result);
		   }
		   
		   else
			   System.out.println("File not deleted");
		
		
        
        response.sendRedirect(inputPage);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}
     
	// get image name from image path
	public String getImageName(String imagePath)
	{
		String imageName = imagePath.substring(imagePath.lastIndexOf('\\')+1);
		System.out.println("Image Path: "+imageName);
		
        
		
		
		return imageName;
	}
}
