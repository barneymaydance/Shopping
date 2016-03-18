<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.shopping.product.*,com.shopping.category.*,java.util.*"%>
<%@include file="_sessioncheck.jsp" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
int pageno = Integer.parseInt(request.getParameter("pageno"));
String action = request.getParameter("action");
if(action!=null&&action.equals("delete")){
	ProductMgr.getInstance().deleteProductById(id);
	out.println("Delete successfully!");
}


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Modify Delete</title>
</head>
<body>
	<center>Modify Delete</center>
	<form action="productdelete.jsp" method="post">
		<input type="hidden" name="action" value="delete"/>
		<input type="hidden" name="id" value="<%=id%>"/>
		<input type="hidden" name="pageno" value="<%=pageno%>"/>
		<table align="center">
			<tr>
				<td ><input type="button" onclick="window.location='productlist.jsp?pageno=<%=pageno %>'" value="Return"></td>
				<td colspan="2"><input  type="submit" value="Delete"></td>
			</tr>			
		</table>
	</form>
	
</body>
</html>