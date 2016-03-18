<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.shopping.product.*,com.shopping.client.*,com.shopping.order.*,com.shopping.user.*,java.util.*,java.sql.*" %>    

<%
Cart cart = (Cart)session.getAttribute("cart");
%>
<%
if(cart==null){
	out.println("Empty Cart!");
	return;
}
User user = (User)session.getAttribute("user");
if(user==null){
	user = new User();
	user.setId(-1);
	
}
%>
<%
String addr = request.getParameter("addr");
SalesOrder so = new SalesOrder();
so.setCart(cart);
so.setAddr(addr);
so.setUser(user);
so.setoDate(new Timestamp(System.currentTimeMillis()));
so.setStatus(0);//0 
so.save();
session.removeAttribute("cart");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Shopping Cart</title>
</head>
<body>
	<center>Shopping Successfully! Welcome Shop Again!</center>
</body>	
</html>
