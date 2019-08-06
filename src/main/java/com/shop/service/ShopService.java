package com.shop.service;

import java.util.List;

import com.shop.vo.Product;
import com.shop.vo.ProductFile;

public interface ShopService {
	Integer registerProductTx(Product product);
	
	void insertProductFile(ProductFile file);

	List<Product> findProductList();

	ProductFile findUploadFile(int productNo);
}
