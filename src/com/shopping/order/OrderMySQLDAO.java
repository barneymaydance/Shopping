package com.shopping.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.shopping.category.Category;
import com.shopping.client.Cart;
import com.shopping.client.CartItem;
import com.shopping.product.Product;
import com.shopping.user.User;
import com.shopping.util.DB;

public class OrderMySQLDAO {

	public void saveOrder(SalesOrder so) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rsKey = null;
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			
			String sql = "insert into salesorder values(null,?,?,?,?)";
			pstmt = DB.getPstmt(conn, sql,true);
			pstmt.setInt(1, so.getUser().getId());
			pstmt.setString(2, so.getAddr());
			pstmt.setTimestamp(3, so.getoDate());
			pstmt.setDouble(4, so.getStatus());
			pstmt.executeUpdate();
			rsKey = pstmt.getGeneratedKeys();
			rsKey.next();
			int key = rsKey.getInt(1);
			
			String sqlItem = "insert into salesitem values(null, ?,?,?,?)";
			pstmt = DB.getPstmt(conn, sqlItem);
			Cart cart = so.getCart();
			List<CartItem> items =cart.getItems();
			for(int i=0; i<items.size();i++){
				CartItem ci = items.get(i);
				pstmt.setInt(1, ci.getProductId());
				pstmt.setDouble(2, ci.getPrice());
				pstmt.setInt(3, ci.getCount());
				pstmt.setDouble(4, key);
				pstmt.addBatch();
				
			}
			pstmt.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);

		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.setAutoCommit(true);
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			DB.closeRs(rsKey);
			DB.closePstmt(pstmt);
			DB.closeConn(conn);
		}
	}

	public int getOrders(List<SalesOrder> list, int pageNo,
			int pageSize) {
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rsCount = null;
		int pageCount = 0;

		try {
			conn = DB.getConn();
			rsCount = DB.executeQuery(conn, "select count(*) from salesorder");
			if (rsCount.next()) {
				pageCount = (rsCount.getInt(1) + pageSize - 1) / pageSize;
			}
			String sql = "select salesorder.id, salesorder.userid, salesorder.odate, salesorder.addr, salesorder.status , "
					+ " ruser.id uid, ruser.username, ruser.password, ruser.addr uaddr, ruser.phone, ruser.rdate from salesorder "
					+ " left join ruser on (salesorder.userid = ruser.id)"
					+ " limit " + (pageNo - 1) * pageSize + "," + pageSize;
			//System.out.println(sql);
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				SalesOrder so = new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setAddr(rs.getString("addr"));
				so.setoDate(rs.getTimestamp("odate"));
				so.setStatus(rs.getInt("status"));
				
				User user= new User();
				user.setId(rs.getInt("uid"));
				user.setAddr(rs.getString("uaddr"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setPhone(rs.getString("phone"));
				user.setRdate(rs.getTimestamp("rdate"));
				
				so.setUser(user);
				list.add(so);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			DB.closeRs(rs);
			DB.closeRs(rsCount);
			DB.closeConn(conn);
		}
		return pageCount;
	}

	public SalesOrder loadById(int id) {
		Connection conn = null;
		ResultSet rs = null;
		SalesOrder so=null;

		try {
			conn = DB.getConn();
			String sql = "select salesorder.id, salesorder.userid, salesorder.odate, salesorder.addr, salesorder.status , "
					+ " ruser.id uid, ruser.username, ruser.password, ruser.addr uaddr, ruser.phone, ruser.rdate from salesorder "
					+ " left join ruser on (salesorder.userid = ruser.id)"
					+ "where salesorder.id = "+id;
			rs = DB.executeQuery(conn, sql);
			if (rs.next()) {
				so = new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setAddr(rs.getString("addr"));
				so.setoDate(rs.getTimestamp("odate"));
				so.setStatus(rs.getInt("status"));
				
				User user= new User();
				user.setId(rs.getInt("uid"));
				user.setAddr(rs.getString("uaddr"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setPhone(rs.getString("phone"));
				user.setRdate(rs.getTimestamp("rdate"));
				so.setUser(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return so;
	}

	public List<SalesItem> getSalesItems(SalesOrder salesOrder) {
		Connection conn = null;
		ResultSet rs = null;
		List<SalesItem> items = new ArrayList<SalesItem>();
		
		try {
			conn = DB.getConn();
			String sql = "select salesorder.id, salesorder.userid, salesorder.odate, salesorder.addr, salesorder.status , " +
					 " salesitem.id itemid, salesitem.productid, salesitem.unitprice, salesitem.pcount, salesitem.orderid, " +
					 " product.id pid, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid" +
					 " from salesorder join salesitem on (salesorder.id = salesitem.orderid)" +
					 " join product on (salesitem.productid = product.id) where salesorder.id = " + salesOrder.getId();
			//System.out.println(sql);
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product product = new Product();
				product.setId(rs.getInt("pid"));
				product.setCategoryid(rs.getInt("categoryid"));
				product.setName(rs.getString("name"));
				product.setDescr(rs.getString("descr"));
				product.setPdate(rs.getTimestamp("pdate"));
				product.setNormalprice(rs.getDouble("normalprice"));
				product.setMemberprice(rs.getDouble("memberprice"));
				
				SalesItem si = new SalesItem();
				si.setId(rs.getInt("itemid"));
				si.setOrder(salesOrder);
				si.setCount(rs.getInt("pcount"));
				si.setUnitPrice(rs.getDouble("unitprice"));
				si.setProduct(product);
				
				 
		
				items.add(si);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		} 
		return items;
	}

	public void updateStatus(SalesOrder salesOrder) {
		Connection conn = null;
		try {
			conn = DB.getConn();
			String sql = "update salesorder set status = "+salesOrder.getStatus()+" where id = "+salesOrder.getId();
			DB.executeUpdate(conn, sql);
		} finally {
			DB.closeConn(conn);
		}
		
	}
	

}
