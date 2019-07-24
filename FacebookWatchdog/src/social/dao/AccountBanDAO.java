package social.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import social.network.TransactionManager;
import social.utility.GetTime;

public class AccountBanDAO 
{
	
TransactionManager tm = null;
    
    
    public AccountBanDAO()
    {
  	  
    }
    
    /**
     * this method inserts Ban Record into 'accountban' table
     * @param email Email Id of user
     * @param phone Mobile number of user
     * @return
     */
    public int banAccount(String email, String phone) // this method inserts Ban Record into 'accountban' table
    {
    	tm = new TransactionManager();
    	java.sql.Date dt1 = new java.sql.Date(System.currentTimeMillis());
    	
    	String query = "insert into accountbanned values('"+email+"','"+GetTime.getCurrentTimeStamp()+"','"+dt1+"','"+phone+"')";
        int inserted = tm.check1(query);
    	
        
    	tm.closeConnection();
    	
    	return inserted;
    	
    }
    
    
    /**
     *  this method checks whether user is banned or not
     * @param email Email Id of user
     * @return
     */
    public String checkBanEmail(String email)  // this method checks whether user is banned or not
    {
    	tm = new TransactionManager();
    	
    	String result = "no";
    	String query = "select * from accountbanned where EmailId='"+email+"'";
    	
    	ResultSet rs = tm.check(query);
    	
    	try 
    	{
			if(rs.next())
			{
				result = "yes";
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
			catch(SQLException e)
			{
					
					e.printStackTrace();
			}
		}
    	
    	return result;
    }
    
    
    /**
     *  this method checks whether user is banned or not
     * @param phone Mobile number of user
     * @return
     */
    public String checkBanPhone(String phone)  // this method checks whether user is banned or not
    {
    	tm = new TransactionManager();
    	
    	String result = "no";
    	String query = "select * from accountbanned where Phone='"+phone+"'";
    	
    	ResultSet rs = tm.check(query);
    	
    	try 
    	{
			if(rs.next())
			{
				result = "yes";
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
			catch(SQLException e)
			{
					
					e.printStackTrace();
			}
		}
    	return result;
    }

}
