package model;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Class that defines the user object.
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
 
	public User(String username, String firstName, String lastName, String email, String phonePrefix
			,String phoneSuffix, String city, String pic ){
		this.username = username;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phonePrefix = phonePrefix;
		this.phoneSuffix = phoneSuffix;
		this.pic=pic;
		this.city = city;
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


 
}
