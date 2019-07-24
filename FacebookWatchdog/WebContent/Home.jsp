<%@ page import="social.network.*,java.sql.*,social.bean.*,social.utility.*,social.dao.*,java.io.*,java.util.*" language="java" contentType="text/html; charset=ISO-8859-1"
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
                   UserInfo info = new UserInfo();
                   UserDAO daoUser = new UserDAO(); 
                
                if(session1.getAttribute("FirstName")==null)          // Check whether Session is valid or not
                {
                	
                	response.sendRedirect("UserLogin.jsp");
                    
                }
                
             // get Uploaded Images, Liked Images and Commented Images information in arrayList objects
                ArrayList<ImageBean> rsImages = new ArrayList<ImageBean>();
                ArrayList<LikeBean> rsLikedImages = new ArrayList<LikeBean>();
                ArrayList<CommentBean> rsCommentedImages = new ArrayList<CommentBean>();
                
                session1.setAttribute("Visited","no");
                String userName =  (String)session1.getAttribute("FirstName");
                String email = (String)session1.getAttribute("Email");
                System.out.println(userName);
               
                FriendsDAO daoFriends = new FriendsDAO();
                ArrayList<Friends> rsFriends = daoFriends.getFriends(email);
               
                FriendRequest frndRequest = new FriendRequest();
            	 IdDAO idDAO = new IdDAO();
            	 FriendRequestsDAO dao = new FriendRequestsDAO();
                    
            	 // Get friend requests from 'requests' table
            	 ArrayList<FriendRequest> rsRequests = dao.getFriendRequests(email);
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
                 <%=userName%> <!-- <span class="caret"> </span>-->
              </a>
              <!-- <ul class="dropdown-menu" role="menu">
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
                
                <input type="hidden" name="viewid" value="Home.jsp"> 
                <input type="hidden" name="userEmail" value="<%=email%>">
                
              </div>
            </div>
            
          </form>
          
          
          <ul class="nav navbar-nav navbar-user">
            <!-- User -->
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                Friend Requests <span class="caret"></span>
              </a>
              <ul class="dropdown-menu" role="menu">
              
              <%
                            	int requestsCount = 0;
              
                               // Display friend requests from 'requests' table
                                             while(requestsCount < rsRequests.size())
                                             {
                                            	String senderName = null;
                                                String senderEmail = rsRequests.get(requestsCount).getEmail1();
                                                info.setEmail(senderEmail);
                                                UserInfo rsSender = daoUser.getUserRecord(info);
                                                
                                                
                                                	senderName = rsSender.getFirst()+" "+rsSender.getLast();
                            %>
                <li>A friend request from <%=senderName%><span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="AcceptRequest?senderEmail=<%=senderEmail%>&inputPage=Home.jsp">Accept</a> &nbsp;&nbsp;&nbsp;&nbsp;<a href="RejectRequest?senderEmail=<%=senderEmail%>&inputPage=Home.jsp">Reject</a></span></li>
                
              
              <%
                                            	requestsCount++;
                                                             }
                                            %>
                
              </ul>
            </li>
          </ul>
          
          &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;
           <ul class="nav navbar-nav navbar-user">
            <!-- User -->
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                Banned Friends <span class="caret"></span>
              </a>
              
               <ul class="dropdown-menu" role="menu">
               
                <li> &nbsp; </li>
               
               <%
               
                         ArrayList<Friends> arrFriendsList = new FriendsDAO().getFriends(email);
               
                         int friendsCount3 = 0;
               
                         while(friendsCount3 < arrFriendsList.size())
                         {
                        	 String email1 = arrFriendsList.get(friendsCount3).getEmail1();
                        	 
                        	 String email2 = arrFriendsList.get(friendsCount3).getEmail2();
                        	 
                        	 if(!email1.equals(email))
                        	 {
                        		 
                        	 
                        	 String banned = new AccountBanDAO().checkBanEmail(arrFriendsList.get(friendsCount3).getEmail1());
                        	 
                        	 if(banned.equals("yes"))
                        	 {
               
                        		 UserInfo bannedFriend = new UserInfo();
                        		 
                        		 bannedFriend.setEmail(arrFriendsList.get(friendsCount3).getEmail1());
                        		 
                        		bannedFriend = new UserDAO().getUserRecord(bannedFriend);
               
               %>
               
                         <li>&nbsp;&nbsp;<font color="crimson" size="3"><%= "  " + bannedFriend.getFirst() + " " + bannedFriend.getLast() %>
                         
                                 &nbsp; &nbsp; &nbsp; &nbsp;<%= bannedFriend.getEmail() %>
                         </font></li>
               
                          <%
                        	 }
                          
                        	 }
                        	 else
                        	 {
                        		 
                        		 String banned = new AccountBanDAO().checkBanEmail(arrFriendsList.get(friendsCount3).getEmail2());
                        		 
                        		 if(banned.equals("yes"))
                            	 {
                   
                            		 UserInfo bannedFriend = new UserInfo();
                            		 
                            		 bannedFriend.setEmail(arrFriendsList.get(friendsCount3).getEmail2());
                            		 
                            		bannedFriend = new UserDAO().getUserRecord(bannedFriend);
                          
                          %>
                          
                            <li>&nbsp;&nbsp;<font color="crimson" size="3"><%= bannedFriend.getFirst() + " " + bannedFriend.getLast() %>
                         
                                 &nbsp; &nbsp; &nbsp; &nbsp; <%= bannedFriend.getEmail() %>
                         </font></li>
               
               <%
                            	 }
               
                        	 }
                        	 
                        	 %>
                        	 
                        	 <li> &nbsp; </li>
                        	 
                        	 <% 
                        friendsCount3++;
               
                         }
                         
               %>
              
              </ul>
            </li>
          </ul>
          
          
         
        </div>
      </div>
    </div>

    
    <div class="sidebar left sidebar-size-2 sidebar-offset-0 sidebar-visible-desktop sidebar-visible-mobile sidebar-skin-dark" id="sidebar-menu" data-type="collapse">
      <div data-scrollable>
        <ul class="sidebar-menu">
          
          <br/> <br/> <br/> <br/>
          
           <li class=""><a href="Profile.jsp"><i class="icon-user-1"></i> <span>Profile</span></a></li>
          <li class=""><a href="Friends.jsp"><i class="fa fa-group"></i> <span>Friends</span></a></li>
          
        <!--   <li class=""><a href="Photos.jsp"><i class="icon-comment-fill-1"></i> <span>Photos</span></a></li>--> 
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

    
   
    
    
    

     <div class="chat-window-container"></div>

   
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
             
               <div class="media-body">
                <div class="panel panel-default share">
                  <div class="input-group">
                  
                   <form method="Post" action="InsertMessage" name="postForm">
                    <div class="input-group-btn">
                      <input type="button" value="Send" class="btn btn-primary" onclick="checkMessage()">
                      
                      
                    </div>
                    
                    <input type="text" class="form-control share-text" placeholder="Post message..." name="message" id="message"/>
                    
                    <input type="hidden" id="useremail" name="userEmail" value="<%= email %>">
                    <input type="hidden" id="email" name="email" value="<%= email %>">
                    <input type="hidden" id="inputPage" name="inputPage" value="Profile.jsp">
                    
                    </form>
                  </div>
                </div>
                  
          

                <div class="tabbable">
                  
                  <div class="tab-content">
                    <div class="tab-pane fade active in" id="home">
                    <%
                    	String friendFirstName = null;
                                                                String friendLastName =null;
                                                                
                                                                java.util.Date date = new java.util.Date();
                                                                java.sql.Date sqlDate = new java.sql.Date(date.getTime());
                                                               
                                                                java.sql.Date lastDate = null;
                                                                
                                                                ImagesDAO daoAllImages = new ImagesDAO();
                                                                ArrayList<ImageBean> rsAllImages = daoAllImages.getImages();
                                                                

                                                            	MessageDAO daoMessagesUploaded1 = new MessageDAO();
                                                            	ArrayList<MessageBean> messList = daoMessagesUploaded1.getAllMessages();
                                                            	
                                                                
                                                                System.out.println("..................!rsAllImages.isEmpty(): "+!rsAllImages.isEmpty());
                                                     	         
                                                     	         if(!rsAllImages.isEmpty())
                                                     	         {
                                                     	        	 lastDate = rsAllImages.get(0).getDate();
                                                     	        	 System.out.println("Last Date in Home.jsp: "+lastDate);
                                                     	         }
                                                     	         else if(!messList.isEmpty())
                                                     	         {
                                                     	        	lastDate = messList.get(0).getDate();
                                                    	        	 System.out.println("Last Date in Home.jsp: "+lastDate);
                                                     	         }
                                                                
                                                                Calendar cal = Calendar.getInstance();
                                                                cal.add(Calendar.DATE, -10);
                                                                
                                                                java.sql.Date dt1 = new java.sql.Date(cal.getTimeInMillis());
                                                                
                                                                ArrayList<String> friends = new ArrayList<String>();
                                                                int friendsCount = 0; 
                                                                
                                                                while(friendsCount < rsFriends.size())
                                                                {
                                                                	if((rsFriends.get(friendsCount).getEmail1()).equals(email))
                                                                	{
                                                                		friends.add(rsFriends.get(friendsCount).getEmail2());
                                                                		
                                                                		System.out.println("Friend in Home: "+rsFriends.get(friendsCount).getEmail2());
                                                                	}
                                                                	else
                                                                	{
                                                                		friends.add(rsFriends.get(friendsCount).getEmail1());
                                                                		System.out.println("Friend in Home: "+rsFriends.get(friendsCount).getEmail1());
                                                                	}
                                                                         friendsCount++;
                                                                }
                                                                
                                                                int timeCount = 1;
                                                                
                                                                TableDAO daoTable = new TableDAO();
                                                                
                                                                
                                                                
                                                                
                                                                if(lastDate != null)
                                                                {
                                                                
                                                                while(!sqlDate.before(lastDate))
                                                                {
                                                                	
                                                                	System.out.println("In Outer While: "+!sqlDate.before(lastDate));
                                                                	
                                                                  int count = 0;
                                                                  while(count<friends.size())
                                                                  {
                                                                	  boolean condition = count<friends.size();
                                                                	  System.out.println("In Inner While: "+condition);
                                                                	  
                                                                	  System.out.println("Friend of email: "+friends.get(count));
                                                                	  
                                                                	String friendEmail = friends.get(count);
                                                                	
                                                                	UserInfo user = new UserInfo();
                                                                	user.setEmail(friendEmail);
                                                                	
                                                                	UserDAO daoUserFriend = new UserDAO();
                                                                	UserInfo rsUserFriend = daoUserFriend.getUserRecord(user);
                                                                	
                                                                		friendFirstName = rsUserFriend.getFirst();
                                                                		friendLastName = rsUserFriend.getLast();
                                                                	
                                                                	
                                                                	
                                                                	//  Get uploaded, liked and commented Messages into arrayList objects
                                                                	MessageDAO daoMessagesUploaded = new MessageDAO();
                                                                	ArrayList<MessageBean> rsMessagesUploaded = daoMessagesUploaded.getMessages(friendEmail);
                                                                	
                                                                	MessageDAO daoMessagesLiked = new MessageDAO();
                                                                	ArrayList<MessageLikeBean> rsMessagesLiked = daoMessagesLiked.getLikedPosts(friendEmail);
                                                                	
                                                                	MessageDAO daoMessagesCommented = new MessageDAO();
                                                                	ArrayList<MessageCommentBean> rsMessagesCommented = daoMessagesCommented.getCommentedPosts(friendEmail);
                                                                	
                                                                	
                                                                	
                                                                	
                                                                	 ImagesDAO daoImages = new ImagesDAO();
                                                                	 
                                                                	 // Get Images uploaded by friend
                                                          	         rsImages = daoImages.selectImages(friendEmail);
                                                          	         System.out.println("######################## Outside of messages/posts: "+rsImages.size());
                                                          	         
                                                          	         LikesDAO daoLikes = new LikesDAO();
                                                          	         rsLikedImages = daoLikes.getLikedImages(friendEmail);
                                                          	         
                                                          	         CommentDAO daoComment = new CommentDAO();
                                                          	         rsCommentedImages = daoComment.getCommentedImages(friendEmail);
                                                          	         
                                                          	         int messageUploadedCount = 0;
                                                          	         
                                                          	         while(messageUploadedCount < rsMessagesUploaded.size())
                                                          	         {
                                                          	        	 
                                                          	        	int imageFId = rsMessagesUploaded.get(messageUploadedCount).getImageFId();
                                                               		 
                                                               		 if(imageFId==0)
                                                               		 {
                                                               			 
                                                               			 
                                                               			if((rsMessagesUploaded.get(messageUploadedCount).getDate().toString()).equals(sqlDate.toString()))
                                                        	        	 {
                                                               		    
                                                               				String profImage = null;
                                                               		 
                                                               			ProfileDAO daoProfile2 = new ProfileDAO();
                                                                	    ProfileInfo rsImage1 = daoProfile2.getProfileImage(friendEmail);
                                                                	    
                                                                	    System.out.println("%%%%%%%%%%%%%%% rsImage1: "+rsImage1.getfirst());
                                                                	    
                                                                	 // Get Profile Picture of user uploaded image or message or comment
                                                                	    if(rsImage1.getfirst()!=null)
                                                                	    {
                                                                	    	profImage = "images2" + File.separator + friendEmail + File.separator + "ProfilePicture" + File.separator + rsImage1.getpath();
                                                                	    }
                                                                	    
                                                                	    else
                                                                	    {
                                                                	    	System.out.println("%%%%%%%%%%%%%%% In else of rsImage1: "+rsImage1.getfirst());
                                                                	    	profImage = "images2" + File.separator + "facebook-default.jpg";
                                                                	    }
                                                               			 
                                                                	 // Check whether Message is liked or not
                                                               		 String likedOwn = daoMessagesUploaded.postLiked(email, rsMessagesUploaded.get(messageUploadedCount).getId());
                                                               		 
                                                               		 int messIdOwn = rsMessagesUploaded.get(messageUploadedCount).getId();
                                                               		 
                                                               		 
                                                               		 
                                                               		 int countMessOwn = 0;
                                                               		 MessageDAO daoCommentsMessOwn = new MessageDAO();
                                                               		 
                                                               		 
                                                               	// Get comments on message in arrayList object 
                                                                        ArrayList<MessageCommentBean> rsCommentsMessOwn = daoCommentsMessOwn.getComments(messIdOwn);
                    %>
                       		 &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;<a href="UserProfile.jsp?email=<%=friendEmail%>"> <img src="<%=profImage%>" alt="image" width="50" height="50"/> </a> &nbsp;   <font color="royalblue" size="3"> <a href="UserProfile.jsp?email=<%=friendEmail%>"> <%=friendFirstName + " "+ friendLastName%>  </a> posted a Message</font>
                       		 
                       		 <br/> <br/>
                       		  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;
                       		 
                       		 
                       		 <%--  Display User Message   --%>
                       		 <%=rsMessagesUploaded.get(messageUploadedCount).getMessage()%> 
                       		 
                       		 <br/><br/><br/>
                       		 
                       		 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; 
                       		 
                       		 <%
                        		                        		 	if(likedOwn.equals("yes"))
                        		                        		                         		                        		                                 {
                        		                        		 %>   
                            
                            <%-- <a href="javascript:unlikePostMess1('<%=rsMessagesUploaded.get(messageUploadedCount).getId()%>','<%=email%>','<%=friendEmail%>')" id="<%="uploaded_"+rsMessagesUploaded.get(messageUploadedCount).getId()+"_"+friendEmail%>">Unlike</a> --%> &nbsp; &nbsp;
                            
                            <%
                                                        	}
                                                                                                                                                else
                                                                                                                                                {
                                                        %>
                            
                          <%-- <a href="javascript:likePostMess1('<%=rsMessagesUploaded.get(messageUploadedCount).getId()%>','<%=email%>','<%=friendEmail%>')" id="<%="uploaded_"+rsMessagesUploaded.get(messageUploadedCount).getId()+"_"+friendEmail%>">Like</a> &nbsp; &nbsp; --%>
                          
                          <%
                                                    	}
                                                    %>
                         
                        
                         
                          <%-- <a href="MessageComments.jsp?messId=<%=rsMessagesUploaded.get(messageUploadedCount).getId()%>&email=<%=email%>&userEmail=<%=friendEmail%>&inputPage=Home.jsp">Comment</a> --%>&nbsp; &nbsp; 
                         
                         <br/><br/>
                         
                         
<!--                  Form to enter Comment -->
                <form style="width: 500px;margin-left: 2.4cm;">
            <input type="text" class="form-control" name="commentBox" id="<%="textBox"+"uploaded"+messIdOwn+friendEmail%>" placeholder="Enter Comment">
            <br/>
            <input type="button" value="Post" onclick="commentOnPostMess1('<%=messIdOwn%>','<%=friendEmail%>');">
            <input type="hidden" id="<%="mess" + "uploaded"+messIdOwn + friendEmail%>" name="image" value="<%=messIdOwn%>">
            <input type="hidden" id="<%="userEmail" + "uploaded"+messIdOwn + friendEmail%>" name="userEmail" value="<%=friendEmail%>">
            <input type="hidden" id="<%="email" + "uploaded"+messIdOwn + friendEmail%>" name="email" value="<%=email%>">
            <input type="hidden" id="<%="inputPage" + "uploaded"+messIdOwn + friendEmail%>" name="inputPage" value="Home.jsp">
       </form>
                         
                     
                     <br/>
     
             <div class="panel panel-default" style="width: 500px;margin-left: 2.4cm;">
           
               <div class="view-all-comments">
                 <a href="MessageComments.jsp?messId=<%=messIdOwn%>&email=<%=email%>&userEmail=<%=friendEmail%>&inputPage=Home.jsp">
                   <i class="fa fa-comments-o"></i> View all Comments
                 </a>
                 

               </div>
     
     
    
     
   
    <ul class="comments" id="<%="Comment"+"uploaded"+messIdOwn+friendEmail%>">
    
    <%
        	int messCommentsCount = 0;
                            while(messCommentsCount < rsCommentsMessOwn.size())
                            {
                           	 if(countMessOwn<=4)
                           	 {
                           	    String userOfComment = rsCommentsMessOwn.get(messCommentsCount).getEmailFId();
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
                      	if(userOfComment.equals(email))
                                                                    {
                      %>
                        <a href="Profile.jsp">
                            <img src="<%=userImagePath%>" class="media-object" width="50" height="50">
                            
                          </a>
                          
                          <%
                                                    	}
                                                                                                                                else
                                                                                                                                {
                                                    %>
                        
                          <a href="UserProfile.jsp?userEmail=<%=userOfComment%>">
                            <img src="<%=userImagePath%>" class="media-object" width="50" height="50">
                            
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
                                                                             if(userOfComment.equals(email))
                                                                             {
                        %>   	  
                       <ul class="dropdown-menu" role="menu">
                       
                      
                         <li><a href="MessageComments.jsp?messId=<%=messIdOwn%>&email=<%=email%>&userEmail=<%=friendEmail%>&inputPage=Home.jsp&input=Edit&comment=<%=rsCommentsMessOwn.get(messCommentsCount).getComment()%>&commentId=<%=rsCommentsMessOwn.get(messCommentsCount).getId()%>">Edit</a></li>
                         <li><a href="DeleteMessComment?messId=<%=messIdOwn%>&email=<%=email%>&userEmail=<%=friendEmail%>&inputPage=Home.jsp&commentId=<%=rsCommentsMessOwn.get(messCommentsCount).getId()%>">Delete</a></li>
                         
                        
                       </ul>
                       
                          <%
                                                 	}
                                                 %>
                     </div>
                      <%
                      	if(userOfComment.equals(email))
                                                                    {
                      %>
                        
                        <a href="Profile.jsp" class="comment-author pull-left"><%=userFirstName1 + " " + userLastName1%></a>
                        
                         <%
                                                 	}
                                                                                                                          else
                                                                                                                          {
                                                 %>
                        
                         <a href="UserProfile.jsp?userEmail=<%=userOfComment%>" class="comment-author pull-left"><%=userFirstName1 + " " + userLastName1%></a>
                         
                          <%
                                                   	}
                                                   %>
                     <span><%=rsCommentsMessOwn.get(messCommentsCount).getComment()%></span>
                     <div class="comment-date"><%=rsCommentsMessOwn.get(messCommentsCount).getDate()%></div>
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
                                  	countMessOwn++;
                                                                                             }
                                                                               	               messCommentsCount++;
                                                                                        }
                                  %>
               </ul>
           
                 
                 
                  
                 <br/><br/><br/><br/>
                
             
                 
                 
               </div>
                     
                         
                       	<%
                                                                     		}
                                                                     	                                                                     	                       		 
                                                                     	                                                                     	                       	}
                                                                     	                                                                     	                       	        messageUploadedCount++;
                                                                     	                                                                     	                  	         } 	
                                                                     	                                                                     	                  	         
                                                                     	                                                                     	                  	         int imagesUploadedCount = 0;
                                                                     	                                                                     	                  	         while(imagesUploadedCount < rsImages.size())
                                                                     	                                                                     	                  	         {
                                                                     	                                                                     	                  	        	System.out.println("Sql date is : " + sqlDate);
                                                                     	                                                                     	                  	        	System.out.println("In rsImages.getDate(Date): "+rsImages.get(imagesUploadedCount).getDate());
                                                                     	                                                                     	                  	        	 
                                                                     	                                                                     	                  	        	int messageFId = rsImages.get(imagesUploadedCount).getMessageFId();
                                                                     	                                                                     	                  	        	
                                                                     	                                                                     	                  	        	
                                                                     	                                                                     	                  	        	 if((rsImages.get(imagesUploadedCount).getDate().toString()).equals(sqlDate.toString()))
                                                                     	                                                                     	                  	        	 { 
                                                                     	                                                                     	                  	        		 String profImage = null;
                                                                     	                                                                     	                  	        		String message = null;
                                                                     	                                                                     	                  	        		 
                                                                     	                                                                     	                  	        		MessageDAO daoPostMessage = new MessageDAO();
                                                                     	                                                                     	                                    
                                                                     	                                                                     	                                    MessageBean rsMessPost = daoPostMessage.getMessageById(messageFId);
                                                                     	                                                                     	                                    
                                                                     	                                                                     	                                    if(messageFId!=0)
                                                                     	                                                                     	                                    {
                                                                     	                                                                     	                                   	 message = rsMessPost.getMessage();
                                                                     	                                                                     	                                    }
                                                                     	                                                                     	                  	        		 
                                                                     	                                                                     	                  	        		 
                                                                     	                                                                     	                  	        		ProfileDAO daoProfile2 = new ProfileDAO();
                                                                     	                                                                     	                            	    ProfileInfo rsImage1 = daoProfile2.getProfileImage(friendEmail);
                                                                     	                                                                     	                            	    
                                                                     	                                                                     	                            	// Get Profile Picture of user uploaded image or message or comment
                                                                     	                                                                     	                            	    if(rsImage1.getfirst()!=null)
                                                                     	                                                                     	                            	    {
                                                                     	                                                                     	                            	    	profImage = "images2" + File.separator + friendEmail + File.separator + "ProfilePicture" + File.separator + rsImage1.getpath();
                                                                     	                                                                     	                            	    }
                                                                     	                                                                     	                            	    
                                                                     	                                                                     	                            	    else
                                                                     	                                                                     	                            	    {
                                                                     	                                                                     	                            	    	profImage = "images2" + File.separator + "facebook-default.jpg";
                                                                     	                                                                     	                            	    }
                                                                     	                                                                     	                            	    	
                                                                     	                                                                     	                  	        		 
                                                                     	                                                                     	                  	        		 System.out.println("In rsImages.getDate(Date).equals(sqlDate): "+rsImages.get(imagesUploadedCount).getDate().equals(sqlDate));
                                                                     	                                                                     	                  	        		 
                                                                     	                                                                     	                  	        		String fileName = (String)rsImages.get(imagesUploadedCount).getImageName();
                                                                     	                                                                     	                  	        		String str="images2"+ File.separator + friendEmail + File.separator + fileName;
                                                                     	                                                                     	                  	        		
                                                                     	                                                                     	                  	        		CommentDAO daoComments = new CommentDAO();
                                                                     	                                                                     	                  	        		
                                                                     	                                                                     	                  	        	// Get comments on image in arrayList object 
                                                                     	                                                                     	                                    ArrayList<CommentBean> rsComments = daoComments.getComments(fileName, friendEmail);
                                                                     	%>
                                    
                                    <br/>
                                    
                                    
        &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; <a href="UserProfile.jsp?email=<%=friendEmail%>"> <img src="<%=profImage%>" alt="image" width="50" height="50"/> </a> &nbsp; &nbsp;  <font color="royalblue" size="3"> <a href="UserProfile.jsp?email=<%=friendEmail%>"> <%=friendFirstName+" "+friendLastName%> </a> </font> <font color="royalblue" size="3">uploaded a Picture </font>
                                        
                                        <br/> <br/>
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;
                                        <%
                                        	if(messageFId!=0)
                                                                                                                         {
                                        		                                                                              //  Display User Message
                                                                                                                        	 out.print(message);   
                                                                                                                         }
                                        %>
                           <br/> <br/>
                                    
                                    
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; <img src="<%=str%>" alt="image" width="150" height="150"/>
                               	 <br/>
                  	        		
                  	        		<%
                  	        		                  	        			String userEmail = email;
                  	        		                  	        		                  	        		                  	        		                                    PostLikes pl = new PostLikes();
                  	        		                  	        		                  	        		                  	        		                                    int numberOfLikes = pl.getPostLikes(fileName, friendEmail);
                  	        		                  	        		                  	        		                  	        		                              
                  	        		                  	        		                  	        		                  	        		                                    LikedOrNot lon = new LikedOrNot();
                  	        		                  	        		                  	        		                  	        		                                    String liked = lon.getLikedStatus(email, str, friendEmail);
                  	        		                  	        		                  	        		                  	        		                                    
                  	        		                  	        		                  	        		                  	        		                                    if(liked.equals("yes"))
                  	        		                  	        		                  	        		                  	        		                                    {
                  	        		                  	        		%>
                                    	
             &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  	&nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; <%-- <a href="javascript:unlikePost1('<%=fileName%>','<%=email%>','<%=friendEmail%>')" id="<%="uploaded_" + fileName+"_"+friendEmail%>">Unlike</a> --%> &nbsp; &nbsp;
                        
                        <%
                                                	}
                                                                                                                                    
                                                                                                                                    else
                                                                                                                                    {
                                                %>
                                
             &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  <%--  <a href="javascript:likePost1('<%=fileName%>','<%=email%>','<%=friendEmail%>')" id="<%="uploaded_" + fileName+"_"+friendEmail%>">Like</a> --%> &nbsp; &nbsp;
                              <%
                              	}
                              %>
                                    
                                  <%-- <a href="Comments.jsp?image=<%=fileName%>&email=<%=email%>&userEmail=<%=friendEmail%>&inputPage=Home.jsp">Comment</a> --%>&nbsp; &nbsp; 
                                  
                                 
                                 
                                 <br/><br/>
                      
                      <!--                  Form to enter Comment -->
                    <form style="width: 500px;margin-left: 2.4cm;" >
                 <input type="text" class="form-control" name="commentBox" id="<%="textBox1"+fileName+friendEmail%>" style="width:400px!important;" placeholder="Enter Comment">
                 <br/>
                 <input type="button" value="Post" onclick="commentOnPost1('<%=fileName%>','<%=friendEmail%>');">
                 <input type="hidden" id="<%="img1" + fileName + friendEmail%>" name="image" value="<%=fileName%>">
                 <input type="hidden" id="<%="userEmail1" + fileName + friendEmail%>" name="userEmail" value="<%=friendEmail%>">
                 <input type="hidden" id="<%="email1" + fileName + friendEmail%>" name="email" value="<%=email%>">
                 <input type="hidden" id="<%="inputPage1" + fileName + friendEmail%>" name="inputPage" value="Home.jsp">
            </form>
            
          <br/> <br/>
             <div class="panel panel-default" style="width:500px; margin-left: 2.4cm">
                
                    <div class="view-all-comments">
                      
                    
                      <a href="Comments.jsp?image=<%=fileName%>&email=<%=email%>&userEmail=<%=friendEmail%>&inputPage=Home.jsp">
                        <i class="fa fa-comments-o"></i> View all Comments
                      </a>
                      
                      
                      

                    </div>
          
          
         
          
        
         <ul class="comments" id="<%="Comment1"+fileName+friendEmail%>">
         
         <%
                  	int count1 = 0;
                                             
                                                       int imageCommentsCount = 0;
                                                     while(imageCommentsCount < rsComments.size())
                                                     {
                                                    	 if(count1<=4)
                                                    	 {
                                                    	    String userOfComment = rsComments.get(imageCommentsCount).getEmailFId();
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
                                                            
                                                            System.out.println("User of Comment in Profile.jsp: "+userOfComment);
                                                            
                                                          	  userFirstName1 = rsUserCommented.getFirst();
                                                          	  userLastName1 = rsUserCommented.getLast();
                  %>
                      <li class="media">
                        <div class="media-left">
                           <%
                           	if(userOfComment.equals(email))
                                                                              {
                           %>
                        <a href="Profile.jsp">
                            <img src="<%=userImagePath%>" class="media-object" width="50" height="50">
                            
                          </a>
                          
                          <%
                                                    	}
                                                                                                                                else
                                                                                                                                {
                                                    %>
                        
                          <a href="UserProfile.jsp?userEmail=<%=userOfComment%>">
                            <img src="<%=userImagePath%>" class="media-object" width="50" height="50">
                            
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
                                                                                                                                                    if(userOfComment.equals(email))
                                                                                                                                                    {
                                                         %>   	  
                            <ul class="dropdown-menu" role="menu">
                            
                           
                              <li><a href="Comments.jsp?image=<%=fileName%>&email=<%=email%>&userEmail=<%=friendEmail%>&inputPage=Home.jsp&input=Edit&comment=<%=rsComments.get(imageCommentsCount).getComment()%>&commentId=<%=rsComments.get(imageCommentsCount).getId()%>">Edit</a></li>
                              <li><a href="Delete?image=<%=fileName%>&email=<%=email%>&userEmail=<%=friendEmail%>&inputPage=Home.jsp&commentId=<%=rsComments.get(imageCommentsCount).getId()%>">Delete</a></li>
                              
                             
                            </ul>
                            
                               <%
                                                           	}
                                                           %>
                            
                          </div>
                        
                          
                           <%
                                                                             	if(userOfComment.equals(email))
                                                                                                                                                                                  {
                                                                             %>
                        
                        <a href="Profile.jsp" class="comment-author pull-left"><%=userFirstName1 + " " + userLastName1%></a>
                        
                         <%
                                                 	}
                                                                                                                          else
                                                                                                                          {
                                                 %>
                        
                         <a href="UserProfile.jsp?userEmail=<%=userOfComment%>" class="comment-author pull-left"><%=userFirstName1 + " " + userLastName1%></a>
                         
                          <%
                                                   	}
                                                   %>
                          <span><%=rsComments.get(imageCommentsCount).getComment()%></span>
                          <div class="comment-date"><%=rsComments.get(imageCommentsCount).getDate()%></div>
                        </div>
                      </li>
                     
                     
                     <!--  <li class="comment-form">
                        <div class="input-group">

                          <span class="input-group-btn">
                   <a href="#" class="btn btn-default"><i class="fa fa-photo"></i></a>
                </span>

                          <input type="text" class="form-control" />

                        </div>
                      </li> -->
                      
                      <%
                                            	}
                                                                                                        	 count1++;
                                                                                                        	 imageCommentsCount++;
                                                                                                         }
                                            %>
                    </ul>
                      
                      
                      
                       
                      <br/><br/><br/><br/>
                     
            </div>
            
            <%
                        	}
                                                                  	        	 imagesUploadedCount++;
                                                                        }
                                                                        
                                                                  	         int messagesLikedCount = 0;
                                                                  	         while(messagesLikedCount < rsMessagesLiked.size())
                                                                  	         {
                                                                  	        	 
                                                                  	        	 int messageId = rsMessagesLiked.get(messagesLikedCount).getMessageFId();
                                                                  	        	 
                                                                  	        	 MessageBean rsMessage = daoMessagesLiked.getMessageById(messageId);
                                                                  	        	 
                                                                  	        	 
                                                                  	        		 
                                                                  	        		 String profImage = null;
                                                                  	        		 
                                                                  	        		ProfileDAO daoProfile2 = new ProfileDAO();
                                                                            	    ProfileInfo rsImage1 = daoProfile2.getProfileImage(friendEmail);
                                                                            	    
                                                                            	 // Get Profile Picture of user uploaded image or message or comment
                                                                            	    if(rsImage1.getfirst()!=null)
                                                                            	    {
                                                                            	    	profImage = "images2" + File.separator + friendEmail + File.separator + "ProfilePicture" + File.separator + rsImage1.getpath();
                                                                            	    }
                                                                            	    
                                                                            	    else
                                                                            	    {
                                                                            	    	profImage = "images2" + File.separator + "facebook-default.jpg";
                                                                            	    }
                                                                  	        		 
                                                                  	        		int imageFId = rsMessage.getImageFId();
                                                                  	        		
                                                                  	        		
                                                                          			 
                                                                           			if((rsMessage.getDate().toString()).equals(sqlDate.toString()))
                                                                    	        	 {
                                                                  	        		
                                                                  	        		String ownerMess = rsMessage.getEmailFId();
                                                                  	        		
                                                                  	        		UserDAO ownerUser = new UserDAO();
                                                                  	        		UserInfo userOwner = new UserInfo();
                                                                  	        		
                                                                  	        		String ownerFirst = null;
                                                                  	        		String ownerLast = null;
                                                                  	        		userOwner.setEmail(ownerMess);
                                                                  	        		
                                                                              		UserInfo rsOwnerMess = ownerUser.getUserRecord(userOwner);
                                                                              		
                                                                              			ownerFirst = rsOwnerMess.getFirst();
                                                                              			ownerLast = rsOwnerMess.getLast();
                                                                              		
                                                                              		
                                                                              		
                                                                              		 
                                                                              		// Check whether Message is liked or not
                                                                              		 String likedOwn = daoMessagesUploaded.postLiked(email, rsMessage.getId());
                                                                              		 
                                                                              		 int messIdOwn = rsMessage.getId();
                                                                              		 
                                                                              		 
                                                                              		 
                                                                              		 int countMessOwn = 0;
                                                                              		 MessageDAO daoCommentsMessOwn = new MessageDAO();
                                                                              		 
                                                                              	// Get comments on message in arrayList object 
                                                                                       ArrayList<MessageCommentBean> rsCommentsMessOwn = daoCommentsMessOwn.getComments(messIdOwn);
                                                                              		 
                                                                              		if(ownerMess.equals(email))
                                                                              		{
                        %>
                              		 &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;<a href="UserProfile.jsp?email=<%=friendEmail%>"> <img src="<%=profImage%>" alt="image" width="50" height="50"/> </a> &nbsp;   <font color="royalblue" size="3"> <a href="UserProfile.jsp?email=<%=friendEmail%>"> <%=friendFirstName + " "+ friendLastName%>  </a> liked   your  Message </font>                       
                              		    
                              		 <%
                                                     		                                  		 	}
                                                     		                                  		                                                      		                                  		                               		
                                                     		                                  		                                                      		                                  		                               		else if(friendEmail.equals(ownerMess))
                                                     		                                  		                                                      		                                  		                               		{
                                                     		                                  		 %>
                              			&nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;<a href="UserProfile.jsp?email=<%=friendEmail%>"> <img src="<%=profImage%>" alt="image" width="50" height="50"/> </a> &nbsp;   <font color="royalblue" size="3"> <a href="UserProfile.jsp?email=<%=friendEmail%>"> <%=friendFirstName + " "+ friendLastName%>  </a> liked   his own  Message </font>   
                              			
                              			<%
                                 			                              				}
                                 			                              			                                 			                              			                              		else
                                 			                              			                                 			                              			                              		{
                                 			                              			%>
                                     &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;<a href="UserProfile.jsp?email=<%=friendEmail%>"> <img src="<%=profImage%>" alt="image" width="50" height="50"/> </a> &nbsp;   <font color="royalblue" size="3"> <a href="UserProfile.jsp?email=<%=friendEmail%>"> <%=friendFirstName + " "+ friendLastName%>  </a> liked  <a href="UserProfile.jsp?email=<%=ownerMess%>"><%=ownerFirst + " "+ ownerLast +"'s"%> </a> Message </font>      		 
                              		 
                              		 <%
      		                               		                               		 	}
      		                               		                               		 %>
                              		 
                              		 <br/> <br/>
                              		 
                              		 &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;
                              		 
                              		 
                              		 <%--  Display User Message   --%>
                              		 <%=rsMessage.getMessage()%>
                              		 
                              		 <br/><br/><br/>
                              		 
                              		 &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;
                              		 
                              		 <%
                              		                               		 	if(likedOwn.equals("yes"))
                              		                               		                               		                               		                                        {
                              		                               		 %>   
                                   
                                   <%-- <a href="javascript:unlikePostMess2('<%=rsMessage.getId()%>','<%=email%>','<%=ownerMess%>')" id="<%="liked_"+rsMessage.getId()+"_"+ownerMess%>">Unlike</a> --%> &nbsp; &nbsp;
                                   
                                   <%
                                                                      	}
                                                                                                                                                                                   else
                                                                                                                                                                                   {
                                                                      %>
                                   
                                <%--  <a href="javascript:likePostMess2('<%=rsMessage.getId()%>','<%=email%>','<%=ownerMess%>')" id="<%="liked_"+rsMessage.getId()+"_"+ownerMess%>">Like</a> --%> &nbsp; &nbsp;
                                 
                                 <%
                                                                  	}
                                                                  %>
                                
                                
                                <%-- <a href="MessageComments.jsp?messId=<%=rsMessage.getId()%>&email=<%=email%>&userEmail=<%=ownerMess%>&inputPage=Home.jsp">Comment</a> --%>&nbsp; &nbsp;
                                
                                <br/><br/>
                        
                        <!--                  Form to enter Comment -->
                       <form style="width: 500px;margin-left: 2.4cm;">
                   <input type="text" class="form-control" name="commentBox" id="<%="textBox"+"liked"+messIdOwn+ownerMess%>" placeholder="Enter Comment">
                   <br/>
                   <input type="button" value="Post" onclick="commentOnPostMess2('<%=messIdOwn%>','<%=ownerMess%>');">
                   <input type="hidden" id="<%="mess" + "liked"+messIdOwn + ownerMess%>" name="image" value="<%=messIdOwn%>">
                   <input type="hidden" id="<%="userEmail" + "liked"+messIdOwn + ownerMess%>" name="userEmail" value="<%=ownerMess%>">
                   <input type="hidden" id="<%="email" + "liked"+messIdOwn + ownerMess%>" name="email" value="<%=email%>">
                   <input type="hidden" id="<%="inputPage" + "liked"+messIdOwn + ownerMess%>" name="inputPage" value="Home.jsp">
              </form>
                                
                            
                       <br/>     
            
                    <div class="panel panel-default" style="width: 500px;margin-left: 2.4cm;">
                  
                      <div class="view-all-comments">
                        <a href="MessageComments.jsp?messId=<%=messIdOwn%>&email=<%=email%>&userEmail=<%=ownerMess%>&inputPage=Home.jsp">
                          <i class="fa fa-comments-o"></i> View all Comments
                        </a>
                        

                      </div>
            
            
           
            
          
           <ul class="comments" id="<%="Comment"+"liked"+messIdOwn+ownerMess%>">
           
           <%
                      	int messageCommentsCount = 0;
                                                               while(messageCommentsCount < rsCommentsMessOwn.size())
                                                               {
                                                              	 if(countMessOwn<=4)
                                                              	 {
                                                              	    String userOfComment = rsCommentsMessOwn.get(messageCommentsCount).getEmailFId();
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
                             	if(userOfComment.equals(email))
                                                                                  {
                             %>
                        <a href="Profile.jsp">
                            <img src="<%=userImagePath%>" class="media-object" width="50" height="50">
                            
                          </a>
                          
                          <%
                                                    	}
                                                                                                                                else
                                                                                                                                {
                                                    %>
                        
                          <a href="UserProfile.jsp?userEmail=<%=userOfComment%>">
                            <img src="<%=userImagePath%>" class="media-object" width="50" height="50">
                            
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
                                                                                                  if(userOfComment.equals(email))
                                                                                                  {
                               %>   	  
                              <ul class="dropdown-menu" role="menu">
                              
                             
                                <li><a href="MessageComments.jsp?messId=<%=messIdOwn%>&email=<%=email%>&userEmail=<%=ownerMess%>&inputPage=Home.jsp&input=Edit&comment=<%=rsCommentsMessOwn.get(messageCommentsCount).getComment()%>&commentId=<%=rsCommentsMessOwn.get(messageCommentsCount).getId()%>">Edit</a></li>
                                <li><a href="DeleteMessComment?messId=<%=messIdOwn%>&email=<%=email%>&userEmail=<%=ownerMess%>&inputPage=Home.jsp&commentId=<%=rsCommentsMessOwn.get(messageCommentsCount).getId()%>">Delete</a></li>
                                
                               
                              </ul>
                              
                                 <%
                                                               	}
                                                               %>
                            </div>
                             <%
                             	if(userOfComment.equals(email))
                                                                                  {
                             %>
                        
                        <a href="Profile.jsp" class="comment-author pull-left"><%=userFirstName1 + " " + userLastName1%></a>
                        
                         <%
                                                 	}
                                                                                                                          else
                                                                                                                          {
                                                 %>
                        
                         <a href="UserProfile.jsp?userEmail=<%=userOfComment%>" class="comment-author pull-left"><%=userFirstName1 + " " + userLastName1%></a>
                         
                          <%
                                                   	}
                                                   %>
                            <span><%=rsCommentsMessOwn.get(messageCommentsCount).getComment()%></span>
                            <div class="comment-date"><%=rsCommentsMessOwn.get(messageCommentsCount).getDate()%></div>
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
                                                	countMessOwn++;
                                                                                                                                }
                                                                                                                  	                messageCommentsCount++;
                                                                                                                           }
                                                %>
                      </ul>
                  
                        
                        
                         
                        <br/><br/><br/><br/>
                       
                    
                        
                        
                      </div>
                            
                                
                              	<%
                                                                                          		}
                                                                                          	                                                                                          	                              		 
                                                                                          	                                                                                          	                              	
                                                                                          	                                                                                          	                  	        	 messagesLikedCount++;
                                                                                          	                                                                                          	                  	         }
                                                                                          	                                                                                          	                  	         
                                                                                          	                                                                                          	                  	         int likedImagesCount = 0;
                                                                                          	                                                                                          	                             while(likedImagesCount < rsLikedImages.size())
                                                                                          	                                                                                          	              	         {
                                                                                          	                                                                                          	              	        	String ownerFirstName = null;
                                                                                          	                                                                                          	              	        	String ownerLastName = null;
                                                                                          	                                                                                          	                            	 
                                                                                          	                                                                                          	              	        	 int imageId = rsLikedImages.get(likedImagesCount).getImageFId();
                                                                                          	                                                                                          	              	        	 
                                                                                          	                                                                                          	              	        	 ImagesDAO daoLikedPost = new ImagesDAO();
                                                                                          	                                                                                          	              	        	 
                                                                                          	                                                                                          	              	        	 ImageBean rsPost = daoLikedPost.getImageById(imageId);
                                                                                          	                                                                                          	              	        	 
                                                                                          	                                                                                          	              	        		 String emailFId = rsPost.getEmailFId();
                                                                                          	                                                                                          	              	        		 
                                                                                          	                                                                                          	              	        		UserInfo owner = new UserInfo();
                                                                                          	                                                                                          	                            	owner.setEmail(emailFId);
                                                                                          	                                                                                          	                            	
                                                                                          	                                                                                          	                            	UserDAO daoOwnerFriend = new UserDAO();
                                                                                          	                                                                                          	                            	UserInfo rsOwnerFriend = daoOwnerFriend.getUserRecord(owner);
                                                                                          	                                                                                          	                            	
                                                                                          	                                                                                          	                            		ownerFirstName = rsOwnerFriend.getFirst();
                                                                                          	                                                                                          	                            		ownerLastName = rsOwnerFriend.getLast();
                                                                                          	                                                                                          	                            	
                                                                                          	                                                                                          	              	        		
                                                                                          	                                                                                          	                 	        	 if((rsPost.getDate().toString()).equals(sqlDate.toString()))
                                                                                          	                                                                                          	                 	        	 {
                                                                                          	                                                                                          	                 	        		 
                                                                                          	                                                                                          	                 	        		String profImage = null;
                                                                                          	                                                                                          	                 	        		 
                                                                                          	                                                                                          	                 	        		 
                                                                                          	                                                                                          	                  	        		ProfileDAO daoProfile2 = new ProfileDAO();
                                                                                          	                                                                                          	                            	    ProfileInfo rsImage1 = daoProfile2.getProfileImage(friendEmail);
                                                                                          	                                                                                          	                            	    
                                                                                          	                                                                                          	                            	// Get Profile Picture of user uploaded image or message or comment
                                                                                          	                                                                                          	                            	    if(rsImage1.getfirst()!=null)
                                                                                          	                                                                                          	                            	    {
                                                                                          	                                                                                          	                            	    	profImage = "images2" + File.separator + friendEmail + File.separator + "ProfilePicture" + File.separator + rsImage1.getpath();
                                                                                          	                                                                                          	                            	    }
                                                                                          	                                                                                          	                            	    
                                                                                          	                                                                                          	                            	    else
                                                                                          	                                                                                          	                            	    {
                                                                                          	                                                                                          	                            	    	profImage = "images2" + File.separator + "facebook-default.jpg";
                                                                                          	                                                                                          	                            	    }
                                                                                          	                                                                                          	                 	        		 
                                                                                          	                                                                                          	                 	        		 
                                                                                          	                                                                                          	                 	        		String fileName = (String)rsPost.getImageName();
                                                                                          	                                                                                          	                 	        		String str="images2"+ File.separator + emailFId + File.separator + fileName;
                                                                                          	                                                                                          	                 	        		
                                                                                          	                                                                                          	                 	        		CommentDAO daoComments = new CommentDAO();
                                                                                          	                                                                                          	                 	        		
                                                                                          	                                                                                          	                 	        // Get comments on image in arrayList object 
                                                                                          	                                                                                          	                                   ArrayList<CommentBean> rsComments = daoComments.getComments(fileName, emailFId);
                                                                                          	%>
                                   
                                   <br/>
                                   
                                   <%
                                                                      	if(email.equals(emailFId))
                                                                                                              {
                                                                      %>
                                   &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  <a href="UserProfile.jsp?email=<%=friendEmail%>"> <img src="<%=profImage%>" alt="image" width="50" height="50"/> </a> &nbsp; &nbsp; <font color="royalblue" size="3"> <a href="UserProfile.jsp?email=<%=friendEmail%>"> <%=friendFirstName+" "+friendLastName +" "%> </a>  liked your Picture </font>
                 
               
                           <%
                                                           	}
                                                                                              
                                                                                                   else if(friendEmail.equals(emailFId))
                                                                                             		{
                                                           %>
                                        	
                                        	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  <a href="UserProfile.jsp?email=<%=friendEmail%>"> <img src="<%=profImage%>" alt="image" width="50" height="50"/> </a> &nbsp; &nbsp; <font color="royalblue" size="3"> <a href="UserProfile.jsp?email=<%=friendEmail%>"> <%=friendFirstName+" "+friendLastName +" "%> </a>  liked his own Picture </font>
                                        	
                                        	<%
                                        	                                        		}
                                        	                                        	                                        else
                                        	                                        	                                        {
                                        	                                        	%>
                 
                     &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  <a href="UserProfile.jsp?email=<%=friendEmail%>"> <img src="<%=profImage%>" alt="image" width="50" height="50"/> </a> &nbsp; &nbsp; <font color="royalblue" size="3"> <a href="UserProfile.jsp?email=<%=friendEmail%>"> <%=friendFirstName+" "+friendLastName +" "%> </a>  liked <%=" " + ownerFirstName+" "+ownerLastName +"'s "%> Picture </font>
                
                          <%
                                          	}
                                          %> 
                 
                                   <br/> <br/>
                                   
                 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;	&nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; <img src="<%=str%>" alt="image" width="150" height="150"/>
                              	 <br/>
                 	        		
                 	        		<%
                 	        		                 	        			String userEmail = email;
                 	        		                 	        		                                   PostLikes pl = new PostLikes();
                 	        		                 	        		                                   int numberOfLikes = pl.getPostLikes(fileName, emailFId);
                 	        		                 	        		                             
                 	        		                 	        		                                   LikedOrNot lon = new LikedOrNot();
                 	        		                 	        		                                   String liked = lon.getLikedStatus(email, str, emailFId);
                 	        		                 	        		                                   
                 	        		                 	        		                                   if(liked.equals("yes"))
                 	        		                 	        		                                   {
                 	        		                 	        		%>
                                   	
                      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  <%-- 	 <a href="javascript:unlikePost2('<%=fileName%>','<%=email%>','<%=friendEmail%>','<%=emailFId%>')" id="<%="liked_" +fileName+"_"+friendEmail + "_" + emailFId%>">Unike</a>  --%>&nbsp; &nbsp;
                       
                       <%
                                              	}
                                                                                 
                                                                                 else
                                                                                 {
                                              %>
                               
                   &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;     &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;   <%-- <a href="javascript:likePost2('<%=fileName%>','<%=email%>','<%=friendEmail%>','<%=emailFId%>')" id="<%="liked_" +fileName+"_"+friendEmail + "_" + emailFId%>">Like</a> --%> &nbsp; &nbsp;
                             <%
                             	}
                             %>
                                   
                                 <a href="Comments.jsp?image=<%=fileName%>&email=<%=email%>&userEmail=<%=emailFId%>&inputPage=Home.jsp">Comment</a>&nbsp; &nbsp; 
                                 
                                
                                
                                <br/><br/>
                     
                     <!--                  Form to enter Comment -->
                <form style="width: 500px;margin-left: 2.4cm;">
                 <input type="text" class="form-control" name="commentBox" id="<%="textBox2"+fileName+friendEmail+emailFId%>" style="width:400px!important;" placeholder="Enter Comment">
                 <br/>
                 <input type="button" value="Post" onclick="commentOnPost2('<%=fileName%>','<%=friendEmail%>','<%=emailFId%>');">
                 <input type="hidden" id="<%="img2" + fileName + friendEmail + emailFId%>" name="image" value="<%=fileName%>">
                 <input type="hidden" id="<%="userEmail2" + fileName + friendEmail + emailFId%>" name="userEmail" value="<%=emailFId%>">
                 <input type="hidden" id="<%="email2" + fileName + friendEmail + emailFId%>" name="email" value="<%=email%>">
                 <input type="hidden" id="<%="inputPage2" + fileName + friendEmail + emailFId%>" name="inputPage" value="Home.jsp">
            </form>
           
     
           <br/> <br/>
            <div class="panel panel-default" style="width:500px;margin-left: 2.4cm">
               
                   <div class="view-all-comments">
                     
                   
                     <a href="Comments.jsp?image=<%=fileName%>&email=<%=email%>&userEmail=<%=emailFId%>&inputPage=Home.jsp">
                       <i class="fa fa-comments-o"></i> View all Comments
                     </a>
                     
                     
                     

                   </div>
         
         
        
         
       
        <ul class="comments" id="<%="Comment2"+fileName+friendEmail+emailFId%>">
        
        <%
                	int count1 = 0;
                              int commentsCount = 0;
                                while(commentsCount < rsComments.size())
                                {
                               	 if(count1<=4)
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
                                       
                                       System.out.println("User of Comment in Profile.jsp: "+userOfComment);
                                       
                                     	  userFirstName1 = rsUserCommented.getFirst();
                                     	  userLastName1 = rsUserCommented.getLast();
                %>
                     <li class="media">
                        <%
                        	if(userOfComment.equals(email))
                                                {
                        %>
                        <a href="Profile.jsp">
                            <img src="<%=userImagePath%>" class="media-object" width="50" height="50">
                            
                          </a>
                          
                          <%
                                                    	}
                                                                            else
                                                                            {
                                                    %>
                        
                          <a href="UserProfile.jsp?userEmail=<%=userOfComment%>">
                            <img src="<%=userImagePath%>" class="media-object" width="50" height="50">
                            
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
                                                                                        if(userOfComment.equals(email))
                                                                                        {
                                                       %>   	  
                           <ul class="dropdown-menu" role="menu">
                           
                          
                             <li><a href="Comments.jsp?image=<%=fileName%>&email=<%=email%>&userEmail=<%=emailFId%>&inputPage=Home.jsp&input=Edit&comment=<%=rsComments.get(commentsCount).getComment()%>&commentId=<%=rsComments.get(commentsCount).getId()%>">Edit</a></li>
                             <li><a href="Delete?image=<%=fileName%>&email=<%=email%>&userEmail=<%=emailFId%>&inputPage=Home.jsp&commentId=<%=rsComments.get(commentsCount).getId()%>">Delete</a></li>
                             
                            
                           </ul>
                           
                              <%
                                                         	}
                                                         %>
                           
                         </div>
                       
                         
                          <%
                                                                          	if(userOfComment.equals(email))
                                                                                                  {
                                                                          %>
                        
                        <a href="Profile.jsp" class="comment-author pull-left"><%=userFirstName1 + " " + userLastName1%></a>
                        
                         <%
                                                 	}
                                                                         else
                                                                         {
                                                 %>
                        
                         <a href="UserProfile.jsp?userEmail=<%=userOfComment%>" class="comment-author pull-left"><%=userFirstName1 + " " + userLastName1%></a>
                         
                          <%
                                                   	}
                                                   %>
                         <span><%=rsComments.get(commentsCount).getComment()%></span>
                         <div class="comment-date"><%=rsComments.get(commentsCount).getDate()%></div>
                       </div>
                     </li>
                    
                    
                    <!--  <li class="comment-form">
                       <div class="input-group">

                         <span class="input-group-btn">
                  <a href="#" class="btn btn-default"><i class="fa fa-photo"></i></a>
               </span>

                         <input type="text" class="form-control" />

                       </div>
                     </li> -->
                     
                     <%
                                          	}
                                                                    count1++;
                                                                    commentsCount++;
                                                        	        	 }
                                          %>
                </ul>
                
                   <br/><br/><br/><br/>
                   </div>
                
                <%
                                	}
                                              	        	 
                                                                        likedImagesCount++;   
                                              	         }
                                                     
                                                            int messCommentedCount = 0;
                                                            System.out.println("*********** In rsMessagesCommented.size(): "+rsMessagesCommented.size());
                                                            
                                                             while(messCommentedCount < rsMessagesCommented.size())
                                                             {
                                                            	 
                                                                 int messageId = rsMessagesCommented.get(messCommentedCount).getMessageFId();
                                                  	        	 
                                                  	        	 MessageBean rsMessage = daoMessagesCommented.getMessageById(messageId);
                                                  	        	 
                                                  	        		 
                                                  	        		String profImage = null;
                                                	        		 
                                                	        		 
                                                  	        		ProfileDAO daoProfile2 = new ProfileDAO();
                                                            	    ProfileInfo rsImage1 = daoProfile2.getProfileImage(friendEmail);
                                                            	    
                                                            	 // Get Profile Picture of user uploaded image or message or comment
                                                            	    if(rsImage1.getfirst()!=null)
                                                            	    {
                                                            	    	profImage = "images2" + File.separator + friendEmail + File.separator + "ProfilePicture" + File.separator + rsImage1.getpath();
                                                            	    }
                                                            	    
                                                            	    else
                                                            	    {
                                                            	    	profImage = "images2" + File.separator + "facebook-default.jpg";
                                                            	    }
                                                  	        		 
                                                  	        		int imageFId = rsMessage.getImageFId();
                                                  	        		
                                                  	        		
                                                  	        		
                                                  	        		
                                                          			 
                                                           			if((rsMessage.getDate().toString()).equals(sqlDate.toString()))
                                                    	        	 {
                                                           				
                                                           				
                                                           				String displayed = daoTable.selectRecordMess(messageId, friendEmail);
                                                      	        		
                                                      	        		
                                                      	        		if(displayed.equals("no"))
                                                         	        	 {
                                                         	        	     
                                                         	        	     
                                                         	        		 int inserted = daoTable.insertRecordMess(messageId, friendEmail, "yes");
                                                         	        		 System.out.println("Temporary record inserted: "+inserted);
                                                  	        		
                                                  	        		String ownerMess = rsMessage.getEmailFId();
                                                  	        		
                                                  	        		UserDAO ownerUser = new UserDAO();
                                                  	        		UserInfo userOwner = new UserInfo();
                                                  	        		
                                                  	        		String ownerFirst = null;
                                                  	        		String ownerLast = null;
                                                  	        		userOwner.setEmail(ownerMess);
                                                  	        		
                                                              		UserInfo rsOwnerMess = ownerUser.getUserRecord(userOwner);
                                                              		
                                                              			ownerFirst = rsOwnerMess.getFirst();
                                                              			ownerLast = rsOwnerMess.getLast();
                                                              		
                                                              		
                                                              		
                                                              		
                                                              		 
                                                              		// Check whether Message is liked or not
                                                              		 String likedOwn = daoMessagesUploaded.postLiked(email, rsMessage.getId());
                                                              		 
                                                              		 int messIdOwn = rsMessage.getId();
                                                              		 
                                                              		 
                                                              		 
                                                              		 int countMessOwn = 0;
                                                              		 MessageDAO daoCommentsMessOwn = new MessageDAO();
                                                              		 
                                                              		 
                                                              	// Get comments on message in arrayList object 
                                                                       ArrayList<MessageCommentBean> rsCommentsMessOwn = daoCommentsMessOwn.getComments(messIdOwn);
                                                              		 
                                                              		if(ownerMess.equals(email))
                                                              		{
                                %>
                              		 &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;<a href="UserProfile.jsp?email=<%=friendEmail%>"> <img src="<%=profImage%>" alt="image" width="50" height="50"/> </a> &nbsp;   <font color="royalblue" size="3"> <a href="UserProfile.jsp?email=<%=friendEmail%>"> <%=friendFirstName + " "+ friendLastName%>  </a> commented on your Message </font>
                              		 
                              		 
                              		<%
                              		                               		                               			}
                              		                               		                               		                              		
                              		                               		                               		                              		else if(friendEmail.equals(ownerMess))
                              		                               		                               		                              		{
                              		                               		                               		%>
                              			&nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;<a href="UserProfile.jsp?email=<%=friendEmail%>"> <img src="<%=profImage%>" alt="image" width="50" height="50"/> </a> &nbsp;   <font color="royalblue" size="3"> <a href="UserProfile.jsp?email=<%=friendEmail%>"> <%=friendFirstName + " "+ friendLastName%>  </a> commented on his own Message </font>
                              			<%
                              				}
                              			                              		
                              			                              		else
                              			                              		{
                              			%> 
                              		 
                              		 &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;<a href="UserProfile.jsp?email=<%=friendEmail%>"> <img src="<%=profImage%>" alt="image" width="50" height="50"/> </a> &nbsp;   <font color="royalblue" size="3"> <a href="UserProfile.jsp?email=<%=friendEmail%>"> <%=friendFirstName + " "+ friendLastName%>  </a> commented on  <a href="UserProfile.jsp?email=<%=ownerMess%>"><%=ownerFirst + " "+ ownerLast +"'s"%> </a> Message </font>
                              		 
                              		 <%
                              		                               		 	}
                              		                               		 %>
                              		 
                              		 <br/> <br/>
                              		&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; 
                              		 
                              		 
                              		 <%--  Display User Message   --%>
                              		 <%=rsMessage.getMessage()%>
                              		 
                              		 <br/><br/><br/>
                              		 
                              		 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;
                              		 
                              		 <%
                              		                               		 	if(likedOwn.equals("yes"))
                              		                               		                                        {
                              		                               		 %>   
                                   
                                   <%-- <a href="javascript:unlikePostMess3('<%=rsMessage.getId()%>','<%=email%>','<%=ownerMess%>')" id="<%="commented_"+rsMessage.getId()+"_"+ownerMess%>">Unlike</a> --%> &nbsp; &nbsp;
                                   
                                   <%
                                                                      	}
                                                                                                             else
                                                                                                             {
                                                                      %>
                                   
                                 <%-- <a href="javascript:likePostMess3('<%=rsMessage.getId()%>','<%=email%>','<%=ownerMess%>')" id="<%="commented_"+rsMessage.getId()+"_"+ownerMess%>">Like</a> --%> &nbsp; &nbsp;
                                 
                                 <%
                                                                  	}
                                                                  %>
                                
                                
                                 <a href="MessageComments.jsp?messId=<%=rsMessage.getId()%>&email=<%=email%>&userEmail=<%=ownerMess%>&inputPage=Home.jsp">Comment</a>&nbsp; &nbsp;  
                                
                                <br/><br/>
                        
                        
                        <!--                  Form to enter Comment -->
                       <form style="width: 500px;margin-left: 2.4cm;">
                   <input type="text" class="form-control" name="commentBox" id="<%="textBox"+"commented"+messIdOwn+ownerMess%>" placeholder="Enter Comment">
                   <br/>
                   <input type="button" value="Post" onclick="commentOnPostMess3('<%=messIdOwn%>','<%=ownerMess%>');">
                   <input type="hidden" id="<%="mess" + "commented"+messIdOwn + ownerMess%>" name="image" value="<%=messIdOwn%>">
                   <input type="hidden" id="<%="userEmail" + "commented"+messIdOwn + ownerMess%>" name="userEmail" value="<%=ownerMess%>">
                   <input type="hidden" id="<%="email" + "commented"+messIdOwn + ownerMess%>" name="email" value="<%=email%>">
                   <input type="hidden" id="<%="inputPage" + "commented"+messIdOwn + ownerMess%>" name="inputPage" value="Home.jsp">
              </form>
                                
                            
                            <br/>
            
                    <div class="panel panel-default" style="width: 500px;margin-left: 2.4cm;">
                  
                      <div class="view-all-comments">
                        <a href="MessageComments.jsp?messId=<%=messIdOwn%>&email=<%=email%>&userEmail=<%=ownerMess%>&inputPage=Home.jsp">
                          <i class="fa fa-comments-o"></i> View all Comments
                        </a>
                        

                      </div>
            
            
           
            
          
           <ul class="comments" id="<%="Comment"+"commented"+messIdOwn+ownerMess%>">
           
           <%
                      	int commentsCount = 0;
                                         while(commentsCount < rsCommentsMessOwn.size())
                                         {
                                        	 if(countMessOwn<=4)
                                        	 {
                                        	    String userOfComment = rsCommentsMessOwn.get(commentsCount).getEmailFId();
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
                             	if(userOfComment.equals(email))
                                                     {
                             %>
                        <a href="Profile.jsp">
                            <img src="<%=userImagePath%>" class="media-object" width="50" height="50">
                            
                          </a>
                          
                          <%
                                                    	}
                                                                            else
                                                                            {
                                                    %>
                        
                          <a href="UserProfile.jsp?userEmail=<%=userOfComment%>">
                            <img src="<%=userImagePath%>" class="media-object" width="50" height="50">
                            
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
                                                                   if(userOfComment.equals(email))
                                                                   {
                               %>   	  
                              <ul class="dropdown-menu" role="menu">
                              
                             
                                <li><a href="MessageComments.jsp?messId=<%=messIdOwn%>&email=<%=email%>&userEmail=<%=ownerMess%>&inputPage=Home.jsp&input=Edit&comment=<%=rsCommentsMessOwn.get(commentsCount).getComment()%>&commentId=<%=rsCommentsMessOwn.get(commentsCount).getId()%>">Edit</a></li>
                                <li><a href="DeleteMessComment?messId=<%=messIdOwn%>&email=<%=email%>&userEmail=<%=ownerMess%>&inputPage=Home.jsp&commentId=<%=rsCommentsMessOwn.get(commentsCount).getId()%>">Delete</a></li>
                                
                               
                              </ul>
                              
                                 <%
                                                               	}
                                                               %>
                            </div>
                             <%
                             	if(userOfComment.equals(email))
                                                     {
                             %>
                        
                        <a href="Profile.jsp" class="comment-author pull-left"><%=userFirstName1 + " " + userLastName1%></a>
                        
                         <%
                                                 	}
                                                                         else
                                                                         {
                                                 %>
                        
                         <a href="UserProfile.jsp?userEmail=<%=userOfComment%>" class="comment-author pull-left"><%=userFirstName1 + " " + userLastName1%></a>
                         
                          <%
                                                   	}
                                                   %>
                            <span><%=rsCommentsMessOwn.get(commentsCount).getComment()%></span>
                            <div class="comment-date"><%=rsCommentsMessOwn.get(commentsCount).getDate()%></div>
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
                                                	countMessOwn++;
                                                                                }
                                                                  	             commentsCount++;
                                                                           }
                                                %>
                      </ul>
                  
                        
                        
                         
                        <br/><br/><br/><br/>
                       
                    
                        
                        
                      </div>
                            
                                
                              	<%
                                                                                          		}
                                                                                          	                              		 }
                                                                                          	                              		 
                                                                                          	                              	
                                                                                          	                  	        	 messCommentedCount++;
                                                                                          	                  	         }
                                                                                          		 
                                                                                          	                            	 
                                                                                          	                             
                                                                                          	                              int commentedImagesCount = 0;
                                                                                          	                             
                                                                                          	                             while(commentedImagesCount < rsCommentedImages.size())
                                                                                          	              	         {
                                                                                          	              	        	 
                                                                                          	                            	 int imageId = rsCommentedImages.get(commentedImagesCount).getImageFId();
                                                                                          	                            	 ImageBean rsPost = daoImages.getImageById(imageId);
                                                                                          	                            	 
                                                                                          	                            	 String message = null;
                                                                                          	                            	 int messageFId = 0;
                                                                                          	                            	 
                                                                                          	                            	
                                                                                          	                            		 messageFId = rsPost.getMessageFId();
                                                                                          	                            	 
                                                                                          	                            	 
                                                                                          	                            	 
                                                                                          	                            	 
                                                                                          	                            	 MessageDAO daoPostMessage = new MessageDAO();
                                                                                          	                                 
                                                                                          	                                 MessageBean rsMessPost = daoPostMessage.getMessageById(messageFId);
                                                                                          	                                 
                                                                                          	                                 if(messageFId!=0)
                                                                                          	                                 {
                                                                                          	                                	 message = rsMessPost.getMessage();
                                                                                          	                                 }
                                                                                          	                            	 
                                                                                          	                             String ownerFirstName = null;
                                                                                          	                             String ownerLastName = null;
                                                                                          	                             
                                                                                          	              	        
                                                                                          	              	        
                                                                                          	              	        		String emailFId = rsPost.getEmailFId();
                                                                                          	             	        		 
                                                                                          	              	        		UserInfo owner = new UserInfo();
                                                                                          	                            	owner.setEmail(emailFId);
                                                                                          	                            	
                                                                                          	                            	UserDAO daoOwnerFriend = new UserDAO();
                                                                                          	                            	UserInfo rsOwnerFriend = daoOwnerFriend.getUserRecord(owner);
                                                                                          	                            	
                                                                                          	                            	
                                                                                          	                            		ownerFirstName = rsOwnerFriend.getFirst();
                                                                                          	                            		ownerLastName = rsOwnerFriend.getLast();
                                                                                          	                            	
                                                                                          	              	        		
                                                                                          	              	        		 
                                                                                          	              	        		 
                                                                                          	                 	        	 if((rsPost.getDate().toString()).equals(sqlDate.toString()))
                                                                                          	                 	        	 {
                                                                                          	                 	        		 
                                                                                          	                 	        		String displayed = daoTable.selectRecord(imageId, friendEmail);
                                                                                          	                     	        	 
                                                                                          	                     	        	 if(displayed.equals("no"))
                                                                                          	                     	        	 {
                                                                                          	                     	        	     
                                                                                          	                     	        	     
                                                                                          	                     	        		 int inserted = daoTable.insertRecord(imageId, friendEmail, "yes");
                                                                                          	                     	        		 System.out.println("Temporary record inserted: "+inserted);
                                                                                          	                 	        		 
                                                                                          	                 	        		String profImage = null;
                                                                                          	                	        		 
                                                                                          	                	        		 
                                                                                          	                  	        		ProfileDAO daoProfile2 = new ProfileDAO();
                                                                                          	                            	    ProfileInfo rsImage1 = daoProfile2.getProfileImage(friendEmail);
                                                                                          	                            	    
                                                                                          	                            	// Get Profile Picture of user uploaded image or message or comment
                                                                                          	                            	    if(rsImage1.getfirst()!=null)
                                                                                          	                            	    {
                                                                                          	                            	    	profImage = "images2" + File.separator + friendEmail + File.separator + "ProfilePicture" + File.separator + rsImage1.getpath();
                                                                                          	                            	    }
                                                                                          	                            	    
                                                                                          	                            	    else
                                                                                          	                            	    {
                                                                                          	                            	    	profImage = "images2" + File.separator + "facebook-default.jpg";
                                                                                          	                            	    }
                                                                                          	                 	        		 
                                                                                          	                 	        		String fileName = (String)rsPost.getImageName();
                                                                                          	                 	        		String str="images2"+ File.separator + emailFId + File.separator + fileName;
                                                                                          	                 	        		
                                                                                          	                 	        		CommentDAO daoComments = new CommentDAO();
                                                                                          	                 	        		
                                                                                          	                 	        	// Get comments on image in arrayList object 
                                                                                          	                                   ArrayList<CommentBean> rsComments = daoComments.getComments(fileName, emailFId);
                                                                                          	                                   
                                                                                          	                                   if(emailFId.equals(email))
                                                                                          	                                   {
                                                                                          	%>
                                   
                                   <br/>
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  <a href="UserProfile.jsp?email=<%= friendEmail %>"> <img src="<%= profImage %>" alt="image" width="50" height="50"/> </a> &nbsp; &nbsp;  <font color="royalblue" size="3"> <a href="UserProfile.jsp?email=<%= friendEmail %>"> <%= friendFirstName+" "+friendLastName +" " %> </a>  commented on your Picture </font>
                             
                              
                             <%
                                   }
                                   else if(friendEmail.equals(emailFId))
                                   {
                                	   %>
                                	    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  <a href="UserProfile.jsp?email=<%= friendEmail %>"> <img src="<%= profImage %>" alt="image" width="50" height="50"/> </a> &nbsp; &nbsp;  <font color="royalblue" size="3"> <a href="UserProfile.jsp?email=<%= friendEmail %>"> <%= friendFirstName+" "+friendLastName +" " %> </a>  commented on his own Picture </font>
                                	   <% 
                                   }
                                   
                                   else
                                   {
                             
                             %> 
                            
                             &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  <a href="UserProfile.jsp?email=<%= friendEmail %>"> <img src="<%= profImage %>" alt="image" width="50" height="50"/> </a> &nbsp; &nbsp;  <font color="royalblue" size="3"> <a href="UserProfile.jsp?email=<%= friendEmail %>"> <%= friendFirstName+" "+friendLastName +" " %> </a>  commented on <%= " " + ownerFirstName+" "+ownerLastName +"'s " %> Picture </font>
                             
                                <%
                                   }
                                %>   
                                   <br/> <br/>
                                   
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;
                                    <%
                                         if(messageFId!=0)
                                         {
                                        	 // Display User Message
                                        	 out.print(message);
                                         }
                                  %>
                           <br/> <br/>
                                   
                              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;	 <img src="<%= str %>" alt="image" width="150" height="150"/>
                              	 <br/>
                 	        		
                 	        		<% 
                 	        		
                 	        		
                 	        		String userEmail = email;
                                   PostLikes pl = new PostLikes();
                                   int numberOfLikes = pl.getPostLikes(fileName, emailFId);
                             
                                   LikedOrNot lon = new LikedOrNot();
                                   String liked = lon.getLikedStatus(email, str, emailFId);
                                   
                                   if(liked.equals("yes"))
                                   {
                                   	%>
                                   	
                              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  	 <%-- <a href="javascript:unlikePost3('<%= fileName %>','<%= email %>','<%= friendEmail %>','<%= emailFId %>')" id="<%= "commented_" +fileName+"_"+friendEmail+"_"+emailFId %>">Unlike</a> --%> &nbsp; &nbsp;
                       
                       <%
                                   	
                                   }
                                   
                                   else
                                   {
                               %>
                               
                       &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  <%-- <a href="javascript:likePost3('<%= fileName %>','<%= email %>','<%= friendEmail %>','<%= emailFId %>')" id="<%= "commented_" +fileName+"_"+friendEmail+"_"+emailFId %>">Like</a> --%> &nbsp; &nbsp;
                             <% 
                 	        	 }
                                   
                                   %>
                                   
                                 <a href="Comments.jsp?image=<%= fileName%>&email=<%= email%>&userEmail=<%= friendEmail %>&inputPage=Home.jsp">Comment</a>&nbsp; &nbsp; 
                                 
                                
                                
                                <br/><br/>
                     
                    <!--                  Form to enter Comment -->
                <form style="width: 500px;margin-left: 2.4cm;">
                 <input type="text" class="form-control" name="commentBox" id="<%= "textBox3"+fileName+friendEmail+emailFId %>" style="width:400px!important;" placeholder="Enter Comment">
                 <br/>
                 <input type="button" value="Post" onclick="commentOnPost3('<%= fileName %>','<%= friendEmail %>','<%= emailFId %>');">
                 <input type="hidden" id="<%= "img3" + fileName + friendEmail + emailFId %>" name="image" value="<%= fileName %>">
                 <input type="hidden" id="<%= "userEmail3" + fileName + friendEmail + emailFId %>" name="userEmail" value="<%= emailFId %>">
                 <input type="hidden" id="<%= "email3" + fileName + friendEmail + emailFId %>" name="email" value="<%= email %>">
                 <input type="hidden" id="<%= "inputPage3" + fileName + friendEmail + emailFId %>" name="inputPage" value="Home.jsp">
            </form>
           
          <br/> <br/>
            <div class="panel panel-default" style="width: 500px; margin-left: 2.4cm">
               
                   <div class="view-all-comments">
                     
                   
                     <a href="Comments.jsp?image=<%= fileName %>&email=<%= email%>&userEmail=<%= emailFId %>&inputPage=Home.jsp">
                       <i class="fa fa-comments-o"></i> View all Comments
                     </a>
                     
                     
                     

                   </div>
         
         
        
         
       
        <ul class="comments" id="<%= "Comment3"+fileName+friendEmail+emailFId %>">
        
        <%
              int count1 = 0;
              int commentsCount = 0;
        
                while(commentsCount < rsComments.size())
                {
               	 if(count1<=4)
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
                       
                       System.out.println("User of Comment in Profile.jsp: "+userOfComment);
                       
                       
                     	  userFirstName1 = rsUserCommented.getFirst();
                     	  userLastName1 = rsUserCommented.getLast();
                     	  
                       
               	    
                       
            
        %>
                     <li class="media">
                       <div class="media-left">
                          <%
                        if(userOfComment.equals(email))
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
                                 if(userOfComment.equals(email))
                                 {
                            %>   	  
                           <ul class="dropdown-menu" role="menu">
                           
                          
                             <li><a href="Comments.jsp?image=<%= fileName%>&email=<%= email%>&userEmail=<%= emailFId %>&inputPage=Home.jsp&input=Edit&comment=<%= rsComments.get(commentsCount).getComment() %>&commentId=<%= rsComments.get(commentsCount).getId() %>">Edit</a></li>
                             <li><a href="Delete?image=<%= fileName %>&email=<%= email%>&userEmail=<%= emailFId %>&inputPage=Home.jsp&commentId=<%= rsComments.get(commentsCount).getId() %>">Delete</a></li>
                             
                            
                           </ul>
                           
                              <%
                                 }
                             %>
                           
                         </div>
                       
                         
                          <%
                        if(userOfComment.equals(email))
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
                    
                    
                    <!--  <li class="comment-form">
                       <div class="input-group">

                         <span class="input-group-btn">
                  <a href="#" class="btn btn-default"><i class="fa fa-photo"></i></a>
               </span>

                         <input type="text" class="form-control" />

                       </div>
                     </li> -->
                     
                     <%
                     }
                          count1++;
                          commentsCount++;
              	        	 }
                %>
                </ul>
                </div>
                <% 
              	        	 
              	         
                 	        	 }
              	        	 }
                 	        	 commentedImagesCount++;
              	           
              	         }
              	         
                  	        count++;	 
                        }
                          
                          Calendar cal1 = Calendar.getInstance();
             				cal1.add(Calendar.DATE, -timeCount);
             				
             				System.out.println("Cal1: "+Calendar.DATE);
             				sqlDate = new java.sql.Date(cal1.getTimeInMillis());
             				
             				System.out.println("SQL Date: "+sqlDate);
             				timeCount++;
                        }
                        }
                        
                        int truncate = daoTable.truncateTable();
                        System.out.println("Table truncated in home.jsp: "+truncate);
                        
                        int truncateMess = daoTable.truncateTableMess();
                        System.out.println("TableMess truncated in home.jsp: "+truncateMess);
                        
                        %>

                      
                  
                      
                      
                   
                   
                  </div>
                </div>
              
                
                

                
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


 <script language = "javascript">  
var request;  
function likePost1(imageName, email, userEmail)  
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

		var id1 = "uploaded_" + imageName+ "_" + userEmail;
		
		var id = document.getElementById(id1);
		
		
		
		id.href = "javascript:unlikePost1('"+imageName+"','"+email+"','"+userEmail+"')";
		id.innerHTML = "Unlike";
		
		
		
		
	}
};  


request.open("GET",url,true);  
request.send();  
}  
  
