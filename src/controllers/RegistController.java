package controllers;

import java.io.*;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import model.RegisterUser;
import model.User;
 
import sun.text.normalizer.ICUBinary.Authenticate;

@MultipartConfig
@SuppressWarnings("unused")
public class RegistController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public RegistController() {
		super();
	}
	

	/*
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * Function that handles the POST request that comes from registration.jsp page.
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*/
	
	String result=null;
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String phonePrefix = request.getParameter("phonePrefix");
		String phoneSuffix = request.getParameter("phoneSuffix");
		String password = request.getParameter("password");
		String gender = request.getParameter("gender");
		String city = request.getParameter("city");
		String pic = request.getParameter("pic");
		
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
		
		RequestDispatcher rd = null;	  
		RegisterUser regist = new RegisterUser();
		result = regist.RegisterToDB(username, firstName, lastName, email, phonePrefix, phoneSuffix, password, city, gender, pic_filename);
		
		if (result.equals("success")) 
		{
			rd = request.getRequestDispatcher("/login");
		} 
		else if (result.equals("failure"))
		{
			rd = request.getRequestDispatcher("/registError");
		}
		else
		{
			rd = request.getRequestDispatcher("/registError");
		}
			
			rd.forward(request, response);
	}
}
