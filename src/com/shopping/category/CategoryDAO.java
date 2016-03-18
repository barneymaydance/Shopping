package com.shopping.category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.List;

import com.shopping.util.DB;

public class CategoryDAO {
	public static void save(Category c){
		Connection conn = null;
		String sql =""; 
		PreparedStatement pstmt = null;
		try {
			conn=DB.getConn();
			if(c.getId() == -1){
				sql="insert into category values (null, ?, ?, ?, ?, ?)";
			}
			else{
				sql="insert into category values ("+c.getId()+", ?, ?, ?, ?, ?)";
			}
			pstmt=DB.getPstmt(conn, sql);
			pstmt.setString(1,c.getName() );
			pstmt.setString(2, c.getDescr());
			pstmt.setInt(3, c.getPid());
			pstmt.setInt(4, c.getIsleaf());// can use boolean
			pstmt.setInt(5 , c.getGrade());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closePstmt(pstmt);
			DB.closeConn(conn);
		}
	}
	
	public static void getCategories(List<Category> list, int id){
		Connection conn = null;
		try {
			conn=DB.getConn();
			getCategories(conn, list, id);
		} finally {
			DB.closeConn(conn);
		}
	}
	
	private static void getCategories(Connection conn,List<Category> list, int id){
		ResultSet rs=null;
		try {
			String sql ="select * from category where pid = "+id; 
			rs=DB.executeQuery(conn, sql);
			while(rs.next()){
				Category c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setPid(rs.getInt("pid"));
				c.setIsleaf(rs.getInt("isleaf"));
				c.setGrade(rs.getInt("grade"));
				list.add(c);
				if(c.getIsleaf()!=1){
					getCategories(list,c.getId());
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
		}
	}
	

	public static void addChildCategory(int pid, String name, String descr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
			conn=DB.getConn();
			
			conn.setAutoCommit(false);
			
			rs=DB.executeQuery(conn, "select * from category where id = "+pid);
			int parentGrade=0;
			if(rs.next()){
				parentGrade	=rs.getInt("grade");
			}
			
			String sql="insert into category values (null, ?, ?, ?, ?, ?)";
			pstmt=DB.getPstmt(conn, sql);
			pstmt.setString(1,name);
			pstmt.setString(2, descr);
			pstmt.setInt(3, pid);
			pstmt.setInt(4, 1);// can use boolean
			pstmt.setInt(5 ,parentGrade+1);
			pstmt.executeUpdate();
			
			DB.executeUpdate(conn, "update category set isleaf = 0 where id = "+pid);
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closePstmt(pstmt);
			DB.closeConn(conn);
		}
		
	}

	public static void delete(int id, int pid) {
		
		
	}

	public static Category loadById(int id) {
		Connection conn = null;
		ResultSet rs=null;
		Category c= null;
		try {
			conn=DB.getConn();
			rs=DB.executeQuery(conn, "select * from category where id = "+ id);
			if(rs.next()){
				c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setPid(rs.getInt("pid"));
				c.setIsleaf(rs.getInt("isleaf"));
				c.setGrade(rs.getInt("grade"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return c;
	}


}
