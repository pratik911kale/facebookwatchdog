<%@ page import="social.network.*,java.sql.*,java.util.*,java.io.*,social.bean.*,social.dao.*,social.utility.*" language="java" contentType="text/html; charset=ISO-8859-1"
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
   	int result1=0;
                int result=0;
                String userEmail = null;
                String profileImage2 = null;
                ProfileDAO pic1 = new ProfileDAO();
                
                ArrayList<ImageBean> imageList = new ArrayList<ImageBean>();
                
                HttpSession session1 = request.getSession(false);
                String myFirstName = (String)session1.getAttribute("FirstName");   
                String mylastName = (String)session1.getAttribute("LastName");
                String userFirstName = null;
                String userLastName = null;
                String profileImagePath = null;
                String userDOB = null;
                String userGender = null;
                String livesIn = null;
                String profession = null;
                String qualification = null;
                String worksIn = null;
                ProfessionDAO dao1 = new ProfessionDAO();
                
                ResultSet rsImages = null;
                
                String myEmail = (String)session1.getAttribute("Email");
                
                String visited = (String)session1.getAttribute("Visited");
                
                System.out.println("Request value: "+request.getAttribute("message"));
                
                if(request.getAttribute("UserEmail")==null)
                {
                   userEmail = request.getParameter("userEmail");
                   
                }
                else
              	  userEmail = (String)request.getAttribute("UserEmail");
                
                String profileImage = null;
                
                System.out.println("User Email: "+userEmail);
                
                UserInfo info = new UserInfo();
                UserDAO dao = new UserDAO();
                info.setEmail(userEmail);
                UserInfo rsUser = dao.getUserRecord(info);
                
                  userFirstName = rsUser.getFirst();
              	  userLastName = rsUser.getLast();
              	  livesIn = rsUser.getLocal();
              	  userDOB = rsUser.getDOB();
              	  userGender = rsUser.getGender();
                
                
                ProfessionBean rsProfession = dao1.getProfession(userEmail);
                if(rsProfession.getEmail()!=null)
                {
              	  profession = rsProfession.getProfession();
              	  qualification = rsProfession.getQualification();
              	  worksIn = rsProfession.getWorkIn();
                }
                
                
                
                String appPath = request.getServletContext().getRealPath("");
                String savePath = appPath + File.separator + "images2" + File.separator + userEmail;
                String savePath1 = "images2" + File.separator + userEmail + File.separator + "ProfilePicture";
                
                ArrayList<String> fileList = new ArrayList<String>();
                
               if(session1.getAttribute("FirstName")==null)      // Check whether Session is valid or not
               {
         	
               	response.sendRedirect("UserLogin.jsp");
             
               }       
               
               else
               {
        
                
                // constructs path of the directory to save uploaded file
               
                
                session1.setAttribute("UserEmail", userEmail);
        		  
               
                // constructs path of the directory to save uploaded file
                
                
                System.out.println(savePath);
                
                ImagesDAO daoPosts = new ImagesDAO();
         	     imageList = daoPosts.selectImages(userEmail);
               
                ProfileInfo rsPic = pic1.getProfileImage(userEmail);
             	 if(rsPic.getfirst()!=null)
           		{
           			profileImage2 =rsPic.getpath();
           		}
             	    
                
                
                
               }
   %>
    

