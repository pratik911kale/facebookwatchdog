<%@ page  language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="hide-sidebar ls-bottom-footer" lang="en">



<head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>Facebook</title>

  
  <link href="css/vendor/all.css" rel="stylesheet">


  <link href="css/app/app.css" rel="stylesheet">

 

  

</head>

<body class="login">

  <div id="content">
    <div class="container-fluid">

      <div class="lock-container">
       
        <div class="panel panel-default text-center" size="200">
          
          <div class="panel-body">
          
        
             <h1 style="color:black">Account Access</h1>
          
           <form name="client" method="post" action="UserRegistration"/>
             <table border="0">
                 <tr>
                   <td>First Name: </td>
                   <td><input type="text" name="first" id="first"/></td>
                 </tr>
                 <tr>
                   <td>Last Name: </td>
                   <td><input type="text" name="last" id="last"/></td>
                 </tr>
                 <tr>
                   <td>Email: </td>
                   <td><input type="text" name="email" id="email"/></td>
                 </tr>
                 <tr>
                   <td>Password: </td>
                   <td><input type="password" name="password" id="password"/></td>
                 </tr>
                 <tr>
                   <td>Phone: </td>
                   <td><input type="text" name="phone" id="phone"/></td>
                 </tr>
                 <tr>
                   <td>Local Address: </td>
                   <td><textarea name="local" columns="30" rows="5" id="local"></textarea>
                 </tr>
                 <tr>
                   <td>Permanent Address: </td>
                   <td><textarea name="permanent" columns="30" rows="5" id="permanent"></textarea></td>
                 </tr>
                  <tr>
                   <td>Date of Birth: <br/>(dd-mm-yyyy)</td>
                   <td><input type="text" name="dob" id="dob"/></td>
                 </tr>
                  <tr>
                   <td>Gender: </td>
                   <td><input type="radio" name="gender" value="Male" checked="checked"/> Male
                             &nbsp; <input type="radio" name="gender" value="Female"/> Female
                   </td>
                 </tr>
            </table>

          <input type="button" class="btn btn-primary" value="Register" onclick="checkLogin();"/></td>
            
           

          <%
             String str = request.getParameter("message");
             if(str!=null)
             {
               
          %>
          
          <font color="crimson" size="3"><%= str %></font>
          <%
          
             }
          %>
          
        
         </form>
             <br/><br/><br/><br/>

          </div>
        </div>
      </div>

    </div>
  </div>

  <!-- Footer 
  <footer class="footer">
    <strong>ThemeKit</strong> v4.0.0 &copy; Copyright 2015
  </footer>
  -->
  <!-- // Footer -->
  <!-- Inline Script for colors and config objects; used by various external scripts; -->
  <script>
    var colors = {
      "danger-color": "#e74c3c",
      "success-color": "#81b53e",
      "warning-color": "#f0ad4e",
      "inverse-color": "#2c3e50",
      "info-color": "#2d7cb5",
      "default-color": "#6e7882",
      "default-light-color": "#cfd9db",
      "purple-color": "#9D8AC7",
      "mustard-color": "#d4d171",
      "lightred-color": "#e15258",
      "body-bg": "#f6f6f6"
    };
    var config = {
      theme: "social-1",
      skins: {
        "default": {
          "primary-color": "#16ae9f"
        },
        "orange": {
          "primary-color": "#e74c3c"
        },
        "blue": {
          "primary-color": "#4687ce"
        },
        "purple": {
          "primary-color": "#af86b9"
        },
        "brown": {
          "primary-color": "#c3a961"
        }
      }
    };
  </script>

  
  <script src="js/vendor/all.js"></script>

  


  
  <script src="js/app/app.js"></script>


 <script language = "javascript">  
var request;  
function checkLogin()  
{  
	
 
 

var first = document.getElementById('first').value;
var last = document.getElementById('last').value;

var email = document.getElementById('email').value;

var phone = document.getElementById('phone').value;

var password = document.getElementById('password').value;

var local = document.getElementById('local').value;

var permanent = document.getElementById('permanent').value;

var dob = document.getElementById('dob').value;


var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;  

    

     if(first==null || first=="" || last==null || last=="" || email==null || email=="" || password==null || password=="" || phone==null || phone=="" || local==null || local=="" || permanent==null || permanent=="" || dob==null || dob=="")
	      {
	      alert("Please Fill All Required Field");
	      
	      }
    
     else if(!email.match(mailformat))  
    {  
	    alert("You have entered an invalid email address!");  
	    document.client.email.focus();  
	    
    }
	  
	  else if(isNaN(phone) )
		  {
		  alert("Enter a number in Phone Number Field");
		  phone.value="";
		  document.client.phone.focus(); 
		  
		  }
	  else if(phone.length!=10)
		  {
		  alert("Length of Mobile Number must be 10 digits");
		  phone.value="";
		  document.client.phone.focus(); 
		  
		  }
	  else if(!isValidDate(dob))
	  {
		   
		  alert("Date of Birth is not valid");
		  dob.value="";
		  document.client.dob.focus(); 
      }
	  else if(password.length<5)
	  {
	  alert("Length of Password must be at least 5 characters");
	  phone.value="";
	  document.client.phone.focus(); 
	  
	  }
	  
	  else
		{
		  document.client.submit();
		}
	    
	


}
	  

  
</script>


<script type="text/javascript">

function isValidDate(s) 
{
	  var bits = s.split('-');
	  var y = bits[2], m  = bits[1], d = bits[0];
	  // Assume not leap year by default (note zero index for Jan)
	  var daysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31];

	  // If evenly divisible by 4 and not evenly divisible by 100,
	  // or is evenly divisible by 400, then a leap year
	  if ( (!(y % 4) && y % 100) || !(y % 400)) {
	    daysInMonth[1] = 29;
	  }
	  return d <= daysInMonth[--m]
}

</script>
  
</body>

</html></html>