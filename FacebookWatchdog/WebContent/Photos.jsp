<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="st-layout ls-top-navbar ls-bottom-footer show-sidebar sidebar-l2" lang="en">


<!-- Mirrored from themekit.aws.ipv4.ro/dist/themes/social-1/index.html by HTTrack Website Copier/3.x [XR&CO'2013], Mon, 05 Oct 2015 05:27:27 GMT -->
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>Facebook</title>
  <link href="css/vendor/all.css" rel="stylesheet">
  <link href="css/app/app.css" rel="stylesheet">

</head>

<body>

<%
        HttpSession session1 = request.getSession(false);
        
        if(session1.getAttribute("FirstName")==null)      // Check whether Session is valid or not
        {
        	response.sendRedirect("UserLogin.jsp");
        }
        
        String firstName = (String)session1.getAttribute("FirstName");
        
        String userName =  (String)session1.getAttribute("FirstName");
        String email = (String)session1.getAttribute("Email");
        System.out.println(userName);
        
        
    %>
    


<div class="st-container">

   
    <div class="navbar navbar-main navbar-default navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <a href="#sidebar-menu" data-effect="st-effect-1" data-toggle="sidebar-menu" class="toggle pull-left visible-xs"><i class="fa fa-bars"></i></a>
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-nav">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a href="#sidebar-chat" data-toggle="sidebar-menu" data-effect="st-effect-1" class="toggle pull-right visible-xs "><i class="fa fa-comments"></i></a>
          <a class="navbar-brand navbar-brand-primary hidden-xs" href="Home.jsp">Facebook</a>
        </div>
        <div class="collapse navbar-collapse" id="main-nav">
                    
          
          <ul class="nav navbar-nav navbar-user">
            <!-- User -->
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                 <%= firstName %> <span class="caret"></span>
              </a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="Profile.jsp">Profile</a></li>
                
                <li><a href="LogoutServlet">Logout</a></li>
                <li><a href="Photos.jsp">Upload Picture</a></li>
              </ul>
            </li>
          </ul>
          
          
          
         <form action="UsersRegistered" method="Get" class="navbar-form margin-none navbar-left hidden-xs ">
            <!-- Search -->
            <div class="search-1">
              <div class="input-group">
                <span class="input-group-addon"><i class="icon-search"></i></span>
                <input type="text" name="find" class="form-control" placeholder="Search a Person"><br/>
                <input type="submit" value="Search"/> 
                
                <input type="hidden" name="viewid" value="Home.jsp"> 
                
              </div>
            </div>
           
          </form>

          
          <!--           Form to upload picture of user -->
          
          
          
          
          
        </div>
      </div>
    </div>
    
    
     

<div class="sidebar left sidebar-size-2 sidebar-offset-0 sidebar-visible-desktop sidebar-visible-mobile sidebar-skin-dark" id="sidebar-menu" data-type="collapse">
      <div data-scrollable>
        <ul class="sidebar-menu">
          
          <br/> <br/> <br/> <br/>
         <li class=""><a href="Profile.jsp"><i class="icon-user-1"></i> <span>Profile</span></a></li>
          <li class=""><a href="Friends.jsp"><i class="fa fa-group"></i> <span>Friends</span></a></li>
          
       <!--     <li class=""><a href="Photos.jsp"><i class="icon-comment-fill-1"></i> <span>Photos</span></a></li> -->
           <li class=""><a href="Messages.jsp"><i class="icon-comment-fill-1"></i> <span>Messages</span></a></li>
          
          <li><a href="LogoutServlet"><i class="icon-lock-fill"></i> <span>Login</span></a></li>
          
          <!--  <li><a href="Politics.jsp"><i class="icon-lock-fill"></i> <span>Politics</span></a></li>
          <li><a href="Entertainment.jsp"><i class="icon-lock-fill"></i> <span>Entertainment</span></a></li>
          
           <li><a href="History.jsp"><i class="icon-lock-fill"></i> <span>History</span></a></li>
           
            <li><a href="Education.jsp"><i class="icon-lock-fill"></i> <span>Education</span></a></li>
            <li><a href="Sports.jsp"><i class="icon-lock-fill"></i> <span>Sports</span></a></li>
         -->
      </div>
      
     
      
    </div> <!-- // End Sidebar -->
    
    
   <div class="st-pusher" id="content">

     
            <div class="st-content">
          
          <br/> <br/> <br/> <br/> <br/>
      <center>
      
          <!--   Form to Upload Image with message -->
          <form action="upload" method="post" enctype="multipart/form-data" name="upload">
                
                <table>
                
                <tr>
                    <td><input type="file" name="file" id="file"/></td>
                    
                    </tr>
                    <tr> <td> &nbsp; &nbsp;</td></tr>
                    <tr>
                    <td><input type="text" class="form-control share-text" style="width:350px;" placeholder="Post message..." name="message" id="message">
                    </td>
                    </tr>
                    <tr> <td> &nbsp; &nbsp;</td></tr>
                    <tr>
                    <td>
                
                <input type="button" value="Upload" class="btn btn-primary" onclick="checkFile();" />
                </td></tr>
                
                </table>
                
                <input type="hidden" id="useremail" name="userEmail" value="<%= email %>">
                    <input type="hidden" id="email" name="email" value="<%= email %>">
                    <input type="hidden" id="inputPage" name="inputPage" value="Photos.jsp">
            </form>  
            
            <%
                  String str = request.getParameter("message");
                  
            %>
            <br/> <br/>
            <font color="royalblue" size="3">
                                            <% if(str!=null)
          	                                      out.print(str); 
          	                                 %>
            </font>
          </center>
          
            
            </div>
            
            </div>
    
 
    
    
    <!-- Footer -->
        <!-- 
    <footer class="footer">
      <strong>Facebook</strong> v4.0.0 &copy; Copyright 2015
    </footer>
       -->
    <!-- // Footer -->
    
</div>

    
<script src="js/vendor/all.js"></script>

  
  <script src="js/app/app.js"></script>


 <script language = "javascript">  
var request;  
function checkFile()  
{  
	
	var file = document.getElementById('file').value;
	
	var id = document.getElementById('message').value;
	
	if(file==null || file=="")
	{
	
		alert("Select image to upload");
	}
	
	else
	{
	
		 document.upload.submit();
	}
	
	
	
}

</script>

</body>
</html>






