package com.shop.controller;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

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
import com.shop.vo.Member;
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
	public String cart(Model model, HttpSession session){
		Member loginuser = (Member) session.getAttribute("loginuser");
		model.addAttribute("loginuser", loginuser);
		if(loginuser != null) {
			List<Cart> carts = shopService.findCartList(loginuser.getMemberId());
			String rows = "";
			for(Cart cart : carts) {
				rows = rows + cart.getCartNo() + ",";
			}
			model.addAttribute("rows", rows);
			model.addAttribute("carts", carts);
			return "cart";
		} else {
			return "redirect:/";
		}
	}
	
	@RequestMapping(value="/cart_register", method = RequestMethod.GET)
	@ResponseBody
	public String addToCart(Cart cart, HttpSession session){
		Member loginuser = (Member) session.getAttribute("loginuser");
		if(loginuser != null) {
			cart.setMemberId(loginuser.getMemberId());
			shopService.registerCart(cart);
			return "success";
		} else {
			return "redirect:/";
		}
	}
	
	@RequestMapping(value="/cart_remove", method = RequestMethod.GET
			, produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String removeCart(String cartNoList){
		shopService.removeCart(cartNoList);
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
	
	@RequestMapping(value = "/checkout/{cartNostrs}", method = RequestMethod.GET)
	public String checkout(Model model, HttpSession session, @PathVariable String cartNostrs) {
		Member loginuser = (Member) session.getAttribute("loginuser");
		if (loginuser != null) {
			List<Cart> products = shopService.findCheckoutList(loginuser.getMemberId(), cartNostrs);
			model.addAttribute("loginuser", loginuser);
			model.addAttribute("products", products);
			return "checkout";
		} else {
			return "redirect:/";
		}
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
	
//	회원 장바구니
	@RequestMapping(value="/account/myCartList", method = RequestMethod.GET)
	public String MyCartList(Model model, HttpSession session){
		
		Member loginuser = (Member) session.getAttribute("loginuser");
		String memberId = loginuser.getMemberId();
		
		List<Cart> carts = shopService.findMyCartList(memberId);
		
		model.addAttribute("carts", carts);
		model.addAttribute("loginuser", loginuser);
		
		return "account/myCartList";
		
	}
}
