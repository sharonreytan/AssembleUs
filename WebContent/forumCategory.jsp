<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
	<title>Forum</title>
	<style>
		table {
		    border-collapse: collapse;
		    width: 43%;
		}
		
		th, td {
		    text-align: left;
		    padding: 8px;
		}
		
		tr:nth-child(odd){background-color: #f2f2f2}
		
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
<%@ page import="model.User" %>
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
      <li class="active"><a href="#">Forum</a></li>
      <li><a href="logout">Logout</a></li>
    </ul>
  </div>
</nav> 
<div class="container">
<center>
<h2><strong>Categories</strong></h2><BR>
<table>
<%@ page import="model.ForumCategoryPOJO" %>
<%@ page import="java.sql.ResultSet" %>
<%
	RequestDispatcher rd = null;
	ResultSet cat_records = null;
	String isLogin = "false";
	boolean isAdmin = false;
	String userId = null;
	String catLink = null;
	String catName = null;
	String catDesc = null;
	
	if(session.getAttribute("isLogin") == null || !session.getAttribute("isLogin").equals("true")){
		isLogin = "false";
		rd = request.getRequestDispatcher("/login");
		rd.forward(request, response);
	}
	else if(session.getAttribute("isLogin").equals("true")){
		isLogin = "true";
	}
	
	try{
		
		ForumCategoryPOJO category = (ForumCategoryPOJO)session.getAttribute("category");
		cat_records = category.getCat_rs();
		while (cat_records.next()){
			catLink = "/AssembleUs/topics?category=" + String.valueOf(cat_records.getInt("cat_id"));
			catName = cat_records.getString("cat_name");
			catDesc = cat_records.getString("cat_desc");
			%>
			<c:set var="catNameAntiXSS" value="<%= catName %>"/>
			<c:set var="catDescAntiXSS" value="<%= catDesc %>"/>
			    <tr><td><a href=<%= catLink %>><strong>${fn:escapeXml(catNameAntiXSS)}</strong></a></td></tr>
			    <tr><td>${fn:escapeXml(catDescAntiXSS)}</td></tr>
			<%
			}
			%>
		    </table>
		    <%
		    cat_records.close();
		    User user = (User)session.getAttribute("user");
		    isAdmin = user.getIsAdmin();
		    userId = String.valueOf(user.getUserId());
		    if (isAdmin){
		    	%>
		    		<center>
					<BR>
					<h4><strong>New Category:</strong></h4>
					<form method="post" action="addCategoryController" class="form-inline" onsubmit="return validate()">
						<input name="userId" type="hidden" class="form-control" value=<%=userId%> />
						<input name="subject" id="subject" type="text" class="form-control" maxlength="255" placeholder = "Category subject"/>
						<p id="subjectErr" style="color:#FA8258;"></p>
						<textarea rows="7" cols="50" name = "description" id = "description" maxlength="255" placeholder = "Category description"></textarea><br>
						<p id="descriptionErr" style="color:#FA8258;"></p>
						<input type="submit" value="Create Category" class="btn btn-default"/>
					</form>
					</center>
		    	<% 
		    }
	}catch (Exception e){
		e.printStackTrace();
		System.out.println("error");
	}
%>
<br>
</center>
</div>
<script>
	function validate(){
		var subject = document.getElementById("subject").value;
		var description = document.getElementById("description").value;
		var err = 0;
		document.getElementById("subjectErr").innerHTML = "";
		document.getElementById("descriptionErr").innerHTML = "";
		
		if(subject == null || subject =='' || subject.length >= 255){
			document.getElementById("subjectErr").innerHTML = "Subject empty or too long";
			err = 1;
		}
		if(description == null || description =='' || description.length >= 255){
			document.getElementById("descriptionErr").innerHTML = "Description empty or too long";
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