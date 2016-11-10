package model; 

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class JoinGroupModel {
	public String joinGroup(String userId, String groupId){
		Connection c = null;
		PreparedStatement stmt = null;
		
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");
			
			stmt = c.prepareStatement("insert into group_members (group_id, user_id, join_time) values (?, ?, datetime())");
			stmt.setString(1, groupId);
			stmt.setString(2, userId);
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
