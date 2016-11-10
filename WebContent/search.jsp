<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
	<title>Search Results</title>
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
	ResultSet searchResults = null;
	String isLogin = "false";
	String searchStr = null;
	String groupName = null;
	String groupDesc = null;
	String groupId = null;
	String groupLink = null;
	
	if(session.getAttribute("isLogin") == null || !session.getAttribute("isLogin").equals("true")){
		isLogin = "false";
		rd = request.getRequestDispatcher("/login");
		rd.forward(request, response);
	}
	else if(session.getAttribute("isLogin").equals("true")){
		isLogin = "true";
	}
	
	try{
		GroupsPOJO search = (GroupsPOJO)session.getAttribute("searchResult");
		searchStr = (String)session.getAttribute("searchStr");
		searchResults = search.getGroups_rs();
		if(searchResults.next()){
			 %>
			<h2><strong>Search Results:</strong></h2><BR>
			<table>
			<% 
			groupName = searchResults.getString("group_name");
			groupDesc = searchResults.getString("group_desc");
			groupId = String.valueOf(searchResults.getInt("group_id"));
			groupLink = "/AssembleUs/group?group_id=" + groupId;
			%>
			<c:set var="groupNameAntiXSS" value="<%= groupName %>"/>
			<c:set var="groupDescAntiXSS" value="<%= groupDesc %>"/>		
			<tr>
				<td style="font-size:20px"><a href=<%=groupLink %>>${fn:escapeXml(groupNameAntiXSS)}</a></td>
			</tr>
			<tr><td><strong>Description: </strong>${fn:escapeXml(groupDescAntiXSS)}</td></tr> 
			<%
			while (searchResults.next()){
				groupName = searchResults.getString("group_name");
				groupDesc = searchResults.getString("group_desc");
				groupId = String.valueOf(searchResults.getInt("group_id"));
				groupLink = "/AssembleUs/group?group_id=" + groupId;
				%>
				<c:set var="groupNameAntiXSS" value="<%= groupName %>"/>
				<c:set var="groupDescAntiXSS" value="<%= groupDesc %>"/>		
				<tr>
					<td style="font-size:20px"><a href=<%=groupLink %>>${fn:escapeXml(groupNameAntiXSS)}</a></td>
				</tr>
				<tr><td><strong>Description: </strong>${fn:escapeXml(groupDescAntiXSS)}</td></tr> 
				<%
				}
				%>
			    </table>
			    <%
			}
		
		else{%>
			<c:set var="searchStrAntiXSS" value="<%= searchStr %>"/>
			<h2><strong>No Results Found for ${fn:escapeXml(searchStrAntiXSS)} !</strong></h2><BR>
		<%
		}
		searchResults.close();
		
	}catch (Exception e){
		e.printStackTrace();
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