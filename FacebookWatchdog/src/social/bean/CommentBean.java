package social.bean;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class CommentBean 
{
      int id;
      int imageFId;
      String emailFId;
      String comment;
      Time time;
      Date date;
      String status;
      
      public int getId()
      {
     	 return id;
      }
      
      public void setId(int id)
      {
     	 this.id = id;
      }
      
      public int getImageFId()
      {
     	 System.out.println("getPostFId in commentbean: "+imageFId);
     	 return imageFId;
      }
      
      public void setImageFId(int imageFId)
      {
     	 System.out.println("setPostFId in commentbean: "+imageFId);
     	 this.imageFId = imageFId;
      }
      
      
      
      public String getEmailFId()
      {
     	 return emailFId;
      }
      
      public void setEmailFId(String emailFId)
      {
     	 this.emailFId = emailFId;
      }
      
      public String getComment()
      {
     	 return comment;
      }
      
      public void setComment(String comment)
      {
     	 this.comment = comment;
      }
      
      public Time getTime()
      {
   	   return time;
      }
      
      public void setTime(Time time)
      {
   	   this.time = time;
      }
      
      public Date getDate()
      {
     	 return date;
      }
      
      public void setDate(Date date)
      {
     	 this.date = date;
      }
      
      public String getStatus()
      {
     	 return status;
      }
      
      public void setStatus(String status)
      {
     	 this.status = status;
      }
}
