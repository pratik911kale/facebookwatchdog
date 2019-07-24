package social.network;

public class UtilityPhone
{
	
    public static boolean numberOrNot(String input)
    {
        try
        {
            Long.parseLong(input);
        }
        catch(NumberFormatException ex)
        {
        	ex.printStackTrace();
            return false;
        }
        return true;
    }
}