</script>

 <script language = "javascript">  
var request;  
function unlikePost1(imageName, email, userEmail)  
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
		
		var id1 = "uploaded_" + imageName+ "_" + userEmail;
		var id = document.getElementById(id1);
		
		
		id.href = "javascript:likePost1('"+imageName+"','"+email+"','"+userEmail+"')";
		id.innerHTML = "Like";
		
        
	}
  };    
request.open("GET",url,true);  
request.send();  

}  
  
</script>  



<script language = "javascript">  
var request;  
function likePost2(imageName, email, friendEmail, userEmail)  
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

		var id1 = "liked_" + imageName+ "_" + friendEmail + "_" + userEmail;
		
		var id = document.getElementById(id1);
		
		
		
		id.href = "javascript:unlikePost2('"+imageName+"','"+email+"','"+friendEmail+"','"+userEmail+"')";
		id.innerHTML = "Unlike";
		
		
		
		
	}
};  


request.open("GET",url,true);  
request.send();  
}  
  
</script>

 <script language = "javascript">  
var request;  
function unlikePost2(imageName, email, friendEmail, userEmail)  
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
		
		var id1 = "liked_" + imageName+ "_" + friendEmail + "_" + userEmail;
		var id = document.getElementById(id1);
		
		
		id.href = "javascript:likePost2('"+imageName+"','"+email+"','"+friendEmail+"','"+userEmail+"')";
		id.innerHTML = "Like";
		
        
	}
  };    
