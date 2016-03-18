<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.shopping.product.*,com.shopping.category.*,java.util.*" %>    

<%
int id = Integer.parseInt(request.getParameter("id"));
Product p = ProductMgr.getInstance().loadById(id);

%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Product Detail</title>
</head>
<body>
	<center>Product Detail</center>
	<img alt="<%=p.getName() %>" src="#" height=90 width=90 border=0>
	<br>
	Name:  <%=p.getName() %><br><br>
	Description:  <%=p.getDescr() %><br><br>
	Normal Price:  <%=p.getNormalprice() %>$<br><br>
	Member Price:  <%=p.getMemberprice() %>$<br><br>
	<a href="buy.jsp?id=<%=id %>">Check out</a>
	
</body>
</html>