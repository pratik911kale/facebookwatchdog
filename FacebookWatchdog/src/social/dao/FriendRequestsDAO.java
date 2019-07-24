package social.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import social.bean.FriendRequest;
import social.bean.ProfessionBean;
import social.network.TransactionManager;

public class FriendRequestsDAO 
{
	 TransactionManager tm = null;
	    
	    public FriendRequestsDAO()
	    {
	    	
	    }
	    
	    
	    /**
	     * This method is used to insert request record from 'friendrequests' table
	     * @param req friend request information
	     * @return
	     */
	    public int insertRequest(FriendRequest req) // This method is used to insert request record from 'friendrequests' table
	    {
	    	tm = new TransactionManager();
	    	
	    	String query1 = "insert into friendrequests(Id,Email1,Email2,Time) values('"+req.getId()+"','"+req.getEmail1()+"','"+req.getEmail2()+"','"+req.getDate()+"')";
	    	
	    	int result = tm.check1(query1);
	    	tm.closeConnection();
	    	return result;
	    }
	    
	    
	    /**
	     * This method is used to get request records from 'friendrequests' table for particular user
	     * @param email
	     * @return
	     */
	    public ArrayList<FriendRequest> getFriendRequests(String email)
	    {
	    	 // This method is used to get request records from 'friendrequests' table for particular user
	    	
	    	tm = new TransactionManager();
	    	
	    	String query = "select * from friendrequests where Email2='"+email+"'";
	    	
	    	ArrayList<FriendRequest> reqList = new ArrayList<FriendRequest>();
	    	
	    	
	    	
	    	ResultSet rs = tm.check(query);
	    	try 
	    	{
				while(rs.next())
				{
					FriendRequest request = new FriendRequest();
					request.setEmail1(rs.getString("Email1"));
					request.setEmail2(rs.getString("Email2"));
					request.setDate(rs.getTimestamp("Time"));
					request.setId(rs.getInt("Id"));
					reqList.add(request);
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
	    	
	    	   return reqList;
	    }
	    
	    
	    /**
	     * This method is used to delete request record from 'friendrequests' table
	     * @param frndRequest friend request information
	     * @return
	     */
	    public int deleteRequest(FriendRequest frndRequest)
	    {
	    	
	    	// This method is used to delete request record from 'friendrequests' table
	    	tm = new TransactionManager();
	    	String query = "delete from friendrequests where Email1='"+frndRequest.getEmail1()+"' and Email2='"+frndRequest.getEmail2()+"'";
	    	
	    	int result = tm.check1(query);
	    	tm.closeConnection();
	    	
	    	if(result == 1)
	    		return 1;
	    	else
	    	    return 0;
	    }
	    
	    
	    /**
	     * This method is used to get request record from 'friendrequests' table
	     * @param email1 Email Id of sender
	     * @param email2 Email Id of Receiver
	     * @return
	     */
	    public String getFriendRequest(String email1, String email2)
	    {
	    	
	    	 // This method is used to get request record from 'friendrequests' table
	    	tm = new TransactionManager();
	    	String query = "select * from friendrequests where Email1='"+email1+"' and Email2='"+email2+"'";
	    	
	    	ResultSet rs = tm.check(query);
	    	
	    	try 
	    	{
				if(rs.next())
				{
					return "yes";
				}
			} 
	    	catch (SQLException e) 
	    	{
				
				e.printStackTrace();
			}
	    	
	    	return "no";
	    	
	    }
	    
	    
	    /**
	     *  // These method is used to delete requests records from 'friendrequests' table
	     * @param email
	     * @return
	     */
	    public int deleteRequests(String email)  // This method is used to delete requests records from 'friendrequests' table
	    {
	    	
	    	tm = new TransactionManager();
	    	
	    	String query = "delete from friendrequests where Email1='"+email+"' or Email2='"+email+"'";
	    	
	    	int deleted = tm.check1(query);
	    	
	    	tm.closeConnection();
	    	
	    	return deleted;
	    	
	    	
	    	
	    }
}
