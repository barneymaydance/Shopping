<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.shopping.product.*,com.shopping.category.*,java.util.*"%>
<%@include file="_sessioncheck.jsp" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
Product p = ProductMgr.getInstance().loadById(id);
String action = request.getParameter("action");
if(action!=null&&action.equals("modify")){
	String name = request.getParameter("name");
	String descr = request.getParameter("descr");
	double normalPrice = Double.parseDouble(request.getParameter("normalprice"));
	double memberPrice = Double.parseDouble(request.getParameter("memberprice"));
	int categoryId = Integer.parseInt(request.getParameter("categoryid"));
	Category c = Category.loadById(categoryId);
	if(!c.isleaf()){
		out.println("Please choose the leaf category!");
		return;
	}
	
	p.setName(name);
	p.setDescr(descr);
	p.setNormalprice(normalPrice);
	p.setMemberprice(memberPrice);
	p.setCategoryid(categoryId);
//	p.setCategory(c);
	
	boolean b=ProductMgr.getInstance().updateProduct(p);
	System.out.println("error="+b);
	
	%>
	<script type="text/javascript">
		window.parent.main.location.reload();	
	</script>
	<%
	out.println("Modify successfully!");
	
}


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Modify Product</title>
<script type="text/javascript">
	var arrLeaf=new Array();
	function checkdata(){
		if(arrLeaf[document.form.categoryid.selectedIndex] != "leaf"){
			alert("You should choose leaf category!");
			document.form.categoryid.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<center>Modify Product</center>
	<form action="productmodify.jsp" method="post" name="form" onsubmit="return checkdata()" >
		<input type="hidden" name="action" value="modify"/>
		<input type="hidden" name="id" value="<%=p.getId()%>"/>
		<table align="center">
			<tr>
				<td> Product Name: </td>
				<td><input type="text" name="name" value="<%=p.getName()%>"/></td>
			</tr>
			<tr>
				<td> Product Description: </td>
				<td><textarea name="descr" rows="8" cols="40"><%=p.getDescr() %></textarea></td>
			</tr>
			<tr>
				<td> Normal Price: </td>
				<td><input type="text" name="normalprice" value="<%=p.getNormalprice()%>"/></td>
			</tr>
			<tr>
				<td> Member Price: </td>
				<td><input type="text" name="memberprice" value="<%=p.getMemberprice()%>"/></td>
			</tr>
			<tr>
				<td> Category ID: </td>
				<td><select name="categoryid">
						<option value="0">All</option>
						<script>
							arrLeaf[0]="not leaf";
						</script>
						<%
						List<Category> categories = Category.getCategories();
						int index = 1;
						for(Iterator<Category> it = categories.iterator();it.hasNext();){
																		Category c= it.next();
																		String preStr="";
																		for(int i=1;i<c.getGrade();i++){
																			preStr+="--";
																		}
						%>
						<script type="text/javascript">
							arrLeaf[<%=index%>] = '<%=c.isleaf()? "leaf":"not leaf"%>';
						</script>
						<option value="<%=c.getId()%>"<%=c.getId()==p.getCategoryid()?"selected":"" %>><%=preStr+c.getName()%></option>
						<%
							index++;
							}
						%>
				</select></td>
			</tr>			
			<tr>
				<td colspan="2"><input  type="submit" value="Submit"></td>
			</tr>			
		</table>
	</form>
	
</body>
</html>