package social.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import social.network.TransactionManager;

public class TableDAO 
{
    
     TransactionManager tm = null;
    
    public TableDAO()
    {
    	
    }
    
  
    /**
     * This method is used to truncate temporary table	
     * @return
     */
   public int truncateTable()   // This method is used to truncate temporary table	
   {
	   tm = new TransactionManager();
	   String query = "truncate temporary";
	   
	   int result = tm.check1(query);
	   tm.closeConnection();
	   return result;
   }
    
  
   /**
    * This method is used to insert into temporary table	
    * @param postId
    * @param friendEmail
    * @param displayed
    * @return
    */
    public int insertRecord(int postId, String friendEmail, String displayed)
    {
    	
    	 // This method is used to insert into temporary table	
    	tm = new TransactionManager();
    	String query = "insert into temporary values("+postId+",'"+friendEmail+"','"+displayed+"')";
    	
    	int result = tm.check1(query);
    	tm.closeConnection();
    	return result;
    	
    }
    
    
    /**
     * This method is used to truncate temporarymess table
     * @param messId
     * @param friendEmail
     * @param displayed
     * @return
     */
    public int insertRecordMess(int messId, String friendEmail, String displayed)
    {
    	// This method is used to truncate temporarymess table	
    	
    	tm = new TransactionManager();
    	String query = "insert into temporarymess values("+messId+",'"+friendEmail+"','"+displayed+"')";
    	
    	int result = tm.check1(query);
    	tm.closeConnection();
    	return result;
    	
    }
    
   	
    /**
     * This method is used to check whether temporary table has record for particular user and image
     * @param postId
     * @param friendEmail
     * @return
     */
    public String selectRecord(int postId, String friendEmail)  // This method is used to check whether temporary table has record for particular user and image
    {
    	tm = new TransactionManager();
    	String query = "select * from temporary where PostId="+postId+" and FriendEmail='"+friendEmail+"'";
    	
    	ResultSet rs = tm.check(query);
    	
    	
			try 
			{
				if(rs.next())
					return "yes";
				
				
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
			
		
    	return "no";
		
	
			
		
    	
    	
    	
    }
    
 
    /**
     * This method is used to check whether temporarymess table has record for particular user and Message Post
     * @param messId
     * @param friendEmail
     * @return
     */
    public String selectRecordMess(int messId, String friendEmail)
    {
    	// This method is used to check whether temporarymess table has record for particular user and Message Post
    	
    	tm = new TransactionManager();
    	String query = "select * from temporarymess where MessageId="+messId+" and FriendEmail='"+friendEmail+"'";
    	
    	ResultSet rs = tm.check(query);
    	
    	
			try 
			{
				if(rs.next())
					return "yes";
				
				
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
			
		
    	return "no";
		
	
			
		
    	
    	
    	
    }
    
    
    /**
     * This method is used to truncate temporarymess table
     * @return
     */
    public int truncateTableMess() // This method is used to truncate temporarymess table	
    {
 	   tm = new TransactionManager();
 	   String query = "truncate temporarymess";
 	   
 	   int result = tm.check1(query);
 	   tm.closeConnection();
 	   return result;
    }
	
}
