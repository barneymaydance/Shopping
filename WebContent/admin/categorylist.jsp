<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, com.shopping.category.*,java.util.*"%>
<%@include file="_sessioncheck.jsp" %>
<%
List<Category> categories = Category.getCategories();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<table align="center" border="1">
		<tr>
			<td>ID</td>
			<td>Name</td>
			<td>PID</td>
			<td>Grade</td>
			<td>Management</td>
		</tr>
		<%
			for(Iterator<Category> it =categories.iterator();it.hasNext();){
				Category c = it.next();
				String preStr="";
				for(int i=1;i<c.getGrade();i++){
					preStr +="----";
				}
				
		%>
		<tr>
			<td><%=c.getId() %></td>
			<td><%=preStr+c.getName() %></td>
			
			<td><%=c.getPid() %></td>
			<td><%=c.getGrade() %></td>
			 
			<td>
				<a href="categoryadd.jsp?pid=<%=c.getId()%>">Add Child Category</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<% 
				if(c.isleaf()){
				%>
				<a href="productadd.jsp?categoryid=<%=c.getId()%>">Add Product to this Category</a>
				<%} %>
			</td>	
			 
		</tr>
		<%
			}
		%>
		
	</table>
</body>
</html>