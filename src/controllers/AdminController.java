package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.AdminModel;
import model.User;

public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public AdminController(){
		super();
	}
		
	/*
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * Function that handles the POST request that comes from admin.jsp page.
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*/
	String result=null;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = null;
		try{
			HttpSession session = request.getSession();
			String promotedUsername = request.getParameter("promotedUsername");
			User promoterAdminUser = (User)session.getAttribute("user");
			String promoterAdminUserId = String.valueOf(promoterAdminUser.getUserId());
			
			AdminModel adminModel = new AdminModel();
			result = adminModel.PromoteUser(promotedUsername, promoterAdminUserId);
			
			if (result.equals("success")) 
			{
				rd = request.getRequestDispatcher("/home");
				request.getSession().setAttribute("isLogin", "true");
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
