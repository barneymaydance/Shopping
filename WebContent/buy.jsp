<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.shopping.product.*,com.shopping.client.*,com.shopping.category.*,java.util.*" %>    

<%
Cart cart = (Cart)session.getAttribute("cart");
if(cart==null){
	cart=new Cart();
	session.setAttribute("cart", cart);
}
%>
<%
int id = Integer.parseInt(request.getParameter("id"));
CartItem ci = new CartItem();
Product p = ProductMgr.getInstance().loadById(id);
ci.setProductId(id);
ci.setPrice(p.getNormalprice());//need to check if login
ci.setCount(1);
cart.add(ci);
response.sendRedirect("cart.jsp");


%>	
