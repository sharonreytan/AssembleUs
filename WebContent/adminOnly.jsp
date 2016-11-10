<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
	<title>Assemble Us</title>
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
      <li><a href="profile">Profile</a></li>
      <li><a href="info">Information</a></li> 
      <li><a href="forum">Forum</a></li> 
      <li><a href="logout">Logout</a></li>
    </ul>
  </div>
</nav>      

<%@ page import="model.User" %>
<%
	RequestDispatcher rd = null;
	User user = (User)session.getAttribute("user");
	String isLogin = null;
	
	if(session.getAttribute("isLogin") == null || !session.getAttribute("isLogin").equals("true") || !user.isAdmin()){
		isLogin = "false";
		rd = request.getRequestDispatcher("/login");
		rd.forward(request, response);
	}
	else if(session.getAttribute("isLogin").equals("true") && user.isAdmin()){
		isLogin = "true";
	}
%>
<div class="container">
<center>                
<h2><strong>Admin Page</strong></h2>  
<h4>Username to promote:</h4><br>
<form method="post" action="AdminController" class="form-inline" onsubmit="return validate()">
	<input type="text" id="username" name="promotedUsername" title="5-30 charcters, Alphabets and numbers" maxlength="30" class="form-control"></input>
	<p id="userErr" style="color:#3281c3;"></p>
	<input type="submit" value="Update Details" class="btn btn-default"/><br>
	<br>
</form>
</center>

<script>
	function validate(){
		var usernameRegex = /^[a-zA-Z0-9]{5,30}$/;
		var err = 0;
		
		var user = document.getElementById("username").value;

		document.getElementById("userErr").innerHTML = "";

		if (user.match(usernameRegex) == null){
			document.getElementById("userErr").innerHTML = "Invalid username input";
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