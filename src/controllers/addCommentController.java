package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.addCommentModel;

public class addCommentController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	 
	public addCommentController() { 
		super();
	}
	
	
	/*
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * Function that handles the POST request that comes from posts.jsp page.
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*/
	String result=null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = null;
		try{
			String comment = request.getParameter("comment");
			String topicId = request.getParameter("topic");
			String userId = request.getParameter("userId");
			addCommentModel commentModel = new addCommentModel();
			result = commentModel.addComment(comment,topicId , userId);
			
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
