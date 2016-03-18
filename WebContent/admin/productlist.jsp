<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.shopping.product.*,com.shopping.category.*,java.util.*"%>
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
List<Product> products = new ArrayList<Product>();
int pageCount= ProductMgr.getInstance().getProducts(products,pageno,PAGE_SIZE);
if(pageno>pageCount){
	pageno=pageCount;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Product list</title>
</head>
<body>
	<table align="center" border="1">
		<tr>
			<td>ID</td>
			<td>Name</td>
			<td>Description</td>
			<td>Normal Price</td>
			<td>Member Price</td>
			<td>Date</td>
			<td>Category Name</td>
			<td>Management</td>
					
		</tr>
		<%
			for(Iterator<Product> it =products.iterator();it.hasNext();){
				Product p = it.next();				
		%>
		<tr>
			<td><%=p.getId() %></td>
			<td><%=p.getName() %></td>
			<td><%=p.getDescr() %></td>
			<td><%=p.getNormalprice() %></td>
			<td><%=p.getMemberprice() %></td>
			<td><%=p.getPdate() %></td>
			<td><%=p.getCategory().getName() %></td>
			<td>
				<a href="productdelete.jsp?id=<%=p.getId()%>&pageno=<%=pageno%>">Delete</a>
				&nbsp;&nbsp;
				<a href="productmodify.jsp?id=<%=p.getId()%>">Modify</a>
				&nbsp;&nbsp;
				<a href="productupload.jsp?id=<%=p.getId()%>">Upload Image</a>
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
		<a href="productlist.jsp?pageno=1">First Page</a>
		&nbsp;&nbsp;
		<a href="productlist.jsp?pageno=<%=pageno-1 %>">Previous Page</a>
		&nbsp;&nbsp;
		<a href="productlist.jsp?pageno=<%=pageno+1 %>">Next Page</a>
		&nbsp;&nbsp;
		<a href="productlist.jsp?pageno=<%=pageCount %>">Last Page</a>
	</center>
	
</body>
</html>