request.open("GET",url,true);  
request.send();  

}  
  
</script>  


<script language = "javascript">  
var request;  
function likePost3(imageName, email, friendEmail, userEmail)  
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

		var id1 = "commented_" + imageName+ "_" + friendEmail + "_" + userEmail;
		
		var id = document.getElementById(id1);
		
		
		
		id.href = "javascript:unlikePost3('"+imageName+"','"+email+"','"+friendEmail+"','"+userEmail+"')";
		id.innerHTML = "Unlike";
		
		
		
		
	}
};  



request.open("GET",url,true);  
request.send();  
}  
  
</script>

 <script language = "javascript">  
var request;  
function unlikePost3(imageName, email, friendEmail, userEmail)  
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
		
		var id1 = "commented_" + imageName+ "_" + friendEmail + "_" + userEmail;
		var id = document.getElementById(id1);
		
		
		id.href = "javascript:likePost3('"+imageName+"','"+email+"','"+friendEmail+"','"+userEmail+"')";
		id.innerHTML = "Like";
		
        
	}
  };    
request.open("GET",url,true);  
request.send();  

}  
  
</script>  

<script language = "javascript">  
var request;  
function commentOnPost1(imageName, userEmail)  
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
		  var comments = document.getElementById("Comment1" + image + userEmail);
		
		  var first = comments.firstChild;
		  var li = document.createElement("li");
		  li.innerHTML = comment;
		  comments.insertBefore(li, first);
	    }
		}
};   



