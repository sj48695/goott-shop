package com.shop.service;

import java.util.List;

import com.shop.repository.ManagerRep;
import com.shop.vo.Product;
import com.shop.vo.ProductFile;

public class ManagerServiceImpl implements ManagerService{
	private ManagerRep managerRep;
	
	public ManagerRep getManagerRep() {
		return managerRep;
	}

	public void setManagerRep(ManagerRep managerRep) {
		this.managerRep = managerRep;
	}

	@Override
	public Integer registerProductTx(Product product) {
		System.out.println(product);
		int newProductNo = managerRep.insertProduct(product);
		System.out.println(product);
		
		for (ProductFile file : product.getFiles()) {
			file.setProductNo(newProductNo);
			System.out.println(file);
			managerRep.insertProductFile(file);
			System.out.println(file);
		}
			return newProductNo;
	}

	@Override
	public void insertProductFile(ProductFile file) {
		
		managerRep.insertProductFile(file);
		
	}
	
	@Override
	public List<Product> findProductList() {
		List<Product> products = managerRep.selectProduct();
		
		return products;
	}

	@Override
	public ProductFile findUploadFile(int productNo) {
		ProductFile file = managerRep.selectProductFile(productNo);
		
		return file;
	}
	
}
