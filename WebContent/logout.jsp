<%@page import="controllers.LogoutController"%>
<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
</head>
<body>



<%
String isLogin = null;
RequestDispatcher rd = null;
try{
	long sessCreateTime = session.getCreationTime(); //in case that a session was invalidated, go to login
	if(session.getAttribute("isLogin").equals("true") && session != null){
		isLogin = "true";
		%>
		<jsp:forward page="LogoutController"></jsp:forward>
		<%
	}
	else{
		isLogin = "false";
		rd = request.getRequestDispatcher("/login");
		rd.forward(request, response);
	}
	if(session.getAttribute("isLogin").equals("null")){
		System.out.println("isLogin is null");
	}
}
catch (Exception e){
	rd = request.getRequestDispatcher("/login");
	rd.forward(request, response);
}
%>

</body>
</html>