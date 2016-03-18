<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date, com.shopping.user.*"%>
<%
String action = request.getParameter("action");
if(action!=null&&action.equals("register")){
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	String phone=request.getParameter("phone");
	String addr=request.getParameter("addr");
	User user = new User();
	user.setUsername(username);
	user.setPassword(password);
	user.setPhone(phone);
	user.setAddr(addr);
	user.setRdate(new Date());
	user.save();
	%>
	<center> Register Successfully!</center>
	<%
	return;
	
}
%>	
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>register</title>
<script language=JavaScript src="script/regcheckdata.js"></script>
</head>
<body>
	<form name="form" action="register.jsp" method="post"
		onSubmit="return checkdata()">
		<input type="hidden" name="action" value="register"/>
		<table width="750" align="center" border="2">
			<tr>
				<td colspan="2" align="center">Register</td>
			</tr>
			<tr>
				<td>Username:</td>
				<td><input type=text name="username" size="30" maxlength="10">
				</td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type=password name="password" size="15" maxlength="12">
				</td>
			</tr>
			<tr>
				<td>Password again</td>
				<td><input type=password name="password2" size="15" maxlength="12">
				</td>
			</tr>
			<tr>
				<td>Phone:</td>
				<td><input type=text name="phone" size="15" maxlength="12">
				</td>
			</tr>
			<tr>
				<td>Address:</td>
				<td><textarea rows="12" cols="80" name="addr"></textarea></td>
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