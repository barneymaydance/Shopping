package com.shopping.order;

import java.util.List;

import com.shopping.product.ProductDAO;
import com.shopping.product.ProductMgr;
import com.shopping.product.ProductMySQLDAO;

public class OrderMgr {
	//singleton pattern
	private static OrderMgr om = null;
	
	private static OrderMySQLDAO dao=null;
	
	static {
		if(om==null){
			om= new OrderMgr();
			om.setDao(new OrderMySQLDAO());
		}
	}
	
	private OrderMgr(){};
	public static OrderMgr getInstance(){
		return om;
	}
	
	public OrderMySQLDAO getDao() {
		return dao;
	}
	public void setDao(OrderMySQLDAO dao) {
		this.dao = dao;
	}
	
	public void saveOrder(SalesOrder so){
		dao.saveOrder(so);
	}
	
	public int getOrders(List<SalesOrder> list, int pageNo, int pageSize){
		return dao.getOrders(list, pageNo, pageSize);
	}
	
	public SalesOrder loadById(int id){
		return dao.loadById(id);
	}
	public List<SalesItem> getSalesItems(SalesOrder salesOrder) {	
		return dao.getSalesItems(salesOrder);
	}
	public void updateStatus(SalesOrder salesOrder) {
		dao.updateStatus(salesOrder);
	}

}
