<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.shopping.product.*,com.shopping.category.*,java.util.*" %>    
<%@include file="_sessioncheck.jsp" %>
<%
String strCategoryId = request.getParameter("categoryid");
int categoryid = 0;
if(strCategoryId!=null&&!strCategoryId.trim().equals("")){
	categoryid = Integer.parseInt(strCategoryId);
}

String action = request.getParameter("action");
if(action!=null&&action.equals("add")){
	String name=request.getParameter("name");
	String descr=request.getParameter("descr");
	double normalprice=Double.parseDouble(request.getParameter("normalprice"));
	double memberprice=Double.parseDouble(request.getParameter("memberprice"));
	
	
	Category c = Category.loadById(categoryid);
	if(!c.isleaf()){
		out.println("Can't add product to no-leaf category!");
		return;
	}
	
	Product p = new Product();
	p.setId(-1);
	p.setName(name);
	p.setDescr(descr);
	p.setNormalprice(normalprice);
	p.setMemberprice(memberprice);
	p.setPdate(new java.util.Date());
	p.setCategoryid(categoryid);
	ProductMgr.getInstance().addProduct(p);
	out.println("Add Product successfully!");
	return;
}
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Product</title>
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
	<center>Add Product</center>
	<form action="productadd.jsp" method="post" name="form" onsubmit="return checkdata()" >
		<input type="hidden" name="action" value="add">
		<table align="center">
		
			<tr>
				<td> Product Name: </td>
				<td><input type="text" name="name"/></td>
			</tr>
			<tr>
				<td> Product Description: </td>
				<td><textarea name="descr" rows="8" cols="40"></textarea></td>
			</tr>
			<tr>
				<td> Normal Price: </td>
				<td><input type="text" name="normalprice"/></td>
			</tr>
			<tr>
				<td> Member Price: </td>
				<td><input type="text" name="memberprice"/></td>
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
						<option value="<%=c.getId()%>"<%=c.getId()==categoryid?"selected":"" %>><%=preStr+c.getName()%></option>
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