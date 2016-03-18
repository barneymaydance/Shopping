<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.shopping.client.*,com.shopping.order.*,com.shopping.product.*,com.shopping.category.*,java.util.*"%>
<%@include file="_sessioncheck.jsp" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
SalesOrder so = OrderMgr.getInstance().loadById(id);

String action = request.getParameter("action");
if(action!=null&&action.equals("modify")){
	int status= Integer.parseInt(request.getParameter("status"));
	so.setStatus(status);
	so.updateStatus();
}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Order Modify</title>

</head>
<body>
	<center>Order Detail </center>
	<center>Order User:<%=so.getUser().getUsername() %></center>
	<form action="ordermodify.jsp" method="post" >
		<input type="hidden" name="action" value="modify">
		<input type="hidden" name="id" value="<%=so.getId() %>">
		<select name="status">
			<option value="0"> Untreated </option>
			<option value="1"> Delivered </option>
			<option value="2"> Discard </option>
		</select>
		<br>
		<input type="submit" value="Modify"/>
	</form>
	<!-- 
	<script>
		function select(){
			for(var option in document.forms["form"].status.otpions){
				 if(option.value==<%=so.getStatus()%>){
					option.selected=true;
					 //document.forms["form"].status.selectedIndex = option.index;
					break;
				 }
				 else{
					 option.selected=false;
				 }
			}
		}
	</script>	
	 -->
</body>
</html>