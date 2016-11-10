package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpSession;

public class GroupProfileModel {
	public String getGroupDetails(HttpSession session, String group_id){
		Connection c = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");

			stmt = c.prepareStatement("select * from groups where group_id = ?");
			stmt.setString(1, String.valueOf(group_id));
			rs = stmt.executeQuery();
			
			
			if(rs.next()){
				GroupProfilePOJO group_details = new GroupProfilePOJO(group_id, rs.getString("group_name"), rs.getString("group_desc"));
				session.setAttribute("group_details", group_details);
				
				User user = (User)session.getAttribute("user");
				int user_id = user.getUserId();
				stmt = c.prepareStatement("select * from group_members where group_id = ? and user_id = " + user_id);
				stmt.setString(1, String.valueOf(group_id));
				rs = stmt.executeQuery();
				
				if (rs.next()){
					group_details.setMember(true);
				}
				else
					group_details.setMember(false);
				
				rs.close();
				stmt.close();
				c.close();
				return "success";
			}
			else{
				rs.close();
				stmt.close();
				c.close();
				return "failure";
			}
		}
		catch(Exception e){
			System.out.println(e.getMessage().toString());
			System.out.println("SQL error");
			return "SQL ERROR";
		}
	}
}
