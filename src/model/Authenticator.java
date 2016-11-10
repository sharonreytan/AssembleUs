package model;

import java.io.IOException;
import java.security.MessageDigest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import java.util.Calendar;


@SuppressWarnings("unused")
public class Authenticator {
	/*
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 * Authentication function is responsible to perform the connection to the database.
	 * In addition, the function is responsible for the authentication process.
	 * In case that a user try to log in with bad credentials more than 5 time in a time 
	 * period of 20 minutes - he becomes blocked for 20 minutes.
	 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 */  
	
	@SuppressWarnings("resource")
	public String authenticate(HttpSession httpSession, String username, String password) 
	{
		Connection c = null;
		PreparedStatement stmt = null;
		String session = httpSession.getId();
		boolean isAdmin=false;
		try{
			Class.forName("org.sqlite.JDBC");
			
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~
			
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");
			
			//hash the password
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(password.getBytes("UTF-8"));
			byte[] digest = md.digest();
			String hashedPassword = new String(digest); 
			
			 //delete password
			password = "";
			
			//search for the user inserted, and check if he is blocked (user is blocked after 5 bad login attempts within 20 minutes time period)
			stmt = c.prepareStatement("select strftime('%s', datetime()) - strftime('%s', last_attempt_time) as diff_sec, * "
									+ "from tblusers left outer join login_attempts on tblusers.id = login_attempts.user_id "
									+ "where username = ? and password = ? "
									+ "and ((attempts <= 5 or attempts is null) "
									+ "or (diff_sec > 1200 or diff_sec is null))"); 
			stmt.setString(1, username);
			stmt.setString(2, hashedPassword);
			ResultSet rs = stmt.executeQuery();

		  if (rs.next()) {
			  String attempts = rs.getString("attempts");
			  int user_id = rs.getInt("id");
			  if (attempts != null){
				  //delete the old record for the bad login attempt
				stmt = c.prepareStatement("delete from login_attempts where user_id = " + user_id);
				stmt.executeUpdate();
			  }
			  //take care of session tracking
			  stmt = c.prepareStatement("select uuid from uuid_users where user_id = " + user_id);
			  rs = stmt.executeQuery();
			  rs.next();
			  String user_uuid = rs.getString(1);
			  
			  stmt = c.prepareStatement("select * from session_of_user where user_uuid = ?");
			  stmt.setString(1, user_uuid);
			  rs = stmt.executeQuery();
			  if (rs.next()){
				  //replace old session
				  stmt = c.prepareStatement("update session_of_user set session = ? where user_uuid = ?");
				  stmt.setString(1, session);
				  stmt.setString(2, user_uuid);
				  stmt.executeUpdate();
			  }
			  else {
				  //create a session record for this user
				  stmt = c.prepareStatement("insert into session_of_user (session ,user_uuid) values (?, ?)");
				  stmt.setString(1, session);
				  stmt.setString(2, user_uuid);
				  stmt.executeUpdate();
			  }
			  
			  stmt= c.prepareStatement("select * from admins where user_id = " + user_id);
			  rs = stmt.executeQuery();	
			  
			  if(rs.next())
				  isAdmin = true;	  
			  
			  stmt= c.prepareStatement("select * from user_details where user_id = " + user_id);
			  rs = stmt.executeQuery();	
			  
			  User user = new User(username, rs.getString("first_name"), rs.getString("last_name"), 
					  rs.getString("email"), 
					  rs.getString("phone").substring(0, 3), // phone prefix
					  rs.getString("phone").substring(3, 10), // phone suffix
					  rs.getString("city"), 
					  rs.getString("pic_filename"),
					  isAdmin , user_id);
			  httpSession.setAttribute("user", user);
			  rs.close();
			  stmt.close();
			  c.close();
			  return "success";
		  } 
		  
		  else 
		  {
			//if this user exists, log his login failure
			stmt = c.prepareStatement("select id from tblusers where username = ?"); 
			stmt.setString(1, username);
			rs = stmt.executeQuery();
			
			if (rs.next()){
				Integer user_id = rs.getInt("id");
				//check if there is already a bad login attempt, and how many seconds passed
				stmt = c.prepareStatement("select strftime('%s', datetime()) - strftime('%s', last_attempt_time) as diff_sec, attempts from login_attempts where user_id = " + user_id); 
				rs = stmt.executeQuery();
				if (rs.next()){ //there is a bad login attempt record
					Integer diff_sec = rs.getInt("diff_sec");
					Integer attempts = rs.getInt("attempts");
					//increase attempts to update the DB
					attempts += 1;
					//bad login attempt time out is 20 minutes = 1200 seconds
					if (diff_sec <= 1200){
						//update the record to current date time and the increased attempts, in case it is less than 5
						if (attempts > 5)
							stmt = c.prepareStatement("update login_attempts set last_attempt_time = datetime() where user_id = " + user_id);
						else
							stmt = c.prepareStatement("update login_attempts set attempts = " + attempts + ", last_attempt_time = datetime() where user_id = " + user_id);
						stmt.executeUpdate();
					}
					else {
						//update the relevant login failure
						stmt = c.prepareStatement("update login_attempts set last_attempt_time = datetime(), attempts = 1 where user_id = " + user_id);
						stmt.executeUpdate();
					}
				}
				else { //there is no bad login attempt record
					stmt = c.prepareStatement("insert into login_attempts values (" + user_id + ", 1, datetime())");
					stmt.executeUpdate();
				}
			}
			rs.close();
			c.close();
			return "failure";
		  }
	   }
		catch(Exception e)
		{
			System.out.println(e.getMessage().toString());
			System.out.println("SQL error");
			return "SQL ERROR";
		}
	}
}