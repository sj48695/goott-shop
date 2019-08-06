package com.shop.service;

import java.util.HashMap;
import java.util.List;

import com.shop.vo.Cart;
import com.shop.vo.Product;

public interface ShopService {

	Product findProductByProductNo(int productNo);

	List<Product> findProducts();

	List<HashMap<String, Object>> findCategories();

	List<String> findColors();

	List<Cart> findCartList();

	void registerCart(Cart cart);

	void removeCart(int cartNo);

	void updateCartCntByCartNo(int cartNo, int count);

}
