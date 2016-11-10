package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpSession;

public class GroupsModel {
	public String getGroups(HttpSession session, String faculty){
		Connection c = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");
			User user = (User)session.getAttribute("user");
			String userId = String.valueOf(user.getUserId());
			
			stmt = c.prepareStatement("select g1.group_id, group_name, group_desc, count(gm1.user_id) as members_count, "
					+ "creation_date, first_name || ' ' || last_name as full_name "
					+ "from groups g1 inner join user_details on g1.creator_user_id = user_details.user_id "
					+ "left outer join group_members gm1 on gm1.group_id = g1.group_id  "
					+ "where faculty = ? and " + userId + " not in (select gm2.user_id from group_members gm2 where gm2.group_id = g1.group_id) "
					+ "group by g1.group_id");
			stmt.setString(1, faculty);
			rs = stmt.executeQuery();
			
			GroupsPOJO groups = new GroupsPOJO(rs);
			session.setAttribute("groups", groups);
			return "success";
		}
		catch(Exception e){
			System.out.println(e.getMessage().toString());
			System.out.println("SQL error");
			return "SQL ERROR";
		}
	}
}
