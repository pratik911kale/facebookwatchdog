package social.dao;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;

import social.network.TransactionManager;


public class AdultDetectionDAO 
{

TransactionManager tm = null;
    
    
    public AdultDetectionDAO()
    {
  	  
    }
    
    public int insertAdultCrime(String email, int count) // this method inserts Ban Record into 'accountban' table
    {
    	tm = new TransactionManager();
    	
    
    	String query = "insert into adultdetection values('"+email+"', "+count+")";
        int inserted = tm.check1(query);
    	
        
    	tm.closeConnection();
    	
    	return inserted;
    	
    }
	
    
    
    public int getAdultCount(String email)  // this method returns the adult image upload count
    {
    	tm = new TransactionManager();
    	
    	int result = 0;
    	String query = "select * from adultdetection where EmailId='"+email+"'";
    	
    	ResultSet rs = tm.check(query);
    	
    	try 
    	{
			if(rs.next())
			{
				result = rs.getInt(2);
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
     * This method is used to update adult image record  in 'adultdetection' table
     * @param email
     * @param count
     * @return integer
     */
    public int updateAdultRecord(String email, int count) 
    {
  	// This method is used to update adult record  in 'adultdetection' table
  	  
  	  tm = new TransactionManager();
  	  
    	String query = "update adultdetection set Count="+count+" where EmailId='"+email+"'";
    	
        int result = tm.check1(query);
        tm.closeConnection();
    	
    	if(result == 1)
    		return 1;
    	else
    	    return 0;
    }
    
    
    
    public String checkAdultRecord(String email)  // this method checks the adult image record
    {
    	tm = new TransactionManager();
    	
    	String available = "failure";
    	
    	
    	String query = "select * from adultdetection where EmailId='"+email+"'";
    	
    	ResultSet rs = tm.check(query);
    	
    	try 
    	{
			if(rs.next())
			{
				available = "success";
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
    	return available;
    }
    
    
    public int deleteAdultRecord(String email) 
    {
  	// This method is used to delete adult record  from 'adultdetection' table
  	  
  	  tm = new TransactionManager();
  	  
    	String query = "delete from adultdetection where EmailId='"+email+"'";
    	
        int result = tm.check1(query);
        tm.closeConnection();
    	
    	if(result == 1)
    		return 1;
    	else
    	    return 0;
    }
    
	
}
