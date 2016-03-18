package com.shopping.user;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.sql.*;

import com.shopping.util.*;
public class User {
	private int id;

	private String username;

	private String password;

	private String phone;

	private String addr;

	private Date rdate;

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getRdate() {
		return rdate;
	}

	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void save() {
		Connection conn = null;
		String sql = "insert into ruser values (null, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = null;
		try {
			conn=DB.getConn();
			pstmt=DB.getPstmt(conn, sql);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, phone);
			pstmt.setString(4, addr);
			pstmt.setTimestamp(5, new Timestamp(rdate.getTime()));
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closePstmt(pstmt);
			DB.closeConn(conn);
		}

	}
	
	public static List<User> getUsers(){
		List<User> list = new ArrayList<User>();
		Connection conn=null;
		ResultSet rs=null;
		String sql="select * from ruser";
		try {
			conn=DB.getConn();
			rs=DB.executeQuery(conn, sql);
			while(rs.next()){
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("addr"));
				u.setRdate(rs.getTimestamp("rdate"));
				list.add(u);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		
		return list;
	}
	
	public static void deletUser(int id){
		Connection conn=null;
		Statement stmt=null;
		try {
			String sql="delete from ruser where id = "+id;
			conn=DB.getConn();
			stmt=DB.getStmt(conn);
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
	}

	public void update(){
		Connection conn = null;
		String sql = "update ruser set username =? , phone = ?, addr= ? where id= "+this.id;
		PreparedStatement pstmt = null;
		try {
			conn=DB.getConn();
			pstmt=DB.getPstmt(conn, sql);
			pstmt.setString(1, username);
			pstmt.setString(2, phone);
			pstmt.setString(3, addr);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closePstmt(pstmt);
			DB.closeConn(conn);
		}

	}
	
	public static User validate(String username, String password) throws UserNotFoundException, PasswordNotCorrectException{
		Connection conn = null;
		String sql = "select * from ruser where username = '"+username+"'";
		ResultSet rs=null;
		User u=null;
		try {
			conn=DB.getConn();
			rs=DB.executeQuery(conn, sql);
			if(!rs.next()){
				throw new UserNotFoundException();
			}
			else if(!rs.getString("password").equals(password)){
				throw new PasswordNotCorrectException();
			}
			else{
				u=new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password")); 
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("addr"));
				u.setRdate(rs.getTimestamp("rdate"));	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return u;
	}
}
