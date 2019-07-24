package social.bean;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class LikeBean 
{
     int id;
     String emailFId;
     int imageFId;
     Time time;
     Date date;
     
     public int getId()
     {
    	 return id;
     }
     
     public void setId(int id)
    
     {
    	 
    	 this.id = id;
     }
     
     public String getEmailFId()
     {
    	 return emailFId;
     }
     
     public void setEmailFId(String emailFId)
     {
    	 this.emailFId = emailFId;
     }
     
     public int getImageFId()
     {
    	 System.out.println("getImageFId in likebean: "+imageFId);
    	 return imageFId;
     }
     
     public void setImageFId(int imageFId)
     {
    	 System.out.println("setPostFId in likebean: "+imageFId);
    	 this.imageFId = imageFId;
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
}
