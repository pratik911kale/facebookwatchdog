package social.network;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import social.bean.ProfessionBean;
import social.dao.ProfessionDAO;


@WebServlet("/UpdateProfession")
public class UpdateProfession extends HttpServlet
{
	private static final long serialVersionUID = 1L;
       
   
    public UpdateProfession() 
    {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
	}

	/**
	 * These class method updates profession information of user
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session1 = request.getSession(false);
		
		String email = (String)session1.getAttribute("Email");
		
		 /*   Parameters from form are obtained           */
		String profession = request.getParameter("SelectProfession");
		String qualification = request.getParameter("SelectQualification");
		String workIn = request.getParameter("workIn");
		
		if(!profession.equals("") && !qualification.equals(""))
		{
			ProfessionBean prof = new ProfessionBean();
			
			// Set Profession object to insert
			prof.setEmail(email);
			prof.setProfession(profession);
			prof.setQualification(qualification);
			prof.setWorkIn(workIn);
			
			ProfessionDAO dao = new ProfessionDAO();
			String select = dao.selectProfession(prof);
			
			if(select.equals("success"))   // check whether Profession information is already there in table
			{
				
			
			
			   int update = dao.updateProfession(prof);   // update profession record for user in 'profession' table
			
			   if(update==1)
			   {
				  session1.setAttribute("Profession", profession);
				  session1.setAttribute("Qualification", qualification);
				  session1.setAttribute("WorkIn", workIn);
				
				  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Profile.jsp");
				  dispatcher.forward(request, response);
			   }
			   else
			   {
			 	  request.setAttribute("message", "Profession not updated");
				  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Profession.jsp");
				  dispatcher.forward(request, response);
			   }
			}
			else   // if Profession record is not available in table
			{
				 String insert = dao.insertProfession(prof);  // Insert profession record in 'profession' table
					
				   if(insert.equals("Success"))
				   {
					  session1.setAttribute("Profession", profession);
					  session1.setAttribute("Qualification", qualification);
					  session1.setAttribute("WorkIn", workIn);
					
					  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Profile.jsp");
					  dispatcher.forward(request, response);
				   }
				   else
				   {
				 	  request.setAttribute("message", "Profession not inserted");
					  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Profession.jsp");
					  dispatcher.forward(request, response);
				   }
				
			}
			
			
		}
		
		else
		{
			request.setAttribute("message", "Please select profession and qualification");
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Profession.jsp");
			dispatcher.forward(request, response);
		}
		
	}

}
