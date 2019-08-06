package com.shop.controller;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.service.ShopService;
import com.shop.vo.Cart;
import com.shop.vo.Product;

@Controller
public class ShopController {
	
	@Autowired
	@Qualifier("shopService")
	private ShopService shopService;
	
	@RequestMapping(value="/category", method = RequestMethod.GET)
	public String category(Model model){
		List<Product> products = shopService.findProducts();
		List<HashMap<String, Object>> categories = shopService.findCategories();
		List<String> colors = shopService.findColors();
		model.addAttribute("colors", colors);
		model.addAttribute("categories", categories);
		model.addAttribute("products", products);
		return "category";
	}
	
	@RequestMapping(value="/cart", method = RequestMethod.GET)
	public String cart(Model model){
		List<Cart> carts = shopService.findCartList();
		model.addAttribute("carts", carts);
		return "cart";
	}
	
	@RequestMapping(value="/cart_register", method = RequestMethod.GET)
	@ResponseBody
	public String addToCart(Cart cart){
		cart.setMemberId("sj");
		shopService.registerCart(cart);
		return "success";
	}
	
	@RequestMapping(value="/cart_remove", method = RequestMethod.GET
			, produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String removeCart(int cartNo){
		shopService.removeCart(cartNo);
		return "success";
	}
	
	@RequestMapping(value="/cart_cntupdate", method = RequestMethod.GET)
	@ResponseBody
	public String updateCart(int cartNo, int count, int price
			, int total_before, int subtotal_before){
		DecimalFormat fm = new DecimalFormat("#,###");
		int total_after = price * count;
		int subtotal_after = subtotal_before-total_before+total_after;
		String result = fm.format(total_after) + "/" +fm.format(subtotal_after);//total, subtotal
		shopService.updateCartCntByCartNo(cartNo, count);
		return result;
	}
	
	@RequestMapping(value="/checkout", method = RequestMethod.GET)
	public String checkout(Model model){
		List<Cart> products = shopService.findCartList();
		model.addAttribute("products", products);
		return "checkout";
	}
	
	@RequestMapping(value="/confirmation", method = RequestMethod.GET)
	public String confirmaion(){
		return "confirmation";
	}
	
	@RequestMapping(value="/single-product/{productNo}", method = RequestMethod.GET)
	public String detail(@PathVariable int productNo, Model model){
		Product product = shopService.findProductByProductNo(productNo);
		model.addAttribute("product", product);
		return "single-product";
	}
}
