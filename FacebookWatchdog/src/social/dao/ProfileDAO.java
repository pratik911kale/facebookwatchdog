package social.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import social.bean.CommentBean;
import social.bean.FriendRequest;
import social.bean.ProfileInfo;
import social.bean.UserInfo;
import social.network.TransactionManager;

public class ProfileDAO 
{
	TransactionManager tm = null;
    
    public ProfileDAO()
    {
    	
    }
    
    /**
     * This method is used to get Profile information from 'profile' table
     * @param email
     * @return
     */
    public ProfileInfo getProfileImage(String email)   // This method is used to get Profile information from 'profile' table
    {
    	tm = new TransactionManager();
    	 ProfileInfo profile = new ProfileInfo();
   	  
    	
    	String query = "select * from profile where Email='"+email+"'";
    	System.out.println("Here is : "+query);
    	 ResultSet rs = tm.check(query);
    	
    	 try 
   	  {
			if(rs.next())
			{
				
				// Set Profile information in Profile object
				profile.setfirst(rs.getString("FirstName"));
				
				profile.setEmail(rs.getString("Email"));
				
				profile.setlast(rs.getString("LastName"));
				
				profile.setpath(rs.getString("ImagePath"));
				
				
			}
		  } 
   	  catch (SQLException e) 
   	  {
			
			e.printStackTrace();
		  }
   	  finally
	    	{
	    		try
	    		{
	    			if(rs!=null)
	    			{
	    				rs.close();
	    				tm.closeConnection();
	    			}
	    		}
	    		catch(SQLException ex)
	    		{
	    			ex.printStackTrace();
	    		}
	    	}
   	  return profile;
    		
     	   
     	    
    	
    	    	
    }
   
   
    /**
     * This method is used to insert profile information into 'profile' table
     * @param email
     * @param first
     * @param last
     * @param imagePath
     * @return
     */
    public int insertPic(String email, String first, String last, String imagePath)
    {
    	// This method is used to insert profile information into 'profile' table
    	
    	tm = new TransactionManager();
    	String query1 = "insert into profile(Email,FirstName,LastName,ImagePath) values('"+email+"','"+first+"','"+last+"','"+imagePath+"')";
    	
    	int result = tm.check1(query1);
    	tm.closeConnection();
    	return result;
    }
    
    
    /**
     * This method is used to delete profile information from 'profile' table
     * @param email
     * @return
     */
    public int deletePic(String email) // This method is used to delete profile information from 'profile' table
    {
    	tm = new TransactionManager();
    	String query1 = "delete from profile where Email='"+email+"'";
    	
    	int result = tm.check1(query1);
    	
    	System.out.println("Profile Picture deleted: "+result);
    	tm.closeConnection();
    	return result;
    }
    
    
    
    public String getProfileStatus(String email)
    {
    	tm = new TransactionManager();
    	String query = "select * from profilestatus where Email='"+email+"'";
    	
    	ResultSet rs = tm.check(query);
    	
    	try 
    	{
			if(rs.next())
			{
			      return rs.getString("ImageFound");	
			}
		} 
    	catch (SQLException e) 
    	{
			
			e.printStackTrace();
		}
    	
    	return "no";
    }

}
