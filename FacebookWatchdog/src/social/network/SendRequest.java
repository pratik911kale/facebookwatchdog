package social.network;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import social.bean.FriendRequest;
import social.dao.FriendRequestsDAO;
import social.utility.GetTime;
import social.utility.IdDAO;


@WebServlet("/SendRequest")
public class SendRequest extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    
    public SendRequest() 
    {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}

	
	/**
	 * This class method is used to send Friend Request to user
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		// This class method is used to send Friend Request to user
		
		HttpSession session1 = request.getSession(false);
		
		
		String senderEmail = (String)session1.getAttribute("Email");
		String receiverEmail = request.getParameter("userEmail");
		String inputPage = request.getParameter("viewid");
		
		/* DateFormat dateFormat = new SimpleDateFormat("dd/mm/yyyy HH:mm:ss");
    	 Date date = new Date();
    	 Calendar cal = Calendar.getInstance();
    	 System.out.println(dateFormat.format(cal.getTime()));
    	 
    	 System.out.println( cal.HOUR);
    	 */
		
		
		 
         GetTime time =new GetTime();
		
    	 FriendRequest frndRequest = new FriendRequest();
    	 IdDAO idDAO = new IdDAO();
    	 FriendRequestsDAO dao = new FriendRequestsDAO();
    	 
    	 // Set friend request object
    	 frndRequest.setId(idDAO.getRequestId()+1);
    	 frndRequest.setEmail1(senderEmail);
    	 frndRequest.setEmail2(receiverEmail);
    	 frndRequest.setDate(time.getCurrentTimeStamp1());
    	 
    	 int id = dao.insertRequest(frndRequest);   // Insert request into friendrequests table
    	 
    	 System.out.println("SendRequest: "+id);
    	 
    	 
    	 request.setAttribute("UserEmail",receiverEmail);
    	 
	     RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/UserProfile.jsp");
	     dispatcher.forward(request, response);
		
		
	}

}
