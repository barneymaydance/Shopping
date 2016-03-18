<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.shopping.client.*,com.shopping.order.*,com.shopping.product.*,com.shopping.category.*,java.util.*"%>
<%@include file="_sessioncheck.jsp" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
SalesOrder so = OrderMgr.getInstance().loadById(id);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Order Detail</title>
</head>
<body>
	<center>Order Detail </center>
	<center>Order User:<%=so.getUser().getUsername() %></center>
	<table align="center" border="1">
		<tr>
			<td>Product ID:</td>
			<td>Product Name:</td>
			<td>Unit Price:</td>
			<td>Product Number:</td>
			<td>Management:</td>
		</tr>
		<%
		List<SalesItem> items = so.getItems();
		for(int i=0; i<items.size();i++){
			SalesItem si = items.get(i);
		%>
		<tr>
			<td><%=si.getProduct().getId() %></td>
			<td><%=si.getProduct().getName() %></td>
			<td><%=si.getUnitPrice() %></td>
			<td><%=si.getCount() %></td>
			<td></td>
		</tr>
		
		<%	
		}
		%>
	</table>
	<!-- 
	<div style="border:5px double purple; width:400;">
		&nbsp;
	</div>
	 -->
	
</body>
</html>