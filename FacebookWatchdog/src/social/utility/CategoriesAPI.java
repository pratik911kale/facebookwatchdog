package social.utility;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.text.ParseException;
import java.util.ArrayList;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.json.JSONObject;

public class CategoriesAPI 
{

	public static ArrayList<String> getCategory(String message) 
	{
	
		 URL url = null;   
	        String response = null;         
	        String parameters = "text="+message;   
	        
	        String category = "general";
	        
	        ArrayList<String> arrCategories = new ArrayList<String>(); 

	        try
	        {
	            url = new URL("http://gateway-a.watsonplatform.net/calls/text/TextGetRankedTaxonomy?apikey=42853173a69b9003ed001594fda6784005741673&outputMode=json&");
	            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	            connection.setRequestMethod("POST");
	            connection.setDoInput(true);
	            connection.setDoOutput(true);
	            connection.connect();
	            
	            OutputStreamWriter request = new OutputStreamWriter(connection.getOutputStream());
	            request.write(parameters);
	            request.flush();
	            request.close();            
	            String line = "";               
	            InputStreamReader isr = new InputStreamReader(connection.getInputStream());
	            BufferedReader reader = new BufferedReader(isr);
	            StringBuilder sb = new StringBuilder();
	            while ((line = reader.readLine()) != null)
	            {
	                sb.append(line);
	            }
	            // Response from server after login process will be stored in response variable.                
	            response = sb.toString();
	           // System.out.println(sb);
	            // You can perform UI operations here
//	            Toast.makeText(this,"Message from Server: \n"+ response, 0).show();     
	            
	            System.out.println("response : "+response);
	            
	            JSONObject obj = new JSONObject(response);
	            
	            if(obj.has("taxonomy"))
	            {
	            
	            System.out.println("Taxonomy : "+obj.getJSONArray("taxonomy"));
	            
	            int count = 0;
	            
	            while(count < obj.getJSONArray("taxonomy").length())
	            {
	            	
	            	JSONObject objInner = obj.getJSONArray("taxonomy").getJSONObject(count);
	            	
	            	System.out.println("Json Object : "+objInner);
	            	
	            	String label = objInner.getString("label");
	            	
	            	if(label.contains("sports"))
	            	{
	            		
	            		double score = objInner.getDouble("score");
	            		
	            		System.out.println("Sports Score : "+score);
	            		
	            		if(score > 6.0)
	            		{
	            			category = "sports";
	            			
	            			arrCategories.add(category);
	            			
	            			break;
	            		}
	            			
	            		
	            	}
	            	
	            	else if(label.contains("education"))
	            	{
                        double score = objInner.getDouble("score");
	            		
	            		System.out.println("Education Score : "+score);
	            		
	            		if(score > 6.0)
	            		{
	            			category = "education";
	            			
	            			arrCategories.add(category);
	            			
	            			break;
	            		}
	            		
	            	}
	            	
	            	
	            	else if(label.contains("entertainment")) 
	            	{
                        double score = objInner.getDouble("score");
	            		
	            		System.out.println("Entertainment Score : "+score);
	            		
	            		if(score > 6.0)
	            		{
	            			category = "entertainment";
	            			
	            			arrCategories.add(category);
	            			
	            			break;
	            		}
	            		
	            	}
	            	
	            	else if(label.contains("politics")) 
	            	{
                        double score = objInner.getDouble("score");
	            		
	            		System.out.println("Politics Score : "+score);
	            		
	            		if(score > 6.0)
	            		{
	            			category = "politics";
	            			
	            			arrCategories.add(category);
	            			
	            			break;
	            		}
	            		
	            	}
	            	
	            	
	            	count++;
	            }
	            
	            }
	            
	            isr.close();
	            reader.close();
    		 
  		    
	        }
	        catch(IOException e)
	        {
	            // Error
	            e.printStackTrace();
	           
	        }
  		 
  		
  		return arrCategories;
  		
		
	}
	
	
	
	
}
