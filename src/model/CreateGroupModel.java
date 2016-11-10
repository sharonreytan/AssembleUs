package model; 

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CreateGroupModel {
	public String createGroup(String groupName , String groupDesc , String creatorUserId, String faculty){
		Connection c = null;
		PreparedStatement stmt = null;
		
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");
			ResultSet rs = null;
			
			stmt = c.prepareStatement("insert into groups (group_name, group_desc, creator_user_id, faculty, creation_date) values (?, ?, ?, ?, datetime())");
			stmt.setString(1, groupName);
			stmt.setString(2, groupDesc);
			stmt.setString(3, creatorUserId);
			stmt.setString(4, faculty);
			stmt.executeUpdate();
			
			stmt = c.prepareStatement("select group_id from groups where creator_user_id = ? and group_name = ?");
			stmt.setString(1, creatorUserId);
			stmt.setString(2, groupName);
			rs = stmt.executeQuery();
			
			rs.next();
			int groupId = rs.getInt(1);
			
			stmt = c.prepareStatement("insert into group_members (group_id, user_id, join_time) values (?, ?, datetime())");
			stmt.setString(1, String.valueOf(groupId));
			stmt.setString(2, creatorUserId);
			stmt.executeUpdate();
			
			rs.close();
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
