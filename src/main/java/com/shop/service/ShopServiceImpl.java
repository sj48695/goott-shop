package com.shop.service;

import java.util.HashMap;
import java.util.List;

import com.shop.repository.ShopRep;
import com.shop.vo.Cart;
import com.shop.vo.Product;

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
	public List<Product> findProducts() {
		List<Product> products = shopRep.selectProducts();
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
	public List<Cart> findCheckoutList(String memberId, String cartNostrs) {

		String[] cartNo = cartNostrs.split(",");

		List<Cart> checkoutList = shopRep.selectCheckoutList(memberId, cartNo);
		return checkoutList;
	}

}
