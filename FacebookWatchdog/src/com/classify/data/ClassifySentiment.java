package com.classify.data;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.security.cert.X509Certificate;

import org.json.JSONObject;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import social.utility.Category;

public class ClassifySentiment 
{
	
	private static String readAll(Reader rd) throws IOException {
        StringBuilder sb = new StringBuilder();
        int cp;
        while ((cp = rd.read()) != -1) {
          sb.append((char) cp);
        }
        return sb.toString();
    }
     /**
      * This method is used to read Json Object from specified url executing sentiment analysis online
      * @param url It is web address of api where sentiment analysis is done
      * @return
      * @throws IOException
      * @throws ParseException
      */
    public static JSONObject readJsonFromUrl(String url) throws IOException, ParseException 
    {
    	// This method is used to read Json Object from specified url executing sentiment analysis online
    	
    	

   	 TrustManager[] trustAllCerts = new TrustManager[] {
   		       new X509TrustManager() {
   		          public java.security.cert.X509Certificate[] getAcceptedIssuers() {
   		            return null;
   		          }

   		          public void checkClientTrusted(X509Certificate[] certs, String authType) {  }

   		          public void checkServerTrusted(X509Certificate[] certs, String authType) {  }

   		       }
   		    };

   		    SSLContext sc = null;
 				try {
 					sc = SSLContext.getInstance("SSL");
 				} catch (NoSuchAlgorithmException e) {
 					// TODO Auto-generated catch block
 					e.printStackTrace();
 				}
   		    try {
 					sc.init(null, trustAllCerts, new java.security.SecureRandom());
 				} catch (KeyManagementException e) {
 					// TODO Auto-generated catch block
 					e.printStackTrace();
 				}
   		    HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

   		    // Create all-trusting host name verifier
   		    HostnameVerifier allHostsValid = new HostnameVerifier() {
   		        public boolean verify(String hostname, SSLSession session) {
   		          return true;
   		        }
   		    };
   		    // Install the all-trusting host verifier
   		    HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
   		    /*
   		     * end of the fix
   		     */
   	
    	
        InputStream is = new URL(url).openStream();
        try {
          BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
          String jsonText = readAll(rd);
          
          int start=jsonText.indexOf("{");
          int end=jsonText.lastIndexOf("}")+1;
          String substr=jsonText.substring(start,end);             
          
         JSONObject json = new JSONObject(substr);
            System.out.println("Json : "+json.toString());
          return json;
        } finally {
          is.close();
        }
    }
    
    /**
     * This method is used to get status of message whether message is of type 'right' or 'wrong'
     * @param message It is user posted message
     * @return
     */
    public static String getStatus(String message)
    {
   	 
    	 // This method is used to get status of message whether message is of type 'right' or 'wrong'
    	
   	 String sentiment = "neutral";
   	 try 
   	 {
   		 StringBuilder sb = new StringBuilder();
   		 
   		 JSONObject json = new JSONObject();
   		 
   		 json = readJsonFromUrl("https://www.uclassify.com/browse/uClassify/Sentiment/ClassifyText?readkey=uzs7cIHCYjAq&text="+message+"&output=json&version=1.01");
   		 
   		 String jsonData = json.toString();
   		 
   		 System.out.println("Json value: "+jsonData);
   		 
   		 
   		String statusValues = json.get("cls1").toString();
   		
   		System.out.println("Status Values: "+statusValues);
   		
         String arrCategories[] = new String[2];
  		
  		arrCategories = statusValues.split(",");
  		
  		Double negative = Double.parseDouble(arrCategories[0].substring(12));
  		
  		System.out.println("Value of Negative: "+negative);
  		
      Double positive = Double.parseDouble(arrCategories[1].substring(11,arrCategories[1].length()-1));
  		
  		System.out.println("Value of Positive: "+positive);
  		
  		if(positive > 0.65)
  		{
  			sentiment = "right";
  		}
  		else if(negative > 0.65)
  		{
  			sentiment = "wrong";
  		}
   		  
   	 }
   	 catch (ParseException ex) 
   	 {
            Logger.getLogger(Category.class.getName()).log(Level.SEVERE, null, ex);
     } 
   	 catch (IOException ex) 
   	 {
            Logger.getLogger(Category.class.getName()).log(Level.SEVERE, null, ex);
     }
   	 
     return sentiment;
   	 
    }
    /**
     * This method is used for calling getStatus() method
     * @param message  It is user posted message
     * @return
     */
    public static String classifySentiment(String message)
    {
    	// This method is used for calling getStatus() method
    	
    	 String strNew = message.replaceAll(" ", "+");
   	
   	     return getStatus(strNew);
   	     
    }


}
