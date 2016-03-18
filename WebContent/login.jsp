<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date, com.shopping.user.*"%>
<%
String action = request.getParameter("action");
if(action!=null&&action.equals("login")){
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	User u = null;
	try{
		u=User.validate(username, password);
	} catch(UserNotFoundException e){
		out.println("User Not Found!");
		return;
	} catch(PasswordNotCorrectException e){
		out.println("Password Not Correct!");
		return;
	}
	session.setAttribute("user", u);
	response.sendRedirect("selfservice.jsp");
	return;	
}
%>	
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User login</title>
<script language=JavaScript src="script/regcheckdata.js"></script>
</head>
<body>
	<form name="form" action="login.jsp" method="post">
		<input type="hidden" name="action" value="login"/>
		<table width="300" align="center" border="2">
			<tr>
				<td colspan="2" align="center">User Login</td>
			</tr>
			<tr>
				<td>Username:</td>
				<td><input type=text name="username" size="20" maxlength="10">
				</td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type=password name="password" size="20" maxlength="12">
				</td>
			</tr>
			
			<tr>
				<td></td>
				<td><input type="submit" value="Submit"> <input
					type="reset" value="Reset"></td>
			</tr>

		</table>
	</form>



</body>
</html>