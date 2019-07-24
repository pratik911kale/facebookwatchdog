/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.classify.data;

import java.net.*;
import java.io.*;

public class Sentiment {
	
    public static StringBuilder getScoring(String parameter){ 
    
        URL url = null;   
        String response = null;         
        String parameters = "txt="+parameter;   

        try
        {
            url = new URL("http://sentiment.vivekn.com/api/text/");
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
//            Toast.makeText(this,"Message from Server: \n"+ response, 0).show();             
            isr.close();
            reader.close();

            return sb;
        }
        catch(IOException e)
        {
            // Error
            e.printStackTrace();
            return null;
        }
        
       }
}