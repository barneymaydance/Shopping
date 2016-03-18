<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.shopping.product.*,com.shopping.category.*,java.util.*" %> 

<%
List<Product> lastestProducts = ProductMgr.getInstance().getLastestProducts(6);



%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Online Shopping Index</title>
<style>
#header1 
{
	color:gray;
	width:100%;
	font-size:40px;
}
</style>
</head>
<body>
	<div>
		<span id="header1"> Welcome to Online Shopping!</span>
	</div>
	<div>
		<a href="register.jsp"> Register</a>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="login.jsp"> Login</a>	
	</div>
	<div>
		<table>
		<th>Latest Products:</th>
		<%
			for(Iterator<Product> it=lastestProducts.iterator();it.hasNext();){
				Product p = it.next();
				
			
			%>
		<tr>
			<td valign="top"><a href="productdetailshow.jsp?id=<%=p.getId()%>">	<img alt="<%=p.getName() %>" src="#" height=90 width=90 border=0></a></td>
		</tr>
		<tr>
			<td valign="top"><a href="productdetailshow.jsp?id=<%=p.getId()%>"><%=p.getName() %></a></td>
		</tr>
		<tr>
			<td valign="bottom"><a>Member Price: <%=p.getMemberprice() %>$</a></td>
		</tr>
		<%
			}
			%>
		
		</table>
	
	</div>
</body>
</html>