package social.bean;

import java.sql.Date;
import java.sql.Time;

public class Warning 
{

	int id;
	String emailFId;
	String message;
	String category;
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
	    
	
}
