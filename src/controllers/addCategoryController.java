package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.addCategoryModel;


public class addCategoryController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	 
	public addCategoryController() { 
		super();
	}
	
	/*
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * Function that handles the POST request that comes from forumCategory.jsp page.
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*/
	String result=null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = null;
		try{
			String subject = request.getParameter("subject");
			String content = request.getParameter("description");
			String userId = request.getParameter("userId");
			
			
			addCategoryModel categoryModel = new addCategoryModel();
			result = categoryModel.addCategory(subject,content , userId);
			
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
