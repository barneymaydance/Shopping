<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.shopping.product.*,com.shopping.category.*,java.util.*"%>
<%@include file="_sessioncheck.jsp"%>

<%
	String strId = request.getParameter("id");
	int id = -1;
	if (strId != null && !strId.trim().equals("")) {
		id = Integer.parseInt(strId);
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Image Upload</title>
</head>
<body>
	<form action="../servlet/FileUpload" method="post" enctype="multipart/form-data" name="form1">
		<input type="hidden" name="id" value="<%=id%>"> 
		<input type="file" name="file"> 
		<input type="submit" name="submit" value="Upload">
	</form>
	<br><br>
	<form name="uploadform" method="POST" action="./servlet/.FileUpload" ENCTYPE="multipart/form-data">
		<table border="1" width="450" cellpadding="4" cellspacing="2" bordercolor="#9BD7FF">
			<tr>
				<td width="100%" colspan="2">File1:<input name="x" size="40" type="file">
				</td>
			</tr>
			<tr>
				<td width="100%" colspan="2">File2:<input name="y" size="40" type="file">
				</td>
			</tr>
			<tr>
				<td width="100%" colspan="2">File3:<input name="z" size="40" type="file">
				</td>
			</tr>
		</table>
		<br />
		<br />
		<table>
			<tr>
				<td align="center"><input name="upload" type="submit" value="Start Upload" /></td>
			</tr>
		</table>
	</form>
</body>
</html>