var idImg = "img1"+imageName+userEmail;
var idUserEmail = "userEmail1"+imageName+userEmail;
var idEmail = "email1"+imageName+userEmail;
var idInputPage = "inputPage1"+imageName+userEmail;
var idText = "textBox1"+imageName+userEmail;

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
function commentOnPost2(imageName, friendEmail, userEmail)  
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
		  var comments = document.getElementById("Comment2" + image + friendEmail + userEmail);
		
		  var first = comments.firstChild;
		  var li = document.createElement("li");
		  li.innerHTML = comment;
		  comments.insertBefore(li, first);
	    }
		}
};   



var idImg = "img2"+imageName+friendEmail+userEmail;
var idUserEmail = "userEmail2"+imageName+friendEmail+userEmail;
var idEmail = "email2"+imageName+friendEmail+userEmail;
var idInputPage = "inputPage2"+imageName+friendEmail+userEmail;
var idText = "textBox2"+imageName+friendEmail+userEmail;

var image = document.getElementById(idImg).value;

var userEmail= document.getElementById(idUserEmail).value;

var email = document.getElementById(idEmail).value;

var inputPage = document.getElementById(idInputPage).value;

var commentBox = document.getElementById(idText).value;

request.open("GET",url+"?image="+image+"&userEmail="+userEmail+"&email="+email+"&inputPage="+inputPage+"&commentBox="+commentBox,true);  
request.send();  
}  
  
