package com.shopping.client;

public class CartItem {
	private int count;
	private int productId;
	private double price;
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	
	public double getTotalPrice(){
		return price*count;
	}

	
	
	

}
