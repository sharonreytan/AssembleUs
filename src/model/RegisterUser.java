package model;

import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.UUID;

/*
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * RegisterToDB function is responsible to perform the registration to the database.
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 */  
public class RegisterUser {
	public String RegisterToDB(String username, String firstName, String lastName, String email, String phonePrefix
			,String phoneSuffix, String password, String city, String gender, String pic){
		if (!User.inputValidation(username, password, firstName, lastName, email, phonePrefix, phoneSuffix, city)){
			return "failure";
		}
		
		Connection c = null;
		PreparedStatement stmt = null;
		int user_id = 0;
		String phone = phonePrefix + phoneSuffix;
		try{
			Class.forName("org.sqlite.JDBC");
			
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~
			
			//c = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\212481732\\workspace2\\SecureDev\\resource\\db.sqlite");
			//c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");
			
			//check if username exists on the DB
			stmt= c.prepareStatement("select * from tblusers where username=?");
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				stmt.close();
				rs.close();
				c.close();
				return "failure";
		  	}
			//hash the password
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(password.getBytes("UTF-8"));
			byte[] digest = md.digest();
			String hashedPassword = new String(digest); 
			
			 //delete password
			password = "";
			
			//assign the new user
			stmt= c.prepareStatement("insert into tblusers (username, password) values (?, ?)");
			stmt.setString(1, username);
			stmt.setString(2, hashedPassword);
			stmt.executeUpdate();
			
			//get the new user id
			stmt= c.prepareStatement("select id from tblusers where username=?");
			stmt.setString(1, username);
			rs = stmt.executeQuery();
			
			rs.next();
			user_id = rs.getInt("id");
			
			UUID uuid = UUID.randomUUID(); //generate uuid for the user
			stmt= c.prepareStatement("insert into uuid_users (uuid, user_id) values (?, ?)");
			stmt.setString(1, uuid.toString());
			stmt.setString(2, Integer.toString(user_id));
			stmt.executeUpdate();
			//prepare the query
			if (gender == "male")
				gender = "0";
			else
				gender = "1";
			
			stmt=c.prepareStatement("insert into user_details (user_id, regist_date, first_name, last_name, email, phone, gender, "
					+ "city, pic_filename) values (?, datetime(), ?, ?, ?, ?, ?, ?, ?)");
			stmt.setString(1, Integer.toString(user_id));
			stmt.setString(2, firstName);
			stmt.setString(3, lastName);
			stmt.setString(4, email);
			stmt.setString(5, phone);
			stmt.setString(6, gender);
			stmt.setString(7, city);
			stmt.setString(8, pic);
			stmt.executeUpdate();
			rs.close();
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