<div class="st-container">

    <!-- Fixed navbar -->
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
                 <%= myFirstName %> <!-- <span class="caret"></span> -->
              </a>
             <!--  <ul class="dropdown-menu" role="menu">
                <li><a href="Profile.jsp">Profile</a></li>
                
                <li><a href="LogoutServlet">Logout</a></li>
                <li><a href="Photos.jsp">Upload Picture</a></li>
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
                
                <input type="hidden" name="viewid" value="UserProfile.jsp"> 
                 <input type="hidden" name="userEmail" value="<%= userEmail %>">
                
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
          
       <!--   <li class=""><a href="Photos.jsp"><i class="icon-comment-fill-1"></i> <span>Photos</span></a></li> --> 
          <li class=""><a href="Messages.jsp"><i class="icon-comment-fill-1"></i> <span>Messages</span></a></li>
          
          <li><a href="LogoutServlet"><i class="icon-lock-fill"></i> <span>Logout</span></a></li>
          
        <!--   <li><a href="Politics.jsp"><i class="icon-lock-fill"></i> <span>Politics</span></a></li>
          <li><a href="Entertainment.jsp"><i class="icon-lock-fill"></i> <span>Entertainment</span></a></li>
          
           <li><a href="History.jsp"><i class="icon-lock-fill"></i> <span>History</span></a></li>
           
            <li><a href="Education.jsp"><i class="icon-lock-fill"></i> <span>Education</span></a></li>
             <li><a href="Sports.jsp"><i class="icon-lock-fill"></i> <span>Sports</span></a></li> -->
         
        </ul>
      </div>
    </div>
    
    <div class="st-pusher" id="content">

      <!-- sidebar effects INSIDE of st-pusher: -->
      <!-- st-effect-3, st-effect-6, st-effect-7, st-effect-8, st-effect-14 -->

      <!-- this is the wrapper for the content -->
      <div class="st-content">

        <!-- extra div for emulating position:fixed of the menu -->
        <div class="st-content-inner">

          <div class="container-fluid">

            <div class="media media-grid media-clearfix-xs">
            
            <br/><br/><br/><br/><br/>
            <div class="media-left">
                   
                <div class="width-250 width-auto-xs"> 
                  <div class="panel panel-default widget-user-1 text-center">
                    <div class="avatar">
                     <%
                       if(profileImage2!=null)
                       {
                    	   
                    %>
                    
                      <img src="<%= savePath1+File.separator+profileImage2 %>" alt="" class="img-circle" width="150" height="150">
                      
                       <%
                       }
                       else
                       {
                    %>
                          <img src="images2/facebook-default.jpg" alt="image" class="img-circle" width="150" height="150"/>
                    <%
                       }
                    %>
                    
                      <h3><%= userFirstName +" "+ userLastName  %></h3>
                      <!-- <a href="#" class="btn btn-success">Following <i class="fa fa-check-circle fa-fw"></i></a> -->
                    </div>
                    <!-- <div class="profile-icons margin-none">
                      <span><i class="fa fa-users"></i> 372</span>
                      <span><i class="fa fa-photo"></i> 43</span>
                      <span><i class="fa fa-video-camera"></i> 3</span>
                    </div> -->
                    <!-- <div class="panel-body">
                      <div class="expandable expandable-indicator-white expandable-trigger">
                        <div class="expandable-content">
                          
                        </div>
                      </div>
                    </div> -->
                  </div>

                  <!-- Contact -->
                  
                </div>
              </div>
              <div class="media-body">
                <div class="panel panel-default share">
                  <div class="input-group">
                     <form method="Post" action="InsertMessage" name="postForm">
                    <div class="input-group-btn">
                      <input type="button" value="Send" class="btn btn-primary" onclick="checkMessage()">

                      
                      
                    </div>
                    
                    <input type="text" class="form-control share-text" placeholder="Post message..." name="message" id="message"/>
                    
                    <input type="hidden" id="useremail" name="userEmail" value="<%= userEmail %>">
                    <input type="hidden" id="email" name="email" value="<%= myEmail %>">
                    <input type="hidden" id="inputPage" name="inputPage" value="UserProfile.jsp">
                    
                    </form>                  </div>
                </div>

                <div class="tabbable">
                  <ul class="nav nav-tabs">
                    <li class="active"><a href="#home" data-toggle="tab"><i class="fa fa-fw fa-picture-o"></i> Timeline</a></li>
                    
                  </ul>
                  <div class="tab-content">
                  
                  <div class="tab-pane fade active in" id="homeMessageOwn">
                  
                  
                      <%
                            UserInfo infoUser = new UserInfo();
                            UserDAO daoUserPerson = new UserDAO(); 
                          
                            String profileImageOwn = null;
                           
                            String firstNameUser = null;
                            
                            String lastNameUser =null;
                            
                            
                           MessageDAO daoUserMess = new MessageDAO();
                           
                           ArrayList<MessageBean> rsUserMess = daoUserMess.getMessages(userEmail);
                            int userMessCount = 0;
                           
                            
                          
                            	
                            	while(userMessCount < rsUserMess.size())
                            	{
                            		 int imageFId = rsUserMess.get(userMessCount).getImageFId();
                            		 
                            		 if(imageFId==0)
                            		 {
                            		 
                            			 infoUser.setEmail(userEmail);
                            			 
                            			 
                            			// Check whether Message is liked or not
                            		 String liked = daoUserMess.postLiked(myEmail, rsUserMess.get(userMessCount).getId());
                            		 
                            		 int messId = rsUserMess.get(userMessCount).getId();
                            		 
                            		 UserInfo rsUserMessInfo = daoUserPerson.getUserRecord(infoUser);
                            		 
                            		 int countMess = 0;
                            		 MessageDAO daoCommentsMess = new MessageDAO();
                            		 
                            		 
                            		// Get comments on message in arrayList object 
                                     ArrayList<MessageCommentBean> rsCommentsMess = daoCommentsMess.getComments(messId);
                            		 
                            			 firstNameUser = rsUserMessInfo.getFirst();
                            			 lastNameUser = rsUserMessInfo.getLast();
                            			 
                            		 
                            		 
                            		 %>
                            		 <h4> <%= firstNameUser + " "+ lastNameUser %> posted a message </h4>
                            		 
                            		 <br/>
                            		 
                            		 <%--  Display User Message   --%>
                            		 <%= rsUserMess.get(userMessCount).getMessage() %>
                            		 
                            		 <br/><br/><br/>
                            		 
                            		 
                            		 
                            		 <% 
                            		 if(liked.equals("yes"))
                                     {
                                     
                                 %>   
                                 
                                 <%-- <a href="javascript:unlikePostMess('<%= rsUserMess.get(userMessCount).getId() %>','<%= myEmail %>','<%= userEmail %>')" id="<%= rsUserMess.get(userMessCount).getId()+"_"+userEmail %>">Unlike</a> &nbsp; &nbsp; --%>
                                 
                                 <%
                                     }
                                     else
                                     {
                                 %>
                                 
                             <%--   <a href="javascript:likePostMess('<%= rsUserMess.get(userMessCount).getId() %>','<%= myEmail %>','<%= userEmail %>')" id="<%= rsUserMess.get(userMessCount).getId()+"_"+userEmail %>">Like</a> &nbsp; &nbsp; --%>
                               
                               <%
                                     }
                               %>
                              
                              
                            <%--   <a href="MessageComments.jsp?messId=<%= rsUserMess.get(userMessCount).getId()%>&email=<%= myEmail%>&userEmail=<%= userEmail %>&inputPage=UserProfile.jsp">Comment</a>&nbsp; &nbsp; --%> 
                              
                              <br/><br/>
                      
                     <form>
                 <input type="text" class="form-control" name="commentBox" id="<%= "textBox"+messId+userEmail %>" placeholder="Enter Comment">
                 <br/>
                 <input type="button" value="Post" onclick="commentOnPostMess('<%= messId %>','<%= userEmail %>');">
                 <input type="hidden" id="<%= "mess" + messId + userEmail %>" name="image" value="<%= messId %>">
                 <input type="hidden" id="<%= "userEmail" + messId + userEmail %>" name="userEmail" value="<%= userEmail %>">
                 <input type="hidden" id="<%= "email" + messId + userEmail %>" name="email" value="<%= myEmail %>">
                 <input type="hidden" id="<%= "inputPage" + messId + userEmail %>" name="inputPage" value="UserProfile.jsp">
            </form>
                              
                          
                          
          
                  <div class="panel panel-default">
                
                    <div class="view-all-comments">
                      <a href="MessageComments.jsp?messId=<%= messId %>&email=<%= myEmail%>&userEmail=<%= userEmail %>&inputPage=UserProfile.jsp">
                        <i class="fa fa-comments-o"></i> View all Comments
                      </a>
                      

                    </div>
          
          
         
          
        
         <ul class="comments" id="<%= "Comment"+messId+userEmail %>">
         
         <%
                 int commentsCount = 0;
                 while(commentsCount < rsCommentsMess.size())
                 {
                	 if(countMess<=4)
                	 {
                	    String userOfComment = rsCommentsMess.get(commentsCount).getEmailFId();
                	    String profileImageAtComments = "facebook-default.jpg";
                	    
                	    String userFirstName1 = null;
                        String userLastName1 = null;
                	    String userImagePath = null;
                	    
                	    ProfileDAO daoProfile = new ProfileDAO();
                	    ProfileInfo rsImage = daoProfile.getProfileImage(userOfComment);
                	    
                	    // Get Profile Picture of user uploaded image or message or comment
                	    if(rsImage.getfirst()!=null)
                	    {
                	    	profileImageAtComments = rsImage.getpath();
                	    	userImagePath = "images2"+ File.separator + userOfComment + File.separator + "ProfilePicture" + File.separator + profileImageAtComments;
                	    }
                	    else
                	    	userImagePath = "images2"+ File.separator + profileImageAtComments;
                	    
                	    UserInfo infoUserCommented = new UserInfo();
                        UserDAO daoUserCommented = new UserDAO();
                        infoUserCommented.setEmail(userOfComment);
                        UserInfo rsUserCommented = daoUserCommented.getUserRecord(infoUserCommented);
                        
                      	  userFirstName1 = rsUserCommented.getFirst();
                      	  userLastName1 = rsUserCommented.getLast();
                      	  
                        
                	    
                        
             
         %>
                      <li class="media">
                        <div class="media-left">
                          <%
                        if(userOfComment.equals(myEmail))
                        {
                        
                        %>
                        <a href="Profile.jsp">
                            <img src="<%= userImagePath %>" class="media-object" width="50" height="50">
                            
                          </a>
                          
                          <%
                                  }
                        else
                        {
                              %>
                        
                          <a href="UserProfile.jsp?userEmail=<%= userOfComment %>">
                            <img src="<%= userImagePath %>" class="media-object" width="50" height="50">
                            
                          </a>
                            <%
                                  }
                              %>
                        </div>
                        <div class="media-body">
                          <div class="pull-right dropdown" data-show-hover="li">
                            <a href="#" data-toggle="dropdown" class="toggle-button">
                              <i class="fa fa-pencil"></i>
                            </a>
                             <%
                                System.out.println("User Of comment equal to email: "+userOfComment.equals("email"));
                                  if(userOfComment.equals(myEmail))
                                  {
                             %>   	  
                            <ul class="dropdown-menu" role="menu">
                            
                           
                              <li><a href="MessageComments.jsp?messId=<%= messId%>&email=<%= myEmail%>&userEmail=<%= userEmail %>&inputPage=UserProfile.jsp&input=Edit&comment=<%= rsCommentsMess.get(commentsCount).getComment() %>&commentId=<%= rsCommentsMess.get(commentsCount).getId() %>">Edit</a></li>
                              <li><a href="DeleteMessComment?messId=<%= messId %>&email=<%= myEmail%>&userEmail=<%= userEmail %>&inputPage=UserProfile.jsp&commentId=<%= rsCommentsMess.get(commentsCount).getId() %>">Delete</a></li>
                              
                             
                            </ul>
                            
                               <%
                                  }
                              %>
                          </div>
                          <%
                        if(userOfComment.equals(myEmail))
                        {
                        
                        %>
                        
                        <a href="Profile.jsp" class="comment-author pull-left"><%= userFirstName1 + " " + userLastName1  %></a>
                        
                         <%
                                  }
                        else
                        {
                              %>
                        
                         <a href="UserProfile.jsp?userEmail=<%= userOfComment %>" class="comment-author pull-left"><%= userFirstName1 + " " + userLastName1  %></a>
                         
                          <%
                                  }
                              %>
                          <span><%= rsCommentsMess.get(commentsCount).getComment() %></span>
                          <div class="comment-date"><%= rsCommentsMess.get(commentsCount).getDate() %></div>
                        </div>
                      </li>
                     
                     
                      <!-- <li class="comment-form">
                        <div class="input-group">

                          <span class="input-group-btn">
                   <a href="#" class="btn btn-default"><i class="fa fa-photo"></i></a>
                </span>

                          <input type="text" class="form-control" />

                        </div> -->
                      </li>
                      
                      <%
                            countMess++;
                              }
                	           commentsCount++;
                         }
                      %>
                    </ul>
                
                      
                      
                       
                      <br/><br/><br/><br/>
                     
                  
                      
                      
                    </div>
                          
                              
                            	<% 	
                            		 }
                            		 userMessCount++;
                            		 
                            	}
                            	
                            	
                            	
                            
                        
                        
                        %>
                    
                  
                  </div>
                  
                  <div class="tab-pane fade active in" id="homeMessage">
                  
                        <%
                            UserInfo infoMess = new UserInfo();
                            UserDAO daoUserMess1 = new UserDAO(); 
                            Friends frndMess = new Friends();
                            String profileImageMess = null;
                            String friendEmailMess = null;
                            
                            
                            
                            
                           
                    		int frndsCount = 0;
                            
                           MessageDAO daoMess = new MessageDAO();
                        
                            FriendsDAO daoFriendsMess = new FriendsDAO();
                            ArrayList<Friends> rsFriendsMess = daoFriendsMess.getFriends(userEmail);
                            
                            while(frndsCount < rsFriendsMess.size())
                            {
                            	
                            	String firstNameMess = null;
                            	String lastNameMess = null;
                            	
                            	System.out.println("Friend Email: "+(rsFriendsMess.get(frndsCount).getEmail1()).equals(userEmail));
                            	
                            	if((rsFriendsMess.get(frndsCount).getEmail1()).equals(userEmail))
                            	{
                            		friendEmailMess = rsFriendsMess.get(frndsCount).getEmail2();
                            	}
                            	else
                            	{
                            		friendEmailMess = rsFriendsMess.get(frndsCount).getEmail1();
                            	}
                            	
                            	ArrayList<MessageBean> rsMessages = daoMess.getMessagesByRec(friendEmailMess, userEmail);
                            	int messCount = 0;
                            	
                            	while(messCount < rsMessages.size())
                            	{
                            		 int imageFId = rsMessages.get(messCount).getImageFId();
                            		 
                            		 if(imageFId==0)
                            		 {
                            		 
                            		 infoMess.setEmail(friendEmailMess);
                            		 
                            		// Check whether Message is liked or not
                            		 String liked = daoMess.postLiked(myEmail, rsMessages.get(messCount).getId());
                            		 
                            		 int messId = rsMessages.get(messCount).getId();
                            		 
                            	    UserInfo rsUserMess1 = daoUserMess1.getUserRecord(infoMess);
                            		 
                            		 
                            		 MessageDAO daoCommentsMess = new MessageDAO();
                            		 
                            		 
                            		// Get comments on message in arrayList object 
                                     ArrayList<MessageCommentBean> rsCommentsMess = daoCommentsMess.getComments(messId);
                            		 
                            		 
                            			 firstNameMess = rsUserMess1.getFirst();
                            			 lastNameMess = rsUserMess1.getLast();
                            			 
                            		 
                            		 
                            		 %>
                            		 <h4> <%= firstNameMess + " "+ lastNameMess %> posted a message </h4>
                            		 
                            		 <br/>
                            		 
                            		 <%--  Display User Message   --%>
                            		 <%= rsMessages.get(messCount).getMessage() %>
                            		 
                            		 <br/><br/><br/>
                            		 
                            		 
                            		 
                            		 <% 
                            		 if(liked.equals("yes"))
                                     {
                                     
                                 %>   
                                 
<%--                                  <a href="javascript:unlikePostMess('<%= rsMessages.get(messCount).getId() %>','<%= myEmail %>','<%= friendEmailMess %>')" id="<%= rsMessages.get(messCount).getId()+"_"+friendEmailMess %>">Unlike</a> --%> &nbsp; &nbsp;
                                 
                                 <%
                                     }
                                     else
                                     {
                                 %>
                                 
                               <%-- <a href="javascript:likePostMess('<%= rsMessages.get(messCount).getId() %>','<%= myEmail %>','<%= friendEmailMess %>')" id="<%= rsMessages.get(messCount).getId()+"_"+friendEmailMess %>">Like</a> &nbsp; &nbsp; --%>
                               
                               <%
                                     }
                               %>
                              
                              
                            <%-- <a href="MessageComments.jsp?messId=<%= rsMessages.get(messCount).getId()%>&email=<%= myEmail%>&userEmail=<%= friendEmailMess %>&inputPage=UserProfile.jsp">Comment</a>&nbsp; &nbsp; --%> 
                              
                              <br/><br/>
                      
                     <form>
                 <input type="text" class="form-control" name="commentBox" id="<%= "textBox"+messId+friendEmailMess %>" placeholder="Enter Comment">
                 <br/>
                 <input type="button" value="Post" onclick="commentOnPostMess('<%= messId %>','<%= friendEmailMess %>');">
                 <input type="hidden" id="<%= "mess" + messId + friendEmailMess %>" name="image" value="<%= messId %>">
                 <input type="hidden" id="<%= "userEmail" + messId + friendEmailMess %>" name="userEmail" value="<%= friendEmailMess %>">
                 <input type="hidden" id="<%= "email" + messId + friendEmailMess %>" name="email" value="<%= myEmail %>">
                 <input type="hidden" id="<%= "inputPage" + messId + friendEmailMess %>" name="inputPage" value="UserProfile.jsp">
            </form>
                              
                          
                          
          
                  <div class="panel panel-default">
                
                    <div class="view-all-comments">
                      <a href="MessageComments.jsp?messId=<%= messId %>&email=<%= myEmail%>&userEmail=<%= friendEmailMess %>&inputPage=UserProfile.jsp">
                        <i class="fa fa-comments-o"></i> View all Comments
                      </a>
                      

                    </div>
          
          
         
          
        
         <ul class="comments" id="<%= "Comment"+messId+friendEmailMess %>">
         
         <%
                  int countMess = 0;
                  int messCommentsCount = 0;
                 while(messCommentsCount < rsCommentsMess.size())
                 {
                	 if(countMess<=4)
                	 {
                	    String userOfComment = rsCommentsMess.get(messCommentsCount).getEmailFId();
                	    String profileImageAtComments = "facebook-default.jpg";
                	    
                	    String userFirstName1 = null;
                        String userLastName1 = null;
                	    String userImagePath = null;
                	    
                	    ProfileDAO daoProfile = new ProfileDAO();
                	    ProfileInfo rsImage = daoProfile.getProfileImage(userOfComment);
                	    
                	    // Get Profile Picture of user uploaded image or message or comment
                	    if(rsImage.getfirst()!=null)
                	    {
                	    	profileImageAtComments = rsImage.getpath();
                	    	userImagePath = "images2"+ File.separator + userOfComment + File.separator + "ProfilePicture" + File.separator + profileImageAtComments;
                	    }
                	    else
                	    	userImagePath = "images2"+ File.separator + profileImageAtComments;
                	    
                	    UserInfo infoUserCommented = new UserInfo();
                        UserDAO daoUserCommented = new UserDAO();
                        infoUserCommented.setEmail(userOfComment);
                        UserInfo rsUserCommented = daoUserCommented.getUserRecord(infoUserCommented);
                        
                      	  userFirstName1 = rsUserCommented.getFirst();
                      	  userLastName1 = rsUserCommented.getLast();
                      	  
                        
                	    
                        
             
         %>
                      <li class="media">
                        <div class="media-left">
                           <%
                        if(userOfComment.equals(myEmail))
                        {
                        
                        %>
                        <a href="Profile.jsp">
                            <img src="<%= userImagePath %>" class="media-object" width="50" height="50">
                            
                          </a>
                          
                          <%
                                  }
                        else
                        {
                              %>
                        
                          <a href="UserProfile.jsp?userEmail=<%= userOfComment %>">
                            <img src="<%= userImagePath %>" class="media-object" width="50" height="50">
                            
                          </a>
                            <%
                                  }
                              %>
                        </div>
                        <div class="media-body">
                          <div class="pull-right dropdown" data-show-hover="li">
                            <a href="#" data-toggle="dropdown" class="toggle-button">
                              <i class="fa fa-pencil"></i>
                            </a>
                             <%
                                System.out.println("User Of comment equal to email: "+userOfComment.equals("email"));
                                  if(userOfComment.equals(myEmail))
                                  {
                             %>   	  
                            <ul class="dropdown-menu" role="menu">
                            
                           
                              <li><a href="Comments.jsp?messId=<%= messId%>&email=<%= myEmail%>&userEmail=<%= friendEmailMess %>&inputPage=UserProfile.jsp&input=Edit&comment=<%= rsCommentsMess.get(messCommentsCount).getComment() %>&commentId=<%= rsCommentsMess.get(messCommentsCount).getId() %>">Edit</a></li>
                              <li><a href="DeleteMessComment?messId=<%= messId %>&email=<%= myEmail%>&userEmail=<%= friendEmailMess %>&inputPage=UserProfile.jsp&commentId=<%= rsCommentsMess.get(messCommentsCount).getId() %>">Delete</a></li>
                              
                             
                            </ul>
                            
                               <%
                                  }
                              %>
                          </div>
                           <%
                        if(userOfComment.equals(myEmail))
                        {
                        
                        %>
                        
                        <a href="Profile.jsp" class="comment-author pull-left"><%= userFirstName1 + " " + userLastName1  %></a>
                        
                         <%
                                  }
                        else
                        {
                              %>
                        
                         <a href="UserProfile.jsp?userEmail=<%= userOfComment %>" class="comment-author pull-left"><%= userFirstName1 + " " + userLastName1  %></a>
                         
                          <%
                                  }
                              %>
                          <span><%= rsCommentsMess.get(messCommentsCount).getComment() %></span>
                          <div class="comment-date"><%= rsCommentsMess.get(messCommentsCount).getDate() %></div>
                        </div>
                      </li>
                     
                     
                      <!-- <li class="comment-form">
                        <div class="input-group">

                          <span class="input-group-btn">
                   <a href="#" class="btn btn-default"><i class="fa fa-photo"></i></a>
                </span>

                          <input type="text" class="form-control" />

                        </div> -->
                      </li>
                      
                      <%
                            countMess++;
                              }
                	            messCommentsCount++;
                         }
                      %>
                    </ul>
                
                      
                      
                       
                      <br/><br/><br/><br/>
                     
                  
                      
                      
                    </div>
                          
                              
                            	<% 	
                            		 }
                            		 messCount++;
                            		 
                            	}
                            	
                            	frndsCount++;
                            	
                            }
                        
                        
                        %>
                    
                  </div>
                  
                  
                    <div class="tab-pane fade active in" id="home">
                    <%
                         String fileName = null;
                    
                         int imagesCount = 0;

                         while(imagesCount < imageList.size())
                         {  
                        	 int count =0;
                        	 
                             fileName = imageList.get(imagesCount).getImageName();
                             
                             String str="images2"+ File.separator + userEmail + File.separator + fileName;
                             
                             String message = null;
                             
                             String imageName = str.substring(str.lastIndexOf('\\')+1);
                             
                             
                             int messageFId = imageList.get(imagesCount).getMessageFId();
                             
                             MessageDAO daoPostMessage = new MessageDAO();
                             
                             MessageBean rsMessPost = daoPostMessage.getMessageById(messageFId);
                             
                             if(messageFId!=0)
                             {
                            	 message = rsMessPost.getMessage();
                             }
                             
                             CommentDAO daoComments = new CommentDAO();
                             
                             
                          // Get comments on image in arrayList object 
                             ArrayList<CommentBean> rsComments = daoComments.getComments(imageName, userEmail);
                             
                             System.out.println(" file : "+str);
                             
                             
                    %>
                           <h4> <%= userFirstName + " "+ userLastName %> uploaded a picture </h4>
                      
                    <br/>
                    
                                 <%
                                         if(messageFId!=0)
                                         {
                                        	 //   Display User Message
                                        	 out.print(message);
                                         }
                                  %>
                           <br/>
                    
                        	 <img src="<%= str %>" alt="image" width="150" height="150"/>
                      
                      <br/>
                      
                      <%
                            PostLikes pl = new PostLikes();
                            int numberOfLikes = pl.getPostLikes(imageName, userEmail);
                      
                            LikedOrNot lon = new LikedOrNot();
                            String liked = lon.getLikedStatus(myEmail, str, userEmail);
                            
                            if(liked.equals("yes"))
                            {
                            
                        %>   
                        
                        <%-- <a href="javascript:unlikePost('<%= imageName %>','<%= myEmail %>','<%= userEmail %>')" id="<%= imageName+"_"+userEmail %>">Unlike</a> &nbsp; &nbsp; --%>
                        
                        <%
                            }
                            else
                            {
                        %>
                        
                     <%--  <a href="javascript:likePost('<%= imageName %>','<%= myEmail %>','<%= userEmail %>')" id="<%= imageName+"_"+userEmail %>">Like</a> &nbsp; &nbsp; --%>
                      
                      <%
                            }
                      %>
                     
                     
                      <%-- <a href="Comments.jsp?image=<%= imageName%>&email=<%= myEmail%>&userEmail=<%= userEmail %>&inputPage=UserProfile.jsp">Comment</a>&nbsp; &nbsp; --%> 
                      
                      
                      <%
                          if(numberOfLikes!=0)
                          {
                      %>
                        <br/>   <%= numberOfLikes %> likes
                      <%
                          }
                          
                      %>
                      
                      
                       <br/><br/>
                      
                     <form>
                 <input type="text" class="form-control" name="commentBox" id="<%= "textBox"+imageName+userEmail %>" placeholder="Enter Comment">
                 <br/>
                 <input type="button" value="Post" onclick="commentOnPost('<%= imageName %>','<%= userEmail %>');">
                 <input type="hidden" id="<%= "img" + imageName + userEmail %>" name="image" value="<%= imageName %>">
                 <input type="hidden" id="<%= "userEmail" + imageName + userEmail %>" name="userEmail" value="<%= userEmail %>">
                 <input type="hidden" id="<%= "email" + imageName + userEmail %>" name="email" value="<%= myEmail %>">
                 <input type="hidden" id="<%= "inputPage" + imageName + userEmail %>" name="inputPage" value="UserProfile.jsp">
            </form>
         
         
    
  

    
          
                  <div class="panel panel-default">
                
                    <div class="view-all-comments">
                      <a href="Comments.jsp?image=<%= imageName %>&email=<%= myEmail%>&userEmail=<%= userEmail %>&inputPage=UserProfile.jsp">
                        <i class="fa fa-comments-o"></i> View all Comments
                      </a>
                      

                    </div>
          
          
         
          
        
         <ul class="comments" id="<%= "Comment"+imageName+userEmail %>">
         
         <%
                 int commentsCount = 0;
                 while(commentsCount < rsComments.size())
                 {
                	 if(count<=4)
                	 {
                	    String userOfComment = rsComments.get(commentsCount).getEmailFId();
                	    String profileImageAtComments = "facebook-default.jpg";
                	    
                	    String userFirstName1 = null;
                        String userLastName1 = null;
                	    String userImagePath = null;
                	    
                	    ProfileDAO daoProfile = new ProfileDAO();
                	    ProfileInfo rsImage = daoProfile.getProfileImage(userOfComment);
                	    
                	    // Get Profile Picture of user uploaded image or message or comment
                	    if(rsImage.getfirst()!=null)
                	    {
                	    	profileImageAtComments = rsImage.getpath();
                	    	userImagePath = "images2"+ File.separator + userOfComment + File.separator + "ProfilePicture" + File.separator + profileImageAtComments;
                	    }
                	    else
                	    	userImagePath = "images2"+ File.separator + profileImageAtComments;
                	    
                	    UserInfo infoUserCommented = new UserInfo();
                        UserDAO daoUserCommented = new UserDAO();
                        infoUserCommented.setEmail(userOfComment);
                        UserInfo rsUserCommented = daoUserCommented.getUserRecord(infoUserCommented);
                        
                        
                      	  userFirstName1 = rsUserCommented.getFirst();
                      	  userLastName1 = rsUserCommented.getLast();
                      	  
                        
                	    
                        
             
         %>
                      <li class="media">
                        <div class="media-left">
                          <%
                        if(userOfComment.equals(myEmail))
                        {
                        
                        %>
                        <a href="Profile.jsp">
                            <img src="<%= userImagePath %>" class="media-object" width="50" height="50">
                            
                          </a>
                          
                          <%
                                  }
                        else
                        {
                              %>
                        
                          <a href="UserProfile.jsp?userEmail=<%= userOfComment %>">
                            <img src="<%= userImagePath %>" class="media-object" width="50" height="50">
                            
                          </a>
                            <%
                                  }
                              %>
                        </div>
                        <div class="media-body">
                          <div class="pull-right dropdown" data-show-hover="li">
                            <a href="#" data-toggle="dropdown" class="toggle-button">
                              <i class="fa fa-pencil"></i>
                            </a>
                             <%
                                System.out.println("User Of comment equal to email: "+userOfComment.equals("email"));
                                  if(userOfComment.equals(myEmail))
                                  {
                             %>   	  
                            <ul class="dropdown-menu" role="menu">
                            
                           
                              <li><a href="Comments.jsp?image=<%= str%>&email=<%= myEmail%>&userEmail=<%= userEmail %>&inputPage=UserProfile.jsp&input=Edit&comment=<%= rsComments.get(commentsCount).getComment() %>&commentId=<%= rsComments.get(commentsCount).getId() %>">Edit</a></li>
                              <li><a href="Delete?image=<%= imageName %>&email=<%= myEmail%>&userEmail=<%= userEmail %>&inputPage=UserProfile.jsp&commentId=<%= rsComments.get(commentsCount).getId() %>">Delete</a></li>
                              
                             
                            </ul>
                            
                               <%
                                  }
                              %>
                          </div>
                          <%
                        if(userOfComment.equals(myEmail))
                        {
                        
                        %>
                        
                        <a href="Profile.jsp" class="comment-author pull-left"><%= userFirstName1 + " " + userLastName1  %></a>
                        
                         <%
                                  }
                        else
                        {
                              %>
                        
                         <a href="UserProfile.jsp?userEmail=<%= userOfComment %>" class="comment-author pull-left"><%= userFirstName1 + " " + userLastName1  %></a>
                         
                          <%
                                  }
                              %>
                          <span><%= rsComments.get(commentsCount).getComment() %></span>
                          <div class="comment-date"><%= rsComments.get(commentsCount).getDate() %></div>
                        </div>
                      </li>
                     
                     
                      <!-- <li class="comment-form">
                        <div class="input-group">

                          <span class="input-group-btn">
                   <a href="#" class="btn btn-default"><i class="fa fa-photo"></i></a>
                </span>

                          <input type="text" class="form-control" />

                        </div> -->
                      </li>
                      
                      <%
                            count++;
                              }
                	            commentsCount++;
                         }
                      %>
                    </ul>
                
                      
                      
                       
                      <br/><br/><br/><br/>
                     
                  
                      
                      
                    </div>
                    
                     <% 
                         imagesCount++;
                         }
                      
                      %>
                    
                    
                  </div>
                </div>
                
                <div class="row">
                  <div class="col-md-6">
                    <div class="panel panel-default">
                      <div class="panel-heading panel-heading-gray">
                        <!-- <a href="#" class="btn btn-white btn-xs pull-right"><i class="fa fa-pencil"></i></a> -->
                        <i class="fa fa-fw fa-info-circle"></i> About
                      </div>
                      <%
                             String result2="failure";
                             FriendRequestsDAO daoReq = new FriendRequestsDAO();
                             String rsRequest = daoReq.getFriendRequest(myEmail,userEmail);
                             
                             FriendsDAO daoFriends = new FriendsDAO();
                            result2 = daoFriends.selectFriends(myEmail, userEmail);
                            if(result2.equals("success"))
                            {
                      %>
                            <form action="Unfriend" method="post">
                                <input type="submit" name="Unfriend" value="Unfriend">
                                <input type="hidden" name="viewid" value="UserProfile.jsp">
                                <input type="hidden" name="userEmail" value="<%= userEmail %>">
                                
                                
                            </form>
                      <% 
                            }
                            else if(rsRequest.equals("yes"))
                            {
                      
                      %>
                          <h4><font color="blue">Friend request sent</font></h4>
                      <%
                            }
                      
                            
                            else 
                            {
                      
                      %>
                      <form action="SendRequest" method="post">
                          <input type="submit" name="send" value="Add Friend">
                          <input type="hidden" name="viewid" value="UserProfile.jsp">
                          <input type="hidden" name="userEmail" value="<%= userEmail %>">
                      </form>
                      <%
                            }
                      %>
                      
                      <div class="panel-body">
                        <ul class="list-unstyled profile-about margin-none">
                          <li class="padding-v-5">
                            <div class="row">
                              <div class="col-sm-4"><span class="text-muted">Date of Birth</span></div>
                              <div class="col-sm-8"><%= userDOB %></div>
                            </div>
                          </li>
                          
                          <li class="padding-v-5">
                            <div class="row">
                              <div class="col-sm-4"><span class="text-muted">Gender</span></div>
                              <div class="col-sm-8"><%= userGender %></div>
                            </div>
                          </li>
                          <li class="padding-v-5">
                            <div class="row">
                              <div class="col-sm-4"><span class="text-muted">Lives in</span></div>
                              <div class="col-sm-8"><%= livesIn %></div>
                            </div>
                          </li>
                          <%
                            if(profession!=null)
                            {
                            	%>
                            
                          <li class="padding-v-5">
                            <div class="row">
                              <div class="col-sm-4"><span class="text-muted">Profession</span></div>
                              <div class="col-sm-8"><%= profession %></div>
                            </div>
                          </li>
                          <li class="padding-v-5">
                            <div class="row">
                              <div class="col-sm-4"><span class="text-muted">Qualification</span></div>
                              <div class="col-sm-8"><%= qualification %></div>
                            </div>
                          </li>
                          
                          <%
                            }
                            else
                            {
                            	%>
                            
                           <li class="padding-v-5">
                            <div class="row">
                              <div class="col-sm-4"><span class="text-muted">Profession</span></div>
                              <div class="col-sm-8"> </div>
                            </div>
                          </li>
                          <li class="padding-v-5">
                            <div class="row">
                              <div class="col-sm-4"><span class="text-muted">Qualification</span></div>
                              <div class="col-sm-8"> </div>
                            </div>
                          </li>
                          <% 
                            }
                          %>
                          
                          
                          <%
                             if(worksIn!=null)
                             {
                          %>
                          <li class="padding-v-5">
                            <div class="row">
                              <div class="col-sm-4"><span class="text-muted">Works In</span></div>
                              <div class="col-sm-8"><%= worksIn %></div>
                            </div>
                          </li>
                          <%
                             }
                             else
                             {
                          %>
                          <li class="padding-v-5">
                            <div class="row">
                              <div class="col-sm-4"><span class="text-muted">Works In</span></div>
                              <div class="col-sm-8"> </div>
                            </div>
                          </li>
                          <%
                             }
                          %>
                          
                        </ul>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="panel panel-default">
                      <div class="panel-heading panel-heading-gray">
                        <!-- <div class="pull-right">
                          <a href="#" class="btn btn-primary btn-xs">Add <i class="fa fa-plus"></i></a>
                        </div> -->
                        <i class="icon-user-1"></i> Friends
                      </div>
                      <div class="panel-body">
                        <ul class="img-grid">
                          <%
                            UserInfo info1 = new UserInfo();
                            UserDAO daoUser = new UserDAO(); 
                            Friends frnd = new Friends();
                            
                    		String firstName1 = null;
                    		String lastName1 = null;
                            
                            FriendsDAO daoFriends1 = new FriendsDAO();
                            ArrayList<Friends> rsFriends = daoFriends1.getFriends(userEmail);
                            int i=1;
                            int friendsCount = 0;
                            
                            while(friendsCount < rsFriends.size())
                            {
                            	System.out.println("Value of i: "+i);
                            	i++;
                            	String profileImage1 = null;
                            	
                            	System.out.println("Friend Email: "+(rsFriends.get(friendsCount).getEmail1()).equals(userEmail));
                            	if((rsFriends.get(friendsCount).getEmail1()).equals(userEmail))
                            	{
                            		String friendEmail = rsFriends.get(friendsCount).getEmail2();
                            		ProfileDAO pic = new ProfileDAO();
                            	    System.out.println("Friend Email: "+friendEmail);
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
                            		   if(friendEmail.equals(myEmail))
                            		   {
                            %>		    
                                                  <li>
                            	 
                                    <a href="Profile.jsp?userEmail=<%= friendEmail %>">
                                   
                                          <img src="<%= savePathFriend + File.separator + profileImage1 %>" alt="image" width="200" height="200"/><%= firstName1 +" "+lastName1 %>
                                    </a>
                                   </li>
                                   
                                   <%
                            		   }
                            		   else
                            		   {
                            			   
                            		   
                                   %>
                               
                            	<li>
                            	 
                                    <a href="UserProfile.jsp?userEmail=<%= friendEmail %>">
                                   
                                          <img src="<%= savePathFriend + File.separator + profileImage1 %>" alt="image" width="200" height="200"/><%= firstName1 +" "+lastName1 %>
                                    </a>
                                   </li>
                                    <% 
                            		   }
                                         }
                                           else
                                           {
                                        	   if(friendEmail.equals(myEmail))
                                    		   {
                                     %>
                                         <li>
                            	         <a href="Profile.jsp?userEmail=<%= friendEmail %>">
                                   
                                          <img src="images2/facebook-default.jpg" alt="image" width="200" height="200"/><%= firstName1 +" "+lastName1 %>
                                    </a>
                                      </li>
                                      
                                      <%
                                    		   }
                                             else
                                             {
                                      %>
                                     
                                     <li>
                            	         <a href="UserProfile.jsp?userEmail=<%= friendEmail %>">
                                   
                                          <img src="images2/facebook-default.jpg" alt="image" width="200" height="200"/><%= firstName1 +" "+lastName1 %>
                                    </a>
                                      </li>
                                    <%
                                           }
                                           }
                                    %>
                              
                                <% 
                            	
                            		}
                            		    
                            	
                            	else
                            	{
                            		String friendEmail = rsFriends.get(friendsCount).getEmail1();
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
                            		   if(friendEmail.equals(myEmail))
                            		   {
                            %>		    
                                                  <li>
                            	 
                                    <a href="Profile.jsp?userEmail=<%= friendEmail %>">
                                   
                                          <img src="<%= savePathFriend + File.separator + profileImage1 %>" alt="image" width="200" height="200"/><%= firstName1 +" "+lastName1 %>
                                    </a>
                                   </li>
                                   
                                   <%
                            		   }
                            		   else
                            		   {
                            			   
                            		   
                                   %>
                               
                            	<li>
                            	 
                                    <a href="UserProfile.jsp?userEmail=<%= friendEmail %>">
                                   
                                          <img src="<%= savePathFriend + File.separator + profileImage1 %>" alt="image" width="200" height="200"/><%= firstName1 +" "+lastName1 %>
                                    </a>
                                   </li>
                                    <% 
                            		   }
                                         }
                                           else
                                           {
                                        	   if(friendEmail.equals(myEmail))
                                    		   {
                                     %>
                                         <li>
                            	         <a href="Profile.jsp?userEmail=<%= friendEmail %>">
                                   
                                          <img src="images2/facebook-default.jpg" alt="image" width="200" height="200"/><%= firstName1 +" "+lastName1 %>
                                    </a>
                                      </li>
                                      
                                      <%
                                    		   }
                                             else
                                             {
                                      %>
                                     
                                     <li>
                            	         <a href="UserProfile.jsp?userEmail=<%= friendEmail %>">
                                   
                                          <img src="images2/facebook-default.jpg" alt="image" width="200" height="200"/><%= firstName1 +" "+lastName1 %>
                                    </a>
                                      </li>
                                    <%
                                           }
                                           }
                                    %>

                                <% 
                            	
                            	}
                            	friendsCount++;
                            }
                        
                        %>
                          
                          
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>

             <!-- <div class="panel panel-default">
                  <div class="panel-heading panel-heading-gray">
                    <i class="fa fa-bookmark"></i> Bookmarks
                  </div>
                  <div class="panel-body">
                    <div class="row">
                      <div class="col-md-4">
                        <div class="panel panel-default">
                          <div class="panel-body">
                            <a href="#" class="h5 margin-none">Climb a Mountain</a>
                            <div class="text-muted">
                              <small><i class="fa fa-calendar"></i> 24/10/2014</small>
                            </div>
                          </div>
                          <a href="#">
                            <img src="images/place1-full.jpg" alt="image" class="img-responsive" />
                          </a>
                          <div class="panel-body">
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolor impedit ipsum laborum maiores tempore veritatis....</p>
                            <div>
                              <div class="pull-right">
                                <a href="#" class="btn btn-primary btn-xs">read</a>
                              </div>

                              <a href="#" class="text-muted"> <i class="fa fa-comments"></i> 6</a>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="panel panel-default">
                          <div class="panel-body text-center">
                            <a href="#" class="h5 margin-none">Vegetarian Pizza</a>
                            <p class="text-muted"><i class="fa fa-calendar"></i> 24/10/2014</p>
                            <span class="fa fa-star text-primary"></span>
                            <span class="fa fa-star text-primary"></span>
                            <span class="fa fa-star text-primary"></span>
                            <span class="fa fa-star text-primary"></span>
                            <span class="fa fa-star-o"></span>
                          </div>
                          <a href="#">
                            <img src="images/food1-full.jpg" alt="image" class="img-responsive" />
                          </a>
                          <div class="panel-body">
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolor impedit ipsum laborum maiores tempore veritatis....</p>
                            <div>
                              <div class="pull-right">
                                <a href="#" class="btn btn-primary btn-xs">read</a>
                              </div>
                              <a href="#" class="text-muted"> <i class="fa fa-comments"></i> 6</a>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="panel panel-default">
                          <div class="panel-body">
                            <div class="pull-right">
                              <a href="#" class="btn btn-success btn-xs"><i class="fa fa-check-circle"></i></a>
                            </div>
                            <a href="#" class="h5">Win a Holiday</a>
                            <div class="text-muted">
                              <small><i class="fa fa-calendar"></i> 24/10/2014</small>
                            </div>
                          </div>
                          <a href="#">
                            <img src="images/place2-full.jpg" alt="image" class="img-responsive" />
                          </a>
                          <ul class="icon-list icon-list-block">
                            <li><i class="fa fa-calendar fa-fw"></i> <a href="#">1 Week</a></li>
                            <li><i class="fa fa-users fa-fw"></i> <a href="#"> 2 People</a></li>
                            <li><i class="fa fa-map-marker fa-fw"></i> <a href="#">Miami, FL, USA</a></li>
                          </ul>
                        </div>
                      </div>
                    </div>
                  </div>
 -->                
 
                 </div>
              </div>
            </div>

          </div>

        </div>
        <!-- /st-content-inner -->

      </div>
      <!-- /st-content -->

    </div>
    <!-- /st-pusher -->
    
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


