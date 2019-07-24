package social.dao;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import social.bean.FriendRequest;
import social.bean.ImageBean;
import social.bean.ProfessionBean;
import social.bean.UserInfo;
import social.network.TransactionManager;


public class ProfessionDAO 
{
     TransactionManager tm = null;
    
    public ProfessionDAO()
    {
    	
    }
    
    
  
    /**
     * This method is used to check whether user has added profession information
     * @param prof Profession Information
     * @return
     */
    public String selectProfession(ProfessionBean prof)  // This method is used to check whether user has added profession information
    {
    	tm = new TransactionManager();
    	String email = prof.getEmail();
    	
    	String query = "select * from profession where EmailID='"+email+"'";
    	System.out.println("email in profession: "+email);
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
     * This method is used to insert profession information into 'profession' table
     * @param prof Profession Information
     * @return
     */
    public String insertProfession(ProfessionBean prof)  // This method is used to insert profession information into 'profession' table
    {
    	tm = new TransactionManager();
    	String email = prof.getEmail();
    	String name = prof.getProfession();
    	String qualification = prof.getQualification();
    	String workIn = prof.getWorkIn();
    	
    	String query1 = "insert into profession(EmailID,Name,Qualification,WorkIn) values('"+email+"','"+name+"','"+qualification+"','"+workIn+"')";
    	tm.check1(query1);
    	tm.closeConnection();
    	return "Success";
    }
    
    
    /**
     * This method is used to update profession information into 'profession' table
     * @param prof Profession Information
     * @return
     */
    public int updateProfession(ProfessionBean prof)  // This method is used to update profession information into 'profession' table
    {
    	tm = new TransactionManager();
    	String email = prof.getEmail();
    	String name = prof.getProfession();
    	String qualification = prof.getQualification();
    	String workIn = prof.getWorkIn();
    	
    	String query1 = "update profession set EmailID='"+email+"',Name='"+name+"',Qualification='"+qualification+"',WorkIn='"+workIn+"' where EmailID='"+email+"'";
    	int result = tm.check1(query1);
    	tm.closeConnection();
    	return result;
    }
    
    
    /**
     * This method is used to get profession information of user
     * @param emailId
     * @return Profession Information
     */
    public ProfessionBean getProfession(String emailId)  // This method is used to get profession information of user
    {
    	
    	tm = new TransactionManager();
    	ProfessionBean prof = new ProfessionBean();
    	
    	String query = "select * from profession where EmailID='"+emailId+"'";
    	
    	ResultSet rs = tm.check(query);
    	
    	try 
    	{
			if(rs.next())
			{
				// Set Profession Information in Profession object
				prof.setEmail(rs.getString("EmailId"));
				prof.setProfession(rs.getString("Name"));
				prof.setQualification(rs.getString("Qualification"));
				prof.setWorkIn(rs.getString("WorkIn"));
				
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
    	
    	   return prof;
    	
    	
    	
    }
    
    /**
     * This method is used to delete profession information record from 'profession' table
     * @param email
     * @return
     */
    public int deleteProfession(String email)  // This method is used to delete profession information record from 'profession' table
    {
    	tm = new TransactionManager();
    	String query = "delete from profession where EmailID='"+email+"'";
    	
    	int result = tm.check1(query);
    	tm.closeConnection();
    	return result;
    	
    }

}
