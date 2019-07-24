package com.classify.data;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

import social.utility.Category;

public class PostClass 
{

	/**
	 * This method is used for getting category of user message such as politics, entertainment, education, history or sports
	 * @param message
	 * @return
	 */
	public ArrayList<String> classifyPost(String message, String appPath)
	{
		
		String finalScore = "general";
		
		
		ArrayList<String> arrCategories = new  ArrayList<String>();
		 
		 String str = null;
		 String str1 = null;
		 
		 String basePath = appPath + File.separator + "FacebookTextFiles";
		 
		 ArrayList<String> arrPolitics = new ArrayList<String>();
		 
		 
		 
		 ArrayList<String> arrEducation = new ArrayList<String>();
		 
         ArrayList<String> arrHistorical = new ArrayList<String>();
		 
		 ArrayList<String> arrEntertainment = new ArrayList<String>();
		 
		 ArrayList<String> arrSports = new ArrayList<String>();
		 
		
		 // BufferedReader Object references are initialized
		 BufferedReader textReaderPolitics = null;
		 BufferedReader textReaderEducation = null;
		 
		 BufferedReader textReaderHistorical = null;
		 BufferedReader textReaderEntertainment = null; 
		 
		 BufferedReader textReaderSport = null; 
		
	//	 String messageNew = message.replaceAll("^ +| +$| (?= )", " ");
		 
		 String message1 = message.replaceAll("\\s+", " ");
		 
		 String messageNew = message1.trim();
		
		int i, j;
		
		try 
		{
			
			// Read text files into BufferedReader objects
			textReaderPolitics = new BufferedReader(new FileReader(basePath + File.separator + "Politics.txt"));
			
			textReaderEducation = new BufferedReader(new FileReader(basePath + File.separator + "Education.txt"));
			textReaderHistorical = new BufferedReader(new FileReader(basePath + File.separator + "Historical.txt"));
			textReaderEntertainment = new BufferedReader(new FileReader(basePath + File.separator + "Entertainment.txt"));
			
			textReaderSport = new BufferedReader(new FileReader(basePath + File.separator + "Sports.txt"));
			
			String category = Category.classify(messageNew);  // Message Category is obtained from these method
			
		
			arrCategories.add(category);
				
				
			while((str=textReaderSport.readLine())!=null) // check whether line read from text file is not null
			{
				arrSports.add(str.toLowerCase()); // add String from text file into ArrayList object
				
				System.out.println("In Sports.txt: "+str.toLowerCase());
			}
			
			textReaderSport.close();
			
			System.out.println("*******************************************************");
			
			System.out.println();
			
			System.out.println();
			
			System.out.println();
				
			while((str=textReaderPolitics.readLine())!=null) // check whether line read from text file is not null
			{
				arrPolitics.add(str.toLowerCase()); // add String from text file into ArrayList object
				
				System.out.println("In Politics.txt: "+str.toLowerCase());
			}
			
			textReaderPolitics.close();
			
			System.out.println("*******************************************************");
			
			System.out.println();
			
			System.out.println();
			
			System.out.println();
			
			while((str=textReaderEducation.readLine())!=null) // check whether line read from text file is not null
			{
				if(str.equals("BE") || str.equals("ME"))
					arrEducation.add(str); // add String from text file into ArrayList object
				else
				     arrEducation.add(str.toLowerCase()); // add String from text file into ArrayList object
				
				System.out.println("In Education.txt: "+str.toLowerCase());
			}
			
			textReaderEducation.close();
			
			System.out.println("*******************************************************");
			System.out.println();
			
			System.out.println();
			
			System.out.println();
			
			
			while((str=textReaderHistorical.readLine())!=null) // check whether line read from text file is not null
			{
				arrHistorical.add(str.toLowerCase()); // add String from text file into ArrayList object
				
				System.out.println("In Historical.txt: "+str.toLowerCase());
			}
			
			textReaderHistorical.close();
			
			System.out.println("*******************************************************");
			System.out.println();
			
			System.out.println();
			
			System.out.println();
			
			
			while((str=textReaderEntertainment.readLine())!=null) // check whether line read from text file is not null
			{
				arrEntertainment.add(str.toLowerCase()); // add String from text file into ArrayList object
				
				System.out.println("In Entertainment.txt: "+str.toLowerCase());
			}
			
			textReaderEntertainment.close();
			
			System.out.println("*******************************************************");
			System.out.println();
			
			System.out.println();
			
			System.out.println();
			
				
			
			for(i=0; i<arrSports.size(); i++)
			{
				
				// check whether Message contains word of text file
			   if(messageNew.contains(arrSports.get(i)))
			   {
				      finalScore = "sports";
				  	System.out.println(".........Your message is: "+finalScore);
				  	
				  	arrCategories.add(finalScore);
				      
				  
			   }
			   
			   
			}
			
			
				for(i=0; i<arrPolitics.size(); i++)
				{
					
					// check whether Message contains word of text file
				   if(messageNew.contains(arrPolitics.get(i)))
				   {
					      finalScore = "politics";
					  	System.out.println(".........Your message is: "+finalScore);
					  	
					  	arrCategories.add(finalScore);
					      
					   
				   }
				   
				   
				}
			
				for(i=0; i<arrEducation.size(); i++)
				{
					System.out.println("message.contains(arrEducation.get(i)): "+arrEducation.get(i)+" "+message.contains(arrEducation.get(i)));
					
					// check whether Message contains word of text file
				   if(messageNew.contains(arrEducation.get(i)))
				   {
					      finalScore = "education";
					  	System.out.println(".........Your message is: "+finalScore);
					  	
					 	arrCategories.add(finalScore);
					      
					     
				   }
				   
				   
				}
				
				for(i=0; i<arrHistorical.size(); i++)
				{
					
					// check whether Message contains word of text file
				   if(messageNew.contains(arrHistorical.get(i)))
				   {
					      finalScore = "history";
					  	System.out.println(".........Your message is: "+finalScore);
					    
					 	arrCategories.add(finalScore);
					  	
					    
				   }
				   
				   
				}
				
				
				for(i=0; i<arrEntertainment.size(); i++)
				{
					
					// check whether Message contains word of text file
				   if(messageNew.contains(arrEntertainment.get(i)))
				   {
					      finalScore = "entertainment";
					  	System.out.println(".........Your message is: "+finalScore);
					  	
					 	arrCategories.add(finalScore);
					      
					   
				   }
				   
				   
				}
			
			}
			
		catch (Exception e) 
		{
			
			e.printStackTrace();
		}
		
		finally
		{
			
			try
			{
			textReaderEntertainment.close();
			
			textReaderHistorical.close();
			
			textReaderEducation.close();
			
			textReaderPolitics.close();
			
			textReaderSport.close();
			
			}
			
			catch (Exception e) 
			{
				
				e.printStackTrace();
			}
			
		}
		
		
		
		
		System.out.println(".........Your message is: "+finalScore);
		
		return arrCategories;
		
	}
	
}