<script language = "javascript">  
var request;  
function likePost(imageName, email, userEmail)  
{  

var url="Like?imageName="+imageName+"&email="+email+"&userEmail="+userEmail;  
  
if(window.XMLHttpRequest){  
request=new XMLHttpRequest();  
}  
else if(window.ActiveXObject){  
request=new ActiveXObject("Microsoft.XMLHTTP");  
}  

request.onreadystatechange=function getInfo(){  
	if(request.readyState==4){  

		var id1 = imageName + "_" + userEmail;
		
		var id = document.getElementById(id1);
		
		
		
		id.href = "javascript:unlikePost('"+imageName+"','"+email+"','"+userEmail+"')";
		id.innerHTML = "Unlike";
		}
};  
request.open("GET",url,true);  
request.send();  
}  
  
</script>

 <script language = "javascript">  
var request;  
function unlikePost(imageName, email, userEmail)  
{  

	var url="Unlike?imageName="+imageName+"&email="+email+"&userEmail="+userEmail;  
  
	if(window.XMLHttpRequest){  
		request=new XMLHttpRequest();  
	}  	
	else if(window.ActiveXObject){  
		request=new ActiveXObject("Microsoft.XMLHTTP");  
	}  
  request.onreadystatechange=function success(){  
	if(request.readyState==4){  
       
		var id1 = imageName + "_" + userEmail;
		var id = document.getElementById(id1);
		
		
		id.href = "javascript:likePost('"+imageName+"','"+email+"','"+userEmail+"')";
		id.innerHTML = "Like";
		
		}
  };    
request.open("GET",url,true);  
request.send();  

}  
  
