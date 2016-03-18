<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.shopping.order.*,com.shopping.product.*,com.shopping.category.*,java.util.*"%>
<%@include file="_sessioncheck.jsp" %>

<%!
private static final int PAGE_SIZE = 3;
%>
<%

String strPageNo = request.getParameter("pageno");
int pageno =1;
if(strPageNo != null){
	pageno=Integer.parseInt(strPageNo);	
}
if(pageno<1){
	pageno=1;
}


%>

<%
List<SalesOrder> orders = new ArrayList<SalesOrder>();
int pageCount= OrderMgr.getInstance().getOrders(orders,pageno,PAGE_SIZE);
if(pageno>pageCount){
	pageno=pageCount;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Order List</title>
</head>
<body>
	<center>Order List </center>
	<table align="center" border="1">
		<tr>
			<td>ID</td>
			<td>UserName</td>
			<td>Address</td>
			<td>Date</td>
			<td>Status</td>
			<td>Management</td>
					
		</tr>
		<%
			for(Iterator<SalesOrder> it =orders.iterator();it.hasNext();){
				SalesOrder so = it.next();				
		%>
		<tr>
			<td><%=so.getId() %></td>
			<td><%=so.getUser().getUsername() %></td>
			<td><%=so.getAddr()%></td>
			<td><%=so.getoDate()%></td>
			<td><%=so.getStatus() %></td>
			<td>
				<a href="orderdetailshow.jsp?id=<%=so.getId()%>">Show Detail</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="ordermodify.jsp?id=<%=so.getId()%>">Modify</a>
			</td>	
			 
		</tr>
		<%
			}
		%>
		
	</table>
	<center>
		Current Page <%=pageno %>:
		&nbsp;&nbsp;&nbsp;&nbsp;
		Total Page<%=pageCount %>:
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="orderlist.jsp?pageno=1">First Page</a>
		&nbsp;&nbsp;
		<a href="orderlist.jsp?pageno=<%=pageno-1 %>">Previous Page</a>
		&nbsp;&nbsp;
		<a href="orderlist.jsp?pageno=<%=pageno+1 %>">Next Page</a>
		&nbsp;&nbsp;
		<a href="orderlist.jsp?pageno=<%=pageCount %>">Last Page</a>
	</center>
	
</body>
</html>