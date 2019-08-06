package com.shop.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.shop.mapper.ShopMapper;
import com.shop.vo.Cart;
import com.shop.vo.Product;
import com.shop.vo.ProductFile;

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
	public List<Product> selectProducts() {
		List<Product> products = shopMapper.selectProducts();
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

}
