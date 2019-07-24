package social.bean;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class MessageLikeBean
{

	int id;
    String emailFId;
    int messageFId;
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
    
    public int getMessageFId()
    {
   	 System.out.println("getMessageFId in messagelikebean: "+messageFId);
   	 return messageFId;
    }
    
    public void setMessageFId(int messageFId)
    {
   	 System.out.println("setMessageFId in messagelikebean: "+messageFId);
   	 this.messageFId = messageFId;
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
