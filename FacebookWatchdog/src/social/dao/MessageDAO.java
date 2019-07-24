package social.dao;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;

import social.bean.CategoryCounts;
import social.bean.CommentBean;
import social.bean.FriendRequest;
import social.bean.LikeBean;
import social.bean.MessageBean;
import social.bean.MessageCommentBean;
import social.bean.MessageLikeBean;
import social.bean.ImageBean;
import social.network.TransactionManager;

public class MessageDAO 
{

	
	TransactionManager tm = null;
    
    
    public MessageDAO()
    {
  	  
    }
    
 
    /**
     * This method is used to insert  message record into 'messagepost' table
     * @param mess Message object containing message information
     * @return
     */
    public int insertMessage(MessageBean mess) // This method is used to insert  message record into 'messagepost' table
    {
    	tm = new TransactionManager();
    	System.out.println("EmailFId in MessageDAO: "+mess.getEmailFId());
    	String query1 = "insert into messagepost(Id,EmailFId,Message,Time,Date,Category,RecFId,ImageFId,Status) values("+mess.getId()+",'"+mess.getEmailFId()+"','"+mess.getMessage()+"','"+mess.getTime()+"','"+mess.getDate()+"','"+mess.getCategory()+"','"+mess.getRecFId()+"',"+mess.getImageFId()+",'"+mess.getStatus()+"')";
    	
    	int result = tm.check1(query1);
    	tm.closeConnection();
    	return result;
    }
    
    
    /**
     * This method is used to delete particular message from 'messagepost' table
     * @param messId Id of User Message record
     * @return
     */
    public int deleteMessage(int messId) // This method is used to delete particular message from 'messagepost' table
    {
    	
    	tm = new TransactionManager();
    	
    	String query = "delete from messagepost where Id="+messId+"";
    	
    	int deleted = tm.check1(query);
    	
    	System.out.println("Message Deleted: "+deleted);
    	
    	tm.closeConnection();
    	
    	return deleted;
    }
    
    
    /**
     * This method is used to get all messages from 'messagepost' table posted by particular user
     * @param email
     * @return
     */
    public ArrayList<MessageBean> getMessages(String email)
    {
    	// This method is used to get all messages from 'messagepost' table posted by particular user
    	
    	tm = new TransactionManager();
    	
    	ArrayList<MessageBean> messList = new ArrayList<MessageBean>();
  	  
  	  
  	  String queryPost = "select * from messagepost where EmailFId='"+email+"' order by Date desc,Time desc";
  	  
  	  ResultSet rsPost = tm.check(queryPost);
  	  
  	try 
	{
		while(rsPost.next())
		{ 
			// Message record from table 'messagepost' is set in MessageBean object
			
			MessageBean message = new MessageBean();
			message.setEmailFId(rsPost.getString("EmailFId"));
			message.setImageFId(rsPost.getInt("ImageFId"));
			message.setDate(rsPost.getDate("Date"));
			message.setId(rsPost.getInt("Id"));
			message.setTime(rsPost.getTime("Time"));
			message.setMessage(rsPost.getString("Message"));
			message.setCategory(rsPost.getString("Category"));
			message.setRecFId(rsPost.getString("RecFId"));
			message.setStatus(rsPost.getString("Status"));
			
			messList.add(message);
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
			{
				rsPost.close();
				tm.closeConnection();
			}
		}
		catch(SQLException ex)
		{
			ex.printStackTrace();
		}
	}
	
				  return messList;
			 
    }
    
    
    /**
     * This method is used to get messages from 'messagepost' table from particular user to logged in user
     * @param email    Sender User Email Id
     * @param recFId   Receiver user Email Id
     * @return
     */
    public ArrayList<MessageBean> getMessagesByRec(String email, String recFId)
    {
    	// This method is used to get messages from 'messagepost' table from particular user to logged in user
    	
    	tm = new TransactionManager();
    	
    	ArrayList<MessageBean> messList = new ArrayList<MessageBean>();
  	  
  	  
  	  
  	  String queryPost = "select * from messagepost where EmailFId='"+email+"' and RecFId='"+recFId+"' order by Date desc,Time desc";
  	  
  	  ResultSet rsPost = tm.check(queryPost);
  	  
  	try 
	{
		while(rsPost.next())
		{
			// Message record from table 'messagepost' is set in MessageBean object
			
			MessageBean message = new MessageBean();
			message.setEmailFId(rsPost.getString("EmailFId"));
			message.setImageFId(rsPost.getInt("ImageFId"));
			message.setDate(rsPost.getDate("Date"));
			message.setId(rsPost.getInt("Id"));
			message.setTime(rsPost.getTime("Time"));
			message.setMessage(rsPost.getString("Message"));
			message.setCategory(rsPost.getString("Category"));
			message.setRecFId(rsPost.getString("RecFId"));
			message.setStatus(rsPost.getString("Status"));
			
			messList.add(message);
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
			{
				rsPost.close();
				tm.closeConnection();
			}
		}
		catch(SQLException ex)
		{
			ex.printStackTrace();
		}
	}
	
				  return messList;
  	 
				  
			 
    }
    
    
    /**
     * This method is used to check whether Message is liked or not by user
     * @param email
     * @param messId  Id of message record by facebook user
     * @return
     */
    public String postLiked(String email, int messId)  // This method is used to check whether Message is liked or not by user
    {
    	tm = new TransactionManager();
    	String query = "select * from messagelikes where EmailFId='"+email+"' and MessageFId="+messId+"";
    	
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
     * This method is used to insert Like record for Message by user
     * @param like  Message Like object containing like information
     * @return
     */
    public int insertMessLike(MessageLikeBean like)  // This method is used to insert Like record for Message by user
    {
    	tm = new TransactionManager();
    	String query1 = "insert into messagelikes(Id,EmailFId,MessageFId,Time,Date) values("+like.getId()+",'"+like.getEmailFId()+"','"+like.getMessageFId()+"','"+like.getTime()+"','"+like.getDate()+"')";
    	
    	int result = tm.check1(query1);
    	tm.closeConnection();
    	return result;
    }
    
    
    /**
     * This method is used to delete Like record for Message Post from 'messagelikes' table
     * @param email
     * @param messId  Id of Message by user
     * @return
     */
    public int deleteMessLike(String email, int messId)
    { 
    	// This method is used to delete Like record for Message Post from 'messagelikes' table
    	
    	tm = new TransactionManager();
    	String query = "delete from messagelikes where EmailFId='"+email+"' and MessageFId="+messId+"";
    	
        int result = tm.check1(query);
        tm.closeConnection();
    	
    	if(result == 1)
    		return 1;
    	else
    	    return 0;
    }
    
    
    /**
     * This method is used to delete Like records for Message from 'messagelikes' table
     * @param messId Id of Message by user
     * @return
     */
    public int deleteMessageLikes(int messId)  // This method is used to delete Like records for Message from 'messagelikes' table
    {
    	tm = new TransactionManager();
    	String query = "delete from messagelikes where MessageFId="+messId+"";
    	
        int result = tm.check1(query);
        tm.closeConnection();
    	
    	if(result == 1)
    		return 1;
    	else
    	    return 0;
    }
    
    
    /**
     * This method is used to insert comment record for Message into 'messagecomments' table
     * @param comment
     * @return
     */
    public int insertComment(MessageCommentBean comment)
    {
    	
    	// This method is used to insert comment record for Message into 'messagecomments' table
    	
    	tm = new TransactionManager();
    	System.out.println("MessId in MessageDAO: "+comment.getMessageFId());
    	String query1 = "insert into messagecomments(Id,MessageFId,EmailFId,Comment,Time,Date,Status) values("+comment.getId()+","+comment.getMessageFId()+",'"+comment.getEmailFId()+"','"+comment.getComment()+"','"+comment.getTime()+"','"+comment.getDate()+"','"+comment.getStatus()+"')";
    	
    	int result = tm.check1(query1);
    	tm.closeConnection();
    	return result;
    }
    
    
    /**
     * // This method is used to get comments for posted Message
     * @param messId
     * @return
     */
    public ArrayList<MessageCommentBean> getComments(int messId) // This method is used to get comments for posted Message
    {
    	tm = new TransactionManager();
    	
    	ArrayList<MessageCommentBean> commentList = new ArrayList<MessageCommentBean>();

  	  
  	  String query = "select * from messagecomments where MessageFId="+messId+" order by Date desc,Time desc";
  	  
  	  ResultSet rsComment = tm.check(query);
  	  int count = 0;
  	  
  	try 
	{
		while(rsComment.next())
		{
			
			// Message Comments record from table 'messagecomments' is set in MessageCommentBean object
			MessageCommentBean comment = new MessageCommentBean();
			comment.setEmailFId(rsComment.getString("EmailFId"));
			comment.setComment(rsComment.getString("Comment"));
			comment.setDate(rsComment.getDate("Date"));
			comment.setId(rsComment.getInt("Id"));
			comment.setTime(rsComment.getTime("Time"));
			comment.setStatus(rsComment.getString("Status"));
			comment.setMessageFId(rsComment.getInt("MessageFId"));
			
			commentList.add(comment);
			System.out.println("In MessageDAO: " + commentList.get(count).getComment());
			count++;
			
		}
		return commentList;
		
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
  	  
  	  return commentList;
    }
    
    
    /**
     * This method is used to delete comments records from 'messagecomments' table for posted Message
     * @param messId
     * @return
     */
    public int deleteComments(int messId)  // This method is used to delete comments records from 'messagecomments' table for posted Message
    {
    	tm = new TransactionManager();
    	String query = "delete from messagecomments where MessageFId="+messId+"";
    	
        int result = tm.check1(query);
        tm.closeConnection();
    	
    	if(result == 1)
    		return 1;
    	else
    	    return 0;
    }
    
    
    /**
     * This method is used to delete particular comment record from 'messagecomments' table
     * @param commentId Id of Comment on User Message post
     * @return
     */
    public int deleteComment(int commentId)  // This method is used to delete particular comment record from 'messagecomments' table
    {
    	tm = new TransactionManager();
    	String query = "delete from messagecomments where Id="+commentId+"";
    	
        int result = tm.check1(query);
        tm.closeConnection();
    	
    	if(result == 1)
    		return 1;
    	else
    	    return 0;
    }
    
    /**
     * This method is used to update comment record from 'messagecomments' table for posted Message
     * @param commentId  Id of Comment on User Message post
     * @param comment
     * @param time
     * @param date
     * @param status Sentiment of comment such as positive or negative
     * @return
     */
    public int updateComment(int commentId, String comment, Time time, Date date, String status)
    {
    	// This method is used to update comment record from 'messagecomments' table for posted Message
    	
    	tm = new TransactionManager();
    	String query = "update messagecomments set Comment='"+comment+"', Time='"+time+"', Date='"+date+"', Status='"+status+"' where Id="+commentId+"";
    	
        int result = tm.check1(query);
        tm.closeConnection();
    	
    	if(result == 1)
    		return 1;
    	else
    	    return 0;
    }
    
    
    /**
     * This method is used to get all comments records from 'messagecomments' table inserted by particular user
     * @param email
     * @return
     */
    public ArrayList<MessageCommentBean> getCommentedPosts(String email)
    {
    	// This method is used to get all comments records from 'messagecomments' table inserted by particular user
    	
    	tm = new TransactionManager();
    	
    	ArrayList<MessageCommentBean> commentList = new ArrayList<MessageCommentBean>();
    	
  	  String query = "select * from messagecomments where EmailFId='"+email+"' order by Date desc,Time desc";
  	  
  	  ResultSet rsComment = tm.check(query);
  	  
  	try 
	{
		while(rsComment.next())
		{
			
			// Message Comments record from table 'messagecomments' is set in MessageCommentBean object
			MessageCommentBean comment = new MessageCommentBean();
			comment.setEmailFId(rsComment.getString("EmailFId"));
			comment.setComment(rsComment.getString("Comment"));
			comment.setDate(rsComment.getDate("Date"));
			comment.setId(rsComment.getInt("Id"));
			comment.setTime(rsComment.getTime("Time"));
			comment.setStatus(rsComment.getString("Status"));
			comment.setMessageFId(rsComment.getInt("MessageFId"));
			
			
			commentList.add(comment);
		}
		return commentList;
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
  	  
  	  return commentList;
  	  
    }
    
   
    /**
     * This method is used for getting message record by message id
     * @param id Id of Message Post
     * @return 
     */
    public MessageBean getMessageById(int id)   // This method is used for getting message record by message id
    {
    	tm = new TransactionManager();
    	MessageBean message = new MessageBean();
    	
  	  
  	  
  	  
  	  String queryPost = "select * from messagepost where Id="+id+"";
  	  
  	  ResultSet rsPost = tm.check(queryPost);
  	  
  	try 
	{
		if(rsPost.next())
		{
			
			// Message record from table 'messagepost' is set in MessageBean object
			message.setEmailFId(rsPost.getString("EmailFId"));
			message.setImageFId(rsPost.getInt("ImageFId"));
			message.setDate(rsPost.getDate("Date"));
			message.setId(rsPost.getInt("Id"));
			message.setTime(rsPost.getTime("Time"));
			message.setMessage(rsPost.getString("Message"));
			message.setCategory(rsPost.getString("Category"));
			message.setRecFId(rsPost.getString("RecFId"));
			message.setStatus(rsPost.getString("Status"));
			
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
			{
				rsPost.close();
				tm.closeConnection();
			}
		}
		catch(SQLException ex)
		{
			ex.printStackTrace();
		}
	}
	
				  return message;
  	  
  	 
				
			 
    }
    
   
    /**
     * This method is used for getting message record by message id and category from 'messagepost' table
     * @param id Id of Message Post
     * @param category Category of message such as sports, history, entertainment etc.
     * @return
     */
    public MessageBean getMessageByIdAndCategory(int id, String category)
    {
    	 // This method is used for getting message record by message id and category from 'messagepost' table
    	
    	tm = new TransactionManager();
    	MessageBean message = new MessageBean();
    	
  	  
  	  
  	  
  	  String queryPost = "select * from messagepost where Id="+id+" and Category='"+category+"'";
  	  
  	  ResultSet rsPost = tm.check(queryPost);
  	  
  	try 
	{
		if(rsPost.next())
		{
			
			// Message record from table 'messagepost' is set in MessageBean object
			message.setEmailFId(rsPost.getString("EmailFId"));
			message.setImageFId(rsPost.getInt("ImageFId"));
			message.setDate(rsPost.getDate("Date"));
			message.setId(rsPost.getInt("Id"));
			message.setTime(rsPost.getTime("Time"));
			message.setMessage(rsPost.getString("Message"));
			message.setCategory(rsPost.getString("Category"));
			message.setRecFId(rsPost.getString("RecFId"));
			message.setStatus(rsPost.getString("Status"));
			
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
			{
				rsPost.close();
				tm.closeConnection();
			}
		}
		catch(SQLException ex)
		{
			ex.printStackTrace();
		}
	}
	
				  return message;
  	  
  	 
				
			 
    }
    
   
    /**
     * This method is used to get Like records for user from 'messagelikes' table for all messages liked by user
     * @param email
     * @return
     */
    public ArrayList<MessageLikeBean> getLikedPosts(String email)
    {
    	// This method is used to get Like records for user from 'messagelikes' table for all messages liked by user
    	
    	tm = new TransactionManager();
    	
    	ArrayList<MessageLikeBean> likeList = new ArrayList<MessageLikeBean>();
    	
    	String query = "select * from messagelikes where EmailFId='"+email+"' order by Date desc,Time desc";
    	
    	ResultSet rs = tm.check(query);
    	
    	try 
    	{
    		while(rs.next())
    		{
    			MessageLikeBean like = new MessageLikeBean();
    			like.setEmailFId(rs.getString("EmailFId"));
    			like.setMessageFId(rs.getInt("MessageFId"));
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
    
    
    /**
     * This method is used to get all messages from 'messagepost' table ordered by date
     * @return
     */
    public ArrayList<MessageBean> getAllMessages() // This method is used to get all messages from 'messagepost' table ordered by date
    {
    	tm = new TransactionManager();
    	
    	ArrayList<MessageBean> postList = new ArrayList<MessageBean>();
    	String query = "select * from messagepost order by Date";
    	System.out.println("FriendsDAO: "+query);
    	
    	
    		
     	    ResultSet rs = tm.check(query);
     	    
     	    
     	   try 
	    	{
				while(rs.next())
				{
					
					// Message records from table 'messagepost' is set in MessageBean object
					MessageBean post = new MessageBean();
					post.setEmailFId(rs.getString("EmailFId"));
					post.setMessage(rs.getString("Message"));
					post.setTime(rs.getTime("Time"));
					post.setId(rs.getInt("Id"));
					post.setImageFId(rs.getInt("ImageFId"));
					post.setDate(rs.getDate("Date"));
					post.setCategory(rs.getString("Category"));
					post.setRecFId(rs.getString("RecFId"));
					post.setStatus(rs.getString("Status"));
					
					postList.add(post);
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
	    	
	    	   return postList;
     	    
    	   
    	
    	    	
    }
    
   
    /**
     * This method is used to delete all messages from 'messagepost' table posted by particular user
     * @param email
     * @return
     */
    public int deleteMessages(String email) // This method is used to delete all messages from 'messagepost' table posted by particular user
	{
		tm = new TransactionManager();
		String selectQuery = "select * from messagepost where EmailFId='"+email+"'";
		
		int deletedMessages = 0;
		ArrayList<Integer> messIdList = new ArrayList<Integer>();
		
		ResultSet rsMess = tm.check(selectQuery);
		int messId = 0;
		int count = 0;
		
		try 
		{
			while(rsMess.next())
			{
				messId = Integer.parseInt(rsMess.getString("Id"));
				
				messIdList.add(messId);
				
				
			}
			
			tm.closeConnection();
			
			while(count < messIdList.size())
			{
				messId =messIdList.get(count);
				
				
		    	int likesDeleted = deleteMessageLikes(messId);
		    	
		    	System.out.println("Number of Message Likes Deleted: "+likesDeleted);
		    	
		    	
		    	int commentsDeleted = deleteComments(messId);
		    	
		    	System.out.println("Number of Message Comments Deleted: "+commentsDeleted);
				
		    	
		    	count++;
			}
			
			tm = new TransactionManager();
			String query = "delete from messagepost where EmailFId='"+email+"'";
			
			deletedMessages = tm.check1(query);
			
			System.out.println("Messages deleted in deleteMessages: "+deletedMessages);
			
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		finally
    	{
    		try
    		{
    			if(rsMess!=null)
    			{
    				rsMess.close();
    				tm.closeConnection();
    			}
    		}
    		catch(SQLException ex)
    		{
    			ex.printStackTrace();
    		}
    	}
		
		return deletedMessages;
		
	}
    
    /**
     * This method is used to get all messages from 'messagepost' table of specific category posted by particular user
     * @param email
     * @param category Category of message such as sports, history, entertainment etc.
     * @return
     */
    public ArrayList<MessageBean> getMessagesByCategory(String email, String category)
    {
    	// This method is used to get all messages from 'messagepost' table of specific category posted by particular user
    	
    	tm = new TransactionManager();
    	
    	ArrayList<MessageBean> messList = new ArrayList<MessageBean>();
  	  
  	  
  	  String queryPost = "select * from messagepost where EmailFId='"+email+"' order by Date desc,Time desc";
  	  
  	  ResultSet rsPost = tm.check(queryPost);
  	  
  	  
  	  
  	try 
	{
		while(rsPost.next())
		{
			// Message record from table 'messagepost' is set in MessageBean object
			
			int count = 0;
			
			String categories = rsPost.getString("Category");
			
			String arrCategories[] = categories.split(",");
			
			
			
			while(count < arrCategories.length)
			{
				
				if(arrCategories[count].equals(category))
				{
					MessageBean message = new MessageBean();
					message.setEmailFId(rsPost.getString("EmailFId"));
					message.setImageFId(rsPost.getInt("ImageFId"));
					message.setDate(rsPost.getDate("Date"));
					message.setId(rsPost.getInt("Id"));
					message.setTime(rsPost.getTime("Time"));
					message.setMessage(rsPost.getString("Message"));
					message.setCategory(arrCategories[count]);
					message.setRecFId(rsPost.getString("RecFId"));
					message.setStatus(rsPost.getString("Status"));

					messList.add(message);
					
					break;
					
					
				}
				
				count++;
				
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
			if(rsPost!=null)
			{
				rsPost.close();
				tm.closeConnection();
			}
		}
		catch(SQLException ex)
		{
			ex.printStackTrace();
		}
	}
	
				  return messList;
			 
    }
    
    
    public CategoryCounts getMessagesCategoryCount(String email)
    {
    	// This method is used to get all messages from 'messagepost' table of specific category posted by particular user
    	
    	tm = new TransactionManager();
    	
    	 String queryPost = "select * from messagepost where EmailFId='"+email+"'";
     	  
     	  ResultSet rsPost = tm.check(queryPost);
     	  
     	 int sportsCount = 0;
     	
     	int educationCount = 0;
     	
     	int entertainmentCount = 0;
     	
     	int historyCount = 0;
     	
     	int politicsCount = 0;
     	
     	
     	

     	  
     	 CategoryCounts counts = new CategoryCounts();
     	  
     	 try 
     	 {
			while(rsPost.next())
			{
				
				
				int politicsFlag = 0;
		     	
		     	int educationFlag = 0;
		     	
		     	int entertainmentFlag = 0;
		     	
		     	int historyFlag = 0;
		     	
		     	int sportFlag = 0;
		     	
				
				String categories = rsPost.getString("Category");
				
				String categoryArray[] = categories.split(",");
				
				System.out.println("Categories : "+categoryArray);
				
				int count = 0;
				
				while(count <categoryArray.length)
				{
					
					String category = categoryArray[count];
					
					
					if(category.equals("politics"))
					{
						if(politicsFlag == 0)
						{
						   politicsCount++;
						
						    politicsFlag = 1;
						    
						}
					}
					
					else if(category.equals("education"))
					{
						if(educationFlag == 0)
						{
							educationCount++;

							educationFlag = 1;
						}
					}
					else if(category.equals("history"))
					{
						if(historyFlag == 0)
						{
							historyCount++;

							historyFlag = 1;
						
						}
					}
					else if(category.equals("entertainment"))
					{
						
						if(entertainmentFlag == 0)
						{
							entertainmentCount++;

							entertainmentFlag = 1;

						}
					}
					else if(category.equals("sports"))
					{
						
						if(sportFlag == 0)
						{
							sportsCount++;

							sportFlag = 1;
						
						}
					}
					count++;
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
    			if(rsPost!=null)
    			{
    				rsPost.close();
    				tm.closeConnection();
    			}
    		}
    		catch(SQLException ex)
    		{
    			ex.printStackTrace();
    		}
    	}
     	 
     	 
     	 counts.setEducationCount(educationCount);
     	 
     	 counts.setEntertainmentCount(entertainmentCount);
     	 
     	 counts.setHistoryCount(historyCount);
     	 
     	 counts.setPoliticsCount(politicsCount);
     	 
     	 counts.setSportsCount(sportsCount);
     	 
     	 return counts;
    	
    }
    
    
}
