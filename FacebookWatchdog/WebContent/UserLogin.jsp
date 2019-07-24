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
      
             <form name="login" method="post" action="LoginProcess">
                Email or Phone: &nbsp; <input class="form-control" type="text" name="emailorphone" id="emailorphone" style="margin-left:50px"><br/>
                Password: &nbsp; &nbsp; <input class="form-control" type="password" name="password" id="password" style="margin-left:50px"><br/>
                  <input type="button" value="Login" onclick="checkLogin()" class="btn btn-primary">
                  <h3><a href="Register.jsp">New User</a></h3>
                 <br/>
              
              
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
<%-- <%          	 }
          %> --%>

          </div>
        </div>
      </div>

    </div>
  </div>

  <!-- Footer 
  <footer class="footer">
<!--    <strong>ThemeKit</strong> v4.0.0 &copy; Copyright 2015 --> 
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

<script type="text/javascript">

     function checkLogin()
     {
    	 
    	 var emailorphone = document.getElementById('emailorphone').value;
    	 
    	 var password = document.getElementById('password').value;
    	 
    	 if(emailorphone == "" || emailorphone == null || password == "" || password == null)
    		 {
    		             alert("Form field cannot be empty");
    		 }
    	 else
    		 {
    		      document.login.submit();
    		 }
    	 
     }



</script>
 
  
</body>

</html>