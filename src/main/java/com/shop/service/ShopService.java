package com.shop.service;

import java.util.HashMap;
import java.util.List;

import com.shop.vo.Buy;
import com.shop.vo.Cart;
import com.shop.vo.Product;

public interface ShopService {

	Product findProductByProductNo(int productNo);

	List<Product> findProducts();

	List<HashMap<String, Object>> findCategories();

	List<String> findColors();

	List<Cart> findCartList(String memberId);

	void registerCart(Cart cart);

	void removeCart(String cartNostrs);

	void updateCartCntByCartNo(int cartNo, int count);

	List<Cart> findCheckoutList(String memberId, String cartNostrs);

	void buy(Buy buy, String buylist);

}
