<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
<style>
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
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">

<header>
   <h1>AssembleUs</h1>
</header>
	
	<!-- 
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	The LoginController servlet was mapped in the web.xml file. 
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	-->
	<br>
	<center>
	<form method="post" action="afterLogin" class="form-inline" onsubmit="return validate()">
			Username : <input type="text" name="username" id="username" class="form-control" placeholder="Enter username"> <BR>
			<p id="userErr" style="color:#FA8258;"></p>
			Password : <input type="password" name="password" id="password" class="form-control" placeholder="Enter password"> <BR>
			<p id="passErr" style="color:#FA8258;"></p>
			<input type="submit" value="Login" class="btn btn-default"/><br>
	</form>
	<BR><a href="registration">Registration</a>
	</center>
	<script>
	function validate(){
		var usernameRegex = /^[a-zA-Z0-9]{5,30}$/;
		var passRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,12}$/;
		var user = document.getElementById("username").value;
		var pass = document.getElementById("password").value;
		var err = 0;
		document.getElementById("userErr").innerHTML = "";
		document.getElementById("passErr").innerHTML = "";
		
		if (user.match(usernameRegex) == null){
			document.getElementById("userErr").innerHTML = "Invalid username input";
			err = 1;
		}
		
		if (pass.match(passRegex) == null){
			document.getElementById("passErr").innerHTML = "Invalid password input";
			err = 1;
		}
		
		if (err)
			return false;
		return true;
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

</div>
</body>
</html>