package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpSession;

public class SearchModel {
	public String getSearch(HttpSession session,String search){
		Connection c = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");
			
			//extract all groups this user is at
			stmt = c.prepareStatement("select group_id,group_name,group_desc from groups where group_name like ? or group_desc like ?");
			stmt.setString(1, "%" + search + "%");
			stmt.setString(2, "%" + search + "%");
			rs = stmt.executeQuery();
			
			GroupsPOJO searchResult = new GroupsPOJO(rs);
			session.setAttribute("searchResult", searchResult);
			session.setAttribute("searchStr", search);
			
			return "success";
		}
		catch(Exception e){
			System.out.println(e.getMessage().toString());
			System.out.println("SQL error");
			return "SQL ERROR";
		}
	}
}
