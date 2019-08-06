package com.shop.repository;

import java.util.List;

import com.shop.mapper.ShopMapper;
import com.shop.vo.Product;
import com.shop.vo.ProductFile;

public class ShopRepositoryImpl implements ShopRepository {
	private ShopMapper shopMapper;
	public ShopMapper getShopMapper() {
		return shopMapper;
	}

	public void setShopMapper(ShopMapper shopMapper) {
		this.shopMapper = shopMapper;
	}

	@Override
	public int insertProduct(Product product) {
		shopMapper.insertProduct(product);
		
		return product.getProductNo();
	}

	@Override
	public void insertProductFile(ProductFile file) {
		
		shopMapper.insertProductFile(file);
		
	}

	@Override
	public List<Product> selectProduct() {
		List<Product> products = shopMapper.selectProduct();
		
		return products;
	}

	@Override
	public ProductFile selectProductFile(int productNo) {
		ProductFile file = shopMapper.selectProductFile(productNo);
		
		return file;
	}

}
