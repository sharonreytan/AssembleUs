package model; 

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class addTopicModel {
	public String addTopic(String subject , String categoryId , String userId , String content){
		Connection c = null;
		PreparedStatement stmt = null;
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");

			stmt = c.prepareStatement("insert into topics (topic_subject ,topic_cat , topic_content ,topic_by ,post_date) values (?, ?, ? ,? ,datetime())");
			stmt.setString(1, subject);
			stmt.setString(2, categoryId);
			stmt.setString(3, content);
			stmt.setString(4, userId);
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
