package com.shop.mapper;

import java.util.HashMap;
import java.util.List;

import com.shop.vo.Cart;
import com.shop.vo.Product;

public interface ShopMapper {

	Product selectProductByProductNo(int productNo);

	List<Product> selectProducts();

	List<HashMap<String, Object>> selectCategories();

	List<String> selectColors();

	List<Cart> selectCarts(String memberId);

	void insertCart(Cart cart);

	void deleteCart(HashMap<String, Object> params);

	void updateCartCntByCartNo(HashMap<String, Object> params);

	List<Cart> selectCheckoutList(HashMap<String, Object> params);

}
