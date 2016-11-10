<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
	<title>Groups</title>
	<style>
		table {
		    border-collapse: collapse;
		    width: 90%;
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
<div class="container">
<center>


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
		GroupsPOJO groups = (GroupsPOJO)session.getAttribute("groups");
		groups_records = groups.getGroups_rs();
		if(groups_records.next()){
			 %>
			<h2><strong>Groups At This Faculty:</strong></h2><BR>
			<table>
			<tr>
			<td style="font-size:20px"><strong>Groups</strong></td>
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
				<form method="post" action="JoinGroupController" class="form-inline">
					<input type="hidden" name="userId" value="<%= userId %>">
					<input type="hidden" name="groupId" value="<%= groupId %>">
					<input type="submit" value="Assemble Me" class="btn btn-default"></input>
				</form>
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
					<td>
					<form method="post" action="JoinGroupController" class="form-inline">
						<input type="hidden" name="userId" value="<%= userId %>">
						<input type="hidden" name="groupId" value="<%= groupId %>">
						<input type="submit" value="Assemble Me" class="btn btn-default"></input>
					</form>
					</td>
				</tr>
				<tr><td><strong>Description: </strong>${fn:escapeXml(groupDescAntiXSS)}</td></tr> 
				<%
				}
				%>
			    </table>
			    <%
			}
		
		else{%>
			<h2><strong>No Groups for this faculty yet, or you are a member of all of them.</strong></h2><BR>
			<a href="createGroup">Create a New One?</a>
		<%
		}
			    groups_records.close();
		
	}catch (Exception e){
		e.printStackTrace();
		groups_records.close();
		System.out.println("error");
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