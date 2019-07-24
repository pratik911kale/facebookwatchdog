package social.bean;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.sql.Timestamp;

public class FriendRequest 
{
       int id;
       String email1;
       String email2;
       Timestamp date;
       
       public int getId()
       {
    	   return id;
       }
       
       public void setId(int id)
       {
    	   this.id = id;
       }
       
       public String getEmail1()
       {
    	   return email1;
       }
       
       public void setEmail1(String email1)
       {
    	   this.email1 = email1;
       }
       
       public String getEmail2()
       {
    	   return email2;
       }
       
       public void setEmail2(String email2)
       {
    	   this.email2 = email2;
       }
       
       public Timestamp getDate()
       {
    	   return date;
       }
       
       public void setDate(Timestamp date)
       {
    	   this.date = date;
       }
}



