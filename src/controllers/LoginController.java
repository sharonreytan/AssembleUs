package controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Authenticator;
import model.User;
 
import sun.text.normalizer.ICUBinary.Authenticate;
 
@SuppressWarnings("unused")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	public LoginController() { 
		super();
	}
	
	/*
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * Function that handles the POST request that comes from login.jsp page.
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*/
	String result=null;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = null;
		try{
			//set all the session's cookies http only
			Cookie[] cookies = request.getCookies();
			for (Cookie cookie : cookies){
				cookie.setHttpOnly(true);
			}
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			HttpSession session = request.getSession();
			
			//set session timeout for 15 minutes
			session.setMaxInactiveInterval(15*60);
			
			Authenticator authenticator = new Authenticator();
			result = authenticator.authenticate(session, username, password);
			
			if (result.equals("success")) 
			{
				rd = request.getRequestDispatcher("/home");
				request.getSession().setAttribute("isLogin", "true");
			} 
			else 
			{
				rd = request.getRequestDispatcher("/loginError");
			}
		}
		catch (Exception e){
			System.out.println(e.getMessage().toString());
			rd = request.getRequestDispatcher("/loginError");
		}
		finally{
			rd.forward(request, response);
		}
	}
 
}