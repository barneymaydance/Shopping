<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="_sessioncheck.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Shopping Administration</title>
</head>
<body>
	<table>
		<tr> 
			<th>User Management</th> 
		</tr>
		<tr>
			<td><a href="userlist.jsp">User List</a></td>
		</tr>
		<tr> 
			<th>Category Management</th> 
		</tr>
		<tr>
			<td ><a href="categoryadd.jsp">Add Category</a></td>
			<td ><a href="categorylist.jsp">Category List</a></td>
		</tr>
		<tr> 
			<th>Product Management</th> 
		</tr>
		<tr>
			<td ><a href="productlist.jsp">Product List</a></td>
			<td ><a href="productadd.jsp">Add Product</a></td>
			<td ><a href="productsearch.jsp">Search Product</a></td>
		</tr>
		<tr> 
			<th>Order Management</th> 
		</tr>
		<tr>
			<td ><a href="orderlist.jsp">Order List</a></td>
			<td ><a href="#"></a></td>
		</tr>
		
	</table>
</body>
</html>