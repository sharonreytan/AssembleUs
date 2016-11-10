package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpSession;

public class ForumTopicsModel {
	public String getTopics(HttpSession session, int cat_id){
		Connection c = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");

			stmt = c.prepareStatement("select cat_name, topics.*, "
					+ "first_name || ' ' || last_name as full_name from "
					+ "topics inner join category on topics.topic_cat = category.cat_id "
					+ "inner join tblusers on tblusers.id = topics.topic_by "
					+ "inner join user_details on tblusers.id = user_id "
					+ "where topic_cat = ?");
			stmt.setString(1, String.valueOf(cat_id));
			rs = stmt.executeQuery();
			
			ForumTopicsPOJO topics = new ForumTopicsPOJO(rs, cat_id);
			session.setAttribute("topics", topics);
			return "success";
		}
		catch(Exception e){
			System.out.println(e.getMessage().toString());
			System.out.println("SQL error");
			return "SQL ERROR";
		}
	}
}
