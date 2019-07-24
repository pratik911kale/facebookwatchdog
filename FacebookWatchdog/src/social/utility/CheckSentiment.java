package social.utility;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

import com.classify.data.ClassifySentiment;
import com.classify.data.Sentiment;

public class CheckSentiment 
{

	
	/**
	 * This method returns sentiment of user message or comment such as crime, worst, riots or neutral
	 * @param comment  it can be user comment or posted message
	 * @return
	 */
	public String getScore(String comment, String appPath)
	{
		String finalScore = "neutral";
		 
		 String str = null;
		 String str1 = null;
		 
		 String basePath = appPath + File.separator + "FacebookTextFiles";
		 
		 ArrayList<String> arr1 = new ArrayList<String>();
		 
		 ArrayList<String> arr2 = new ArrayList<String>();
		 
		 ArrayList<String> arrCrime = new ArrayList<String>();
		 
		 BufferedReader textReader = null;
		 BufferedReader textReaderBad = null;
		 BufferedReader textReaderCrime = null;
		 
		 int noOfLines = 45;
		 int noOfLines1 = 458;
		 
		 int i, j;
		 String[] textData =new String[noOfLines];
		 String[] textDataBad =new String[noOfLines];
		 
		    
		    /*StringBuilder sbScore = Sentiment.getScoring(comment);
		    
		    String sentiment1 = sbScore.toString();
		    
		    int index = sentiment1.indexOf("sentiment");
		    
		    System.out.println("Index of Sentiment in Insert: "+index);
		    
		    int index1 = index + 13;
		    
		    System.out.println("Index of Result in Insert: "+index1);
		    
		    System.out.println("Sentiment of comment in Insert: "+sentiment1.substring(61, sentiment1.lastIndexOf('\"')));
		    
		    String score = sentiment1.substring(61, sentiment1.lastIndexOf('\"'));*/
		    
		    
		    
		    String sentiment = ClassifySentiment.classifySentiment(comment); // This method returns comment or message sentiment such as Right or Wrong


			try 
			{
				
				// Read notepad files data in different reader objects
				textReader = new BufferedReader(new FileReader(basePath + File.separator + "Sensitive.txt"));
				
				textReaderBad = new BufferedReader(new FileReader(basePath + File.separator + "badwords.txt"));
				
				textReaderCrime = new BufferedReader(new FileReader(basePath + File.separator + "Crime.txt"));
				
				
				
				// add words from text files into arraylist objects
				while((str=textReaderCrime.readLine())!=null)
				{
					arrCrime.add(str.toLowerCase());
					
					System.out.println("In Crime.txt: "+str.toLowerCase());
				}
				
				while((str=textReader.readLine())!=null)
				{
					arr1.add(str.toLowerCase());
				}
				
				while((str1=textReaderBad.readLine())!=null)
				{
					arr2.add(str1.toLowerCase());
				}
				
				
				for(i=0; i<arrCrime.size(); i++)
				{
					
					// check whether user message or comment contains criminal word
				   if(comment.contains(arrCrime.get(i)))
				   {
					      finalScore = "crime";
					  	System.out.println(".........Your message is: "+finalScore);
					      
					      break;
				   }
				   
				   
				}
				
				for(i=0; i<arr2.size(); i++)
				{
					
					// check whether user message or comment contains any worst type word
					if(comment.contains(arr2.get(i)))
						
					{
						  finalScore = "worst";
						  
						  break;
					}  
				}
				
				for(i=0; i<arr1.size(); i++)
				{
					
					for(j=0;j<arr2.size(); j++)
					{
						
						// check whether user message or comment contains any riots related word
					   if(comment.contains(arr1.get(i)) && comment.contains(arr2.get(j)))
					   {
						      finalScore = "riots";
						  	System.out.println(".........Your comment is: "+finalScore);
						      
						      break;
					   }
					   
					   
					}
				}
				
			} 
			catch (FileNotFoundException e) 
			{
				
				e.printStackTrace();
			}
			catch (IOException e) 
			{
				
				e.printStackTrace();
			}
			finally
			{
				try 
				{
					
					textReaderCrime.close();

					textReader.close();
					
					textReaderBad.close();
				} 
				catch (IOException e) 
				{
					
					e.printStackTrace();
				}
				
			}
			
			
			
			System.out.println(".........Your comment is: "+finalScore);
			
			
			
				// return sentiment of user message or comment
				
		        return sentiment+"*"+finalScore;
			
		
		
	}
	
	
}