</script>



<script language = "javascript">  
var request;  
function commentOnPost3(imageName, friendEmail , userEmail) 
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
		  var comments = document.getElementById("Comment3" + image + friendEmail + userEmail);
		
		  var first = comments.firstChild;
		  var li = document.createElement("li");
		  li.innerHTML = comment;
		  comments.insertBefore(li, first);
	    }
		
		}
};   



var idImg = "img3"+imageName+friendEmail+userEmail;
var idUserEmail = "userEmail3"+imageName+friendEmail+userEmail;
var idEmail = "email3"+imageName+friendEmail+userEmail;
var idInputPage = "inputPage3"+imageName+friendEmail+userEmail;
var idText = "textBox3"+imageName+friendEmail+userEmail;

var image = document.getElementById(idImg).value;

var userEmail= document.getElementById(idUserEmail).value;

var email = document.getElementById(idEmail).value;

var inputPage = document.getElementById(idInputPage).value;

var commentBox = document.getElementById(idText).value;

request.open("GET",url+"?image="+image+"&userEmail="+userEmail+"&email="+email+"&inputPage="+inputPage+"&commentBox="+commentBox,true);  
request.send();  
}  
  
</script>


           <!--  Messages Uploaded-->
           
           <!--  Messages Uploaded-->



<script language = "javascript">  
var request;  
function likePostMess1(messId, email, userEmail)  
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

		var id1 = "uploaded_"+messId + "_" + userEmail;
		
		var id = document.getElementById(id1);
		
		
		
		id.href = "javascript:unlikePostMess1('"+messId+"','"+email+"','"+userEmail+"')";
		id.innerHTML = "Unlike";
		}
};  
request.open("GET",url,true);  
request.send();  
}  
  
