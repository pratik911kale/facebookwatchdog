<%@ page import="social.dao.*,social.bean.*,java.sql.*" language="java" contentType="text/html; charset=ISO-8859-1"
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
          String firstName = (String)session1.getAttribute("FirstName");
          String email = (String)session1.getAttribute("Email");
          
          if(session1.getAttribute("FirstName")==null)           // Check whether Session is valid or not
          {
          	response.sendRedirect("UserLogin.jsp");
          }
          
         WarningDAO daoWarn = new WarningDAO();
         
         Warning warnRiots = daoWarn.getWarning(email, "riots");    // Get warning message related to 'riots'
         
         
         Warning warnWorst = daoWarn.getWarning(email, "worst");      // Get warning message related to 'worst'
         
         Warning warnCrime = daoWarn.getWarning(email, "crime");       // Get warning message related to 'crime'
         
         Warning warnBad = daoWarn.getWarning(email, "bad");        // Get warning message related to 'bad'
         
         int countCrimeCategories = daoWarn.getCountOfCrimeCategories(email);
         
         Date date = daoWarn.getCrimeMessageDate(email);
         
         AdultDetectionDAO daoAdultDetect = new AdultDetectionDAO();
         
         int adultCount = daoAdultDetect.getAdultCount(email);
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
                <input type="hidden" name="viewid" value="Messages.jsp">
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
          
      <!--    <li class=""><a href="Photos.jsp"><i class="icon-comment-fill-1"></i> <span>Photos</span></a></li> --> 
           <li class=""><a href="Messages.jsp"><i class="icon-comment-fill-1"></i> <span>Messages</span></a></li>
          
          <li><a href="LogoutServlet"><i class="icon-lock-fill"></i> <span>Logout</span></a></li>
          <!-- 
           <li><a href="Politics.jsp"><i class="icon-lock-fill"></i> <span>Politics</span></a></li>
           <li><a href="Entertainment.jsp"><i class="icon-lock-fill"></i> <span>Entertainment</span></a></li>
        
            <li><a href="History.jsp"><i class="icon-lock-fill"></i> <span>History</span></a></li>
           
            <li><a href="Education.jsp"><i class="icon-lock-fill"></i> <span>Education</span></a></li>
            <li><a href="Sports.jsp"><i class="icon-lock-fill"></i> <span>Sports</span></a></li> -->
        
      </div>
    </div>

   <div class="st-pusher" id="content">

     
            <div class="st-content">
          
          <br/> <br/> <br/> <br/> <br/>
      <center>
                
                <table>
                 <tr>
                          <th width="80"> <center>Sr. No.</center></th>
                          <th width="80"> <center>Warning Message</center></th>
                          <th width="80"> <center>Date</center> </th>
                          <th width="80"> <center>Category</center> </th>
                    </tr>
               
              
               
                    <%
                         int count = 0;
                          if(warnRiots.getEmailFId()!=null)
                          {
                    %>
                    
                     <tr>
                    <td>&nbsp; &nbsp;</td>
                    <td>&nbsp; &nbsp;</td>
                    <td>&nbsp; &nbsp;</td>
                    <td>&nbsp; &nbsp;</td>
               </tr>
                    
                   <tr>
                        <td> <center><%= count+1 %></center></td>
                        <td> <center><%= warnRiots.getMessage() %></center></td>
                        <td> <center><%= warnRiots.getDate() %></center></td>
                        <td> <center><%= warnRiots.getCategory() %></center></td>
                        
                   </tr>
                    <%
                       count = count + 1;
                          }
                          
                          if(warnCrime.getEmailFId()!=null)
                          {
                    %>
                     
                      <tr>
                    <td>&nbsp; &nbsp;</td>
                    <td>&nbsp; &nbsp;</td>
                    <td>&nbsp; &nbsp;</td>
                    <td>&nbsp; &nbsp;</td>
               </tr>
                      
                     <tr>
                        <td> <center><%= count+1 %></center></td>
                        <td> <center><%= warnCrime.getMessage() %></center></td>
                        <td> <center><%= warnCrime.getDate() %></center></td>
                        <td> <center><%= warnCrime.getCategory() %></center></td>
                        
                   </tr>
                
                <%
                       count = count + 1;
                          }
                          
                          if(warnWorst.getEmailFId()!=null)
                          {
                    %>
                     
                      <tr>
                    <td>&nbsp; &nbsp;</td>
                    <td>&nbsp; &nbsp;</td>
                    <td>&nbsp; &nbsp;</td>
                    <td>&nbsp; &nbsp;</td>
               </tr>
                     
                     <tr>
                        <td> <center><%= count+1 %></center></td>
                        <td> <center><%= warnWorst.getMessage() %></center></td>
                        <td> <center><%= warnWorst.getDate() %></center></td>
                        <td> <center><%= warnWorst.getCategory() %></center></td>
                        
                   </tr>
                
                <%
                        count = count + 1;
                          }
                
                
                     if(countCrimeCategories!=0)
                          {
                    %>
                     
                      <tr>
                    <td>&nbsp; &nbsp;</td>
                    <td>&nbsp; &nbsp;</td>
                    <td>&nbsp; &nbsp;</td>
                    <td>&nbsp; &nbsp;</td>
               </tr>
                     
                     <tr>
                        <td> <center><%= count+1 %></center></td>
                        <td> <center>You have posted <%= countCrimeCategories %> Crime Category Messages</center></td>
                        <td> <center><%= date %></center></td>
                        <td> <center>Crime</center></td>
                        
                   </tr>
                
                <%
                        count = count + 1;
                          }
                     
                     if(warnBad.getEmailFId()!=null)
                     {
               %>
                
                 <tr>
               <td>&nbsp; &nbsp;</td>
               <td>&nbsp; &nbsp;</td>
               <td>&nbsp; &nbsp;</td>
               <td>&nbsp; &nbsp;</td>
          </tr>
                
                <tr>
                   <td> <center><%= count+1 %></center></td>
                   <td> <center><%= warnBad.getMessage() %></center></td>
                   <td> <center><%= warnBad.getDate() %></center></td>
                   <td> <center>Bad</center></td>
                   
              </tr>
           
           <%
                   count = count + 1;
                     }
           %>
                
                
                </table>
                
                
                <br/> <br/> <br/> <br/> <br/> <br/> <br/> <br/>
                
                
               <%--  <font color="black" size="3"><b>Your count of adult images upload :</b></font>
                &nbsp; &nbsp; &nbsp;
                <font size="3"><%= adultCount %></font>
                <br/> <br/>
                <font color="black" size="3"><b>Do not exceed limit of 4 otherwise your account will be banned</b></font>
                --%> 
                
      </center>
      
      </div>
      
      </div>
      
      <!-- Footer -->
            <!-- 
    <footer class="footer">
<!--       <strong>Facebook</strong> v4.0.0 &copy; Copyright 2015
 -->    </footer>
       -->
    <!-- // Footer -->
      
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
 
  <script src="js/vendor/all.js"></script>

  
  <script src="js/app/app.js"></script>
  
</body>
</html>