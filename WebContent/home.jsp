 <%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
<title>Home</title>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
		table, td {
		    border: 1px solid greay;
		    padding: 5px;
		    text-align: center;
		}
		
		table {
		    border-spacing: 15px;
		    color:#808080;
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
</head>

<body>
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="home">AssembleUs</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="home">Home</a></li>
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
String isLogin = null;
RequestDispatcher rd = null;

if(session.getAttribute("isLogin") == null || !session.getAttribute("isLogin").equals("true")){
	isLogin = "false";
	rd = request.getRequestDispatcher("/login");
	rd.forward(request, response);
}
else if(session.getAttribute("isLogin").equals("true")){
	isLogin = "true";
}

%>
<!-- search form -->
  <form class="form-inline" action="SearchController" onsubmit="return validate()" method="get">
  	<p>
  		<center>
		    <input type="text" size="50" class="form-control" placeholder = "What would you like to know?" maxlength="1000" id="search" name="search" >
		    <button type="submit" class="btn btn-default" ><span class="glyphicon glyphicon-search"></span>Search</button>
		    <p id="searchErr" style="color:#FA8258;"></p>
	    </center>
   </p>
   <p>
   		<center>
   			<table>
   			<tr>
   			<td>
	   			<a href="groupsFaculties"><img src="http://www.almachurch.co.uk/Content/CMS/images/General/home%20groups.jpg" height="150" width="200"></a>
	   			<p>How about joining a study group?<br>make some friends and study together.<br>The more the merrier!</p>
   			</td>
   			<td>
	   			<center><a href="forum"><img src="http://metaconnects.org/sites/default/files/u3/FocusGroup.jpg" height="150" width="200"></a></center>
	   			<p>When we are together we are powerful.<br>We study better. Make sure to post a message<br>at the forum for any issue.</p>
   			</td>
   			<td>
	   			<a href="createGroup"><img src="http://www.mywelcometothecity.com/wp-content/uploads/2010/12/people_talking.jpg" height="150" width="200"></a>
	   			<p>We combine people from all ages,<br>we believe elders can benefit the youth,<br>and so vice versa. Collaboration! Create a group today.</p>
   			</td>
   			</tr>
   			</table>
   		</center>
   </p>
  </form>

<%
if (isLogin == "true"){
	rd = null;
	User user = (User)session.getAttribute("user");
	boolean isAdmin = user.isAdmin();
	if(isAdmin){
		%>
		<center>
			<BR>
			<a href="adminOnly">Administration Page</a>
			<BR>
			<BR>
		</center>
		<%
	}
}
%>

<script>
	function validate(){
		var search = document.getElementById("search").value;
		var err = 0;
		document.getElementById("searchErr").innerHTML = "";
		
		if(search == null || search =='' || search.length >= 1000){
			document.getElementById("searchErr").innerHTML = "search is empty or too long";
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