</script>


<script language = "javascript">  
var request;  
function unlikePostMess1(messId, email, userEmail)  
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
       
		var id1 = "uploaded_"+messId + "_" + userEmail;
		var id = document.getElementById(id1);
		
		
		id.href = "javascript:likePostMess1('"+messId+"','"+email+"','"+userEmail+"')";
		id.innerHTML = "Like";
		
		}
  };    
request.open("GET",url,true);  
request.send();  

}  
  
</script>  
 
 
 <script language = "javascript">  
var request;  
function commentOnPostMess1(messId, userEmail)  
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
		  var comments = document.getElementById("Comment" + "uploaded" + messId + userEmail);
		
		  var first = comments.firstChild;
		  var li = document.createElement("li");
		  li.innerHTML = comment;
		  comments.insertBefore(li, first);
	    }
		}
};   

var idmess = "mess"+"uploaded"+messId+userEmail;
var idUserEmail = "userEmail"+"uploaded"+messId+userEmail;
var idEmail = "email"+"uploaded"+messId+userEmail;
var idInputPage = "inputPage"+"uploaded"+messId+userEmail;
var idText = "textBox"+"uploaded"+messId+userEmail;

var messId = document.getElementById(idmess).value;

var userEmail = document.getElementById(idUserEmail).value;

