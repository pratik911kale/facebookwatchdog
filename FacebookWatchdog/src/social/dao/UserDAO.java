package social.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import social.bean.CommentBean;
import social.bean.UserInfo;
import social.network.TransactionManager;
import social.utility.GetTime;

public class UserDAO 
{
    TransactionManager tm = null;
    
    public UserDAO()
    {
    	
    }
    
    
    /**
     * This method is used to insert user information into user table	
     * @param info User Information
     * @return
     */
    public String init(UserInfo info) // This method is used to insert user information into user table	
    {
    	tm = new TransactionManager();
    	String email = info.getEmail();
    	String query = "select * from user where Email='"+email+"' or Phone='"+info.getPhone()+"'";
    	System.out.println("Here is : "+query);
    	ResultSet rs = null;
    	
    	try
    	{
    		
     	    rs = tm.check(query);
     	    
    	    if(rs.next())
    	    {
    	    	return "failure";
    	    }
    	    else
    	    {
    	    	
    	    	// insert User Information into  'user' table
    	    	String password = info.getPassword();
    	    	String first = info.getFirst();
    	    	String last = info.getLast();
    	    	String local = info.getLocal();
    	    	String permanent = info.getPermanent();
    	    	String phone = info.getPhone();
    	    	String dob = info.getDOB();
    	    	String gender = info.getGender();
    	    	
    	    	
    	    	
    	    	String query1 = "insert into user(Email,FirstName,LastName,Password,LocalAddress,PermanentAddress,Phone,DOB,Gender) values('"+email+"','"+first+"','"+last+"','"+password+"','"+local+"','"+permanent+"','"+phone+"','"+dob+"','"+gender+"')"; 
    	    	tm.check1(query1);
    	    	
    	    	
    	    	return "success";
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
     * This method is used to check whether user login details are correct or not based on Email and Password
     * @param info
     * @return
     */
    public String initEmail(UserInfo info)   // This method is used to check whether user login details are correct or not based on Email and Password
    {
    	tm = new TransactionManager();
    	String email = info.getEmail();
    	String password = info.getPassword();
    	String query = "select * from user where Email='"+email+"' and Password='"+password+"'";
    	System.out.println("Here is : "+query);
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
     * This method is used to check whether user login details are correct or not	based on Mobile No. and password
     * @param info
     * @return
     */
    public String initPhone(UserInfo info)
    {
    	 // This method is used to check whether user login details are correct or not	based on Mobile No. and password
    	
    	tm = new TransactionManager();
    	String phone = info.getPhone();
    	String password = info.getPassword();
    	String query = "select * from user where Phone='"+phone+"' and Password='"+password+"'";
    	System.out.println("Here is : "+query);
    	ResultSet rs =null;
    	
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
     * This method is used to get user information record from 'user' table based on Email and Password	
     * @param info
     * @return
     */
    public UserInfo getUser(UserInfo info)
    {
    	  // This method is used to get user information record from 'user' table based on Email and Password	
    	
    	tm = new TransactionManager();
    	UserInfo user = new UserInfo();
  	  
  	  
    	
    	String email = info.getEmail();
    	String password = info.getPassword();
    	String query = "select * from user where Email='"+email+"' and Password='"+password+"'";
    	System.out.println("Here is : "+query);
    	
    
    		
     	    ResultSet rs = tm.check(query);
     	    
     	   try 
     	  {
 			if(rs.next())
 			{
 				// Set User Information into User Object
 				
 				user.setFirst(rs.getString("FirstName"));
 				user.setLast(rs.getString("LastName"));
 				user.setEmail(rs.getString("Email"));
 				user.setPassword(rs.getString("Password"));
 				user.setPhone(rs.getString("Phone"));
 				user.setLocal(rs.getString("LocalAddress"));
 				user.setPermanent(rs.getString("PermanentAddress"));
 				user.setDOB(rs.getString("DOB"));
 				user.setGender(rs.getString("Gender"));
 				 
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
     	  return user;
     	    
     	     
    	
    	    	
    }
    
    
    /**
     * This method is used to get user information record from 'user' table based on Mobile No. and password
     * @param info
     * @return
     */
    public UserInfo getPhone(UserInfo info)
    {
    	// This method is used to get user information record from 'user' table based on Mobile No. and password	
    	
    	tm = new TransactionManager();
    	UserInfo user = new UserInfo();
    	  
    	
    	String phone = info.getPhone();
    	String password = info.getPassword();
    	String query = "select * from user where Phone='"+phone+"' and Password='"+password+"'";
    	System.out.println("Here is : "+query);
    	
   
    		
     	    ResultSet rs = tm.check(query); 
     	    
     	   try 
      	  {
  			if(rs.next())
  			{
  			// Set User Information into User Object
  				
  				user.setFirst(rs.getString("FirstName"));
  				user.setLast(rs.getString("LastName"));
  				user.setEmail(rs.getString("Email"));
  				user.setPassword(rs.getString("Password"));
  				user.setPhone(rs.getString("Phone"));
  				user.setLocal(rs.getString("LocalAddress"));
  				user.setPermanent(rs.getString("PermanentAddress"));
  				user.setDOB(rs.getString("DOB"));
  				user.setGender(rs.getString("Gender"));
  				  
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
      	  return user;
     	   
    	    	
    }
    
  
    /**
     * This method is used to get user information record from 'user' table based on Email only	
     * @param info
     * @return
     */
    public UserInfo getUserRecord(UserInfo info)
    {
    	  // This method is used to get user information record from 'user' table based on Email only	
    	
    	tm = new TransactionManager();
    	UserInfo user = new UserInfo();
  	  ArrayList<UserInfo> userInfo = new ArrayList<UserInfo>();
    	
    	String email = info.getEmail();
    	
    	String query = "select * from user where Email='"+email+"'";
    	System.out.println("Here is : "+query);
    	
    
    		
     	    ResultSet rs = tm.check(query);
     	    
     	   try 
       	  {
   			if(rs.next())
   			{
   			// Set User Information into User Object
   				user.setFirst(rs.getString("FirstName"));
   				user.setLast(rs.getString("LastName"));
   				user.setEmail(rs.getString("Email"));
   				user.setPassword(rs.getString("Password"));
   				user.setPhone(rs.getString("Phone"));
   				user.setLocal(rs.getString("LocalAddress"));
   				user.setPermanent(rs.getString("PermanentAddress"));
   				user.setDOB(rs.getString("DOB"));
   				user.setGender(rs.getString("Gender"));
   				 
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
       	  return user;
     	     
    	
    	    	
    }
    
    
    /**
     * This method is used to get different users information records from 'user' table based on First Name and Last Name
     * @param info
     * @return
     */
    public ArrayList<UserInfo> getUserByName(UserInfo info)
    {
    	// This method is used to get different users information records from 'user' table based on First Name and Last Name	
    	
    	tm = new TransactionManager();
    	
    	  ArrayList<UserInfo> userInfo = new ArrayList<UserInfo>();
    	
    	String first = info.getFirst();
    	String last = info.getLast();
    	String query;
    	
    	if(last!=null)
    	{
    		
    		query = "select * from user where FirstName='"+first+"' and LastName='"+last+"'";
    		System.out.println("Called from UsersRegistered.java : "+query);
    	
    	}
    	else
    	{
          	query = "select * from user where FirstName='"+first+"'";
    	    System.out.println("Called from UsersRegistered.java : "+query);
    	}
    	
    
    	
     	    ResultSet rs = tm.check(query);
     	    
     	   try 
        	  {
    			while(rs.next())
    			{
    				
    				// Set User Information into User Object
    				UserInfo user = new UserInfo();
    				user.setFirst(rs.getString("FirstName"));
    				user.setLast(rs.getString("LastName"));
    				user.setEmail(rs.getString("Email"));
    				user.setPassword(rs.getString("Password"));
    				user.setPhone(rs.getString("Phone"));
    				user.setLocal(rs.getString("LocalAddress"));
    				user.setPermanent(rs.getString("PermanentAddress"));
    				user.setDOB(rs.getString("DOB"));
    				user.setGender(rs.getString("Gender"));
    				  userInfo.add(user);
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
        	  return userInfo;
     	    
     	 
    	
    	    	
    }
    
   
    /**
     * This method is used to delete user record from 'user' table based on Email	
     * @param email
     * @return
     */
    public int deleteUser(String email)  // This method is used to delete user record from 'user' table based on Email	
    {
    	
    	tm = new TransactionManager();
    	String query = "delete from user where Email='"+email+"'";
    	
    	int deleted = tm.check1(query);
    	
    	tm.closeConnection();
    	
    	FriendsDAO daoFrnds = new FriendsDAO();
    	
    	int deletedFriends = daoFrnds.deleteFriendships(email);
    	System.out.println("Friendships deleted: "+deletedFriends);
    	
    	FriendRequestsDAO request = new FriendRequestsDAO();
    	int deletedRequests = request.deleteRequests(email);
    	System.out.println("Friend Requests deleted: "+deletedRequests);
    	
    	ProfessionDAO daoProf = new ProfessionDAO();
    	int result = daoProf.deleteProfession(email);
    	System.out.println("Profession deleted: "+result);
    	
    	return deleted;
    }
    
    
}