</script>  
 
 <script language = "javascript">  
var request;  
function commentOnPost(imageName, userEmail)  
{  

var url="InsertComment";  
  
if(window.XMLHttpRequest){  
request=new XMLHttpRequest();  
}  
else if(window.ActiveXObject){  
request=new ActiveXObject("Microsoft.XMLHTTP");  
}  

request.onreadystatechange=function getComment(){  
	if(request.readyState==4){  
		 
		var comment = request.responseText;
		
		if(comment.length != 0)
	    {
		  var comments = document.getElementById("Comment" + image + userEmail);
		
		  var first = comments.firstChild;
		  var li = document.createElement("li");
		  li.innerHTML = comment;
		  comments.insertBefore(li, first);
	    }
		}
};   

var idImg = "img"+imageName+userEmail;
var idUserEmail = "userEmail"+imageName+userEmail;
var idEmail = "email"+imageName+userEmail;
var idInputPage = "inputPage"+imageName+userEmail;
var idText = "textBox"+imageName+userEmail;

var image = document.getElementById(idImg).value;

var userEmail = document.getElementById(idUserEmail).value;

var email = document.getElementById(idEmail).value;

var inputPage = document.getElementById(idInputPage).value;

var commentBox = document.getElementById(idText).value;


request.open("GET",url+"?image="+image+"&userEmail="+userEmail+"&email="+email+"&inputPage="+inputPage+"&commentBox="+commentBox,true);  
request.send();  
}  
  
