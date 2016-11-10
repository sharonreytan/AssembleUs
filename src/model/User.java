package model;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.authenticator.*;
/*
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Class that defines the user object and holds functions to validate his information.
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 */
@SuppressWarnings("unused")
public class User {
	private String username;
	private String firstName;
	private String lastName;
	private String email;
	private String phonePrefix;
	private String phoneSuffix;
	private String city;
	private String pic;
	private int userId;
	private boolean isAdmin;
	
	public User(String username, String firstName, String lastName, String email, String phonePrefix
			,String phoneSuffix, String city, String pic, boolean isAdmin , int userId){
		this.username = username;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phonePrefix = phonePrefix;
		this.phoneSuffix = phoneSuffix;
		this.pic=pic;
		this.city = city;
		this.isAdmin = isAdmin;
		this.userId = userId;
	}
	
	public static boolean inputValidation(String username, String password, String firstName, String lastName, String email, String phonePrefix
			,String phoneSuffix, String city){
		String usernameRegex = "^[a-zA-Z0-9]{5,30}$";
		String passRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,12}$";
		String phoneRegex = "^[0-9]{7,7}$";
		String nameRegex = "^[A-Za-z]{2,20}$";
		
		ArrayList<String> validCities = new ArrayList<String>();
		validCities.add("Tel-Aviv"); validCities.add("Ashdod"); validCities.add("Haifa"); validCities.add("Hertzlia"); validCities.add("Ramat-Gan"); 
		
		ArrayList<String> validPhonePrefix = new ArrayList<String>();
		validPhonePrefix.add("050"); validPhonePrefix.add("052"); validPhonePrefix.add("053"); validPhonePrefix.add("054"); validPhonePrefix.add("056"); 
			validPhonePrefix.add("057"); validPhonePrefix.add("058"); 

		if(!(username.matches(usernameRegex) && password.matches(passRegex) && phoneSuffix.matches(phoneRegex) && firstName.matches(nameRegex) && lastName.matches(nameRegex) 
				&& isValidEmail(email) && validCities.contains(city) && validPhonePrefix.contains(phonePrefix)))
			return false;
		
		return true;
	}
	
	public static boolean inputValidation(String firstName, String lastName, String email, String phonePrefix, String phoneSuffix, String city){
		String phoneRegex = "^[0-9]{7,7}$";
		String nameRegex = "^[A-Za-z]{2,20}$";
		
		ArrayList<String> validCities = new ArrayList<String>();
		validCities.add("Tel-Aviv"); validCities.add("Ashdod"); validCities.add("Haifa"); validCities.add("Hertzlia"); validCities.add("Ramat-Gan"); 
		
		ArrayList<String> validPhonePrefix = new ArrayList<String>();
		validPhonePrefix.add("050"); validPhonePrefix.add("052"); validPhonePrefix.add("053"); validPhonePrefix.add("054"); validPhonePrefix.add("056"); 
			validPhonePrefix.add("057"); validPhonePrefix.add("058"); 

		if(!(phoneSuffix.matches(phoneRegex) && firstName.matches(nameRegex) && lastName.matches(nameRegex) 
				&& isValidEmail(email) && validCities.contains(city) && validPhonePrefix.contains(phonePrefix)))
			return false;
		
		return true;
	}
	
	public static boolean isValidEmail(String email){
        if(email.matches("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$"))
            return true;
        return false;
    }
	
	public boolean verifyUserIsAdmin(){
		return verifyUserIsAdmin(String.valueOf(this.userId));
	}
	
	public static boolean verifyUserIsAdmin(String userId){
		Connection c = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("org.sqlite.JDBC");		
			//~~~~~~~~~~~~~~~Change The path of the SQLite database.~~~~~~~~~~~~~~~~~~~~~~		
			c = DriverManager.getConnection("jdbc:sqlite:C:\\sqlite\\db.sqlite");
			
			stmt = c.prepareStatement("select user_id from admins where user_id=" + userId);
			rs = stmt.executeQuery();
			if(!rs.next()){
				rs.close();
				stmt.close();
				c.close();
				return false;
			}
			
			rs.close();
			stmt.close();
			c.close();
			return true;
		}
		catch(Exception e){
			System.out.println(e.getMessage().toString());
			System.out.println("SQL error");
			return false;
		}
	}
 
	public int getUserId() {
		return userId;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhonePrefix() {
		return phonePrefix;
	}

	public void setPhonePrefix(String phonePrefix) {
		this.phonePrefix = phonePrefix;
	}

	public String getPhoneSuffix() {
		return phoneSuffix;
	}

	public void setPhoneSuffix(String phoneSuffix) {
		this.phoneSuffix = phoneSuffix;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public boolean getIsAdmin() {
		return isAdmin;
	}
 
}
