package com.shop.mapper;

import java.util.HashMap;
import java.util.List;

import com.shop.vo.Product;
import com.shop.vo.ProductFile;

//이 인터페이스의 패키지와 인터페이스 이름은 member-mapper.xml 파일의 namespace와 일치
public interface ManagerMapper {

	void insertProduct(Product product);

	void insertProductFile(ProductFile file);

	List<Product> selectProduct(HashMap<String, Object> param);
	
	ProductFile selectProductFile(int productNo);
	
	Product selectProductByProductNo(int productNo);
	
	List<ProductFile> selectProductFilesByProductNo(int productNo);

	void updateProduct(Product product);
	
	void updateProductFile(ProductFile productFile);

	void deleteProduct(int productNo);

	ProductFile selectProductFileByProductFileNo(int productFileNo);

	void deleteProductFile(int productFileNo);

}
