<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
	<title>Information</title>
	<style>
			table {
		    border-collapse: collapse;
		    width: 45%;
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
      <li><a href="groupsFaculties">Join Group</a></li>
      <li><a href="createGroup">Create Group</a></li>
      <li><a href="profile">Profile</a></li> 
      <li class="active"><a href="info">Information</a></li> 
      <li><a href="forum">Forum</a></li>
      <li><a href="logout">Logout</a></li>
    </ul>
  </div>
</nav> 
<div class="container">
<center>

<h1><u>Your Information</u></h1>
<%@ page import="model.GroupsPOJO" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="model.User" %>
<%
	RequestDispatcher rd = null;
	ResultSet groups_records = null;
	String isLogin = "false";
	String groupName = null;
	String groupDesc = null;
	String groupCreator = null;
	String groupCreationDate = null;
	String memersCount = null;
	String groupId = null;
	
	String firstName = null;
	String lastName = null;
	String email = null;
	String city = null;
	String phonePrefix = null;
	String phoneSuffix = null;
	String phone = null;
	
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
		String userId = String.valueOf(user.getUserId());
		//display user details
		firstName = user.getFirstName();
		lastName = user.getLastName();
		email = user.getEmail();
		city = user.getCity();
		phonePrefix = user.getPhonePrefix();
		phoneSuffix = user.getPhoneSuffix();
		phone = phonePrefix + phoneSuffix;
		%>
			<c:set var="firstNameAntiXSS" value="<%= firstName %>"/>
			<c:set var="lastNameAntiXSS" value="<%= lastName %>"/>
			<c:set var="emailAntiXSS" value="<%= email %>"/>
			<c:set var="cityAntiXSS" value="<%= city %>"/>
			<c:set var="phoneAntiXSS" value="<%= phone %>"/>
			
			<h2><strong>Personal Details</strong></h2><BR>
			<table>
			<tr><td><strong>First Name:</strong></td><td>${fn:escapeXml(firstNameAntiXSS)}</td></tr>
			<tr><td><strong>Last Name:</strong></td><td>${fn:escapeXml(lastNameAntiXSS)}</td></tr>
			<tr><td><strong>E-mail:</strong></td><td>${fn:escapeXml(emailAntiXSS)}</td></tr>
			<tr><td><strong>City:</strong></td><td>${fn:escapeXml(cityAntiXSS)}</td></tr>
			<tr><td><strong>Phone:</strong></td><td>${fn:escapeXml(phoneAntiXSS)}</td></tr>
			</table><br>
		<%
		
		//display groups this user is at
		GroupsPOJO groups = (GroupsPOJO)session.getAttribute("groupsUserAt");
		groups_records = groups.getGroups_rs();
		if(groups_records.next()){
			 %>
			<h2><strong>Groups You Are a Member At:</strong></h2><BR>
			<table>
			<tr>
			<td style="font-size:20px"><strong>Group</strong></td>
			<td style="font-size:20px"><strong>Members amount</strong></td>
			<td style="font-size:20px"><strong>Created By</strong></td>
			<td style="font-size:20px"><strong>Created At</strong></td>
			</tr>
			<% 
			groupName = groups_records.getString("group_name");
			groupDesc = groups_records.getString("group_desc");
			groupCreator = groups_records.getString("full_name");
			groupCreationDate = groups_records.getString("creation_date");
			memersCount = groups_records.getString("members_count");
			groupId = String.valueOf(groups_records.getInt("group_id"));
			%>
			<c:set var="groupNameAntiXSS" value="<%= groupName %>"/>
			<c:set var="groupDescAntiXSS" value="<%= groupDesc %>"/>
			<c:set var="groupCreatorAntiXSS" value="<%= groupCreator %>"/>
			
			<tr>
				<td style="font-size:20px">${fn:escapeXml(groupNameAntiXSS)}</td>
				<td><%= memersCount %></td>
				<td>${fn:escapeXml(groupCreatorAntiXSS)}</td>
				<td><%= groupCreationDate %></td>
				<td>
				</td>
			</tr>
			<tr><td><strong>Description: </strong>${fn:escapeXml(groupDescAntiXSS)}</td></tr> 
			<%
			while (groups_records.next()){
				groupName = groups_records.getString("group_name");
				groupDesc = groups_records.getString("group_desc");
				groupCreator = groups_records.getString("full_name");
				groupCreationDate = groups_records.getString("creation_date");
				memersCount = groups_records.getString("members_count");
				groupId = String.valueOf(groups_records.getInt("group_id"));
				%>
				<c:set var="groupNameAntiXSS" value="<%= groupName %>"/>
				<c:set var="groupDescAntiXSS" value="<%= groupDesc %>"/>
				<c:set var="groupCreatorAntiXSS" value="<%= groupCreator %>"/>
				
				<tr>
					<td style="font-size:20px">${fn:escapeXml(groupNameAntiXSS)}</td>
					<td><%= memersCount %></td>
					<td>${fn:escapeXml(groupCreatorAntiXSS)}</td>
					<td><%= groupCreationDate %></td>
				</tr>
				<tr><td><strong>Description: </strong>${fn:escapeXml(groupDescAntiXSS)}</td></tr> 
				<%
				}
				%>
			    </table>
			    <%
			}
		
		else{%>
			<h2><strong>You are not a member of any group!</strong></h2>
			<p><a href="groupsFaculties">Join a New One?</a></p>
			<p><a href="createGroup">Create a New One?</a></p>
		<%
		}
		groups_records.close();
	}catch (Exception e){
		e.printStackTrace();
		System.out.println("error1");
	}
	
%>
<br>
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