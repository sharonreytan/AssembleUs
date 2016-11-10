package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpSession;

public class ForumCategoryModel {
	public String getCategory(HttpSession session){
		Connection c = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");

			stmt = c.prepareStatement("select cat_id, cat_name, cat_desc from category");
			rs = stmt.executeQuery();
			
			ForumCategoryPOJO category = new ForumCategoryPOJO(rs);
			session.setAttribute("category", category);
			return "success";
		}
		catch(Exception e){
			System.out.println(e.getMessage().toString());
			System.out.println("SQL error");
			return "SQL ERROR";
		}
	}
}
