package com.shop.service;

import java.util.HashMap;
import java.util.List;

import com.shop.repository.ShopRep;
import com.shop.vo.Buy;
import com.shop.vo.Cart;
import com.shop.vo.Product;
import com.shop.vo.Review;

public class ShopServiceImpl implements ShopService {

//	@Autowired
//	@Qualifier("shopRep")
	private ShopRep shopRep;

	public ShopRep getShopRep() {
		return shopRep;
	}

	public void setShopRep(ShopRep shopRep) {
		this.shopRep = shopRep;
	}

	
	@Override
	public Product findProductByProductNo(int productNo) {
		Product product = shopRep.selectProductByProductNo(productNo);
		return product;
	}

	@Override
	public List<Product> findProducts(String category, String sorting, String keyfield, String keyword, int start, int count) {
		List<Product> products = shopRep.selectProducts(category, sorting, keyfield, keyword, start, count);
		return products;
	}

	@Override
	public List<HashMap<String, Object>> findCategories() {
		List<HashMap<String, Object>> categorys = shopRep.selectCategories();
		return categorys;
	}

	@Override
	public List<String> findColors() {
		List<String> colors = shopRep.selectColors();
		return colors;
	}

	@Override
	public List<Cart> findCartList(String memberId) {
		List<Cart> carts = shopRep.selectCarts(memberId);
		return carts;
	}

	@Override
	public void registerCart(Cart cart) {
		shopRep.insertCart(cart);
	}

	@Override
	public void removeCart(String cartNostrs) {
		String[] cartNo = cartNostrs.split(",");
		shopRep.deleteCart(cartNo);
	}

	@Override
	public void updateCartCntByCartNo(int cartNo, int count) {
		shopRep.updateCartCntByCartNo(cartNo, count);
	}

	@Override
	public List<Cart> findMyCartList(String memberId) {
		List<Cart> carts = shopRep.findMyCartList(memberId);
		return carts;
	}
	
	@Override
	public List<Cart> findCheckoutList(String memberId, String cartNostrs) {

		String[] cartNo = cartNostrs.split(",");

		List<Cart> checkoutList = shopRep.selectCheckoutList(memberId, cartNo);
		return checkoutList;
	}
	
	@Override
	public void buy(Buy buy, String cartNoliststr) {
		String[] cartNoList = cartNoliststr.split(",");
		for(int i=0;i<cartNoList.length;i++) {
			Cart cart = shopRep.selectCartByCartNo(Integer.parseInt(cartNoList[i]));
			
			
			buy.setProductNo(cart.getProductNo());
			buy.setPrice(cart.getPrice());
			buy.setTitle(cart.getTitle());
			buy.setColor(cart.getColor());
			buy.setCount(cart.getCount());
			buy.setProductName(cart.getProductName());
			buy.setSize(cart.getSize());
			System.out.println(buy);
			shopRep.insertBuy(buy);
			shopRep.updateProductCountByBuy(cart.getProductNo(), cart.getCount());
		}
		shopRep.deleteCart(cartNoList);
	}

	@Override
	public List<Buy> findLatelyBuyList(String memberId, int rows) {
		List<Buy> buyList = shopRep.selectLatelyBuyList(memberId, rows);
		return buyList;
	}

	@Override
	public List<Buy> findMyBuyList(String memberId) {
		List<Buy> buyList = shopRep.findMyBuyList(memberId);
		return buyList;
	}
	
	@Override
	public int findProductsCount() {
		int count = shopRep.selectProductsCount();
		return count;

	}

	@Override
	public void writeReview(Review review) {
		shopRep.insertReview(review);
	}

	@Override
	public void deleteReview(int reviewNo) {
		shopRep.deleteReview(reviewNo);
	}

	@Override
	public void updateReview(Review review) {
		shopRep.updateReview(review);		
	}

	@Override
	public List<Review> findReviewListByProductNo(int productNo) {
		List<Review> reviews = shopRep.selectReviewsByProductNo(productNo);
		return reviews;
	}
	@Override
	public void writeComment(Review review) {		
		
		Review parent = shopRep.selectReviewByReviewNo(review.getReviewNo());
		shopRep.updateReviewStep(parent);
		
		review.setGroupNo(parent.getGroupNo());
		review.setDepth(parent.getDepth() + 1);
		review.setStep(parent.getStep() + 1);		
		
		shopRep.insertComment(review);
	}

	@Override
	public int selectBuyCountByMemberId(String memberId, int productNo) {
		int buyCount = shopRep.selectBuyCountByMemberId(memberId, productNo);
		return buyCount;
	}
	
}
