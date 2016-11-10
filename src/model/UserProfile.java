package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpSession;

public class UserProfile {
	public String getUserNameBySession(String session){
		Connection c = null;
		PreparedStatement stmt = null;
		try{
			Class.forName("org.sqlite.JDBC");
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");
			
			stmt= c.prepareStatement("select tblusers.username from session_of_user " +
										"inner join uuid_users on uuid_users.uuid = session_of_user.user_uuid " +
										"inner join tblusers on uuid_users.user_id = tblusers.id " +
										"where session_of_user.session = ?");
			stmt.setString(1, session);
			ResultSet rs = stmt.executeQuery();		
			
			if (!rs.next()){
				rs.close();
				c.close();
				return "-1";
			}
			String username = rs.getString(1);
			rs.close();
			stmt.close();
			c.close();
			return username;
		}
		catch(Exception e)
		{
			System.out.println("SQL error");
			return "SQL ERROR";
		}
	}
	public String editProfile(HttpSession session, String firstName, String lastName, String email, String phonePrefix
			,String phoneSuffix, String city, String pic){
		if(!User.inputValidation(firstName, lastName, email, phonePrefix, phoneSuffix, city)){
			return "failure";
		}

		Connection c = null;
		PreparedStatement stmt = null;
		int user_id = 0;
		String phone = phonePrefix + phoneSuffix;
		
		try{
			Class.forName("org.sqlite.JDBC");
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");
			
			stmt= c.prepareStatement("select tblusers.id from session_of_user " +
										"inner join uuid_users on uuid_users.uuid = session_of_user.user_uuid " +
										"inner join tblusers on uuid_users.user_id = tblusers.id " +
										"where session_of_user.session = ?");
			stmt.setString(1, session.getId());
			ResultSet rs = stmt.executeQuery();		
			
			if (!rs.next()){
				stmt.close();
				rs.close();
				c.close();
				return "failure";
			}
			
			user_id = rs.getInt(1);
			stmt= c.prepareStatement("select * from user_details where user_id = " + user_id);
			rs = stmt.executeQuery();
			
			if (pic == null){
				pic = rs.getString("pic_filename");
			}
			
			stmt= c.prepareStatement("update user_details set first_name=? ,last_name=?,email=?, phone=?, city=?"
					+ ",pic_filename=? where user_id=?");
			stmt.setString(1, firstName);
			stmt.setString(2, lastName);
			stmt.setString(3, email);
			stmt.setString(4, phone);
			stmt.setString(5, city);
			stmt.setString(6, pic);
			stmt.setString(7, String.valueOf(user_id));
			stmt.executeUpdate();
			
			User user = (User)session.getAttribute("user");
			user.setCity(city);
			user.setEmail(email);
			user.setFirstName(firstName);
			user.setLastName(lastName);
			user.setPhonePrefix(phonePrefix);
			user.setPhoneSuffix(phoneSuffix);
			user.setPic(pic);
			
			stmt.close();
			c.close();
			return "success";
		}
		catch(Exception e)
		{
			System.out.println("SQL error");
			return "SQL ERROR";
		}
	}
}

