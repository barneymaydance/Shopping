package com.shopping.product;

import java.util.Date;
import java.util.List;

public interface ProductDAO {

	public List<Product> getProducts();

	public List<Product> getProducts(int pageNo, int pageSize);

	public int findProduct(List<Product> list, int[] categoryid,
			String keyword, double lowNormalPrice, double highNormalPrice,
			double lowMemberPrice, double highMemberPrice, Date startDate,
			Date endDate, int pageNo, int pageSize);

	public boolean deleteProductByCategoryId(int category);

	public boolean deleteProductById(int[] idArray);
	
	public boolean deleteProductById(int id);

	public boolean updateProduct(Product p);

	public boolean addProduct(Product p);

	public int getProducts(List<Product> products, int pageNo, int pageSize);

	public Product loadById(int id);

	public List<Product> getLastestProducts(int count);
}
