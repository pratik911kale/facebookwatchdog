<%@ page language="java" import="java.sql.*,java.util.*,social.network.*,social.bean.*,social.dao.*,java.io.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<<html class="st-layout ls-top-navbar ls-bottom-footer show-sidebar sidebar-l2" lang="en">


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
         
          int index = 0;
          
          
         // String []users = new String[userList.size()];
         
         if(session1.getAttribute("FirstName")==null)            // Check whether Session is valid or not
         {
   	
         	response.sendRedirect("UserLogin.jsp");
       
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
                  <%= firstName %> <!-- <span class="caret"></span> -->
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
                <input type="hidden" name="viewid" value="Friends.jsp">
                <input type="hidden" name="userEmail" value="<%= email %>">
                
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
          
        <!--    <li class=""><a href="Photos.jsp"><i class="icon-comment-fill-1"></i> <span>Photos</span></a></li>-->
          
              <li class=""><a href="Messages.jsp"><i class="icon-comment-fill-1"></i> <span>Messages</span></a></li>
          
          <li><a href="LogoutServlet"><i class="icon-lock-fill"></i> <span>Logout</span></a></li>
          
        <!--    <li><a href="Politics.jsp"><i class="icon-lock-fill"></i> <span>Politics</span></a></li>
          
          <li><a href="Entertainment.jsp"><i class="icon-lock-fill"></i> <span>Entertainment</span></a></li>
          
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

<br/> <br/> <br/>
     <div class="chat-window-container"></div>

   
        <div class="st-pusher" id="content">

     
            <div class="st-content">
               
               
                          <div class="col-md-6">
                    <div class="panel panel-default" style="width: 500px;margin-left: 5.4cm;">
                      <div class="panel-heading panel-heading-gray">
                        
                        <i class="icon-user-1"></i> Friends
                      </div>
                      <div class="panel-body">
                        
                        <table>
                        
                          <%
                            UserInfo info1 = new UserInfo();
                            UserDAO daoUser = new UserDAO(); 
                            Friends frnd = new Friends();
                            String profileImage1 = null;
                    		String firstName1 = null;
                    		String lastName1 = null;
                            
                            FriendsDAO daoFriends1 = new FriendsDAO();
                            
                            // Get friends list of user logged in
                            ArrayList<Friends> rsFriends = daoFriends1.getFriends(email);
                            int i=1;
                            int frndsCount = 0;
                            
                            
                            
                            
                            while(frndsCount < rsFriends.size())
                            {
                            	System.out.println("Value of i: "+i);
                            	i++;
                            	
                            	System.out.println("Friend Email: "+(rsFriends.get(frndsCount).getEmail1()).equals(email));
                            	if((rsFriends.get(frndsCount).getEmail1()).equals(email))
                            	{
                            		String friendEmail = rsFriends.get(frndsCount).getEmail2();
                            		ProfileDAO pic = new ProfileDAO();
                            	    System.out.println("Friend Email: "+friendEmail);
                            	    
                            	    // construct path of folder containing profile picture
                            		String savePathFriend = "images2" + File.separator + friendEmail + File.separator + "ProfilePicture";
                            		
                            		ProfileInfo rsPic = pic.getProfileImage(friendEmail);
                            		if(rsPic.getfirst()!=null)
                            		{
                            			profileImage1 =rsPic.getpath();
                            			System.out.println("ProfileImage1: "+profileImage1);
                            		}
                            		
                            		info1.setEmail(friendEmail);
                            		UserInfo rsUser1 = daoUser.getUserRecord(info1);
                            		
                            			
                            		   firstName1 = rsUser1.getFirst();
                            		   lastName1 = rsUser1.getLast();
                            		   
                            		   System.out.println("firstName1: "+firstName1);
                            		   System.out.println("lastName1: "+lastName1);
                            		    
                            		 
                            		if(profileImage1!=null)
                            		{
                            		   
                            %>		    
                                                  
                               
                            	<tr>
                            	
                            	   <td> 
                            	   
                                    <a href="UserProfile.jsp?userEmail=<%= friendEmail %>">
                                   
                                          <img src="<%= savePathFriend + File.separator + profileImage1 %>" alt="image" width="100" height="100"> <br/> 
                                           <font size="3"><%= firstName1 +" "+lastName1 %></font> 
                                          
                                          
                                    </a>
                                   
                                    
                                  </td>
                                    
                                 <td> &nbsp; &nbsp; </td>
                                 
                                 <td> &nbsp; &nbsp; </td>
                                     
                                      <td> 
                                    
<%--                                     <a href="Chats.jsp?friendEmail=<%= friendEmail %>" style="color:crimson; font-size: 20px;">Start Chat</a>
 --%>                                    
                                    </td>
                                    
                                  </tr>
                                    
                                    <% 
                            		   }
                                         
                                           else
                                           {
                                        	   %>
                                     
                                   <tr>
                            	
                            	      <td> 
                            	         <a href="UserProfile.jsp?userEmail=<%= friendEmail %>">
                                   
                                          <img src="images2/facebook-default.jpg" alt="image" alt="image" width="100" height="100"/> 
                                        <br/>    <font size="3"><%= firstName1 +" "+lastName1 %></font>
                                    </a>
                                    
                                   
                                      </td>
                                      
                                        <td> &nbsp; &nbsp; </td>
                                 
                                 <td> &nbsp; &nbsp; </td>
                                     
                                      
                                       <td> 
                                      
                                        
                                    <%-- <a href="Chats.jsp?friendEmail=<%= friendEmail %>" style="color:crimson; font-size: 20px;">Start Chat</a> --%>
                                    
                                   </td>
                                   
                                   </tr>
                                    
                                    <%
                                           }
                                           
                                    %>
                              
                                <% 
                            	
                            		}
                            		    
                            	
                            	else
                            	{
                            		String friendEmail = rsFriends.get(frndsCount).getEmail1();
                            		System.out.println("Else in UserProfile: "+friendEmail);
                            		ProfileDAO pic = new ProfileDAO();
                            		String savePathFriend = "images2" + File.separator + friendEmail + File.separator + "ProfilePicture";
                            		
                            		ProfileInfo rsPic = pic.getProfileImage(friendEmail);
                            		if(rsPic.getfirst()!=null)
                            		{
                            			profileImage1 =rsPic.getpath();
                            			
                            			System.out.println("ProfileImage1: "+profileImage1);
                            		}
                            		
                            		
                            		
                            		info1.setEmail(friendEmail);
                            		UserInfo rsUser1 = daoUser.getUserRecord(info1);
                            		
                            			
                            		    firstName1 = rsUser1.getFirst();
                            		    lastName1 = rsUser1.getLast();
                            		
                            		   
                            		if(profileImage1!=null)
                            		{
                            		    
                                   %>
                               
                            <tr>
                            	
                            	   <td> 
                            	 
                                    <a href="UserProfile.jsp?userEmail=<%= friendEmail %>">
                                   
                                          <img src="<%= savePathFriend + File.separator + profileImage1 %>" alt="image" width="100" height="100"/> 
                                          <br/>  <font size="3"><%= firstName1 +" "+lastName1 %></font>
                                    </a>
                                    
                                  
                                    
                                   </td>
                                   
                                      <td> &nbsp; &nbsp; </td>
                                 
                                 <td> &nbsp; &nbsp; </td>
                                     
                                    
                                    <td>
                                    
                                    
                                     
<%--                                     <a href="Chats.jsp?friendEmail=<%= friendEmail %>" style="color:crimson; font-size: 20px;">Start Chat</a>
 --%>                                    
                                   </td>
                                   
                                   </tr>
                                    
                                    <% 
                            		   }
                                         
                                           else
                                           {
                                        	  
                                      %>
                                     
                                     <tr>
                            	
                            	        <td> 
                            	         <a href="UserProfile.jsp?userEmail=<%= friendEmail %>">
                                   
                                          <img src="images2/facebook-default.jpg" alt="image" alt="image" width="100" height="100"/> 
                                          <br/>  <font size="3"><%= firstName1 +" "+lastName1 %></font>
                                    </a>
                                    
                                     
                                    
                                      </td>
                                      
                                       <td> &nbsp; &nbsp; </td>
                                 
                                 <td> &nbsp; &nbsp; </td>
                                     
                                       
                                       <td>
                                       
                                      
<%--                                     <a href="Chats.jsp?friendEmail=<%= friendEmail %>" style="color:crimson; font-size: 20px;">Start Chat</a>
 --%>                                    
                                   </td>
                                   
                                 </tr>
                                 
                                 <tr>
                                       
                                    <td> &nbsp; &nbsp; </td>
                                 
                                 <td> &nbsp; &nbsp; </td>
                                 
                                 <td> &nbsp; &nbsp; </td>
                                 
                                 <td> &nbsp; &nbsp; </td>
                                     
                                 </tr>
                                 
                                  <tr>
                                       
                                    <td> &nbsp; &nbsp; </td>
                                 
                                 <td> &nbsp; &nbsp; </td>
                                 
                                 <td> &nbsp; &nbsp; </td>
                                 
                                 <td> &nbsp; &nbsp; </td>
                                     
                                 </tr>
                                 
                                    
                                    <%
                                           }
                                           
                                    %>

                                <% 
                            	
                            	}
                            	frndsCount++;
                            	
                            	%>
                            	
                            	
                            	
                            	
                            	
                            	
                            	<% 
                            }
                        
                        %>
                          
                          
                        </table>
                      </div>
                    </div>
                  </div>
                </div>
                          
                 

           </div>
      <!-- st-content -->

      </div>
    <!-- /st-pusher --> 
    </div>
  
    <!-- Footer -->
      <!-- 
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
</html>>