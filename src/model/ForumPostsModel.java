package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpSession;

public class ForumPostsModel {
	public String getPosts(HttpSession session, int topic_id){
		Connection c = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");

			stmt = c.prepareStatement("select topic_subject, posts.*, "
					+ "first_name || ' ' || last_name as full_name from "
					+ "topics inner join tblusers on tblusers.id = posts.post_by "
					+ "inner join user_details on tblusers.id = user_details.user_id "
					+ "inner join posts on posts.post_topic = topics.topic_id "
					+ "where post_topic = ?");
			stmt.setString(1, String.valueOf(topic_id));
			rs = stmt.executeQuery();
			
			ForumPostsPOJO posts = new ForumPostsPOJO(rs , topic_id);
			session.setAttribute("posts", posts);
			return "success";
		}
		catch(Exception e){
			System.out.println(e.getMessage().toString());
			System.out.println("SQL error");
			return "SQL ERROR";
		}
	}
}
