package social.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;

import social.bean.MessageBean;
import social.bean.Warning;
import social.network.TransactionManager;

public class WarningDAO 
{

TransactionManager tm = null;
    
    
    public WarningDAO()
    {
  	  
    }
	
  
    /**
     * This method is used to insert Warning Message record into 'warning' table
     * @param warn
     * @return
     */
    public int insertWarning(Warning warn)   // This method is used to insert Warning Message record into 'warning' table
    {
    	tm = new TransactionManager();
    	System.out.println("EmailFId in WarningDAO: "+warn.getEmailFId());
    	String query1 = "insert into warning(Id,EmailFId,Message,Category,Time,Date) values("+warn.getId()+",'"+warn.getEmailFId()+"','"+warn.getMessage()+"','"+warn.getCategory()+"','"+warn.getTime()+"','"+warn.getDate()+"')";
    	
    	int result = tm.check1(query1);
    	tm.closeConnection();
    	return result;
    }
    
    
    /**
     * This method is used to delete Warning Messages records from 'warning' table
     * @param email
     * @return
     */
    public int deleteWarnings(String email) // This method is used to delete Warning Messages records from 'warning' table
    {
    	
    	tm = new TransactionManager();
    	
    	String query = "delete from warning where EmailFId='"+email+"'";
    	
    	int deleted = tm.check1(query);
    	
    	System.out.println("Warnings Deleted: "+deleted);
    	
    	tm.closeConnection();
    	
    	return deleted;
    }
    
    
    /**
     * This method is used to get Warning Messages records of specific category from 'warning' table
     * @param email
     * @param category
     * @return
     */
    public Warning getWarning(String email, String category)
    {
    	// This method is used to get Warning Messages records of specific category from 'warning' table
    	
    	tm = new TransactionManager();
    	
    	ArrayList<Warning> warningsList = new ArrayList<Warning>();
    	Warning warning = new Warning();
  	  
  	  String queryPost = "select * from warning where EmailFId='"+email+"' and Category='"+category+"' order by Date desc,Time desc";
  	  
  	  ResultSet rs = tm.check(queryPost);
  	  
  	try 
	{
		if(rs.next())
		{
			
			
			warning.setEmailFId(rs.getString("EmailFId"));
			
			warning.setDate(rs.getDate("Date"));
			warning.setId(rs.getInt("Id"));
			warning.setTime(rs.getTime("Time"));
			warning.setMessage(rs.getString("Message"));
			warning.setCategory(rs.getString("Category"));
			
			
			
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
	
				  return warning;
			 
    }
    
    
    /**
     * This method is used to get count of  Warning Messages of Crime type from 'warning' table
     * @param email
     * @return
     */
    public int getCountOfCrimePosts(String email) // This method is used to get count of  Warning Messages of Crime type from 'warning' table
    {
    	tm = new TransactionManager();
    	String query = "select * from warning where EmailFId='"+email+"' and Category='crime'";
    	
    	int count = 0;
    	
    	ResultSet rs = tm.check(query);
    	
    	try 
    	{
			while(rs.next())
			{
				count++;
				
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
    	
    	
    	return count;
    	
    }
    
    
 
    /**
     * This method is used to get count of  Warning Messages of Riots type from 'warning' table
     * @param email
     * @return
     */
    public int getCountOfRiotsPosts(String email)
    {
    	// This method is used to get count of  Warning Messages of Riots type from 'warning' table
    	
    	tm = new TransactionManager();
    	String query = "select * from warning where EmailFId='"+email+"' and Category='riots'";
    	
    	int count = 0;
    	
    	ResultSet rs = tm.check(query);
    	
    	try 
    	{
			while(rs.next())
			{
				count++;
				
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
    	
    	return count;
    	
    }
    
    /**
     * This method is used to get count of  Warning Messages of Worst type from 'warning' table
     * @param email Email of User
     * @return Count of Worst Posts
     */

    public int getCountOfWorstPosts(String email)  // This method is used to get count of  Warning Messages of Worst type from 'warning' table
    {
    	tm = new TransactionManager();
    	String query = "select * from warning where EmailFId='"+email+"' and Category='worst'";
    	
    	int count = 0;
    	
    	ResultSet rs = tm.check(query);
    	
    	try 
    	{
			while(rs.next())
			{
				count++;
				
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
    	
    	return count;
    	
    }
    
    
    /**
     * This method is used to get Warning Id for new Warning Message
     * @return Warning Id
     */
    public int getWarningId() // This method is used to get Warning Id for new Warning Message
    {
   	 tm = new TransactionManager();
   	 int max = 0; 
   	 int i, j, z, value=0;
   	 int []warningId;
   	 
   	 String query3 = "select Id from warning";
   	 String query1 = "select COUNT(*) from warning";
   	 String querySort = "select Id from warning ORDER BY Id";
   	 
   	 ResultSet rs3 = tm.check(query3);
   	 ResultSet rs1 = tm.check(query1);
   	 try
   	 {
   		 
   	   if(rs3.next())
   	   {
   	     try
   	     {
   	       if(rs1.next())
   	       {
   	          int k = rs1.getInt(1);
   	          String query = "select max(Id) from warning";
   	
   	          ResultSet rs = tm.check(query);
   	
   	          try
   	          {
   	             if(rs.next())
   	             {
   	    	        j=0;
   	                max = rs.getInt(1);
   	          
   	             warningId = new int[k];
   	          
   	                ResultSet rsSort = tm.check(querySort);
   	                while(rsSort.next())
   	                {
   	                	warningId[j] = rsSort.getInt("Id");
   	        	        j++;
   	                }
   	          
   	                for(i=0;i<j;i++)
   	                {
   	        	        z = value + 1;
   	        	       while(z<=warningId[i])
   	        	       {
   	        		      if(z!=warningId[i])
   	        			  return z;
   	        		      z++;
   	        	       }
   	        	       value = warningId[i];
   	                }
   	          
   	          
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
 	  					rs.close();
 	  				} 
 	  				catch(SQLException e)
 	  				{
 	  						
 	  						e.printStackTrace();
 	  				}
 	  			}
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
	  				   if(rs1!=null)
	  					rs1.close();
	  				} 
	  				catch(SQLException e)
	  				{
	  						
	  						e.printStackTrace();
	  				}
	  			}
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
				   if(rs3!=null)
				   {
					rs3.close();
					tm.closeConnection();
				   }
				} 
				catch(SQLException e)
				{
						
						e.printStackTrace();
				}
			}
   	int y = max+1;
       System.out.println("In WarningDAO: "+y);
   	 
		return max+1;
    }
   
   
    /**
     * This method is used to get count of Message Posts of Crime Category from 'messagepost' table
     * @param email Email of user
     * @return Count of Crime messages
     */
    public int getCountOfCrimeCategories(String email) // This method is used to get count of Message Posts of Crime Category from 'messagepost' table
    {
    	tm = new TransactionManager();
    	String query = "select * from messagepost where EmailFId='"+email+"' and Category='crime'";
    	
    	int count = 0;
    	
    	ResultSet rs = tm.check(query);
    	
    	try 
    	{
			while(rs.next())
			{
				count++;
				
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
    	
    	
    	return count;
    	
    }
    
    /**
     * This method is used to get date of latest Crime type message from 'messagepost' table
     * @param email Email of user
     * @return Date of Crime Message
     */
    public Date getCrimeMessageDate(String email)  // This method is used to get date of latest Crime type message from 'messagepost' table
    {
    	tm = new TransactionManager();
    	String query = "select * from messagepost where EmailFId='"+email+"' and Category='crime' order by Date desc";
    	
         ResultSet rs = tm.check(query);
    	Date date = null;
         
    	try 
    	{
			while(rs.next())
			{
				date = rs.getDate("Date");
				
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
    	
    	return date;
    }
    
    /**
     * This method is used to get count of Message Posts of wrong status from 'messagepost' table
     * @param email Email of user
     * @return Count of Bad messages
     */
    public int getCountOfBadMessages(String email)
    {
    	 // This method is used to get count of Message Posts of wrong status from 'messagepost' table
    	
    	tm = new TransactionManager();
    	String query = "select * from messagepost where EmailFId='"+email+"' and Status='wrong'";
    	
    	int count = 0;
    	
    	ResultSet rs = tm.check(query);
    	
    	try 
    	{
			while(rs.next())
			{
				count++;
				
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
    	
    	System.out.println("Value of Bad Count: "+count);
    	return count;
    	
    }
}