var email = document.getElementById(idEmail).value;

var inputPage = document.getElementById(idInputPage).value;

var commentBox = document.getElementById(idText).value;


request.open("GET",url+"?messId="+messId+"&userEmail="+userEmail+"&email="+email+"&inputPage="+inputPage+"&commentBox="+commentBox,true);  
request.send();  
}  
  
</script>


           <!--  Messages Liked-->
           
           <!--  Messages Liked-->
           
           

<script language = "javascript">  
var request;  
function likePostMess2(messId, email, userEmail)  
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

		var id1 = "liked_"+messId + "_" + userEmail;
		
		var id = document.getElementById(id1);
		
		
		
		id.href = "javascript:unlikePostMess2('"+messId+"','"+email+"','"+userEmail+"')";
		id.innerHTML = "Unlike";
		}
};  
request.open("GET",url,true);  
request.send();  
}  
  
</script>


<script language = "javascript">  
var request;  
function unlikePostMess2(messId, email, userEmail)  
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
       
		var id1 = "liked_"+messId + "_" + userEmail;
		var id = document.getElementById(id1);
		
		
		id.href = "javascript:likePostMess2('"+messId+"','"+email+"','"+userEmail+"')";
		id.innerHTML = "Like";
		
		}
  };    
request.open("GET",url,true);  
request.send();  

}  
  
