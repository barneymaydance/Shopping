<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.shopping.product.*,com.shopping.client.*,com.shopping.category.*,java.util.*" %>    

<%
Cart cart = (Cart)session.getAttribute("cart");
%>
<%
if(cart==null){
	out.println("Empty Cart!");
	return;
}
List<CartItem> items = cart.getItems();
for(int i=0;i<items.size();i++){
	CartItem ci = items.get(i);
	String strCount = request.getParameter("p"+ci.getProductId());
	if(strCount!=null&&!strCount.trim().equals("")){
		ci.setCount(Integer.parseInt(strCount));
	}
}

response.sendRedirect("cart.jsp");

%>