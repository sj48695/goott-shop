package com.shop.repository;

import java.util.HashMap;
import java.util.List;

import com.shop.mapper.ManagerMapper;
import com.shop.vo.Cart;
import com.shop.vo.Product;
import com.shop.vo.ProductFile;

public class ManagerRepImpl implements ManagerRep{
	private ManagerMapper managerMapper;
	
	public ManagerMapper getManagerMapper() {
		return managerMapper;
	}

	public void setManagerMapper(ManagerMapper managerMapper) {
		this.managerMapper = managerMapper;
	}

	@Override
	public int insertProduct(Product product) {
		managerMapper.insertProduct(product);
		
		return product.getProductNo();
	}

	@Override
	public void insertProductFile(ProductFile file) {
		
		managerMapper.insertProductFile(file);
		
	}

	@Override
	public List<Product> selectProduct() {
		List<Product> products = managerMapper.selectProduct();
		
		return products;
	}

	@Override
	public ProductFile selectProductFile(int productNo) {
		ProductFile file = managerMapper.selectProductFile(productNo);
		
		return file;
	}

}
