<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
	<title>Forum</title>
</head>


<body>
<%
	RequestDispatcher rd = null;
	String isLogin = "false";
	
	if(session.getAttribute("isLogin") == null || !session.getAttribute("isLogin").equals("true")){
		isLogin = "false";
		rd = request.getRequestDispatcher("/login");
		rd.forward(request, response);
	}
	
	else if(session.getAttribute("isLogin").equals("true")){
		isLogin = "true";
		%>
		<jsp:forward page="ForumCategoryController"></jsp:forward>
		<%
	}
	
%>

</body>
</html>