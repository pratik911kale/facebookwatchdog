package social.dao;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import social.bean.FriendRequest;
import social.bean.ImageBean;
import social.network.TransactionManager;

public class ImagesDAO 
{
   TransactionManager tm = null;
    
    public ImagesDAO()
    {
    	
    }
    
    /**
     * This method is used to check whether image is uploaded by user 
     * @param email
     * @param imageName
     * @return
     */
    public String selectImage(String email, String imageName) // This method is used to check whether image is uploaded by user 
    {
    	
    	tm = new TransactionManager();
    	
    	String query = "select * from images where EmailFId='"+email+"' and ImageName='"+imageName+"'";
    	String result="no";
    	
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
     * This method is used to get all Images uploaded by user from 'images' table ordered by date and time
     * @param emailFId
     * @return
     */
    public ArrayList<ImageBean> selectImages(String emailFId)
    {
    	 // This method is used to get all Images uploaded by user from 'images' table ordered by date and time
    	
    	tm = new TransactionManager();
    	
    	ArrayList<ImageBean> imageList = new ArrayList<ImageBean>();
    	
    	String query = "select * from images where EmailFId='"+emailFId+"' order by Date desc,Time desc";
    	System.out.println("ImagesDAO: "+query);
    	
    	
    		
     	    ResultSet rs = tm.check(query);
     	    
     	   try 
	    	{
				while(rs.next())
				{
					// Set Image information from 'images' table into ImageBean object
					
					ImageBean image = new ImageBean();
					image.setEmailFId(rs.getString("EmailFId"));
					image.setImageName(rs.getString("ImageName"));
					image.setTime(rs.getTime("Time"));
					image.setId(rs.getInt("Id"));
					image.setMessageFId(rs.getInt("MessageFId"));
					image.setDate(rs.getDate("Date"));
					
					imageList.add(image);
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
	    	
	    	   return imageList;
     	    
     	    
    	   
    	
    	    	
    }
    
    /**
     * This method is used to insert  image record into 'images' table
     * @param image  Image information object
     * @return
     */
    public int insertImage(ImageBean image)  // This method is used to insert  image record into 'images' table
    {
    	tm = new TransactionManager();
    	String query1 = "insert into images(Id,ImageName,EmailFId,Time,Date,MessageFId) values("+image.getId()+",'"+image.getImageName()+"','"+image.getEmailFId()+"','"+image.getTime()+"','"+image.getDate()+"',"+image.getMessageFId()+")";
    	
    	int result = tm.check1(query1);
    	tm.closeConnection();
    	return result;
    }
	
   
    /**
     * This method is used to delete  image record from 'images' table
     * @param image Image information  
     * @return
     */
    public int deleteImage(ImageBean image)  // This method is used to delete  image record from 'images' table
    {
    	
    	String query = "delete from images where EmailFId='"+image.getEmailFId()+"' and ImageName='"+image.getImageName()+"'";
    	
    	int imageId = getImageId(image.getImageName(), image.getEmailFId());
    	
    	LikesDAO daoLikes = new LikesDAO();
    	int likesDeleted = daoLikes.deleteLikes(imageId);
    	
    	System.out.println("Number of Likes Deleted: "+likesDeleted);
    	
    	CommentDAO daoComments = new CommentDAO();
    	int commentsDeleted = daoComments.deleteComments(imageId);
    	
    	System.out.println("Number of Comments Deleted: "+commentsDeleted);
    	
    	int messageFId = image.getMessageFId();
    	if(messageFId!=0)
    	{
    		MessageDAO daoMess = new MessageDAO();
    		int deleted = daoMess.deleteMessage(messageFId);
    		System.out.println("Message deleted in deleteimage: "+deleted);
    	}
    	
    	tm = new TransactionManager();
    	int result = tm.check1(query);
    	tm.closeConnection();
    	
    	if(result == 1)
    		return 1;
    	else
    	    return 0;
    }
    
 
    /**
     * This method is used to get  image Id for particular image
     * @param imageName
     * @param email
     * @return
     */
    public int getImageId(String imageName, String email) // This method is used to get  image Id for particular image
    {
    	tm = new TransactionManager();
    	String query = "select * from images where EmailFId='"+email+"' and ImageName='"+imageName+"'";
    	
    	ResultSet rs = tm.check(query);
    	try 
    	{
    		System.out.println(".............getImageId in ImagesDAO: ");
			if(rs.next())
			{
				System.out.println(".............getImageId in ImagesDAO: "+rs.getInt("Id"));
				return rs.getInt("Id");
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
    	return 0;
    }
    
   
    /**
     * This method is used to get all images records ordered by date
     * @return Images objects taken from table
     */
    public ArrayList<ImageBean> getImages() // This method is used to get all images records ordered by date
    {
    	tm = new TransactionManager();
    	
    	ArrayList<ImageBean> imageList = new ArrayList<ImageBean>();
    	String query = "select * from images order by Date";
    	System.out.println("FriendsDAO: "+query);
    	
    	
    		
     	    ResultSet rs = tm.check(query);
     	    
     	    
     	   try 
	    	{
				while(rs.next())
				{
					// Set Images information from 'images' table into ImageBean objects
					
					ImageBean image = new ImageBean();
					image.setEmailFId(rs.getString("EmailFId"));
					image.setImageName(rs.getString("ImageName"));
					image.setTime(rs.getTime("Time"));
					image.setId(rs.getInt("Id"));
					image.setMessageFId(rs.getInt("MessageFId"));
					image.setDate(rs.getDate("Date"));
					
					imageList.add(image);
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
	    	
	    	   return imageList;
     	    
    	   
    	
    	    	
    }
    
 
    /**
     * This method is used to get  image with particular image Id
     * @param imageId Id of Image
     * @return
     */
	public ImageBean getImageById(int imageId) // This method is used to get  image with particular image Id
	{
		tm = new TransactionManager();
		ImageBean image = new ImageBean();
    	//ArrayList<ImageBean> imageList = new ArrayList<ImageBean>();
		
		String query = "select * from images where Id="+imageId+"";
		
		ResultSet rs = tm.check(query);
		
		try 
    	{
			if(rs.next())
			{
				// Set Image information from 'images' table into ImageBean object
				image.setEmailFId(rs.getString("EmailFId"));
				image.setImageName(rs.getString("ImageName"));
				image.setTime(rs.getTime("Time"));
				image.setId(rs.getInt("Id"));
				image.setMessageFId(rs.getInt("MessageFId"));
				image.setDate(rs.getDate("Date"));
				
				//imageList.add(image);
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
    	
    	   return image;
	}
	
	/**
	 * This method is used to get  Message Id for particular image
	 * @param imageId Id of Image
	 * @return
	 */
	public int getMessageId(int imageId) // This method is used to get  Message Id for particular image
	{
		tm = new TransactionManager();
		String query = "select * from images where Id="+imageId+"";
		ResultSet rs = tm.check(query);
		int messId = 0;
		try 
    	{
		  if(rs.next())
		  {
			messId = rs.getInt("MessageFId");
			
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
    	
		return messId;
		
	}
	
	
	/**
	 * This method is used to delete  records of images for particular user
	 * @param email
	 * @return
	 */
	public int deleteImages(String email) // This method is used to delete  records of images for particular user
	{
		tm = new TransactionManager();
		String selectQuery = "select * from images where EmailFId='"+email+"'";
		
		int deletedimages = 0;
		ArrayList<Integer> imageIdList = new ArrayList<Integer>();
		
		ResultSet rsimages = tm.check(selectQuery);
		int imageId = 0;
		int count = 0;
		
		try 
		{
			while(rsimages.next())
			{
				imageId = Integer.parseInt(rsimages.getString("Id"));
				
				imageIdList.add(imageId);
				
				
			}
			
			tm.closeConnection();
			
			while(count < imageIdList.size())
			{
				imageId = imageIdList.get(count);
				
				LikesDAO daoLikes = new LikesDAO();
		    	int likesDeleted = daoLikes.deleteLikes(imageId);
		    	
		    	System.out.println("Number of Likes Deleted: "+likesDeleted);
		    	
		    	CommentDAO daoComments = new CommentDAO();
		    	int commentsDeleted = daoComments.deleteComments(imageId);
		    	
		    	System.out.println("Number of Comments Deleted: "+commentsDeleted);
				
		    	int messId = getMessageId(imageId);
		    	
		    	if(messId!=0)
		    	{
		    		MessageDAO daoMess = new MessageDAO();
		    		int deleted = daoMess.deleteMessage(messId);
		    		System.out.println("Message deleted in deleteimages: "+deleted);
		    	}
		    	count++;
			}
			
			tm = new TransactionManager();
			String query = "delete from images where EmailFId='"+email+"'";
			
			deletedimages = tm.check1(query);
			
			System.out.println("images deleted in deleteimages: "+deletedimages);
			
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		finally
    	{
    		try
    		{
    			if(rsimages!=null)
    			{
    				rsimages.close();
    				tm.closeConnection();
    			}
    		}
    		catch(SQLException ex)
    		{
    			ex.printStackTrace();
    		}
    	}
		
		return deletedimages;
		
	}
	
	
	/**
	 * This method is used to get all images having Message images ordered by date and time
	 * @param emailFId
	 * @return
	 */
	public ArrayList<ImageBean> selectImagesForCategory(String emailFId)
    {
		// This method is used to get all images having Message images ordered by date and time
    	tm = new TransactionManager();
    	
    	ArrayList<ImageBean> imageList = new ArrayList<ImageBean>();
    	
    	String query = "select * from images where EmailFId='"+emailFId+"' and MessageFId!=0 order by Date desc,Time desc";
    	System.out.println("FriendsDAO: "+query);
    	
    	
    		
     	    ResultSet rs = tm.check(query);
     	    
     	   try 
	    	{
				while(rs.next())
				{
					
					// Set Image information from 'images' table into ImageBean object
					ImageBean image = new ImageBean();
					image.setEmailFId(rs.getString("EmailFId"));
					image.setImageName(rs.getString("ImageName"));
					image.setTime(rs.getTime("Time"));
					image.setId(rs.getInt("Id"));
					image.setMessageFId(rs.getInt("MessageFId"));
					image.setDate(rs.getDate("Date"));
					
					imageList.add(image);
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
	    	
	    	   return imageList;
     	    
     	    
    	   
    	
    	    	
    }
}
