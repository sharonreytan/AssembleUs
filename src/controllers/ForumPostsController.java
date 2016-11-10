package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ForumPostsModel;

public class ForumPostsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public ForumPostsController() { 
		super();
	}
	
	/*
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * Function that handles the GET request that comes from viewPosts.jsp page.
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*/
	
	protected void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		RequestDispatcher rd = null;
		try{
			HttpSession session = request.getSession();
			ForumPostsModel postsModel = new ForumPostsModel();
			int topic_id = Integer.parseInt(request.getParameter("topic"));
			String result = postsModel.getPosts(session, topic_id);
			
			if (result.equals("success")) 
			{
				rd = request.getRequestDispatcher("/viewPosts");
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
