package social.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import social.bean.CommentBean;
import social.bean.FriendRequest;
import social.bean.Friends;
import social.network.TransactionManager;

public class FriendsDAO 
{
	TransactionManager tm = null;
    
    public FriendsDAO()
    {
    	
    }
    
    
    /**
     * This method is used to check whether two users are friends or not in 'friends' table
     * @param Email Id of sender
	 * @param email2 Email Id of Receiver
     * @return
     */
    public String selectFriends(String email1, String email2)
    {
    	
    	// This method is used to check whether two users are friends or not in 'friends' table
    	tm = new TransactionManager();
    	
    	String query = "select * from friends where Email1='"+email1+"' and Email2='"+email2+"' or Email1='"+email2+"' and Email2='"+email1+"'";
    	System.out.println("FriendsDAO: "+query);
    	ResultSet rs = null;
    	
    	try
    	{
    		
     	    rs = tm.check(query);
     	    
    	    if(rs.next())
    	    {
    	    	
    	    	return "success";
    	    }
    	    else
    	    {
    	    	
    	    	return "failure";
    	    }
    	}
    	
    	catch(SQLException e)
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
			catch(SQLException e)
			{
					
					e.printStackTrace();
			}
		}
		return null;
    	    	
    }
    
    
    /**
     * This method is used to insert friendship record into 'friends' table
     * @param friends Friends table record information
     * @return
     */
    public int insertFriends(Friends friends) // This method is used to insert friendship record into 'friends' table
    {
    	tm = new TransactionManager();
    	String query1 = "insert into friends(Email1,Email2) values('"+friends.getEmail1()+"','"+friends.getEmail2()+"')";
    	
    	int result = tm.check1(query1);
    	tm.closeConnection();
    	return result;
    }
    

    /**
     * This method is used to get records of Friends for user
     * @param email
     * @return
     */
    public ArrayList<Friends> getFriends(String email)  // This method is used to get records of Friends for user
    {
    	tm = new TransactionManager();
    	
     	  ArrayList<Friends> frndInfo = new ArrayList<Friends>();
    	String query = "select * from friends where Email1='"+email+"' or Email2='"+email+"'";
    	ResultSet rsFriends = tm.check(query);
    	
    	try 
    	{
			while(rsFriends.next())
			{
				Friends frnd = new Friends();
				frnd.setEmail1(rsFriends.getString("Email1"));
				frnd.setEmail2(rsFriends.getString("Email2"));
				frndInfo.add(frnd);
			}
		} 
    	catch (SQLException e) 
    	{
			
			e.printStackTrace();
		}
    	return frndInfo;
    }
    
    
    /**
     * This method is used to delete friendship record from'friends' table
     * @param frnd Friends table record information
     * @return
     */
    public int deleteFriends(Friends frnd)  // This method is used to delete friendship record from'friends' table
    {
    	tm = new TransactionManager();
    	String query = "delete from friends where Email1='"+frnd.getEmail1()+"' and Email2='"+frnd.getEmail2()+"' or Email1='"+frnd.getEmail2()+"' and Email2='"+frnd.getEmail1()+"'";
    	
    	int result = tm.check1(query);
    	tm.closeConnection();
    	
    	return result;
    }
    
    
    /**
     * This method is used to delete friendship records for user from'friends' table
     * @param email
     * @return
     */
    public int deleteFriendships(String email) // This method is used to delete friendship records for user from'friends' table
    {
    	
    	tm = new TransactionManager();
    	
    	String query = "delete from friends where Email1='"+email+"' or Email2='"+email+"'";
    	
    	int deleted = tm.check1(query);
    	
    	tm.closeConnection();
    	
    	return deleted;
    	
    	
    	
    }
}
