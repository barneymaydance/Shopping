<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.shopping.product.*,com.shopping.client.*,com.shopping.user.*,java.util.*" %>    

<%
Cart cart = (Cart)session.getAttribute("cart");
if(cart==null){
	cart=new Cart();
	session.setAttribute("cart", cart);
}

%>
<%
User u = (User)session.getAttribute("user");
if(u==null){
	out.println("You haven't login! <br>");
	//out.println("<a href = confirmusenormal.jsp>Continue</a><br>");
	out.println("<a href = login.jsp>Login</a>");
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Shopping Cart</title>
</head>
<body>
	<center>Shopping Cart</center>
	<form action="cartupdate.jsp" method="post">
	<table align="center" border="1">
		<tr>
			<td>Product ID:</td>
			<td>Product Name:</td>
			<td>Product Price<%= (u==null?"(Normal Price)":"(Member Price)") %>:</td>
			<td>Product Number:</td>
	
		</tr>
		<%
		List<CartItem> items = cart.getItems();
		for(int i=0;i<items.size();i++){
			CartItem ci = items.get(i);
			Product p=ProductMgr.getInstance().loadById(ci.getProductId());
			%>
			<tr>
				<td><%=ci.getProductId() %></td>
				<td><%=p.getName() %></td>
				<td><%=(u==null?p.getNormalprice():p.getMemberprice()) %></td>
				<td><%=ci.getCount() %></td>
			</tr>
			
			<%
		}
		%>
	</table>
	<center>
		Total: <%=Math.round(cart.getTotalPrice()*100)/100.0 %>$ 
	</center>
	</form>
	<br>
	<form action="order.jsp" method="post">
	<center>
		Deliver Address:<br>
		<textarea name="addr" rows="4" cols="25"><%=(u==null?"":u.getAddr()) %></textarea><br>
		<input type="submit" value="Place Order">
	</center>
	</form>
	
</body>	
</html>

