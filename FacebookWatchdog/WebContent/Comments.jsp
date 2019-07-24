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
       HttpSession session1 = request.getSession(false);

       String email = (String)session1.getAttribute("Email");
       String userEmail = request.getParameter("userEmail");
       String firstName = (String)session1.getAttribute("FirstName");
       String lastName = (String)session1.getAttribute("LastName");
       
       String imageName = request.getParameter("image");
       String inputPage = request.getParameter("inputPage");
       
       if(session1.getAttribute("FirstName")==null)         // Check whether Session is valid or not
       {
 	
       	response.sendRedirect("UserLogin.jsp");
     
       }
       
       String profImage = null;
  
       String input = request.getParameter("input");
       
       String userFirstName = null;
       String userLastName = null;
       
      String imagePath = "images2" + File.separator + userEmail + File.separator + imageName;
       
      
      ProfileDAO daoProfile2 = new ProfileDAO();
	    ProfileInfo rsImage1 = daoProfile2.getProfileImage(userEmail);
	    
	    // Get Profile Picture of user uploaded image
	    if(rsImage1.getfirst()!=null)
	    {
	    	profImage = "images2" + File.separator + userEmail + File.separator + "ProfilePicture" + File.separator + rsImage1.getpath();
	    }
	    
	    else
	    {
	    	profImage = "images2" + File.separator + "facebook-default.jpg";
	    }
      
       UserInfo info = new UserInfo();
       UserDAO dao = new UserDAO();
       info.setEmail(userEmail);
       UserInfo rsUser = dao.getUserRecord(info);
       
     	  userFirstName = rsUser.getFirst();
     	  userLastName = rsUser.getLast();
       
       
       System.out.println("Image Name & User Email: "+imageName+" "+userEmail);
       CommentDAO daoComments = new CommentDAO();
       
       // Get comments on Image uploaded by user
       ArrayList<CommentBean> rsComments = daoComments.getComments(imageName, userEmail);


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
                
                <li><a href="UserLogin.jsp">Logout</a></li>
                <li><a href="Upload.jsp">Upload Picture</a></li>
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
                <input type="hidden" name="viewid" value="Comments.jsp">
                
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
          
       <!--     <li class=""><a href="Photos.jsp"><i class="icon-comment-fill-1"></i> <span>Photos</span></a></li>-->
          <li class=""><a href="Messages.jsp"><i class="icon-comment-fill-1"></i> <span>Messages</span></a></li>
          
          <li><a href="LogoutServlet"><i class="icon-lock-fill"></i> <span>Login</span></a></li>
          
           <li><a href="Politics.jsp"><i class="icon-lock-fill"></i> <span>Politics</span></a></li>
          
           <li><a href="Entertainment.jsp"><i class="icon-lock-fill"></i> <span>Entertainment</span></a></li>
           
           <li><a href="History.jsp"><i class="icon-lock-fill"></i> <span>History</span></a></li>
           
            <li><a href="Education.jsp"><i class="icon-lock-fill"></i> <span>Education</span></a></li>
            
             <li><a href="Sports.jsp"><i class="icon-lock-fill"></i> <span>Sports</span></a></li>
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
            
            <div class="st-content-inner">

          <div class="container-fluid">

            <div class="media media-grid media-clearfix-xs">
            
            <div class="media-body">
            
             <div class="tabbable">
                  
                  <div class="tab-content">
                  
                  
                  
                  <div class="tab-pane fade active in" id="homeMessage1">

