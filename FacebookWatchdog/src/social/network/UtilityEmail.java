package social.network;

public class UtilityEmail 
{
	
	/**
	 * This method checks whether email entered by user has correct pattern or not
	 * @param input
	 * @return
	 */
	public static boolean emailOrNot(String input)
    {
        
            if(input.matches("[a-zA-Z0-9\\.]+@[a-zA-Z0-9\\-\\_\\.]+\\.[a-zA-Z0-9]{3}"))
            {
                      return true;
            }
       
            else
            	return false;
       
    }

}
