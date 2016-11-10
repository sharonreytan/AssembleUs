
<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
	<title>Posts</title>
	<style>
		table {
		    border-collapse: collapse;
		    width: 80%;
		}
		
		th, td {
		    text-align: left;
		    padding: 8px;
		}
		
		tr:nth-child(even){background-color: }
		
		th {
		    background-color: #4CAF50;
		    color: white;
		}
		 
		div.container {
			font-family: calibri;
		    width: 80%;
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
<div class="container">
<center>
<BR>
<BR>
<%@ page import="model.ForumPostsPOJO" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="model.User" %>

<%
	RequestDispatcher rd = null;
	ResultSet posts_records = null;
	String userId = null;
	String isLogin = "false";
	String postTopic = null;
	String postContent = null;
	String fullName = null;
	String postDate = null;
	
	
	if(session.getAttribute("isLogin") == null || !session.getAttribute("isLogin").equals("true")){
		isLogin = "false";
		rd = request.getRequestDispatcher("/login");
		rd.forward(request, response);
	}
	else if(session.getAttribute("isLogin").equals("true")){
		isLogin = "true";
	}
	
	try{
		ForumPostsPOJO posts = (ForumPostsPOJO)session.getAttribute("posts");
		User user = (User)session.getAttribute("user");
	    userId = String.valueOf(user.getUserId());
	    postTopic = String.valueOf(posts.getTopic());
	    
	  	posts_records = posts.getPosts_rs();
		  if(posts_records.next()){
			  %>
			  <h2><strong>Posts</strong></h2><BR>
			  <table class="table">
			  <tr>
			  <td style="font-size:20px"><strong>Post</strong></td>
			  <td style="font-size:20px"><strong>Author</strong></td>
			  <td style="font-size:20px"><strong>Written at</strong></td>
			  </tr>
		  
		  <%
	
		  postContent = posts_records.getString("post_content");
		  fullName = posts_records.getString("full_name");
		  postDate = posts_records.getString("post_date");
			 
		  %>
	  	   <c:set var="postContentAntiXSS" value="<%= postContent %>"/>
	  	   <c:set var="fullNameAntiXSS" value="<%= fullName %>"/>
	  	   <tbody>
	       <tr>
	       <td><strong>${fn:escapeXml(postContentAntiXSS)}</strong></td>
	       <td>${fn:escapeXml(fullNameAntiXSS)}</td>
	       <td><%=postDate %></td>
	       </tr>
	   <%
		  while (posts_records.next()){
			  postContent = posts_records.getString("post_content");
			  fullName = posts_records.getString("full_name");
			  postDate = posts_records.getString("post_date");
			  
	
			  
		   %>
		  	   <c:set var="postContentAntiXSS" value="<%= postContent %>"/>
		  	   <c:set var="fullNameAntiXSS" value="<%= fullName %>"/>
		       <tr>
		       <td><strong>${fn:escapeXml(postContentAntiXSS)}</strong></td>
		       <td>${fn:escapeXml(fullNameAntiXSS)}</td>
		       <td><%=postDate %></td>
		       </tr>
		   <%
		   }
		   %>
	    </tbody>
	    </table>
	      <%
	  }
	  else{%>
	  	
		<h2><strong>No Posts for this Topic yet</strong></h2><BR>
		<p>Write a new one!</p>
	<%
	}
		  posts_records.close();
	}catch (Exception e){
		e.printStackTrace();
		posts_records.close();
		System.out.println("error " + e.toString());
	}
%>
<br>

<BR>
<h3><strong>Reply:</strong></h3><BR>
<form method="post" action="addCommentController" class="form-inline" onsubmit="return validate()">

	<input name="userId" type="hidden" class="form-control" value=<%=userId%> > </input>
	<input name="topic" type="hidden" class="form-control" value=<%=postTopic%> ></input>
	<textarea rows="7" cols="50" name = "comment"  id = "comment" maxlength="1000"></textarea><br>
	<p id="commentErr" style="color:#FA8258;"></p>
	<input type="submit" value="reply" class="btn btn-default"/>
</form>
<br>
<br>
</center>
</div>
<script>
	function validate(){
		var comment = document.getElementById("comment").value;
		var err = 0;
		document.getElementById("commentErr").innerHTML = "";
		
		if(comment == null || comment =='' || comment.length >= 1000){
			document.getElementById("commentErr").innerHTML = "reply empty or too long";
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