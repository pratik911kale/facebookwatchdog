package social.utility;
import social.bean.*;
import social.dao.*;
import social.network.*;

public class LikedOrNot 
{
        public String getLikedStatus(String email, String imagePath, String userEmail)
        {
        	String imageName = getImageName(imagePath);
        	System.out.println("Email in LikedOrNot.java: "+email);
        	
        	ImagesDAO daoPosts = new ImagesDAO();
        	int postId = daoPosts.getImageId(imageName, userEmail);
        	
        	LikesDAO daoLikes = new LikesDAO();
        	String result = daoLikes.imageLiked(email, postId);
        	
			return result;
        	
        }
        
        public String getImageName(String imagePath)
    	{
    		String imageName = imagePath.substring(imagePath.lastIndexOf('\\')+1);
    		System.out.println("Image Path: "+imageName);
    		
            
    		
    		
    		return imageName;
    	}
}