</script>


<script language = "javascript">  
var request;  
function likePostMess(messId, email, userEmail)  
{  

var url="MessageLike?messId="+messId+"&email="+email+"&userEmail="+userEmail;  
  
if(window.XMLHttpRequest){  
request=new XMLHttpRequest();  
}  
else if(window.ActiveXObject){  
request=new ActiveXObject("Microsoft.XMLHTTP");  
}  

request.onreadystatechange=function getInfo(){  
	if(request.readyState==4){  

		var id1 = messId + "_" + userEmail;
		
		var id = document.getElementById(id1);
		
		
		
		id.href = "javascript:unlikePostMess('"+messId+"','"+email+"','"+userEmail+"')";
		id.innerHTML = "Unlike";
		}
};  
request.open("GET",url,true);  
request.send();  
}  
  
</script>


<script language = "javascript">  
var request;  
function unlikePostMess(messId, email, userEmail)  
{  

	var url="MessageUnlike?messId="+messId+"&email="+email+"&userEmail="+userEmail;  
  
	if(window.XMLHttpRequest){  
		request=new XMLHttpRequest();  
	}  	
	else if(window.ActiveXObject){  
		request=new ActiveXObject("Microsoft.XMLHTTP");  
	}  
  request.onreadystatechange=function success(){  
	if(request.readyState==4){  
       
		var id1 = messId + "_" + userEmail;
		var id = document.getElementById(id1);
		
		
		id.href = "javascript:likePostMess('"+messId+"','"+email+"','"+userEmail+"')";
		id.innerHTML = "Like";
		
		}
  };    
request.open("GET",url,true);  
request.send();  

}  
  
