package com.shop.mapper;

import java.util.List;

import com.shop.vo.Product;
import com.shop.vo.ProductFile;

//이 인터페이스의 패키지와 인터페이스 이름은 member-mapper.xml 파일의 namespace와 일치
public interface ShopMapper {
	
	void insertProduct(Product product);

	void insertProductFile(ProductFile file);

	List<Product> selectProduct();

	ProductFile selectProductFile(int productNo);

}
	
