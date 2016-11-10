<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
	<title>Registration</title>
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

<body>

	<header>
	   <h1>AssembleUs</h1>
	</header>
<form method="post" action="RegistController" onsubmit="return validate()" enctype="multipart/form-data">
<table style="width:45%">
		<tr>
			<td>User name:</td>
			<td colspan="2"><input type="text" id="username" name="username" title="5-30 charcters, Alphabets and numbers" maxlength="30" class="form-control"></input></td>
			<td colspan="3"><p id="userErr" style="color:#3281c3;"></p></td>
		</tr>
		<tr>
			<td>First name:</td>
			<td colspan="2"><input type="text" id="firstName" name="firstName" maxlength="20" class="form-control"></input></td>
			<td><p id="firstNameErr" style="color:#3281c3;"></p></td>
		</tr>
		<tr>
			<td>Last name:</td>
			<td colspan="2"><input type="text" id="lastName" name="lastName" maxlength="20" class="form-control"></input></td>
			<td><p id="lastNameErr" style="color:#3281c3;"></p></td>
		</tr>
		<tr>
			<td>E-mail:</td>
			<td colspan="2"><input type="text" id="email" name="email" maxlength="70" class="form-control"></input></td>
			<td><p id="emailErr" style="color:#3281c3;"></p></td>
		</tr>
		<tr>
			<td>Phone:</td>
			<td><select class="form-control" name="phonePrefix">
								<option value="050">050</option>
								<option value="052">052</option>
								<option value="053">053</option>
								<option value="054">054</option>
								<option value="056">056</option>
								<option value="057">057</option>
								<option value="058">058</option>
							</select></td>
							<td><input type="text" id="phone" name="phoneSuffix" maxlength="7" class="form-control"></input>
			</td>
			<td><p id="phoneErr" style="color:#3281c3;"></p></td>
		</tr>
		<tr>
			<td>Password:</td>
			<td colspan="2"><input type="password" id="password" name="password" maxlength="12" class="form-control"></input></td>
			<td><p id="passErr" style="color:#3281c3;"></p></td>
		</tr>
		<tr>
			<td>Confirm Password:</td>
			<td colspan="2"><input type="password" id="confPassword" maxlength="12" class="form-control"></input></td>
			<td><p id="confPassErr" style="color:#3281c3;"></p></td>
		</tr>
		<tr>
			<td>Gender:</td>
			<td colspan="2"><select class="form-control" name="gender">
						<option value="male">Male</option>
						<option value="female">Female</option>
						</select>
			</td>
			<td><p id="userErr" style="color:#3281c3;"></p></td>
		</tr>
		<tr>
			<td>City:</td>
			<td colspan="2"><select class="form-control" name="city">
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
			<td colspan="2"><input type="file" id="pic" name="pic" accept="image/jpg,image/png,img/gif,img/bmp,image/jpeg"></input></td>
			<td><p id="picErr" style="color:#3281c3;"></p></td>
		</tr>
	</table>
	<center>
	
		<input type="submit" value="Join Us" class="btn btn-default"/><br>
	</form>
	</center>

<script>
	function validate(){
		var usernameRegex = /^[a-zA-Z0-9]{5,30}$/;
		var passRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,12}$/;
		var phoneRegex = /^[0-9]{7,7}$/;
		var nameRegex = /^[A-Za-z]{2,20}$/;
		var fileRegex = /\.(jpe?g|png|gif|bmp)$/i; 

		var user = document.getElementById("username").value;
		var pass = document.getElementById("password").value;
		var confirmPass = document.getElementById("confPassword").value;
		var firstName = document.getElementById("firstName").value;
		var lastName = 	document.getElementById("lastName").value;
		var email = document.getElementById("email").value;
		var phone = document.getElementById("phone").value;
		var pic_name = document.getElementById("pic").value;
		var pic_file = document.getElementById("pic");
		var err = 0;

		document.getElementById("userErr").innerHTML = "";
		document.getElementById("passErr").innerHTML = "";
		document.getElementById("confPassErr").innerHTML = "";
		document.getElementById("firstNameErr").innerHTML = "";
		document.getElementById("lastNameErr").innerHTML = "";
		document.getElementById("emailErr").innerHTML = "";
		document.getElementById("phoneErr").innerHTML = "";
		document.getElementById("picErr").innerHTML = "";

		if (user.match(usernameRegex) == null){
			document.getElementById("userErr").innerHTML = "Invalid username input";
			err = 1;
		}
		
		if (pass.match(passRegex) == null){ 
			document.getElementById("passErr").innerHTML = "Your password should combine small letters, big letters and numbers";
			err = 1;
		}
		
		else if (pass.match(user)){
			document.getElementById("passErr").innerHTML = "Your password should be different from your username";
			err = 1;
		}

		if(confirmPass == null || confirmPass == ""){
			document.getElementById("confPassErr").innerHTML = "Password confirmation is empty";
			err=1;
		}
		
		else if (pass.match(confirmPass) == null){
			document.getElementById("confPassErr").innerHTML = "Password confirmation does not match";
			err=1;
		}
		
		if(firstName.match(nameRegex) == null){
			document.getElementById("firstNameErr").innerHTML = "Invalid first name, a valid name is with Alphabets only";
			err=1;
		}
		
		if(lastName.match(nameRegex) == null){
			document.getElementById("lastNameErr").innerHTML = "Invalid last name, a valid name is with Alphabets only";
			err=1;
		}
		
		if (!validateEmail(email)){
			document.getElementById("emailErr").innerHTML = "Invalid E-mail address";
			err = 1;
		}
		
		if (phone.match(phoneRegex) == null){
			document.getElementById("phoneErr").innerHTML = "Invalid phone number";
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
		else
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