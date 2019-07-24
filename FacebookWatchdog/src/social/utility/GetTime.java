package social.utility;

public class GetTime 
{
	
	/**
	 * This method returns current system time in Time object
	 * @return
	 */
	public static java.sql.Time getCurrentTimeStamp()
	{

		java.util.Date today = new java.util.Date();
		return new java.sql.Time(today.getTime());

	}
	
	/**
	 * This method returns current system time in Timestamp object
	 * @return
	 */
	public static java.sql.Timestamp getCurrentTimeStamp1()
	{

		java.util.Date today = new java.util.Date();
		return new java.sql.Timestamp(today.getTime());

	}
}
