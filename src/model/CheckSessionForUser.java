package model;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;

public class CheckSessionForUser {
	public boolean isSessionLogged(String session){
		try{
			Class.forName("org.sqlite.JDBC");
			
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~
			
			Connection c = DriverManager.getConnection("jdbc:sqlite:C:\\db.sqlite");
			PreparedStatement stmt= c.prepareStatement("select * from session_of_user where session_of_user.session = ?");
			stmt.setString(1, session);
			ResultSet rs = stmt.executeQuery();		
			
			if (rs.next()){
				rs.close();
				c.close();
				return true;
			}
			else{
				rs.close();
				c.close();
				return false;
			}
		}
		catch(Exception e){
			return false;
		}
	}
}
