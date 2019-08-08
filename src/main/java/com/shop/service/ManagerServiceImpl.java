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
		
		// 대표이미지
		ProductFile titleFile = product.getFile();
		titleFile.setProductNo(newProductNo);
		managerRep.insertProductFile(titleFile);
		
		insertProductFiles(product, newProductNo);
		
		return newProductNo;
	}

	@Override
	public void insertProductFiles(Product product, int productNo) {
		
		// 이미지
		for (ProductFile file : product.getFiles()) {
			file.setProductNo(productNo);
			System.out.println(file);
			managerRep.insertProductFile(file);
			System.out.println(file);
		}
		
	}
	
	@Override
	public void insertProductFile(ProductFile file) {
		
		managerRep.insertProductFile(file);
		
	}
	
	@Override
	public List<Product> findProductList(String category,String keyword) {
		List<Product> products = managerRep.selectProduct(category,keyword);
		
		return products;
	}

	@Override
	public ProductFile findUploadFile(int productNo) {
		ProductFile file = managerRep.selectProductFile(productNo);
		
		return file;
	}

	@Override
	public Product findProductByProductNo(int productNo) {
		Product product = managerRep.selectProductByProductNo(productNo);
		
		return product;
	}

	@Override
	public List<ProductFile> findProductFilesByProductNo(int productNo) {
		List<ProductFile> files = managerRep.selectProductFilesByProductNo(productNo);
		
		return files;
	}

	@Override
	public ProductFile findProductFile(int productNo) {
		ProductFile file = managerRep.selectProductFile(productNo);
		
		return file;
	}

	@Override
	public void updateProduct(Product product) {
		managerRep.updateProduct(product);
	}
	
	@Override
	public void updateProductFile(ProductFile productFile) {
		managerRep.updateProductFile(productFile);
		
	}

	@Override
	public void deleteProduct(int productNo) {
		managerRep.deleteProduct(productNo);
	}

	@Override
	public ProductFile findProductFileByProductFileNo(int productFileNo) {
		ProductFile file = managerRep.selectProductFileByProductFileNo(productFileNo);
		
		return file;
	}

	@Override
	public void deleteProductFile(int productFileNo) {
		managerRep.deleteProductFile(productFileNo);
	}
	
}
