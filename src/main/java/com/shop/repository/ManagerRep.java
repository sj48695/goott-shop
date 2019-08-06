package com.shop.repository;

import java.util.List;

import com.shop.vo.Product;
import com.shop.vo.ProductFile;

public interface ManagerRep {
	
	int insertProduct(Product product);

	void insertProductFile(ProductFile file);

	List<Product> selectProduct();

	ProductFile selectProductFile(int productNo);

}
