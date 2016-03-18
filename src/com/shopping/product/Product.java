package com.shopping.product;

import java.sql.Timestamp;
import java.util.Date;

import com.shopping.category.Category;

public class Product {

	private int id;
	private String name;
	private String descr;
	private double normalprice;
	private double memberprice;
	private Date pdate;
	private int categoryid;
	
	private Category category;
	
	public Category getCategory() {
		return category;
	}
	
	public Category getCategory(boolean lazy) {
		if(lazy){
			return category;
		}
		else{
			return Category.loadById(categoryid);
		}
	}
	
	public void setCategory(Category category) {
		this.category = category;
	}
	public Date getPdate() {
		return pdate;
	}
	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescr() {
		return descr;
	}
	public void setDescr(String descr) {
		this.descr = descr;
	}
	public double getNormalprice() {
		return normalprice;
	}
	public void setNormalprice(double normalprice) {
		this.normalprice = normalprice;
	}
	public double getMemberprice() {
		return memberprice;
	}
	public void setMemberprice(double memberprice) {
		this.memberprice = memberprice;
	}
	
	public int getCategoryid() {
		return categoryid;
	}
	public void setCategoryid(int categoryid) {
		this.categoryid = categoryid;
	}
	

}
