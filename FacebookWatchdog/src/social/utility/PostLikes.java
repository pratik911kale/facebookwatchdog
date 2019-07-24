package social.utility;
import social.dao.*;
import social.network.*;
import social.bean.*;

public class PostLikes 
{
    
	public int getPostLikes(String imageName, String email)
	{
		System.out.println("Email in PostLikes.java: "+email);
		
		
		LikesDAO daoLikes = new LikesDAO();
		
		return daoLikes.selectPostLikes(imageName, email);
		
	}
	
	
}
