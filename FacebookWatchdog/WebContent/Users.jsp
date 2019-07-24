<%@ page language="java" import="java.sql.*,java.util.*,social.network.*,social.bean.*,social.dao.*,java.io.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
 
          String email = (String)session1.getAttribute("Email");
 
          String firstName = (String)session1.getAttribute("FirstName");   
          String lastName = (String)session1.getAttribute("LastName");
 
          UserDAO dao = new UserDAO();
          UserInfo info = new UserInfo(); 
          ArrayList<String> userList = new ArrayList<String>();
          userList = (ArrayList<String>)session1.getAttribute("userList");
          int index = 0;
          
          
         // String []users = new String[userList.size()];
         
         if(session1.getAttribute("FirstName")==null)          // Check whether Session is valid or not
         {
   	
         	response.sendRedirect("UserLogin.jsp");
       
         }
         else
         {
          
             while(index < userList.size())
             {
               //users[index] = userList.get(index);
               System.out.println("Users: "+userList.get(index));
               index++;
             }
      
      
         
      
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
                 <%= firstName %><!--  <span class="caret"></span> -->
              </a>
              <!-- <ul class="dropdown-menu" role="menu">
                <li><a href="Profile.jsp">Profile</a></li>
                
                <li><a href="LogoutServlet">Logout</a></li>
                <li><a href="Upload.jsp">Upload Picture</a></li>
              </ul> -->
            </li>
          </ul>

          <form action="UsersRegistered" method="Get" class="navbar-form margin-none navbar-left hidden-xs ">
            <!-- Search -->
            <div class="search-1">
              <div class="input-group">
                <span class="input-group-addon"><i class="icon-search"></i></span>
                <input type="text" name="find" class="form-control" placeholder="Search a Person"><br/>
                <input type="submit" value="Search"/>
                <input type="hidden" name="viewid" value="/Home.jsp">
                
              </div>
            </div>
           
          </form>

         
        </div>
      </div>
    </div>

    
    <div class="sidebar left sidebar-size-2 sidebar-offset-0 sidebar-visible-desktop sidebar-visible-mobile sidebar-skin-dark" id="sidebar-menu" data-type="collapse">
      <div data-scrollable>
        <ul class="sidebar-menu">
          
          <br/> <br/> <br/> <br/>
          
          <li class=""><a href="Profile.jsp"><i class="icon-user-1"></i> <span>Profile</span></a></li>
          <li class=""><a href="Friends.jsp"><i class="fa fa-group"></i> <span>Friends</span></a></li>
          
     <!--      <li class=""><a href="Photos.jsp"><i class="icon-comment-fill-1"></i> <span>Photos</span></a></li> -->
          
          <li><a href="LogoutServlet"><i class="icon-lock-fill"></i> <span>Logout</span></a></li>
          
          <!--  <li><a href="Entertainment.jsp"><i class="icon-lock-fill"></i> <span>Entertainment</span></a></li>
           
            <li><a href="History.jsp"><i class="icon-lock-fill"></i> <span>History</span></a></li>
           
            <li><a href="Education.jsp"><i class="icon-lock-fill"></i> <span>Education</span></a></li>
             <li><a href="Sports.jsp"><i class="icon-lock-fill"></i> <span>Sports</span></a></li> -->
          
        </ul> 
              </div>
    </div>

    

    <script id="chat-window-template" type="text/x-handlebars-template">

      <div class="panel panel-default">
        <div class="panel-heading" data-toggle="chat-collapse" data-target="#chat-bill">
          <a href="#" class="close"><i class="fa fa-times"></i></a>
          <a href="#">
            <span class="pull-left">
                    <img src="{{ user_image }}" width="40">
                </span>
            <span class="contact-name">{{user}}</span>
          </a>
        </div>
        <div class="panel-body" id="chat-bill">
          <div class="media">
            <div class="media-left">
              <img src="{{ user_image }}" width="25" class="img-circle" alt="people" />
            </div>
            <div class="media-body">
              <span class="message">Feeling Groovy?</span>
            </div>
          </div>
          <div class="media">
            <div class="media-left">
              <img src="{{ user_image }}" width="25" class="img-circle" alt="people" />
            </div>
            <div class="media-body">
              <span class="message">Yep.</span>
            </div>
          </div>
          <div class="media">
            <div class="media-left">
              <img src="{{ user_image }}" width="25" class="img-circle" alt="people" />
            </div>
            <div class="media-body">
              <span class="message">This chat window looks amazing.</span>
            </div>
          </div>
          <div class="media">
            <div class="media-left">
              <img src="{{ user_image }}" width="25" class="img-circle" alt="people" />
            </div>
            <div class="media-body">
              <span class="message">Thanks!</span>
            </div>
          </div>
        </div>
        <input type="text" class="form-control" placeholder="Type message..." />
      </div>
    </script>

     <div class="chat-window-container"></div>

   
         <div class="st-pusher" id="content">

     
            <div class="st-content">
               
               <br/> <br/>
              <%
                  int index1 = 0;
                  String first;
                  String last;
                 String profileImage =null;
                 
                 String profileImagePath = null;
               
                      while(index1 < userList.size())
                      {
                    	  String imagePath = "images2" + File.separator +  userList.get(index1) + File.separator + "ProfilePicture";
                    	  
                    	  ProfileDAO daoProfile = new ProfileDAO();
                  	    ProfileInfo rsImage = daoProfile.getProfileImage(userList.get(index1));
                    	  
                  	    // Get Profile Picture of user
                  	    if(rsImage.getfirst()!=null)
                  	    {
                  	    	profileImage = rsImage.getpath();
                  	    	profileImagePath = imagePath + File.separator + profileImage;
                  	    }
                  	    else
                  	    {
                  	    	profileImage = "facebook-default.jpg";
                  	    	profileImagePath = "images2" + File.separator + profileImage;
                  	    }
                    	  
                    	  info.setEmail(userList.get(index1));
                    	  UserInfo user = dao.getUserRecord(info);
                    	    
                    	     first = user.getFirst();
                    	     last = user.getLast();
                    	     
                    	     
               %>
               <br/> <br/>
               
               <%
                    if(email.equals(userList.get(index1)))
                    {
                    	
                    
               %>
                &nbsp; &nbsp; &nbsp;    &nbsp; &nbsp; &nbsp;  <a href="Profile.jsp?userEmail=<%= userList.get(index1)%>"><img src="<%= profileImagePath %>" width="50" height="50"></a> &nbsp; &nbsp; <a href="Profile.jsp?userEmail=<%= userList.get(index1)%>"><font size="5"><%= first+" "+last %></font></a>
                
                &nbsp; &nbsp; &nbsp;    &nbsp;    <%-- <a href="CategoriesGraph.jsp?email=<%= userList.get(index1) %>"><font size="5" color="crimson">View Graph</font></a> --%>
                
               <%
                    }
                    else
                    {
                 
               %>
                
                &nbsp; &nbsp; &nbsp;    &nbsp; &nbsp; &nbsp;  <a href="UserProfile.jsp?userEmail=<%= userList.get(index1)%>"><img src="<%= profileImagePath %>" width="50" height="50"></a> &nbsp; &nbsp; <a href="UserProfile.jsp?userEmail=<%= userList.get(index1)%>"><font size="5"><%= first+" "+last %></font></a>
                
                &nbsp; &nbsp; &nbsp;    &nbsp;    <%-- <a href="CategoriesGraph.jsp?email=<%= userList.get(index1) %>"><font size="5" color="crimson">View Graph</font></a> --%>
                
               <% 
                    }
                              index1++;
                    	      
                      }
                      
         }
                
               %> 
                 

           </div>
      <!-- st-content -->

      </div>
    <!-- /st-pusher --> 
    </div>

    <!-- Footer 
    <footer class="footer">
      <strong>Facebook</strong> v4.0.0 &copy; Copyright 2015
    </footer>
    -->
    <!-- // Footer -->

  </div>
  <!-- /st-container -->


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

</body>
</html>