package social.bean;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class ImageBean 
{
	 int id;
     String imageName;
     String emailFId;
     Time time;
     Date date;
     int messageFId;
     
     public int getId()
     {
    	 return id;
     }
     
     public void setId(int id)
     {
    	 this.id = id;
     }
     
     public String getImageName()
     {
    	 return imageName;
     }
     
     public void setImageName(String imageName)
     {
    	 this.imageName = imageName;
     }
     
     public String getEmailFId()
     {
    	 return emailFId;
     }
     
     public void setEmailFId(String emailFId)
     {
    	 this.emailFId = emailFId;
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
     
     
     public int getMessageFId()
     {
    	 return messageFId;
     }
     
     public void setMessageFId(int messageFId)
     {
    	 this.messageFId = messageFId;
     }
     
}
