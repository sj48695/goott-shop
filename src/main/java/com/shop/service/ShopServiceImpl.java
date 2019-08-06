package com.shop.service;

import java.util.List;

import com.shop.repository.ShopRepository;
import com.shop.vo.Product;
import com.shop.vo.ProductFile;

public class ShopServiceImpl implements ShopService{

	private ShopRepository shopRepository;
	public ShopRepository getShopRepository() {
		return shopRepository;
	}

	public void setShopRepository(ShopRepository shopRepository) {
		this.shopRepository = shopRepository;
	}

	@Override
	public Integer registerProductTx(Product product) {
		System.out.println(product);
		int newProductNo = shopRepository.insertProduct(product);
		System.out.println(product);
		
		for (ProductFile file : product.getFiles()) {
			file.setProductNo(newProductNo);
			System.out.println(file);
			shopRepository.insertProductFile(file);
			System.out.println(file);
		}
			return newProductNo;
	}

	@Override
	public void insertProductFile(ProductFile file) {
		
		shopRepository.insertProductFile(file);
		
	}

	@Override
	public List<Product> findProductList() {
		List<Product> products = shopRepository.selectProduct();
		
		return products;
	}

	@Override
	public ProductFile findUploadFile(int productNo) {
		ProductFile file = shopRepository.selectProductFile(productNo);
		
		return file;
	}

}
