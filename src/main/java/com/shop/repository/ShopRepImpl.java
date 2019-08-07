package com.shop.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.shop.mapper.ShopMapper;
import com.shop.vo.Buy;
import com.shop.vo.Cart;
import com.shop.vo.Product;

public class ShopRepImpl implements ShopRep {

//	@Autowired
//	@Qualifier("shopMapper")
	private ShopMapper shopMapper;

	public ShopMapper getShopMapper() {
		return shopMapper;
	}

	public void setShopMapper(ShopMapper shopMapper) {
		this.shopMapper = shopMapper;
	}


	@Override
	public Product selectProductByProductNo(int productNo) {
		Product product = shopMapper.selectProductByProductNo(productNo);
		return product;
	}

	@Override
	public List<Product> selectProducts(String category, String sorting, String keyfield, String keyword, int start, int count) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("category", category);
		params.put("sorting", sorting);
		params.put("keyfield", keyfield);
		params.put("keyword", keyword);
		params.put("start", start-1);
		params.put("count", count);
		List<Product> products = shopMapper.selectProducts(params);
		return products;
	}

	@Override
	public List<HashMap<String, Object>> selectCategories() {
		List<HashMap<String, Object>> categorys = shopMapper.selectCategories();
		return categorys;
	}

	@Override
	public List<String> selectColors() {
		List<String> colors = shopMapper.selectColors();
		return colors;
	}

	@Override
	public List<Cart> selectCarts(String memberId) {
		List<Cart> carts = shopMapper.selectCarts(memberId);
		return carts;
	}

	@Override
	public void insertCart(Cart cart) {
		shopMapper.insertCart(cart);
	}

	@Override
	public void deleteCart(String[] cartNos) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();

		List<String> codeList = new ArrayList<String>();
		for (int i = 0; i < cartNos.length; i++) {
			codeList.add(cartNos[i]);
		}
		params.put("codeList", codeList);
		shopMapper.deleteCart(params);
	}

	@Override
	public void updateCartCntByCartNo(int cartNo, int count) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("cartNo", cartNo);
		params.put("count", count);
		shopMapper.updateCartCntByCartNo(params);
	}

	@Override
	public List<Cart> findMyCartList(String memberId) {
		List<Cart> carts = shopMapper.findMyCartList(memberId);
		return carts;
	}
	
	public List<Cart> selectCheckoutList(String memberId, String[] cartNos) {

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);

		List<String> codeList = new ArrayList<String>();
		for (int i = 0; i < cartNos.length; i++) {
			codeList.add(cartNos[i]);
		}
		params.put("codeList", codeList);
		List<Cart> checkoutList = shopMapper.selectCheckoutList(params);
		return checkoutList;

	}

	@Override
	public void insertBuy(Buy buy) {
		shopMapper.insertBuy(buy);
	}

	@Override
	public Cart selectCartByCartNo(int cartNo) {
		Cart cart = shopMapper.selectCartByCartNo(cartNo);
		return cart;
	}

	@Override
	public void updateProductCountByBuy(int productNo, int count) {
		HashMap<String, Integer> params = new HashMap<String, Integer>();
		params.put("productNo", productNo);
		params.put("count", count);
		shopMapper.updateProductCountByBuy(params);
	}

	@Override
	public List<Buy> selectLatelyBuyList(String memberId, int rows) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("rows", rows);
		List<Buy> buyList = shopMapper.selectLatelyBuyList(params);
		return buyList;
	}

	@Override
	public int selectProductsCount() {
		int count = shopMapper.selectProductsCount();
		return count;
	}

}
