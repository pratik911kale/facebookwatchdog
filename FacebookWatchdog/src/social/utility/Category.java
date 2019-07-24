package social.utility;



import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.text.ParseException;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.json.JSONObject;

public class Category 
{
	
	
	/**
	 * This method is used for reading text returned from url in String form
	 * @param rd Reader object used to read data
	 * @return
	 * @throws IOException
	 */
	 private static String readAll(Reader rd) throws IOException {
         StringBuilder sb = new StringBuilder();
         int cp;
         while ((cp = rd.read()) != -1) {
           sb.append((char) cp);
         }
         return sb.toString();
     }
      
	 
	 /**
	  * This method is used to read JSON object that contains data obtained from url
	  * @param url url address where Classification of text is done by online api
	  * @return
	  * @throws IOException
	  * @throws ParseException
	  */
     public static JSONObject readJsonFromUrl(String url) throws IOException, ParseException {
    	 
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
      * This method is used obtain JSON object and get categories from JSON object to find score for each category based on user message
      * @param message
      * @return
      */
     public static String getCategory(String message)
     {
    	 
    	 String category = "general";
    	 try 
    	 {
    		 StringBuilder sb = new StringBuilder();
    		 
    		 JSONObject json = new JSONObject();
    		 
    		 json = readJsonFromUrl("https://www.uclassify.com/browse/uClassify/Society%20Topics/ClassifyText?readkey=uzs7cIHCYjAq&text="+message+"&output=json&version=1.01");
    		 
    		 String jsonData = json.toString();
    		  int index = jsonData.indexOf("History");    // find index of category in json data
    		  
    		  int index1 = jsonData.indexOf("Politics");
    		  
    		  int index2 = jsonData.indexOf("Crime");
  		    
  		    System.out.println("Index of history in Insert: "+index);
  		    
  		  System.out.println("Index of politics in Insert: "+index1);
  		  
  		 System.out.println("Index of crime in Insert: "+index2);
  		 
  		String categoryValues = json.get("cls1").toString();
  		
  		sb.append(categoryValues);
  		
  		String arrCategories[] = new String[25];
  		
  		arrCategories = categoryValues.split(",");
  		
  		int indexHistoryValue = arrCategories[16].indexOf(':');
  		 
  		System.out.println("value of History: "+arrCategories[16].substring(indexHistoryValue+1));
  		
  		double history = Double.parseDouble(arrCategories[16].substring(indexHistoryValue+1));   // obtain score for history category in json object
  		
  		System.out.println("value of History(Double): "+history);
  		
  	    int indexPoliticsValue = arrCategories[5].indexOf(':');
  	    
  	  double politics = Double.parseDouble(arrCategories[5].substring(indexPoliticsValue+1));    // obtain score for politics category in json object
  	    
  	    
  	  System.out.println("value of Politics: "+arrCategories[5].substring(indexPoliticsValue+1));
  	  
  	System.out.println("value of Politics(Double): "+politics);
  	
  	
  	 int indexCrimeValue = arrCategories[3].indexOf(':');
	    
 	  double crime = Double.parseDouble(arrCategories[3].substring(indexCrimeValue+1));    // obtain score for crime category in json object
 	    
 	    
 	  System.out.println("value of Crime: "+arrCategories[3].substring(indexCrimeValue+1));
 	  
 	System.out.println("value of Crime(Double): "+crime);
 	
 	
 	int indexReligionValue = arrCategories[19].indexOf(':');
    
	  double religion = Double.parseDouble(arrCategories[19].substring(indexReligionValue+1));
	    
	    
	  System.out.println("value of Religion: "+arrCategories[19].substring(indexReligionValue+1));
	  
	System.out.println("value of Religion(Double): "+religion);
	
 	
  	
  	   
  	   
  	   if(history > 0.5)
  	   {
  		   category = "history";
  	   }
  	   else if(politics > 0.5)
  	   {
  		   category = "politics";
  	   }
  	   else if(crime > 0.5)
  	   {
  		   category = "crime";
  	   }
  	   else if(religion > 0.5)
  	   {
  		   category = "religion";
  	   }
  	   
  	   
  	   System.out.println("Category of message: "+category);
    		 
    	 }
    	 catch (ParseException ex) 
    	 {
             Logger.getLogger(Category.class.getName()).log(Level.SEVERE, null, ex);
         } 
    	 catch (IOException ex) 
    	 {
             Logger.getLogger(Category.class.getName()).log(Level.SEVERE, null, ex);
         }
    	 
    	 return category;
    	 
     }
     
     public static String classify(String message)
     {
    	 
    	 
    	 String strNew = message.replaceAll(" ", "+");
    	 return getCategory(strNew);
     }

}
