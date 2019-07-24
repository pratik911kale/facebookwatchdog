package social.dao;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;

import social.bean.CommentBean;
import social.bean.LikeBean;
import social.network.TransactionManager;

public class CommentDAO 
{
    TransactionManager tm = null;
    
    
      public CommentDAO()
      {
    	  
      }
      
      /**
       * This method is used to insert comment record for image into 'comments' table
       * @param comment
       * @return
       */
     public int insertComment(CommentBean comment)
      {
    	  tm = new TransactionManager();    // This method is used to insert comment record for image into 'comments' table
    	  
      	System.out.println("PostId in LikesDAO: "+comment.getImageFId());
      	String query1 = "insert into comments(Id,ImageFId,EmailFId,Comment,Time,Date,Status) values("+comment.getId()+","+comment.getImageFId()+",'"+comment.getEmailFId()+"','"+comment.getComment()+"','"+comment.getTime()+"','"+comment.getDate()+"','"+comment.getStatus()+"')";
      	
      	int result = tm.check1(query1);
      	tm.closeConnection();
      	
      	return result;
      }
      
      
      /**
       * This method is used to get comments for image
       * @param imageName
       * @param email
       * @return
       */
      public ArrayList<CommentBean> getComments(String imageName, String email)
      {
    	// This method is used to get comments for image
    	  
    	  tm = new TransactionManager();
    	  
    	  int postId = 0;
    	  
    	  ArrayList<CommentBean> commentInfo = new ArrayList<CommentBean>();
    	  
    	  String queryPost = "select * from images where ImageName='"+imageName+"' and EmailFId='"+email+"'";
    	  
    	  ResultSet rsPost = tm.check(queryPost);
    	  
    	  try 
    	  {
			if(rsPost.next())
			  {
				  postId = rsPost.getInt("Id");
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
				   if(rsPost!=null)
					 rsPost.close();
				} 
				catch(SQLException e)
				{
						
						e.printStackTrace();
				}
			}
    	  
    	  String query = "select * from comments where ImageFId="+postId+" order by Date desc,Time desc";
    	  
    	  ResultSet rsComment = tm.check(query);
    	  
    	  try 
    	  {
			while(rsComment.next())
			{
				CommentBean comment = new CommentBean();
				  comment.setComment(rsComment.getString("Comment"));
				  comment.setDate(rsComment.getDate("Date"));
				  comment.setEmailFId(rsComment.getString("EmailFId"));
				  comment.setTime(rsComment.getTime("Time"));
				  comment.setStatus(rsComment.getString("Status"));
				  comment.setImageFId(rsComment.getInt("ImageFId"));
				  comment.setId(rsComment.getInt("Id"));
				  commentInfo.add(comment);
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
	    			if(rsComment!=null)
	    			{
	    				rsComment.close();
	    				tm.closeConnection();
	    			}
	    		}
	    		catch(SQLException ex)
	    		{
	    			ex.printStackTrace();
	    		}
	    	}
    	  return commentInfo;
      }
      
      /**
       * This method is used to delete comments records from 'comments' table for image
       * @param postId Id of Image uploaded by user
       * @return
       */
      public int deleteComments(int postId) // This method is used to delete comments records from 'comments' table for image
      {
    	  tm = new TransactionManager();
    	  
      	String query = "delete from comments where ImageFId="+postId+"";
      	
          int result = tm.check1(query);
          tm.closeConnection();
      	
      	if(result == 1)
      		return 1;
      	else
      	    return 0;
      }
      
      
      /**
       * This method is used to get count of comments  from 'comments' table for image
       * @param imagePath  Path of Image on server
       * @param email
       * @return
       */
      public int getCountOfComments(String imagePath, String email)
      {
    	  tm = new TransactionManager();  // These method is used to get count of comments  from 'comments' table for image
    	  
    	  int postId = 0;
    	  int count =0;
    	  
    	  String imageName = imagePath.substring(imagePath.lastIndexOf('\\')+1);
    	  
    	  String queryPost = "select * from images where ImageName='"+imageName+"' and EmailFId='"+email+"'";
    	  
    	  ResultSet rsPost = tm.check(queryPost);
    	  
    	  try 
    	  {
			if(rsPost.next())
			  {
				  postId = rsPost.getInt("Id");
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
				   if(rsPost!=null)
					rsPost.close();
				} 
				catch(SQLException e)
				{
						
						e.printStackTrace();
				}
			}
    	  
    	  String query = "select * from comments where ImageFId="+postId+"";
    	  
    	  ResultSet rsComment = tm.check(query);
    	  
    	  try 
    	  {
			while(rsComment.next())
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
				   if(rsComment!=null)
				   {
					rsComment.close();
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
       * This method is used to delete comment record from 'comments' table
       * @param commentId
       * @return
       */
      public int deleteComment(int commentId)  // This method is used to delete comment record from 'comments' table
      {
    	  tm = new TransactionManager();
    	  
      	String query = "delete from comments where Id="+commentId+"";
      	
          int result = tm.check1(query);
          tm.closeConnection();
      	
      	if(result == 1)
      		return 1;
      	else
      	    return 0;
      }
      
      /**
       * This method is used to update comment  in 'comments' table
       * @param commentId
       * @param comment
       * @param time
       * @param date
       * @param status Comment sentiment such as positive or negative
       * @return
       */
      public int updateComment(int commentId, String comment, Time time, Date date, String status) 
      {
    	// This method is used to update comment  in 'comments' table
    	  
    	  tm = new TransactionManager();
    	  
      	String query = "update comments set Comment='"+comment+"', Time='"+time+"', Date='"+date+"', Status='"+status+"' where Id="+commentId+"";
      	
          int result = tm.check1(query);
          tm.closeConnection();
      	
      	if(result == 1)
      		return 1;
      	else
      	    return 0;
      }
      
     
      /**
       * This method is used to get all comments records from 'comments' table inserted by particular user
       * @param email
       * @return
       */
      public ArrayList<CommentBean> getCommentedImages(String email)
      {
    	  // This method is used to get all comments records from 'comments' table inserted by particular user
    	  
    	  tm = new TransactionManager();
    	  
    	  String query = "select * from comments where EmailFId='"+email+"'";
    	  
    	 
    	  ArrayList<CommentBean> commentInfo = new ArrayList<CommentBean>();
          ResultSet rsComment = tm.check(query);
    	  
    	  try 
    	  {
			while(rsComment.next())
			{
				 CommentBean comment = new CommentBean();
				  comment.setComment(rsComment.getString("Comment"));
				  comment.setDate(rsComment.getDate("Date"));
				  comment.setEmailFId(rsComment.getString("EmailFId"));
				  comment.setTime(rsComment.getTime("Time"));
				  comment.setStatus(rsComment.getString("Status"));
				  comment.setImageFId(rsComment.getInt("ImageFId"));
				  comment.setId(rsComment.getInt("Id"));
				  commentInfo.add(comment);
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
	    			if(rsComment!=null)
	    			{
	    				rsComment.close();
	    				tm.closeConnection();
	    			}
	    		}
	    		catch(SQLException ex)
	    		{
	    			ex.printStackTrace();
	    		}
	    	}
    	  return commentInfo;
    	  
      }
      
      
}
