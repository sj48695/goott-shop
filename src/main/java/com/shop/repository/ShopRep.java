package com.shop.repository;

import java.util.HashMap;
import java.util.List;

import com.shop.vo.Cart;
import com.shop.vo.Product;
import com.shop.vo.ProductFile;

public interface ShopRep {
	Product selectProductByProductNo(int productNo);

	List<Product> selectProducts();

	List<HashMap<String, Object>> selectCategories();

	List<String> selectColors();

	List<Cart> selectCarts(String memberId);

	void insertCart(Cart cart);

	void deleteCart(String[] cartNo);

	void updateCartCntByCartNo(int cartNo, int count);

	List<Cart> findMyCartList(String memberId);

	List<Cart> selectCheckoutList(String memberId, String[] cartNo);

}
