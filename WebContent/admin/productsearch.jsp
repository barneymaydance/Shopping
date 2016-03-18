<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page
	import="com.shopping.product.*,com.shopping.category.*,java.util.*,java.sql.*"%>
<%@include file="_sessioncheck.jsp"%>
<%
	List<Category> categories = Category.getCategories();
	String action = request.getParameter("action");
%>

<%
	if(action!=null&&action.equals("advancedsearch")){
		int pageno=1;
		String strPageNo = request.getParameter("pageno");
		if(strPageNo!=null&&!strPageNo.trim().equals("")){
			pageno=Integer.parseInt(strPageNo);
		}
		if(pageno<1){
			pageno=1;
		}
		
		String keyword = request.getParameter("keyword");
		double lowNormalPrice = Double.parseDouble(request.getParameter("lownormalprice"));
		double highNormalPrice = Double.parseDouble(request.getParameter("highnormalprice"));
		double lowMemberPrice = Double.parseDouble(request.getParameter("lowmemberprice"));
		double highMemberPrice = Double.parseDouble(request.getParameter("highmemberprice"));
		int categoryId = Integer.parseInt(request.getParameter("categoryid"));
		 
		int[] idArray;
		if(categoryId==0){
			idArray=null;
		}
		else{
			idArray= new int[1];
			idArray[0] = categoryId;
		}	
		
		Timestamp startDate,endDate;
		String strStartDate = request.getParameter("startdate");
		String strEndDate = request.getParameter("enddate");
		
		if(strStartDate==null||strStartDate.trim().equals("")){
			startDate = null;
		}
		else{
			startDate = Timestamp.valueOf(request.getParameter("startdate"));
		}
		if(strEndDate==null||strEndDate.trim().equals("")){
			endDate = null;
		}
		else{
			endDate = Timestamp.valueOf(request.getParameter("enddate"));
		}
		
			
	
		List<Product> products = new ArrayList<Product>(); 
		int pageCount = ProductMgr.getInstance().findProduct(products, idArray, keyword, 
													  lowNormalPrice, highNormalPrice, 
													  lowMemberPrice, highMemberPrice, 
										              startDate, endDate, pageno, 3);
%>


		<center>Search Result:</center>
		<table align="center" border="1">
			<tr>
				<td>ID</td>
				<td>Name</td>
				<td>Description</td>
				<td>Normal Price</td>
				<td>Member Price</td>
				<td>Date</td>
				<td>Category ID</td>
				<td>Management</td>
		
			</tr>
			<%
				for(Iterator<Product> it =products.iterator();it.hasNext();){
				Product p = it.next();
			%>
			<tr>
				<td><%=p.getId()%></td>
				<td><%=p.getName()%></td>
				<td><%=p.getDescr()%></td>
				<td><%=p.getNormalprice()%></td>
				<td><%=p.getMemberprice()%></td>
				<td><%=p.getPdate()%></td>
				<td><%=p.getCategoryid()%></td>
				<td><a href="#">Delete</a> &nbsp;&nbsp; <a href="#">Modify</a></td>
		
			</tr>
			<%
				}
			%>
		
		</table>
		<center>
			Current Page <%=pageno %>:
				&nbsp;&nbsp;&nbsp;&nbsp;
				Total Page<%=pageCount %>:
				&nbsp;&nbsp;&nbsp;&nbsp; <a
				href="productsearch.jsp?action=<%=action%>&keyword=<%=keyword%>&lownormalprice=<%=lowNormalPrice%>&highnormalprice=<%=highNormalPrice%>&lowmemberprice=<%=lowMemberPrice%>&highmemberprice=<%=highMemberPrice%>&startdate=<%=strStartDate %>&enddate=<%=strEndDate %>&categoryid=<%=categoryId %>&pageno=1">First
				Page</a> &nbsp;&nbsp; <a href="productsearch.jsp?action=<%=action%>&keyword=<%=keyword%>&lownormalprice=<%=lowNormalPrice%>&highnormalprice=<%=highNormalPrice%>&lowmemberprice=<%=lowMemberPrice%>&highmemberprice=<%=highMemberPrice%>&startdate=<%=strStartDate %>&enddate=<%=strEndDate %>&categoryid=<%=categoryId %>&pageno=<%=pageno-1%>">Previous
				Page</a> &nbsp;&nbsp; <a href="productsearch.jsp?action=<%=action%>&keyword=<%=keyword%>&lownormalprice=<%=lowNormalPrice%>&highnormalprice=<%=highNormalPrice%>&lowmemberprice=<%=lowMemberPrice%>&highmemberprice=<%=highMemberPrice%>&startdate=<%=strStartDate %>&enddate=<%=strEndDate %>&categoryid=<%=categoryId %>&pageno=<%=pageno+1%>">Next
				Page</a>
		</center>

<%
}
%>


