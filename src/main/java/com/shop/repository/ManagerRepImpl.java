package com.shop.repository;

import java.util.HashMap;
import java.util.List;

import com.shop.mapper.ManagerMapper;
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
	public List<Product> selectProduct(String category, String keyword) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("category", category);
		params.put("keyword", keyword);
		
		List<Product> products = managerMapper.selectProduct(params);
		
		return products;
	}

	@Override
	public ProductFile selectProductFile(int productNo) {
		ProductFile file = managerMapper.selectProductFile(productNo);
		
		return file;
	}

	@Override
	public Product selectProductByProductNo(int productNo) {
		Product product = managerMapper.selectProductByProductNo(productNo);
		System.out.println(product);
		return product;
	}

	@Override
	public List<ProductFile> selectProductFilesByProductNo(int productNo) {
		List<ProductFile> files = managerMapper.selectProductFilesByProductNo(productNo);
		
		return files;
	}

	@Override
	public void updateProduct(Product product) {
		
		managerMapper.updateProduct(product);
		
	}
	
	@Override
	public void updateProductFile(ProductFile productFile) {
		
		managerMapper.updateProductFile(productFile);
		
	}

	@Override
	public void deleteProduct(int productNo) {
		
		managerMapper.deleteProduct(productNo);
		
	}

	@Override
	public ProductFile selectProductFileByProductFileNo(int productFileNo) {
		ProductFile file = managerMapper.selectProductFileByProductFileNo(productFileNo);
		
		return file;
	}

	@Override
	public void deleteProductFile(int productFileNo) {
		
		managerMapper.deleteProductFile(productFileNo);
		
	}

}
