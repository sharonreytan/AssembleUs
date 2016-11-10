<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
	<title>Topics</title>
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
      <li><a href="groupsFaculties">Join Group</a></li>
      <li><a href="createGroup">Create Group</a></li>
      <li><a href="profile">Profile</a></li> 
      <li><a href="info">Information</a></li> 
      <li class="active"><a href="forum">Forum</a></li>
      <li><a href="logout">Logout</a></li>
    </ul>
  </div>
</nav>  
<center>
<div class="container">
<%@ page import="model.ForumTopicsPOJO" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="model.User" %>
<%
	RequestDispatcher rd = null;
	ResultSet topics_records = null;
	String isLogin = "false";
	String category = null ;
	String userId = null;
	String postsLink = null;
	String topicSubj = null;
	String fullName = null;
	String postDate = null;
	String topicCont = null;
	
	if(session.getAttribute("isLogin") == null || !session.getAttribute("isLogin").equals("true")){
		isLogin = "false";
		rd = request.getRequestDispatcher("/login");
		rd.forward(request, response);
	}
	else if(session.getAttribute("isLogin").equals("true")){
		isLogin = "true";
	}
	
	try{
		ForumTopicsPOJO topics = (ForumTopicsPOJO)session.getAttribute("topics");
		topics_records = topics.getTopic_rs();
		category = String.valueOf(topics.getCategory());
		User user = (User)session.getAttribute("user");
	    userId = String.valueOf(user.getUserId());
		
		if(topics_records.next()){
			  %>
			  	<h2><strong>Topics</strong></h2><BR>
				<table>
				<tr>
				<td style="font-size:20px"><strong>Topic</strong></td>
				<td style="font-size:20px"><strong>Author</strong></td>
				<td style="font-size:20px"><strong>Written at</strong></td>
				</tr>
		 	 <%
		
		postsLink = "/AssembleUs/posts?topic=" + String.valueOf(topics_records.getInt("topic_id"));
		topicSubj = topics_records.getString("topic_subject");
		fullName = 	topics_records.getString("full_name");
		postDate = topics_records.getString("post_date");
		topicCont = topics_records.getString("topic_content");
		%>
		<c:set var="topicSubjAntiXSS" value="<%= topicSubj %>"/>
		<c:set var="fullNameAntiXSS" value="<%= fullName %>"/>
		<c:set var="topicContAntiXSS" value="<%= topicCont %>"/>
		    <tr>
		    <td ><a href=<%= postsLink %>><strong>${fn:escapeXml(topicSubjAntiXSS)}</strong></a></td>
		    <td>${fn:escapeXml(fullNameAntiXSS)}</td>
		    <td><%=postDate %></td>
		    </tr>
		    <tr>
		    <td>${fn:escapeXml(topicContAntiXSS)}</td>
		    
		    </tr>
		<%
		while (topics_records.next()){
			postsLink = "/AssembleUs/posts?topic=" + String.valueOf(topics_records.getInt("topic_id"));
			topicSubj = topics_records.getString("topic_subject");
			fullName = 	topics_records.getString("full_name");
			postDate = topics_records.getString("post_date");
			topicCont = topics_records.getString("topic_content");
			%>
			<c:set var="topicSubjAntiXSS" value="<%= topicSubj %>"/>
			<c:set var="fullNameAntiXSS" value="<%= fullName %>"/>
			<c:set var="topicContAntiXSS" value="<%= topicCont %>"/>
			    <tr>
			    <td ><a href=<%= postsLink %>><strong>${fn:escapeXml(topicSubjAntiXSS)}</strong></a></td>
			    <td>${fn:escapeXml(fullNameAntiXSS)}</td>
			    <td><%=postDate %></td>
			    </tr>
			    <tr>
			    <td >${fn:escapeXml(topicContAntiXSS)}</td>
			    
			    </tr>
			<%
			}
			%>
		    </table>
		    <%
		}
		else{%>
			<h2><strong>No Topics for this Category yet</strong></h2><BR>
			<%
		}
		topics_records.close();
	}catch (Exception e){
		e.printStackTrace();
		System.out.println("error");
	}
%>


<BR>
<h4><strong>New topic:</strong></h4>
<form method="post" action="addTopicController" class="form-inline" onsubmit="return validate()">
	<input name="userId" type="hidden" class="form-control" value=<%=userId%> > </input>
	<input name="category" type="hidden" class="form-control" value=<%=category%> ></input>
	<input type="text" name="subject" id="subject" maxlength ="255" class="form-control" placeholder = "Topic subject"/><BR>
	<p id="subjectErr" style="color:#FA8258;"></p>
	<textarea rows="7" cols="50" name = "content" id = "content" maxlength ="1000"  placeholder = "Topic description"></textarea><br>
	<p id="contentErr" style="color:#FA8258;"></p>
	<input type="submit" name="topic" value="create topic" class="btn btn-default"/>
</form>
</center>
</div>
<script>
	function validate(){
		var subject = document.getElementById("subject").value;
		var content = document.getElementById("content").value;
		var err = 0;
		document.getElementById("subjectErr").innerHTML = "";
		document.getElementById("contentErr").innerHTML = "";
		
		if(subject == null || subject =='' || subject.length >= 255){
			document.getElementById("subjectErr").innerHTML = "subject empty or too long";
			err = 1;
		}
		if(content == null || content =='' || content.length >= 1000){
			document.getElementById("contentErr").innerHTML = "content empty or too long";
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