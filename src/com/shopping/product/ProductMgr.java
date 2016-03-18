package com.shopping.product;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public class ProductMgr {
	
//	List<Product> list;
	private static ProductMgr pm = null;
	
	private ProductDAO dao=null;
	
	static {
		if(pm==null){
			pm= new ProductMgr();
			pm.setDao(new ProductMySQLDAO());
		}
	}
	
	private ProductMgr(){};
	
	public static ProductMgr getInstance(){
		return pm;
	}
	
	
	public ProductDAO getDao() {
		return dao;
	}

	public void setDao(ProductDAO dao) {
		this.dao = dao;
	}

	public List<Product> getProducts(){
		return dao.getProducts();
	}
	
	public List<Product> getProducts(int pageNo, int pageSize){
		return dao.getProducts(pageNo, pageSize);
	}
	
	public int  getProducts(List<Product> products,int pageNo, int pageSize){
		return dao.getProducts(products,pageNo, pageSize);
	}
	
	public int findProduct(List<Product> list, int[] categoryid, 
									 String keyword, 
									 double lowNormalPrice, 
									 double highNormalPrice,
									 double lowMemberPrice,
									 double highMemberPrice,
									 Timestamp startDate,
									 Timestamp endDate,
									 int pageNo,
									 int pageSize){
		return dao.findProduct(list, categoryid, keyword, lowNormalPrice, highNormalPrice, lowMemberPrice, highMemberPrice, startDate, endDate, pageNo, pageSize);
	}
	
	public List<Product> findProduct(String name){
		return null;
	}
	
	public boolean deleteProductByCategoryId(int category){
		return false;
	}
	
	public boolean deleteProductById(int[] idArray){
		return false;
	}
	
	public boolean deleteProductById(int id){
		return dao.deleteProductById(id);
	}
	
	public boolean updateProduct (Product p){
		return dao.updateProduct(p);
	}
	
	public boolean addProduct(Product p){
		return dao.addProduct(p);
	}
	
	public Product loadById(int id){
		return dao.loadById(id);
	}
	
	public List<Product> getLastestProducts(int count){
		return dao.getLastestProducts(count);
	}
	
	
	
	
	
	
	

}
