package com.shop.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.shop.vo.Buy;
import com.shop.vo.Cart;
import com.shop.vo.Product;
import com.shop.vo.Review;

public interface ShopService {

	Product findProductByProductNo(int productNo);

	List<Product> findProducts(String category, String keyfield, String keyword, String keyword2, int start, int count);

	List<HashMap<String, Object>> findCategories();

	List<String> findColors();

	List<Cart> findCartList(String memberId);

	List<Cart> findMyCartList(String memberId);//

	void registerCart(Cart cart);

	void removeCart(String cartNostrs);

	void updateCartCntByCartNo(int cartNo, int count);

	void buy(Buy buy, String buylist);

	List<Cart> findCheckoutList(String memberId, String cartNostrs);

	List<Buy> findLatelyBuyList(String memberId, int rows);

	int findProductsCount();

	void writeReview(Review review);

	List<Review> findReviewListByProductNo(int productNo);

	void deleteReview(int reviewNo);

	void updateReview(Review review);

	void writeComment(Review review);
	
}

