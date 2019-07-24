package social.bean;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class MessageBean 
{

	int id;
    
    String emailFId;
    String message;
    Time time;
    Date date;
    String category;
    String recFId;
    int imageFId;
    String status;
    
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
    
    public String getMessage()
    {
   	 return message;
    }
    
    public void setMessage(String message)
    {
   	 this.message = message;
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
    
    public String getCategory()
    {
   	 return category;
    }
    
    public void setCategory(String category)
    {
   	 this.category = category;
    }
    
    public String getRecFId()
    {
   	 return recFId;
    }
    
    public void setRecFId(String recFId)
    {
   	 this.recFId = recFId;
    }
    
    
    public int getImageFId()
    {
   	 return imageFId;
    }
    
    public void setImageFId(int imageFId)
    {
   	 this.imageFId = imageFId;
    }
    
    public void setStatus(String status)
    {
   	 this.status = status;
    }
    
    public String getStatus()
    {
   	 return status;
    }
	
}
