package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ForumTopicsModel;

public class ForumTopicsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public ForumTopicsController() { 
		super();
	}
	
	/*
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * Function that handles the GET request that comes from topics.jsp page.
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*/
	
	protected void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		RequestDispatcher rd = null;
		try{
			HttpSession session = request.getSession();
			ForumTopicsModel topicsModel = new ForumTopicsModel();
			String result = topicsModel.getTopics(session, Integer.parseInt(request.getParameter("category")));
			
			if (result.equals("success")) 
			{
				rd = request.getRequestDispatcher("/viewTopic");
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
