package com.shop.repository;

import java.util.List;

import com.shop.vo.Product;
import com.shop.vo.ProductFile;

public interface ManagerRep {
	
	int insertProduct(Product product);

	void insertProductFile(ProductFile file);

	List<Product> selectProduct(String category, String keyword);

	ProductFile selectProductFile(int productNo);

	Product selectProductByProductNo(int productNo);

	List<ProductFile> selectProductFilesByProductNo(int productNo);

	void updateProduct(Product product);
	
	void updateProductFile(ProductFile productFile);

	void deleteProduct(int productNo);

	ProductFile selectProductFileByProductFileNo(int productFileNo);

	void deleteProductFile(int productFileNo);

}
