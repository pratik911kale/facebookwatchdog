package social.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import social.bean.FriendRequest;
import social.bean.Friends;
import social.bean.LikeBean;
import social.bean.ImageBean;
import social.network.TransactionManager;

public class LikesDAO 
{
     TransactionManager tm = null;
    
    public LikesDAO()
    {
    	
    }
    
    
    /**
     * This method is used to get Image likes count
     * @param imageName
     * @param email
     * @return
     */
    public int selectPostLikes(String imageName, String email) // This method is used to get Image likes count
    {
    	tm = new TransactionManager();
    	int postId = 0;
    	String query = "select Id from images where EmailFId='"+email+"' and ImageName='"+imageName+"'";
    	System.out.println("LikesDAO: "+query);
    	int count = 0;
    	
    		
     	    ResultSet rs = tm.check(query);
     	    
     	    try 
     	    {
				if(rs.next())
				{
				    postId = rs.getInt("Id");
				    
				    String query1 = "select * from likes where ImageFId = "+postId+"";
			        
			        ResultSet rsLikes = tm.check(query1);
			        
			        try 
			        {
						while(rsLikes.next())
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
						   if(rsLikes!=null)
							rsLikes.close();
						} 
						catch(SQLException e)
						{
								
								e.printStackTrace();
						}
					}
			        
				    
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
					  
					rs.close();                         // Close Resultset object
					 tm.closeConnection();
				   }
				} 
				catch(SQLException e)
				{
						
						e.printStackTrace();
				}
			}
     	  
     	    return count;
     	    	
    	
    	    	
    }
    
    
    /**
     * This method is used to insert Like record for image by user
     * @param like  Like information
     * @return 
     */
    public int insertLike(LikeBean like)   // This method is used to insert Like record for image by user
    {
    	tm = new TransactionManager();
    	System.out.println("PostId in LikesDAO: "+like.getImageFId());
    	String query1 = "insert into likes(Id,EmailFId,ImageFId,Time,Date) values("+like.getId()+",'"+like.getEmailFId()+"','"+like.getImageFId()+"','"+like.getTime()+"','"+like.getDate()+"')";
    	
    	int result = tm.check1(query1);
    	tm.closeConnection();
    	return result;
    }
    
    
    /**
     * This method is used to check whether image is liked or not by user
     * @param email
     * @param postId  Id of Image
     * @return
     */
    public String imageLiked(String email, int postId)
    {
    	
    	 // This method is used to check whether image is liked or not by user
    	tm = new TransactionManager();
    	
    	String query = "select * from likes where EmailFId='"+email+"' and ImageFId="+postId+"";
    	
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
					rs.close();                          // Close Resultset object
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
     * This method is used to delete Like record for image from 'likes' table
     * @param email
     * @param postId Id of Image
     * @return
     */
    public int deleteLike(String email, int postId)
    {
    	 // This method is used to delete Like record for image from 'likes' table
    	tm = new TransactionManager();
    	String query = "delete from likes where EmailFId='"+email+"' and ImageFId="+postId+"";
    	
        int result = tm.check1(query);
        tm.closeConnection();
    	
    	if(result == 1)
    		return 1;
    	else
    	    return 0;
    }
    
    
    /**
     * This method is used to delete Like records for image from 'likes' table
     * @param postId Id of Image
     * @return
     */
    public int deleteLikes(int postId) // This method is used to delete Like records for image from 'likes' table
    {
    	tm = new TransactionManager();
    	String query = "delete from likes where ImageFId="+postId+"";
    	
        int result = tm.check1(query);
        tm.closeConnection();
    	
    	if(result == 1)
    		return 1;
    	else
    	    return 0;
    }
    
   
    /**
     * This method is used to get Like records for user from 'likes' table for all images liked by user
     * @param email
     * @return
     */
    public ArrayList<LikeBean> getLikedImages(String email)
    {
    	 // This method is used to get Like records for user from 'likes' table for all images liked by user
    	
    	tm = new TransactionManager();
    	
    	ArrayList<LikeBean> likeList = new ArrayList<LikeBean>();
    	String query = "select * from likes where EmailFId='"+email+"'";
    	
    	ResultSet rs = tm.check(query);
    	try 
    	{
			while(rs.next())
			{
				LikeBean like = new LikeBean();
				like.setEmailFId(rs.getString("EmailFId"));
				like.setImageFId(rs.getInt("ImageFId"));
				like.setDate(rs.getDate("Date"));
				like.setId(rs.getInt("Id"));
				like.setTime(rs.getTime("Time"));
				likeList.add(like);
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
    	
    	   return likeList;
 
    	
    }
    
    public String getLikeRecord(String email, int postId)
    {
    	
    	tm = new TransactionManager();
    	String query = "select * from likes where EmailFId='"+email+"' and ImageFId="+postId+"";
    	
    	ResultSet rs = tm.check(query);
    	
    	if(rs != null)
    	{
    		tm.closeConnection();
    		return "liked";
    	}
    	else
    	{
    		tm.closeConnection();
    		return "notLiked";
    	}
    	
    }
    
}
