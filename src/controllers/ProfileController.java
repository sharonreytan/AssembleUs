package controllers;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import model.RegisterUser;
import model.User;
import model.UserProfile;

@MultipartConfig
@SuppressWarnings("unused")
public class ProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;

public ProfileController() {
	super();
}

String result=null;
protected void doPost(HttpServletRequest request,
	        HttpServletResponse response)
	throws ServletException, IOException
	{
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String phonePrefix = request.getParameter("phonePrefix");
		String phoneSuffix = request.getParameter("phoneSuffix");
		String city = request.getParameter("city");
		String pic = request.getParameter("pic");
		HttpSession session = request.getSession();
		UserProfile profile = new UserProfile();
		RequestDispatcher rd = null;
		
		
	    String username = profile.getUserNameBySession(session.getId());
	    if (username.equals("-1"))
	    {
	    	rd = request.getRequestDispatcher("/error");
	    }
	    
	    else
	    {
	    	Collection<Part> parts = request.getParts();
			//define acceptable file formats
			ArrayList<String> validFormats = new ArrayList<String>();
			validFormats.add("jpeg"); validFormats.add("jpg"); validFormats.add("png"); validFormats.add("gif"); validFormats.add("bmp"); 
			Part filePart = request.getPart("pic");
			InputStream imageInputStream = filePart.getInputStream();
			String format = filePart.getContentType().substring(filePart.getContentType().indexOf("/") + 1);
			String pic_filename = username + "." + format;
			//octet-stream fromat means there is no file
			if (!format.equals("octet-stream") && validFormats.contains(format) && filePart.getSize() < 3145728){
				//read imageInputStream
				filePart.write("C:/AssembleUs/" + pic_filename);
			}
			else {
		    	pic_filename = null;
		    }
			imageInputStream.close();
		      	  
		    result = profile.editProfile(session, firstName, lastName, email, phonePrefix, phoneSuffix, city, pic_filename);
				
			if (result.equals("success")) 
			{
				rd = request.getRequestDispatcher("/home");
				request.getSession().setAttribute("username", username);
			} 
			else if (result.equals("failure"))
			{
				rd = request.getRequestDispatcher("/error");
			}
			else
			{
				rd = request.getRequestDispatcher("/error");
			}
	    }	
		rd.forward(request, response);
	}

}


