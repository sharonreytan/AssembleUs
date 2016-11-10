package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.GroupProfileModel;

public class GroupProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public GroupProfileController() { 
		super();
	}

	
	protected void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		RequestDispatcher rd = null;
		try{
			HttpSession session = request.getSession();
			String group_id = request.getParameter("group_id");
			GroupProfileModel groupProfileModel = new GroupProfileModel();
			String result = groupProfileModel.getGroupDetails(session, group_id);
			
			if (result.equals("success")) 
			{
				rd = request.getRequestDispatcher("/groupProfile");
			} 
			else 
			{
				rd = request.getRequestDispatcher("/error");
			}
			
		}
		catch (Exception e){
			System.out.println(e.getMessage().toString());
			rd = request.getRequestDispatcher("/error");
		}
		finally{
			rd.forward(request, response);
		}
	}

}
