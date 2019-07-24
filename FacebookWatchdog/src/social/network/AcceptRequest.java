package social.network;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import social.bean.FriendRequest;
import social.bean.Friends;
import social.dao.FriendRequestsDAO;
import social.dao.FriendsDAO;


@WebServlet("/AcceptRequest")
public class AcceptRequest extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    
    public AcceptRequest() 
    {
        super();
        
    }

	
    /**
     * This method is used for adding record of friend request from sender into table 'friendrequests'
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		 HttpSession session1 = request.getSession(false);
		    
		    
		    
		    
		    String userName =  (String)session1.getAttribute("FirstName");      /*   Parameters from form are obtained           */
		    String receiverEmail = (String)session1.getAttribute("Email");
		    System.out.println(userName);
		   
		        String inputPage = request.getParameter("inputPage");
		        System.out.println("AccepRequest: "+inputPage);
		        
		        String senderEmail = request.getParameter("senderEmail");
		        FriendRequest frndRequest = new FriendRequest();
		        
		        FriendRequestsDAO daoRequests = new FriendRequestsDAO();
		        
		        Friends friends = new Friends();
		        friends.setEmail1(senderEmail);
		        friends.setEmail2(receiverEmail);
		        
		        FriendsDAO daoFriends = new FriendsDAO();
		        int result = daoFriends.insertFriends(friends);       /*  Request is inserted into  'friendrequests' table  */
		        
		        if(result == 1)
		        {
		        	
		        	frndRequest.setEmail1(senderEmail);
		        	frndRequest.setEmail2(receiverEmail);
		        	int result1 = daoRequests.deleteRequest(frndRequest);
		        	if(result1 == 1)
		        		response.sendRedirect(inputPage);
		        		
		        }
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}

}
