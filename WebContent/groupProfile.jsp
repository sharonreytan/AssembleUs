<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
	<title>Group</title>
	<style>
		table {
		    border-collapse: collapse;
		    width: 80%;
		}
		
		th, td {
		    text-align: left;
		    padding: 8px;
		}
		
		tr:nth-child(even){background-color: #f2f2f2}
		
		th {
		    background-color: #4CAF50;
		    color: white;
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

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="home">AssembleUs</a>
    </div>
    <ul class="nav navbar-nav">
      <li><a href="home">Home</a></li>
      <li class="active"><a href="groupsFaculties">Join Group</a></li>
      <li><a href="createGroup">Create Group</a></li>
      <li><a href="profile">Profile</a></li> 
      <li><a href="info">Information</a></li> 
      <li><a href="forum">Forum</a></li>
      <li><a href="logout">Logout</a></li>
    </ul>
  </div>
</nav>  
<center>
<div class="container">
<%@ page import="model.GroupProfilePOJO" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="model.User" %>
<%
	RequestDispatcher rd = null;
	String isLogin = "false";
	String groupName = null;
	String groupDesc = null;
	String groupId = null;
	String userId = null;
	boolean isMember = false;
	
	if(session.getAttribute("isLogin") == null || !session.getAttribute("isLogin").equals("true")){
		isLogin = "false";
		rd = request.getRequestDispatcher("/login");
		rd.forward(request, response);
	}
	else if(session.getAttribute("isLogin").equals("true")){
		isLogin = "true";
	}
	
	try{
		User user = (User)session.getAttribute("user");
	    userId = String.valueOf(user.getUserId());
	    
		GroupProfilePOJO group_details = (GroupProfilePOJO)session.getAttribute("group_details");
		groupName = group_details.getGroup_name();
		groupDesc = group_details.getGroup_desc();
		groupId = group_details.getGroup_id();
		isMember = group_details.isMember();
		
		%>
		<c:set var="groupNameAntiXSS" value="<%= groupName %>"/>
		<c:set var="groupDescAntiXSS" value="<%= groupDesc %>"/>
			<h1><u>Group Details</u></h1>
		   	<h3>${fn:escapeXml(groupNameAntiXSS)}</h3>
		    <p><strong>Description: </strong>${fn:escapeXml(groupDescAntiXSS)}</p>
		<% if (!isMember){%>    
		<form method="post" action="JoinGroupController" class="form-inline">
				<input type="hidden" name="userId" value="<%= userId %>">
				<input type="hidden" name="groupId" value="<%= groupId %>">
				<input type="submit" value="Assemble Me" class="btn btn-default"></input>
		</form>
		<br>
		<%
		}
	}catch (Exception e){
		e.printStackTrace();
		System.out.println("error");
	}
%>

</center>
</div>

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