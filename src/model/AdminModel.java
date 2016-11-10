package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminModel {
	public String PromoteUser(String promotedUsername, String promoterAdminUserId){
		//make sure the request is by an administrator
		if(!User.verifyUserIsAdmin(promoterAdminUserId)){
			return "failure";
		}
		
		Connection c = null;
		PreparedStatement stmt = null;
		
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");
			
			//make sure the requested username is valid
			stmt = c.prepareStatement("select id from tblusers where username=?");
			stmt.setString(1, promotedUsername);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				//get the promoted user its id
				int promotedUserId = rs.getInt(1); 
				//check if this user is already an administrator - to prevent primary key constraint error
				stmt = c.prepareStatement("select * from admins where user_id=" + promotedUserId);
				rs = stmt.executeQuery();
				
				if (rs.next()){
					//this user is already an administrator - go back as if we succeed
					rs.close();
					stmt.close();
					c.close();
					return "success";
				}
				
				//the selected user is not an administrator, add it to admins table
				stmt = c.prepareStatement("insert into admins values (" + promotedUserId + ")");
				stmt.executeUpdate();
				
				rs.close();
				stmt.close();
				c.close();
				return "success";
			}
			
			else{
				rs.close();
				stmt.close();
				c.close();
				return "failure";
			}
		}
		catch(Exception e){
			System.out.println(e.getMessage().toString());
			System.out.println("SQL error");
			return "SQL ERROR";
		}
	}
}
