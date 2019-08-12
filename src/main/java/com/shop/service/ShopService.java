package com.shop.service;

import java.util.HashMap;
import java.util.List;

import com.shop.vo.Buy;
import com.shop.vo.Cart;
import com.shop.vo.Product;
import com.shop.vo.Review;

public interface ShopService {

	Product findProductByProductNo(int productNo);

	List<Product> findProducts(HashMap<String, Object> params);

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

	List<Buy> findMyBuyList(String memberId);

	int selectBuyCountByMemberId(String memberId, int productNo);

	int findProductsCountByCategory(HashMap<String, Object> params);
	
}

