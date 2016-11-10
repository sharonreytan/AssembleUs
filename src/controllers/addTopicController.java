package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.addTopicModel;

public class addTopicController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	 
	public addTopicController() { 
		super();
	}
	
	/*
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * Function that handles the POST request that comes from viewTopic.jsp page.
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*/
	String result=null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = null;
		try{
			String subject = request.getParameter("subject");
			String categoryId = request.getParameter("category");
			String userId = request.getParameter("userId");
			String content = request.getParameter("content");
			addTopicModel topicModel = new addTopicModel();
			result = topicModel.addTopic(subject,categoryId , userId , content);
			
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
