<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
	<title>Create Group</title>
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


<body>

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="home">AssembleUs</a>
    </div>
    <ul class="nav navbar-nav">
      <li><a href="home">Home</a></li>
      <li><a href="groupsFaculties">Join Group</a></li>
      <li class="active"><a href="createGroup">Create Group</a></li>
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
	String userId = null;
	String isLogin = "false";

	if(session.getAttribute("isLogin") == null || !session.getAttribute("isLogin").equals("true")){
		isLogin = "false";
		rd = request.getRequestDispatcher("/login");
		rd.forward(request, response);
	}
	else if(session.getAttribute("isLogin").equals("true")){
		isLogin = "true";
		User user = (User)session.getAttribute("user");
		userId = String.valueOf(user.getUserId());
	}
%>

<center>
<h2><strong>Create a Group</strong></h2>
<BR>
<form method="post" action="CreateGroupController" class="form-inline" onsubmit="return validate()">
	<h4>Group Name:</h4>
	<p style="color:#808080">This will be your group title. Write something we will relate to as future members!</p>
	<input id="groupName" name="groupName" class="form-control" maxlength="255"></input><br>
	<p id="groupNameErr" style="color:#FA8258;"></p>
	
	<h4>Faculty:</h4>
	<select class="form-control" name="faculty">
		<option value="Sciences">Sciences</option>
		<option value="Engineering">Engineering</option>
		<option value="Design">Design</option>
		<option value="TechnologyManagement">Technology Management</option>
		<option value="InstructionalTechnologies">Instructional Technologies</option>
	</select>
	
	<h4>Group Description:</h4>
	<p style="color:#808080">What this group is all about</p>
	<textarea rows="7" cols="50" name="groupDesc"  id="groupDesc" maxlength="1000"></textarea><br>
	<p id="groupDescErr" style="color:#FA8258;"></p>
	
	<input name="creatorUserId" type="hidden" value=<%=userId%> class="form-control"></input>
	<input type="submit" value="Create the Group!" class="btn btn-default"/><br>
</form>
<br>
</center>

<script>
	function validate(){
		var groupName = document.getElementById("groupName").value;
		var groupDesc = document.getElementById("groupDesc").value;
		var err = 0;
		document.getElementById("groupNameErr").innerHTML = "";
		document.getElementById("groupDescErr").innerHTML = "";
		
		if(groupName == null || groupName =='' || groupName.length >= 255){
			document.getElementById("groupNameErr").innerHTML = "Group name is empty or too long. Maximum 255 characters.";
			err = 1;
		}
		if(groupDesc == null || groupDesc =='' || groupDesc.length >= 1000){
			document.getElementById("groupDescErr").innerHTML = "Description is empty or too long. Maximum 1000 characters.";
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
</body>
</html>