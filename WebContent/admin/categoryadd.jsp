<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.shopping.user.*,com.shopping.category.*" %>    
<%@include file="_sessioncheck.jsp" %>
<%
String strPid = request.getParameter("pid");
int pid=0;
if(strPid!=null&&!strPid.trim().equals("")){
	pid=Integer.parseInt(strPid);
}

String action = request.getParameter("action");
if(action!=null&&action.equals("add")){
	String name=request.getParameter("name");
	String descr=request.getParameter("descr");
	if(pid==0){
		Category.addTopCategory(name, descr);
	}
	else{
		Category.addChildCategory(pid,name,descr);
	}
	out.println("Add category successfully!");
	return;
}
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Category</title>
</head>
<body>
	<center>Add Root Category</center>
	<form action="categoryadd.jsp" method="post" >
		<input type="hidden" name="action" value="add">
		<input type="hidden" name="pid" value=<%=pid%>>
		<table align="center">
			<tr>
				<td> Category Name: </td>
				<td><input type="text" name="name"/></td>
			</tr>
			<tr>
				<td> Category Description: </td>
				<td><textarea name="descr" rows="8" cols="40"></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><input  type="submit" value="Submit"></td>
			</tr>
			
		</table>
	</form>
</body>
</html>