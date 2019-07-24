package social.network;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import social.bean.FriendRequest;
import social.dao.FriendRequestsDAO;


@WebServlet("/RejectRequest")
public class RejectRequest extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    
    public RejectRequest() 
    {
        super();
        
    }

 
    /**
     * This class method is used for rejecting Friend request from sender
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// This class method is used for rejecting Friend request from sender
		
		HttpSession session1 = request.getSession(false);
		
		
		String receiverEmail = (String)session1.getAttribute("Email");
		
		/*   'Reject' Hyperlink Parameters are obtained           */
		String inputPage = request.getParameter("inputPage");
		String senderEmail = request.getParameter("senderEmail");
		
		FriendRequest frndRequest = new FriendRequest();
        
        FriendRequestsDAO daoRequests = new FriendRequestsDAO();
        
		frndRequest.setEmail1(senderEmail);
    	frndRequest.setEmail2(receiverEmail);
    	int result1 = daoRequests.deleteRequest(frndRequest); // Delete request from 'friendrequests' table
    	if(result1 == 1)
    		response.sendRedirect(inputPage);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}

}
