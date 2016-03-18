<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.shopping.user.*"%>
<%
User u=(User) session.getAttribute("user");
if(u==null){
	out.println("You havn't logged in!");
	return; 
}
%>   
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Self Service</title>
</head>
<body>
	<div>
		<a href="usermodify.jsp">Changer personal information</a>
	</div>
</body>
</html>