<br/> <br/><br/>
           <center> 
           
           <%
                       if(email.equals(userEmail))
                       {
                    	   
                       
                  %>
           
                         <a href="Profile.jsp?userEmail=<%= userEmail %>"> <img src="<%= profImage %>" alt="image" width="50" height="50"/> </a> <font color="royalblue" size="3"> <a href="Profile.jsp?email=<%= userEmail %>"><%= userFirstName + " "+ userLastName %> </a> uploaded a picture</font>
           
           <%
                       }
                  
                       else
                       {
                    	   
                       
                  %>
           
           <a href="UserProfile.jsp?userEmail=<%= userEmail %>"> <img src="<%= profImage %>" alt="image" width="50" height="50"/> </a> <font color="royalblue" size="3"> <a href="UserProfile.jsp?userEmail=<%= userEmail %>"><%= userFirstName + " "+ userLastName %> </a> uploaded a picture</font>
            
            <%
                       }
           %>
            
            <br/><br/>
            
            <img src="<%= imagePath %>" alt="image" width="150" height="150"/> </center>
            
            <br/>
            
            <%
            LikedOrNot lon = new LikedOrNot();
            String liked = lon.getLikedStatus(email, imagePath, userEmail);
            
            if(liked.equals("yes"))
            {
            	%>
            	
      &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
       <a href="javascript:unlikePost('<%= imageName %>','<%= email %>','<%= userEmail %>')" id="liked">Unlike</a>

<%
            	
            }
            
            else
            {
        %>
        
        &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;   
 <a href="javascript:likePost('<%= imageName %>','<%= email %>','<%=userEmail %>')" id="liked">Like</a>

    

      <% 
      	 }
          %>
          
           <br/> <br/>
           <%   
            
                  if(input!=null)
                  {
            %>
         
         <center>
         
               <!--   form to enter comment -->
            <form style="width: 700px;" action="InsertComment" name="form1" method="post">
                 <input type="text" class="form-control" name="commentBox" value="<%= request.getParameter("comment") %>" id="textBox" placeholder="Enter Comment">
                 <br/>
                 <input type="button" value="Post" onclick="commentOnPost();">
                 <input type="hidden" id="img" name="image" value="<%= imageName %>">
                 <input type="hidden" id="useremail" name="userEmail" value="<%= userEmail %>">
                 <input type="hidden" id="email" name="email" value="<%= email %>">
                  <input type="hidden" id="inputpage" name="inputPage" value="Comments.jsp">
                  
                   <input type="hidden" id="input" name="input" value="Edit">
                   <input type="hidden" id="oldComment" name="oldComment" value="<%= request.getParameter("comment") %>">
                   <input type="hidden" id="commentId" name="commentId" value="<%= Integer.parseInt( request.getParameter("commentId").toString()) %>">
                   
            </form>
            </center>
            <%
                  } 
                  else
                  {
            %>
            
            <center>
            
                   <!--                form to enter comment -->
                   <form style="width: 700px;">
                 <input type="text" class="form-control" name="commentBox" id="textBox1" placeholder="Enter Comment">
                 <br/>
                 <input type="button" value="Post" onclick="commentOnPost1();">
                 <input type="hidden" id="img1" name="image" value="<%= imageName %>">
                 <input type="hidden" id="useremail1" name="userEmail" value="<%= userEmail %>">
                 <input type="hidden" id="email1" name="email" value="<%= email %>">
                 <input type="hidden" id="inputpage1" name="inputPage" value="Comments.jsp">
            </form>
            
            <%
                  }
            %>
                  
         </center>
         
    
        <br/> <br/>

    
          
                  <div class="panel panel-default" style="width:800px;margin-left: 4cm">
                
                    
          
          
         
          
        
         <ul class="comments" id="comments">
         
         <%
                int commentsCount = 0;
                 while(commentsCount < rsComments.size())
                 {
                	    String userOfComment = rsComments.get(commentsCount).getEmailFId();
                	    String profileImage = "facebook-default.jpg";
                	    
                	    String userFirstName1 = null;
                        String userLastName1 = null;
                	    String userImagePath = null;
                	    
                	    ProfileDAO daoProfile = new ProfileDAO();
                	    ProfileInfo rsImage = daoProfile.getProfileImage(userOfComment);
                	    
                	    // Get profile picture of user
                	    if(rsImage.getfirst()!=null)
                	    {
                	    	profileImage = rsImage.getpath();
                	    	userImagePath = "images2"+ File.separator + userOfComment + File.separator + "ProfilePicture" + File.separator + profileImage;
                	    }
                	    else
                	    	userImagePath = "images2"+ File.separator + profileImage;
                	    
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
                            <ul class="dropdown-menu" role="menu">
                            
                            <%
                                System.out.println("User Of comment equal to email: "+userOfComment.equals("email"));
                                  if(userOfComment.equals(email))
                                  {
                             %>   	  
                             <li><a href="Comments.jsp?image=<%= imageName%>&email=<%= email%>&userEmail=<%= userEmail %>&inputPage=Comments.jsp&input=Edit&comment=<%= rsComments.get(commentsCount).getComment() %>&commentId=<%= rsComments.get(commentsCount).getId() %>">Edit</a></li>
                              <li><a href="Delete?image=<%= imageName %>&email=<%= email%>&userEmail=<%= userEmail %>&inputPage=Comments.jsp&commentId=<%= rsComments.get(commentsCount).getId() %>">Delete</a></li>
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
                     
                     
                      <li class="comment-form">
                        <div class="input-group">

                          <span class="input-group-btn">
                   <a href="#" class="btn btn-default"><i class="fa fa-photo"></i></a>
                </span>

                          <input type="text" class="form-control" />

                        </div>
                      </li>
                      
                      <%
                            commentsCount++;
                              }
                      %>
                    </ul>
         
             
          
          
         </div>
         </div>
         </div>
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
    <!-- // Footer -->
     -->

  </div>
  <!-- /st-container -->
           
           
           
           
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
		var val="javascript:unlikePost('"+imageName+"','"+email+"','"+userEmail+"')"; 
		document.getElementById('liked').href=val;
		document.getElementById('liked').innerHTML="Unlike";
		
		
		
		
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
		var val="javascript:likePost('"+imageName+"','"+email+"','"+userEmail+"')";

		document.getElementById('liked').href=val;
		document.getElementById('liked').innerHTML="Like";
		
        
	}
  };    
request.open("GET",url,true);  
request.send();  

}  
  
</script>  


<script language = "javascript">  
var request;  
function commentOnPost()  
{  

var commentBox = document.getElementById('textBox').value;

if(commentBox==null || commentBox=="")
{
    alert("Comment Box cannot be empty");
    
}
else
	{
	document.form1.submit();
	}



}  
  
</script>

<script language = "javascript">  
var request;  
function commentOnPost1()  
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
			  alert(comment);
		   	  var comments = document.getElementById('comments');
			
			  var first = comments.firstChild;
			  var li = document.createElement("li");
			  li.innerHTML = comment;
			  comments.insertBefore(li, first);
		    }
			}
	};   

	var image = document.getElementById('img1').value;
	var userEmail = document.getElementById('useremail1').value;
	var email = document.getElementById('email1').value;
	var inputPage = document.getElementById('inputpage1').value;
	var commentBox = document.getElementById('textBox1').value;


	request.open("GET",url+"?image="+image+"&userEmail="+userEmail+"&email="+email+"&inputPage="+inputPage+"&commentBox="+commentBox,true);  
	request.send();  

}  
  
</script>
 
  <script src="js/vendor/all.js"></script>

  
  <script src="js/app/app.js"></script>

</body>
</html>