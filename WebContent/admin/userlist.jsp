<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, com.shopping.user.*,java.util.*"%>
<%@include file="_sessioncheck.jsp" %>
<%
	//get all the users
List<User> users = User.getUsers();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<table align="center" border="1">
		<tr>
			<td>ID</td>
			<td>Username</td>
			<td>Phone</td>
			<td>Address</td>
			<td>Rdate</td>
			<td>Management</td>	
		</tr>
		<%
			for(Iterator<User> it =users.iterator();it.hasNext();){
				User u = it.next();
		%>
		<tr>
			<td><%=u.getId() %></td>
			<td><%=u.getUsername() %></td>
			<td><%=u.getPhone() %></td>
			<td><%=u.getAddr() %></td>
			<td><%=u.getRdate() %></td>
			<td><a href="userdelete.jsp?id=<%=u.getId()%>">Delete</a></td>	
		</tr>
		<%
			}
		%>
		
	</table>
</body>
</html>