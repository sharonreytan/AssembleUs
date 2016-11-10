package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpSession;

public class InfoModel {
	public String getInfo(HttpSession session){
		Connection c = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");
			User user = (User)session.getAttribute("user");
			String userId = String.valueOf(user.getUserId());
			
			//extract all groups this user is at
			stmt = c.prepareStatement("select g1.group_id, group_name, group_desc, count(gm1.user_id) as members_count, "
					+ "creation_date, first_name || ' ' || last_name as full_name "
					+ "from groups g1 inner join user_details on g1.creator_user_id = user_details.user_id "
					+ "left outer join group_members gm1 on gm1.group_id = g1.group_id  "
					+ "where gm1.user_id = " + userId
					+ " group by g1.group_id");
			rs = stmt.executeQuery();
			
			GroupsPOJO groupsUserAt = new GroupsPOJO(rs);
			session.setAttribute("groupsUserAt", groupsUserAt);
			
			return "success";
		}
		catch(Exception e){
			System.out.println(e.getMessage().toString());
			System.out.println("SQL error");
			return "SQL ERROR";
		}
	}
}