</script>  
 
 
 <script language = "javascript">  
var request;  
function commentOnPostMess(messId, userEmail)  
{  

var url="InsertCommentMess";  
  
if(window.XMLHttpRequest){  
request=new XMLHttpRequest();  
}  
else if(window.ActiveXObject){  
request=new ActiveXObject("Microsoft.XMLHTTP");  
}  

request.onreadystatechange=function getComment(){  
	if(request.readyState==4){  
		 
		var comment = request.responseText;
		
		if(comment.length != 0)
	    {
		  var comments = document.getElementById("Comment" + messId + userEmail);
		
		  var first = comments.firstChild;
		  var li = document.createElement("li");
		  li.innerHTML = comment;
		  comments.insertBefore(li, first);
	    }
		}
};   

var idmess = "mess"+messId+userEmail;
var idUserEmail = "userEmail"+messId+userEmail;
var idEmail = "email"+messId+userEmail;
var idInputPage = "inputPage"+messId+userEmail;
var idText = "textBox"+messId+userEmail;

var messId = document.getElementById(idmess).value;

var userEmail = document.getElementById(idUserEmail).value;

var email = document.getElementById(idEmail).value;

var inputPage = document.getElementById(idInputPage).value;

var commentBox = document.getElementById(idText).value;


request.open("GET",url+"?messId="+messId+"&userEmail="+userEmail+"&email="+email+"&inputPage="+inputPage+"&commentBox="+commentBox,true);  
request.send();  
}  
  
</script>

<script type="text/javascript">

function checkMessage()
{
	
	  var id = document.getElementById('message').value;
	  
	  if(id==null || id=="")
		{
		
			alert("Enter Message");
		}
		else
		{
		
			 document.postForm.submit();
		}
   	
}
            
</script>   
 
  <script src="js/vendor/all.js"></script>

  
  <script src="js/app/app.js"></script>
     
    
</body>
</html>