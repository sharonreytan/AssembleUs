package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.GroupsModel;

public class GroupsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public GroupsController() { 
		super();
	}
	
	/*
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * Function that handles the GET request that comes from groups.jsp page.
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*/
	
	protected void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		RequestDispatcher rd = null;
		try{
			HttpSession session = request.getSession();
			String faculty = request.getParameter("faculty");
			GroupsModel groupsModel = new GroupsModel();
			String result = groupsModel.getGroups(session, faculty);
			
			if (result.equals("success")) 
			{
				rd = request.getRequestDispatcher("/viewGroups");
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