</script>  
 
 
 <script language = "javascript">  
var request;  
function commentOnPostMess2(messId, userEmail)  
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
		  var comments = document.getElementById("Comment" + "liked" + messId + userEmail);
		
		  var first = comments.firstChild;
		  var li = document.createElement("li");
		  li.innerHTML = comment;
		  comments.insertBefore(li, first);
	    }
		}
};   

var idmess = "mess"+"liked"+messId+userEmail;
var idUserEmail = "userEmail"+"liked"+messId+userEmail;
var idEmail = "email"+"liked"+messId+userEmail;
var idInputPage = "inputPage"+"liked"+messId+userEmail;
var idText = "textBox"+"liked"+messId+userEmail;

var messId = document.getElementById(idmess).value;

var userEmail = document.getElementById(idUserEmail).value;

var email = document.getElementById(idEmail).value;

var inputPage = document.getElementById(idInputPage).value;

var commentBox = document.getElementById(idText).value;


request.open("GET",url+"?messId="+messId+"&userEmail="+userEmail+"&email="+email+"&inputPage="+inputPage+"&commentBox="+commentBox,true);  
request.send();  
}  
  
</script>
           
           <!--  Messages Commented-->
           
           <!--  Messages Commented-->
           
           
<script language = "javascript">  
var request;  
function likePostMess3(messId, email, userEmail)  
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

		var id1 = "commented_"+messId + "_" + userEmail;
		
		var id = document.getElementById(id1);
		
		
		
		id.href = "javascript:unlikePostMess3('"+messId+"','"+email+"','"+userEmail+"')";
		id.innerHTML = "Unlike";
		}
};  
request.open("GET",url,true);  
request.send();  
}  
  
</script>


<script language = "javascript">  
var request;  
function unlikePostMess3(messId, email, userEmail)  
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
       
		var id1 = "commented_"+messId + "_" + userEmail;
		var id = document.getElementById(id1);
		
		
		id.href = "javascript:likePostMess3('"+messId+"','"+email+"','"+userEmail+"')";
		id.innerHTML = "Like";
		
		}
  };    
request.open("GET",url,true);  
request.send();  

}  
  
</script>  
 
 
 <script language = "javascript">  
var request;  
function commentOnPostMess3(messId, userEmail)  
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
		  var comments = document.getElementById("Comment" + "commented" + messId + userEmail);
		
		  var first = comments.firstChild;
		  var li = document.createElement("li");
		  li.innerHTML = comment;
		  comments.insertBefore(li, first);
	    }
		}
};   

var idmess = "mess"+"commented"+messId+userEmail;
var idUserEmail = "userEmail"+"commented"+messId+userEmail;
var idEmail = "email"+"commented"+messId+userEmail;
var idInputPage = "inputPage"+"commented"+messId+userEmail;
var idText = "textBox"+"commented"+messId+userEmail;

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
 
  <script src="js/vendor/all.js"></script>

  
  <script src="js/app/app.js"></script>

 
</body>
</html>