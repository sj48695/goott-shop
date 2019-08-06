package com.shop.repository;

import java.util.HashMap;
import java.util.List;

import com.shop.vo.Buy;
import com.shop.vo.Cart;
import com.shop.vo.Product;

public interface ShopRep {
	Product selectProductByProductNo(int productNo);

	List<Product> selectProducts();

	List<HashMap<String, Object>> selectCategories();

	List<String> selectColors();

	List<Cart> selectCarts(String memberId);

	void insertCart(Cart cart);

	void deleteCart(String[] cartNo);

	void updateCartCntByCartNo(int cartNo, int count);

	List<Cart> selectCheckoutList(String memberId, String[] cartNo);

	void insertBuy(Buy buy);

	Cart selectCartByCartNo(int cartNo);

	void updateProductCountByBuy(int productNo, int count);

}
