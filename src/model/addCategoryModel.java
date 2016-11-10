package model; 

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class addCategoryModel {
	public String addCategory(String subject , String content , String userId){
		if(!User.verifyUserIsAdmin(userId)){
			return "failure";
		}
		Connection c = null;
		PreparedStatement stmt = null;
		
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");
				
			stmt = c.prepareStatement("insert into category (cat_name , cat_desc) values (? , ?)");
			stmt.setString(1, subject);
			stmt.setString(2, content);
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
