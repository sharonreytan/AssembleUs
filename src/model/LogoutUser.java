package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class LogoutUser {
	public String deleteSession(String session){
		Connection c = null;
		PreparedStatement stmt = null;
		
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");

			stmt = c.prepareStatement("delete from session_of_user where session = ?");
			stmt.setString(1, session);
			stmt.executeUpdate();
			
			stmt.close();
			c.close();
			return "success";
		}
		catch(Exception e){
			System.out.println(e.getMessage().toString());
			System.out.println("SQL error");
			return "SQL ERROR";
		}
	}
}
