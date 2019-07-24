package social.utility;

import java.io.File;

public class FolderOperations 
{

	/**
	 * This method deletes folder at appPath
	 * @param email
	 * @param appPath
	 * @return
	 */
	public int deleteFolder(String email, String appPath)
	{
		 
		 int result = 0;
		String savePath = appPath + File.separator + "images2" + File.separator + email;
		
		File file = new File(savePath);
		
		if(file.delete())
		   {
			   System.out.println("Folder deleted....");
			   result = 1;
		   }
		
		return result;
        
	}
	
}
