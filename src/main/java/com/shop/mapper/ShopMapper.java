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

	List<Cart> selectCarts();

	void insertCart(Cart cart);

	void deleteCart(int cartNo);

	void updateCartCntByCartNo(HashMap<String, Object> params);

}
