package com.shop.repository;

import java.util.HashMap;
import java.util.List;

import com.shop.vo.Buy;
import com.shop.vo.Cart;
import com.shop.vo.Product;
import com.shop.vo.Review;

public interface ShopRep {
	Product selectProductByProductNo(int productNo);

	List<Product> selectProducts(String category, String keyfield, String keyword, String keyword2, int start, int count);

	List<HashMap<String, Object>> selectCategories();

	List<String> selectColors();

	List<Cart> selectCarts(String memberId);

	void insertCart(Cart cart);

	void deleteCart(String[] cartNo);

	void updateCartCntByCartNo(int cartNo, int count);

	List<Cart> findMyCartList(String memberId);

	List<Cart> selectCheckoutList(String memberId, String[] cartNo);

	void insertBuy(Buy buy);

	Cart selectCartByCartNo(int cartNo);

	void updateProductCountByBuy(int productNo, int count);

	List<Buy> selectLatelyBuyList(String memberId, int rows);

	List<Buy> findMyBuyList(String memberId);

	int selectProductsCount();

	void insertReview(Review review);

	void deleteReview(int reviewNo);

	void updateReview(Review review);

	List<Review> selectReviewsByProductNo(int productNo);

	Review selectReviewByReviewNo(int reviewNo);

	void updateReviewStep(Review parent);

	void insertComment(Review review);

	int selectBuyCountByMemberId(String memberId, int productNo);

}
