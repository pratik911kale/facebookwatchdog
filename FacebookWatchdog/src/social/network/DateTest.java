package social.network;

import java.text.SimpleDateFormat;
import java.text.ParseException;
 
public class DateTest 
{
 
  public boolean isValidDate(String inDate) 
  {
 
   
 
    //set the format to use as a constructor argument
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-mm-yyyy");
    System.out.println(inDate.trim()+"Date Test "+inDate.trim().length());
    System.out.println(dateFormat.toPattern()+" : "+dateFormat.toPattern().length());
    
    if (inDate.trim().length() != dateFormat.toPattern().length()) {
        return false;

    }
 
    dateFormat.setLenient(false);
    
    try
    {
      //parse the inDate parameter
      dateFormat.parse(inDate.trim());
    }
    catch (ParseException pe)
    {
    		pe.printStackTrace();
      return false;
    }
    return true;
  }
  public static void main(String[] args) {
	  DateTest test = new DateTest();
	  System.out.println("Resutl "+test.isValidDate("2015-11-22"));
  }
}