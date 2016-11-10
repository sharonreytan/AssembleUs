package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.InfoModel;

public class InfoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public InfoController() { 
		super();
	}
	
	/*
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * Function that handles the GET request to show a user information.
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*/
	
	protected void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		RequestDispatcher rd = null;
		try{
			HttpSession session = request.getSession();
			InfoModel infoModel = new InfoModel();
			String result = infoModel.getInfo(session);
			
			if (result.equals("success")) 
			{
				rd = request.getRequestDispatcher("/viewInfo");
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
