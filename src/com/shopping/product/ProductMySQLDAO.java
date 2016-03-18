package com.shopping.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.shopping.category.Category;
import com.shopping.util.DB;

public class ProductMySQLDAO implements ProductDAO {

	public List<Product> getProducts() {
		Connection conn = null;
		ResultSet rs = null;
		List<Product> list = new ArrayList<Product>();

		try {
			conn = DB.getConn();
			String sql = "select * from product";
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalprice(rs.getDouble("normalprice"));
				p.setMemberprice(rs.getDouble("memberprice"));
				p.setPdate(new Date(rs.getTimestamp("pdate").getTime()));
				p.setCategoryid(rs.getInt("categoryid"));
				list.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return list;

	}

	public List<Product> getProducts(int pageNo, int pageSize) {
		Connection conn = null;
		ResultSet rs = null;
		List<Product> list = new ArrayList<Product>();

		try {
			conn = DB.getConn();
			String sql = "select product.id, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid"
					+ "category.id cid, category.name cname, cateogry.descr cdescr, category.isleaf, category.pid, category.grade"
					+ " from product join category on (product.category = category.id) limit " + (pageNo - 1)
					* pageSize + "," + pageSize;
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalprice(rs.getDouble("normalprice"));
				p.setMemberprice(rs.getDouble("memberprice"));
				p.setPdate(new Date(rs.getTimestamp("pdate").getTime()));
				p.setCategoryid(rs.getInt("categoryid"));
				
				Category c = new Category();
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				c.setDescr(rs.getString("cdescr"));
				c.setPid(rs.getInt("pid"));
				c.setIsleaf(rs.getInt("isleaf"));
				c.setGrade(rs.getInt("grade"));
				p.setCategory(c);
				list.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return list;
	}

	public int getProducts(List<Product> products, int pageNo, int pageSize) {
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rsCount = null;
		int pageCount = 0;

		try {
			conn = DB.getConn();
			rsCount = DB.executeQuery(conn, "select count(*) from product");
			if (rsCount.next()) {
				pageCount = (rsCount.getInt(1) + pageSize - 1) / pageSize;
			}
			String sql = "select product.id, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid,"
					+ "category.id cid, category.name cname, category.descr cdescr, category.isleaf, category.pid, category.grade"
					+ " from product join category on (product.categoryid = category.id) order by product.id limit " + (pageNo - 1)
					* pageSize + "," + pageSize;
			//System.out.println(sql);
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalprice(rs.getDouble("normalprice"));
				p.setMemberprice(rs.getDouble("memberprice"));
				p.setPdate(new Date(rs.getTimestamp("pdate").getTime()));
				p.setCategoryid(rs.getInt("categoryid"));
				
				Category c = new Category();
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				c.setDescr(rs.getString("cdescr"));
				c.setPid(rs.getInt("pid"));
				c.setIsleaf(rs.getInt("isleaf"));
				c.setGrade(rs.getInt("grade"));
				p.setCategory(c);
				products.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			DB.closeRs(rs);
			DB.closeRs(rsCount);
			DB.closeConn(conn);
		}
		return pageCount;
	};

	public int findProduct(List<Product> list,int[] categoryId, String keyword,
			double lowNormalPrice, double highNormalPrice,
			double lowMemberPrice, double highMemberPrice, Date startDate,
			Date endDate, int pageNo, int pageSize) {

		Connection conn = null;
		ResultSet rs = null;
		ResultSet rsCount = null;
		
		int pageCount =0;

		try {
			conn = DB.getConn();
			String sql = "select * from product where 1=1";

			String strId = "";
			if (categoryId != null && categoryId.length > 0) {
				strId += "(";
				for (int i = 0; i < categoryId.length; i++) {
					if (i < categoryId.length - 1) {
						strId += categoryId[i] + ",";
					} else {
						strId += categoryId[i];
					}
				}
				strId += ")";
				sql += " and categoryid in " + strId;
			}
			
			if(keyword!=null&&!keyword.trim().equals("")){
				sql += " and name like '%"+keyword+"%' or descr like '%"+keyword+"%'";
			}
			
			if(lowNormalPrice >=0){
				sql += " and normalprice > " + lowNormalPrice;
			}
			
			if(highNormalPrice >=0){
				sql += " and normalprice < " + highNormalPrice;
			}
			
			if(lowMemberPrice >=0){
				sql += " and memberprice > " + lowMemberPrice;
			}
			
			if(highMemberPrice >=0){
				sql += " and memberprice < " + highMemberPrice;
			}
			
			if(startDate!=null){
				sql += " and pdate > "+startDate;
			}
			
			if(startDate!=null){
				sql += " and pdate >= '"+new SimpleDateFormat("yyyy-MM-dd").format(startDate)+"'";
			}
			
			if(endDate!=null){
				sql += " and pdate <= '"+new SimpleDateFormat("yyyy-MM-dd").format(endDate)+"'";
			}
			
			String sqlCount = sql.replaceFirst("select \\*", "select count(*)");
			
			sql += " limit "+(pageNo-1)*pageSize+","+pageSize;
						
			System.out.println(sql);
			rsCount = DB.executeQuery(conn, sqlCount);
			if(rsCount.next()){
				pageCount =( rsCount.getInt(1)+pageSize -1 )/pageSize;
			}
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalprice(rs.getDouble("normalprice"));
				p.setMemberprice(rs.getDouble("memberprice"));
				p.setPdate(new Date(rs.getTimestamp("pdate").getTime()));
				p.setCategoryid(rs.getInt("categoryid"));
				list.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return pageCount;
	}

	public boolean deleteProductByCategoryId(int category) {
		return false;
	}

	public boolean deleteProductById(int[] idArray) {
		return false;
	}
	
	
	public boolean deleteProductById(int id) {
		Connection conn = null;
		try{
			conn=DB.getConn();
			String sql = "delete from product where id = "+id;
			DB.executeUpdate(conn, sql);
			
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			DB.closeConn(conn);
		}
		return true;
	}

	public boolean updateProduct(Product p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "update product set name=?, descr=?, normalprice=?, memberprice=?, categoryid=? where id=?";
			pstmt = DB.getPstmt(conn, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.setDouble(3, p.getNormalprice());
			pstmt.setDouble(4, p.getMemberprice());
			pstmt.setInt(5, p.getCategoryid());
			pstmt.setInt(6, p.getId());
			//System.out.print("update product set name="+p.getName()+", descr="+p.getDescr()+", normalprice="+p.getNormalprice()+", memberprice="+p.getMemberprice()+", categoryid="+p.getCategoryid()+", where id="+p.getId());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DB.closePstmt(pstmt);
			DB.closeConn(conn);
		}
		return true;
	}

	/**
	 * @return null if there is no record in DB
	 */
	
	public boolean addProduct(Product p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "insert into product values(null, ?,?,?,?,?,?)";
			pstmt = DB.getPstmt(conn, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.setDouble(3, p.getNormalprice());
			pstmt.setDouble(4, p.getMemberprice());
			pstmt.setTimestamp(5, new Timestamp(p.getPdate().getTime()));
			pstmt.setInt(6, p.getCategoryid());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DB.closePstmt(pstmt);
			DB.closeConn(conn);
		}
		return true;
	}

	@Override
	public Product loadById(int id) {
		Product p = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			String sql = "select product.id, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid,"
					+ "category.id cid, category.name cname, category.descr cdescr, category.isleaf, category.pid, category.grade"
					+ " from product join category on (product.categoryid = category.id) where product.id = "+id;
			rs = DB.executeQuery(conn, sql);
			if (rs.next()) {
				p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalprice(rs.getDouble("normalprice"));
				p.setMemberprice(rs.getDouble("memberprice"));
				p.setPdate(new Date(rs.getTimestamp("pdate").getTime()));
				p.setCategoryid(rs.getInt("categoryid"));
				Category c = new Category();
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				c.setDescr(rs.getString("cdescr"));
				c.setPid(rs.getInt("pid"));
				c.setIsleaf(rs.getInt("isleaf"));
				c.setGrade(rs.getInt("grade"));
				p.setCategory(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return p;
	}

	@Override
	public List<Product> getLastestProducts(int count) {
		Connection conn = null;
		ResultSet rs = null;
		List<Product> list = new ArrayList<Product>();

		try {
			conn = DB.getConn();
			String sql = "select * from product order by pdate desc limit 0,"+count;
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalprice(rs.getDouble("normalprice"));
				p.setMemberprice(rs.getDouble("memberprice"));
				p.setPdate(new Date(rs.getTimestamp("pdate").getTime()));
				p.setCategoryid(rs.getInt("categoryid"));
				list.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return list;
	}



}
