package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CreateGroupModel;


public class CreateGroupController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	 
	public CreateGroupController() { 
		super();
	}
	
	/*
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * Function that handles the POST request that comes from createCategory.jsp page.
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*/
	String result=null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = null;
		try{ 
			String groupName = request.getParameter("groupName");
			String groupDesc = request.getParameter("groupDesc");
			String creatorUserId = request.getParameter("creatorUserId");
			String faculty = request.getParameter("faculty");
			
			CreateGroupModel groupModel = new CreateGroupModel();
			result = groupModel.createGroup(groupName, groupDesc ,creatorUserId, faculty);
			
			if (result.equals("success")) 
			{
				rd = request.getRequestDispatcher("/home");
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
