<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
	<title>Edit Profile</title>
	<style>
		table, td {
		    border: 15px solid white;
		    padding: 5px;
		    text-align: left;
		}
		
		table {
		    border-spacing: 15px;
		}

		div.container {
			font-family: calibri;
		    width: 100%;
		}
		
		header, footer {
			font-family: calibri;
		    padding: 1em;
		    color: white;
		    background-color: #0cddc0;
		    clear: left;
		    text-align: center;
		}
	</style>
	
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<body onload="setCityPhone();">

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="home">AssembleUs</a>
    </div>
    <ul class="nav navbar-nav">
      <li><a href="home">Home</a></li>
      <li><a href="groupsFaculties">Join Group</a></li>
      <li><a href="createGroup">Create Group</a></li>
      <li class="active"><a href="profile">Profile </a></li>
      <li><a href="info">Information</a></li> 
      <li><a href="forum">Forum</a></li> 
      <li><a href="logout">Logout</a></li>
    </ul>
  </div>
</nav>      

<%@ page import="model.User" %>
<%
String isLogin = null;
String firstName = null;
String lastName = null;
String email = null;
String city = null;
String phonePrefix = null;
String phoneSuffix = null;
String pic = null;

RequestDispatcher rd = null;
	if(session.getAttribute("isLogin") == null || !session.getAttribute("isLogin").equals("true")){
		isLogin = "false";
		rd = request.getRequestDispatcher("/login");
		rd.forward(request, response);
	}

	else if(session.getAttribute("isLogin").equals("true")){
		isLogin = "true";
		
		User user = (User)session.getAttribute("user");
		firstName = user.getFirstName();
		lastName = user.getLastName();
		email = user.getEmail();
		city = user.getCity();
		phonePrefix = user.getPhonePrefix();
		phoneSuffix = user.getPhoneSuffix();
		pic = user.getPic();
	}
%>
                    
<form method="post" action="ProfileController" onsubmit="return validate()" enctype="multipart/form-data">
<table style="width:45%">
		<tr>
			<td>First name:</td>
			<td colspan="2"><input type="text" id="firstName" name="firstName" maxlength="20" class="form-control" value =<%=firstName %>></input></td>
			<td><p id="firstNameErr" style="color:#3281c3;"></p></td>
		</tr>
		<tr>
			<td>Last name:</td>
			<td colspan="2"><input type="text" id="lastName" name="lastName" maxlength="20" class="form-control" value =<%=lastName %>></input></td>
			<td><p id="lastNameErr" style="color:#3281c3;"></p></td>
		</tr>
		<tr>
			<td>E-mail:</td>
			<td colspan="2"><input type="text" id="email" name="email" maxlength="70" class="form-control" value =<%=email %>></input></td>
			<td><p id="emailErr" style="color:#3281c3;"></p></td>
		</tr>
		<tr>
			<td>Phone:</td>
			<td><select class="form-control" name="phonePrefix" id="phonePrefix">
								<option value="050">050</option>
								<option value="052">052</option>
								<option value="053">053</option>
								<option value="054">054</option>
								<option value="056">056</option>
								<option value="057">057</option>
								<option value="058">058</option>
							</select></td>
							<td><input type="text" id="phone" name="phoneSuffix" maxlength="7" class="form-control" value =<%=phoneSuffix %>></input>
			</td>
			<td><p id="phoneErr" style="color:#3281c3;"></p></td>
		</tr>
		<tr>
			<td>City:</td>
			<td colspan="2"><select class="form-control" name="city" id="city">
								<option value="Tel-Aviv">Tel-Aviv</option>
								<option value="Ashdod">Ashdod</option>
								<option value="Haifa">Haifa</option>
								<option value="Hertzlia">Hertzlia</option>
								<option value="Ramat-Gan">Ramat-Gan</option>
							</select>
			</td>
		</tr>
		<tr>
			<td>Profile Picture:</td>
			<td colspan="2"><input type="file" id="pic" name="pic" accept="image/jpg,image/png,img/gif,img/bmp,image/jpeg" value =<%=pic %>></input></td>
			<td><p id="picErr" style="color:#3281c3;"></p></td>
		</tr>
	</table>
	<center>
		<input type="submit" value="Update Details" class="btn btn-default"/><br>
		<br>
	</form>
	</center>

<script>
	setCityPhone();
	function setCityPhone(){
		var city = "<%=city%>";
		var phonePre = "<%=phonePrefix%>";
		document.getElementById("city").value = city;
		document.getElementById("phonePrefix").value = phonePre;
		
	}
	
	function validate(){
		var usernameRegex = /^[a-zA-Z0-9]{5,30}$/;
		var passRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,12}$/;
		var phoneRegex = /^[0-9]{7,7}$/;
		var nameRegex = /^[A-Za-z]{2,20}$/;
		var fileRegex = /\.(jpe?g|png|gif|bmp)$/i; 
		
		var firstName = document.getElementById("firstName").value;
		var lastName = 	document.getElementById("lastName").value;
		var email = document.getElementById("email").value;
		var phone = document.getElementById("phone").value;
		var pic_name = document.getElementById("pic").value;
		var pic_file = document.getElementById("pic");
		var err = 0;

		document.getElementById("firstNameErr").innerHTML = "";
		document.getElementById("lastNameErr").innerHTML = "";
		document.getElementById("emailErr").innerHTML = "";
		document.getElementById("phoneErr").innerHTML = "";
		document.getElementById("picErr").innerHTML = "";

		if(firstName.match(nameRegex) == null){
			document.getElementById("firstNameErr").innerHTML = "Empty or invalid first name, a valid name is with Alphabets only";
			err=1;
		}
		
		if(lastName.match(nameRegex) == null){
			document.getElementById("lastNameErr").innerHTML = "Empty or invalid last name, a valid name is with Alphabets only";
			err=1;
		}
		
		if (!validateEmail(email)){
			document.getElementById("emailErr").innerHTML = "Empty or invalid E-mail address";
			err = 1;
		}
		
		if (phone.match(phoneRegex) == null){
			document.getElementById("phoneErr").innerHTML = "Empty or invalid phone number";
			err = 1;
		}
		
		if (pic_name != null && pic_name != ""){
			if(pic_name.match(fileRegex) == null || pic_file.files[0].size > 3145728){ //up to 3MB
				document.getElementById("picErr").innerHTML = "Invalid image file (we accept jpeg, jpg, bmp, gif, png), and maximum 3MB";
				err = 1;
			}
		}
		
		if (err)
			return false;
		return true;
	}
	
	function validateEmail(email) {
		  var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		  return re.test(email);
	}
</script>

<footer>
	<a href = "" style="color:white"/>About Us</a> |
	<a href = "" style="color:white"/> Help</a> |
	<a href = "" style="color:white"/> Jobs</a> |
	<a href = "" style="color:white"/> Terms</a> |
	<a href = "" style="color:white"/> Privacy</a> |
	<a href = "" style="color:white"/> Contact Us</a> 
</footer>
</body>
</html>