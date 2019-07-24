package social.utility;
import social.bean.*;
import social.network.*;

import java.util.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;




public class IdDAO 
{
	TransactionManager tm = null;
    
    public IdDAO()
    {
    	
    }
    
    
     /**
      * This method is used to generate and return Id for 'requests' table
      * @return
      */
     public int getRequestId()
     {
    	 tm = new TransactionManager();
    	 String query1 = "select COUNT(*) from friendrequests";
    	 ResultSet rs1 = tm.check(query1);
    	 
    	 try
    	 {
    	  if(rs1.next())
    	  {
    	 
    	    String query = "select max(Id) from friendrequests";
    	
    	    ResultSet rs = tm.check(query);
    	
    	    try
    	    {
    	       if(rs.next())
    	       {
    	           return rs.getInt(1); 
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
    				
    			   }
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
 			   {
 				rs1.close();
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
      * This method is used to generate and return Id for 'images' table
      * @return
      */
     public int getPostId()
     {
    	 tm = new TransactionManager();
    	 int max = 0; 
    	 int i, j, z, value=0;
    	 int []postId;
    	 String query1 = "select COUNT(*) from images";
    	 String querySort = "select Id from images ORDER BY Id";
    	 
    	 ResultSet rs1 = tm.check(query1);
    	 
    	 try
    	 {
    	  if(rs1.next())
    	  {
    	     int k = rs1.getInt(1);
    	    String query = "select max(Id) from images";
    	
    	    ResultSet rs = tm.check(query);
    	
    	    try
    	    {
    	       if(rs.next())
    	       {
    	    	   j=0;
    	          max = rs.getInt(1);
    	          
    	          postId = new int[k];
    	          
    	          ResultSet rsSort = tm.check(querySort);
    	          while(rsSort.next())
    	          {
    	        	 postId[j] = rsSort.getInt("Id");
    	        	 j++;
    	          }
    	          
    	          for(i=0;i<j;i++)
    	          {
    	        	  z = value + 1;
    	        	  while(z<=postId[i])
    	        	  {
    	        		  if(z!=postId[i])
    	        			  return z;
    	        		  z++;
    	        	  }
    	        	  value = postId[i];
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
    	  else
    		  return max+1;
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
 			   {
 				rs1.close();
 				tm.closeConnection();
 			   }
 			} 
 			catch(SQLException e)
 			{
 					
 					e.printStackTrace();
 			}
 		}
    	 
		return max+1;
     }
     
     
     /**
      * This method is used to generate and return Id for 'comments' table
      * @return
      */
     public int getCommentId()
     {
    	 tm = new TransactionManager();
    	 int max = 0; 
    	 int i, j, z, value=0;
    	 int []commentId;
    	 
    	 String query3 = "select Id from comments";
    	 String query1 = "select COUNT(*) from comments";
    	 String querySort = "select Id from comments ORDER BY Id";
    	 
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
    	          String query = "select max(Id) from comments";
    	
    	          ResultSet rs = tm.check(query);
    	
    	          try
    	          {
    	             if(rs.next())
    	             {
    	    	        j=0;
    	                max = rs.getInt(1);
    	          
    	                commentId = new int[k];
    	          
    	                ResultSet rsSort = tm.check(querySort);
    	                while(rsSort.next())
    	                {
    	        	        commentId[j] = rsSort.getInt("Id");
    	        	        j++;
    	                }
    	          
    	                for(i=0;i<j;i++)
    	                {
    	        	        z = value + 1;
    	        	       while(z<=commentId[i])
    	        	       {
    	        		      if(z!=commentId[i])
    	        			  return z;
    	        		      z++;
    	        	       }
    	        	       value = commentId[i];
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
        System.out.println("In IdDAO: "+y);
    	 
		return max+1;
     }
     
     /**
      * This method is used to generate and return Id for 'likes' table
      * @return
      */
     public int getLikeId()
     {
    	 tm = new TransactionManager();
    	 int max = 0; 
    	 int i, j, z, value=0;
    	 int []likeId;
    	 
    	 String query3 = "select Id from likes";
    	 String query1 = "select COUNT(*) from likes";
    	 String querySort = "select Id from likes ORDER BY Id";
    	 
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
    	          String query = "select max(Id) from likes";
    	
    	          ResultSet rs = tm.check(query);
    	
    	          try
    	          {
    	             if(rs.next())
    	             {
    	    	        j=0;
    	                max = rs.getInt(1);
    	          
    	                likeId = new int[k];
    	          
    	                ResultSet rsSort = tm.check(querySort);
    	                while(rsSort.next())
    	                {
    	        	        likeId[j] = rsSort.getInt("Id");
    	        	        j++;
    	                }
    	          
    	                for(i=0;i<j;i++)
    	                {
    	        	        z = value + 1;
    	        	       while(z<=likeId[i])
    	        	       {
    	        		      if(z!=likeId[i])
    	        			  return z;
    	        		      z++;
    	        	       }
    	        	       value = likeId[i];
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
        System.out.println("In IdDAO: "+y);
    	 
		return max+1;
     }
     
     
     /**
      * This method is used to generate and return Id for 'messagepost' table
      * @return
      */
     public int getMessageId()
     {
    	 tm = new TransactionManager();
    	 int max = 0; 
    	 int i, j, z, value=0;
    	 int []messageId;
    	 
    	 String query3 = "select Id from messagepost";
    	 String query1 = "select COUNT(*) from messagepost";
    	 String querySort = "select Id from messagepost ORDER BY Id";
    	 
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
    	          String query = "select max(Id) from messagepost";
    	
    	          ResultSet rs = tm.check(query);
    	
    	          try
    	          {
    	             if(rs.next())
    	             {
    	    	        j=0;
    	                max = rs.getInt(1);
    	          
    	                messageId = new int[k];
    	          
    	                ResultSet rsSort = tm.check(querySort);
    	                while(rsSort.next())
    	                {
    	        	        messageId[j] = rsSort.getInt("Id");
    	        	        j++;
    	                }
    	          
    	                for(i=0;i<j;i++)
    	                {
    	        	        z = value + 1;
    	        	       while(z<=messageId[i])
    	        	       {
    	        		      if(z!=messageId[i])
    	        			  return z;
    	        		      z++;
    	        	       }
    	        	       value = messageId[i];
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
        System.out.println("In IdDAO: "+y);
    	 
		return max+1;
     }
     
     
     /**
      * This method is used to generate and return Id for 'messagelikes' table
      * @return
      */
     public int getMessageLikeId()
     {
    	 tm = new TransactionManager();
    	 int max = 0; 
    	 int i, j, z, value=0;
    	 int []likeId;
    	 
    	 String query3 = "select Id from messagelikes";
    	 String query1 = "select COUNT(*) from messagelikes";
    	 String querySort = "select Id from messagelikes ORDER BY Id";
    	 
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
    	          String query = "select max(Id) from messagelikes";
    	
    	          ResultSet rs = tm.check(query);
    	
    	          try
    	          {
    	             if(rs.next())
    	             {
    	    	        j=0;
    	                max = rs.getInt(1);
    	          
    	                likeId = new int[k];
    	          
    	                ResultSet rsSort = tm.check(querySort);
    	                while(rsSort.next())
    	                {
    	        	        likeId[j] = rsSort.getInt("Id");
    	        	        j++;
    	                }
    	          
    	                for(i=0;i<j;i++)
    	                {
    	        	        z = value + 1;
    	        	       while(z<=likeId[i])
    	        	       {
    	        		      if(z!=likeId[i])
    	        			  return z;
    	        		      z++;
    	        	       }
    	        	       value = likeId[i];
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
        System.out.println("In IdDAO: "+y);
    	 
		return max+1;
     }
     
     
     /**
      * This method is used to generate and return Id for 'messagecomments' table
      * @return
      */
     public int getMessageCommentId()
     {
    	 tm = new TransactionManager();
    	 int max = 0; 
    	 int i, j, z, value=0;
    	 int []commentId;
    	 
    	 String query3 = "select Id from messagecomments";
    	 String query1 = "select COUNT(*) from messagecomments";
    	 String querySort = "select Id from messagecomments ORDER BY Id";
    	 
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
    	          String query = "select max(Id) from messagecomments";
    	
    	          ResultSet rs = tm.check(query);
    	
    	          try
    	          {
    	             if(rs.next())
    	             {
    	    	        j=0;
    	                max = rs.getInt(1);
    	          
    	                commentId = new int[k];
    	          
    	                ResultSet rsSort = tm.check(querySort);
    	                while(rsSort.next())
    	                {
    	        	        commentId[j] = rsSort.getInt("Id");
    	        	        j++;
    	                }
    	          
    	                for(i=0;i<j;i++)
    	                {
    	        	        z = value + 1;
    	        	       while(z<=commentId[i])
    	        	       {
    	        		      if(z!=commentId[i])
    	        			  return z;
    	        		      z++;
    	        	       }
    	        	       value = commentId[i];
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
        System.out.println("In IdDAO: "+y);
    	 
		return max+1;
     }
}
