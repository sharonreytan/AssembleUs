package model; 

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class addCommentModel {
	public String addComment(String comment , String topicId , String userId){
		Connection c = null;
		PreparedStatement stmt = null;
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");

			stmt = c.prepareStatement("insert into posts (post_content ,post_date, post_topic,post_by) values (?,datetime(), ?, ?)");
			stmt.setString(1, comment);
			stmt.setString(2, topicId);
			stmt.setString(3, userId);
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
