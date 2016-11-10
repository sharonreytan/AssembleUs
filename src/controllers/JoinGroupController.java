package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.JoinGroupModel;


public class JoinGroupController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	 
	public JoinGroupController() { 
		super();
	}
	
	/*
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * Function that handles the POST request that comes from group.jsp/groupProfile.jsp page.
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*/
	String result=null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = null;
		try{ 
			String userId = request.getParameter("userId");
			String groupId = request.getParameter("groupId");
			JoinGroupModel joinModel = new JoinGroupModel();
			result = joinModel.joinGroup(userId, groupId);
			
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