<%
// simple search 2
	if(action!=null&&action.equals("simplesearch2")){
		int pageno=1;
		String strPageNo = request.getParameter("pageno");
		if(strPageNo!=null&&!strPageNo.trim().equals("")){
			pageno=Integer.parseInt(strPageNo);
		}
		if(pageno<1){
			pageno=1;
		}
		
		String keyword = request.getParameter("keyword");
		String strCategoryIds[] = request.getParameterValues("categoryid");
		String strCategoryIdQuery="";
		int[] idArray;
		if(strCategoryIds==null||strCategoryIds.length==0){
			idArray=null;
		}
		else{
			
			
			idArray= new int[strCategoryIds.length];
			for(int i=0; i<strCategoryIds.length;i++){
				strCategoryIdQuery +="&categoryid="+strCategoryIds[i];
				idArray[i]=Integer.parseInt(strCategoryIds[i]);
			}
			
		}	
		
		
		List<Product> products = new ArrayList<Product>(); 
		int pageCount = ProductMgr.getInstance().findProduct(products, idArray, keyword, 
													  -1, -1, 
													  -1, -1, 
										              null, null, pageno, 3);
%>


		<center>Search Result:</center> 
		<table align="center" border="1">
			<tr>
				<td>ID</td>
				<td>Name</td>
				<td>Description</td>
				<td>Normal Price</td>
				<td>Member Price</td>
				<td>Date</td>
				<td>Category ID</td>
				<td>Management</td>
		
			</tr>
			<%
				for(Iterator<Product> it =products.iterator();it.hasNext();){
				Product p = it.next();
			%>
			<tr>
				<td><%=p.getId()%></td>
				<td><%=p.getName()%></td>
				<td><%=p.getDescr()%></td>
				<td><%=p.getNormalprice()%></td>
				<td><%=p.getMemberprice()%></td>
				<td><%=p.getPdate()%></td>
				<td><%=p.getCategoryid()%></td>
				<td><a href="#">Delete</a> &nbsp;&nbsp; <a href="#">Modify</a></td>
		
			</tr>
			<%
				}
			%>
		
		</table>
		<center>
			Current Page <%=pageno %>:
				&nbsp;&nbsp;&nbsp;&nbsp;
				Total Page<%=pageCount %>:
				&nbsp;&nbsp;&nbsp;&nbsp; <a
				href="productsearch.jsp?action=<%=action%>&keyword=<%=keyword%><%=strCategoryIdQuery %>&pageno=1">First
				Page</a> &nbsp;&nbsp; <a href="productsearch.jsp?action=<%=action%>&keyword=<%=keyword%><%=strCategoryIdQuery %>&pageno=<%=pageno-1%>">Previous
				Page</a> &nbsp;&nbsp; <a href="productsearch.jsp?action=<%=action%>&keyword=<%=keyword%><%=strCategoryIdQuery %>&pageno=<%=pageno+1%>">Next
				Page</a>
		</center>

<%
}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Product</title>
<script>
	function checkdata() {
		with (document.forms["advanced"]) {
			if (lownormalprice.value == null || lownormalprice.value == "") {
				lownormalprice.value = -1;
			}
			if (highnormalprice.value == null || highnormalprice.value == "") {
				highnormalprice.value = -1;
			}
			if (lowmemberprice.value == null || lowmemberprice.value == "") {
				lowmemberprice.value = -1;
			}
			if (highmemberprice.value == null || highmemberprice.value == "") {
				highmemberprice.value = -1;
			}
		}
	}
</script>
</head>
<body>
<center>Simple Search</center>
	<form action="productsearch.jsp" method="post">
		<input type="hidden" name="action" value="simplesearch">
		<table align="center">
			<tr>
				<td>Category</td>
				<td><select></select></td>
			</tr>
			<tr>
				<td>Key word:<input type="text" name="keyword"></td>
				<td colspan="2"><input type="submit" value="Search"></td>

			</tr>
		</table>
	</form>
	
	<center>Simple Search Second</center>
	<form action="productsearch.jsp" method="get">
		<input type="hidden" name="action" value="simplesearch2">
		<table align="center">
			<tr>
				<td>Category</td>
				
			</tr>
			<tr>
				<td>
					<%
						for(Iterator<Category> it = categories.iterator();it.hasNext();){
							Category c= it.next();
							if(c.isleaf()){
							
																
					%>
					<input type="checkbox" name="categoryid" value="<%=c.getId()%>"><%=c.getName() %><br>
					<%
							}
						}
					%>
				</td>
			</tr>
			<tr>	
				<td>Key word:<input type="text" name="keyword"></td>
				<td colspan="2"><input type="submit" value="Search"></td>

			</tr>
		</table>
	</form>
	
	<center>Advanced Search</center>
	<form action="productsearch.jsp" method="post" onsubmit="checkdata()"
		name="advanced">
		<input type="hidden" name="action" value="advancedsearch">
		<table align="center">
			<tr>
				<td>Category:</td>
				<td><select name="categoryid">
						<option value="0">All</option>
						<%
							for(Iterator<Category> it = categories.iterator();it.hasNext();){
																		Category c= it.next();
																		String preStr="";
																		for(int i=1;i<c.getGrade();i++){
																			preStr+="--";
																		}
						%>
						<option value="<%=c.getId()%>"><%=preStr+c.getName()%></option>
						<%
							}
						%>
				</select></td>
			</tr>
			<tr>
				<td>Key Word</td>
				<td><input type="text" name="keyword"></td>
			</tr>
			<tr>
				<td>Normal Price:</td>
				<td>From:<input type="text" name="lownormalprice" /> To:<input
					type="text" name="highnormalprice" />
				</td>
			</tr>
			<tr>
				<td>Member Price:</td>
				<td>From:<input type="text" name="lowmemberprice" /> To:<input
					type="text" name="highmemberprice" />
				</td>
			</tr>
			<tr>
				<td>Date:</td>
				<td>From:<input type="text" name="startdate" /> To:<input
					type="text" name="enddate" />
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Search"></td>
			</tr>

		</table>
	</form>
</body>
</html>