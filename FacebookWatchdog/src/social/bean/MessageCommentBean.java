package social.bean;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class MessageCommentBean 
{

	
	int id;
    int messageFId;
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
    
    public int getMessageFId()
    {
   	 System.out.println("getMessageFId in messagecommentbean: "+messageFId);
   	 return messageFId;
    }
    
    public void setMessageFId(int messageFId)
    {
   	 System.out.println("setMessageFId in messagecommentbean: "+messageFId);
   	 this.messageFId = messageFId;
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
    
    @Override
	public String toString() {
		return "MessageCommentBean [id=" + id + ", messageFId=" + messageFId
				+ ", emailFId=" + emailFId + ", comment=" + comment + ", time="
				+ time + ", date=" + date + ", status=" + status + "]";
	}

	public void setStatus(String status)
    {
   	 this.status = status;
    }
}
