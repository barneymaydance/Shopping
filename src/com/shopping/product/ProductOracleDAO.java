package com.shopping.product;

import java.util.Date;
import java.util.List;

public class ProductOracleDAO implements ProductDAO {

	@Override
	public List<Product> getProducts() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Product> getProducts(int pageNo, int pageSize) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int findProduct( List<Product> list, int[] categoryid, String keyword,
			double lowNormalPrice, double highNormalPrice,
			double lowMemberPrice, double highMemberPrice, Date startDate,
			Date endDate, int pageNo, int pageSize) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean deleteProductByCategoryId(int category) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteProductById(int[] idArray) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateProduct(Product p) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean addProduct(Product p) {
		// TODO Auto-generated method stub
		return false;
	}
	
	public int getProducts(List<Product> products, int pageNo, int pageSize){
	
		return 0;
	}

	@Override
	public Product loadById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Product> getLastestProducts(int count) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean deleteProductById(int id) {
		// TODO Auto-generated method stub
		return false;
	};

}
