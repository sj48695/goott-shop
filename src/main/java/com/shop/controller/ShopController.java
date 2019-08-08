package com.shop.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale.Category;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.service.ManagerService;
import com.shop.service.ShopService;
import com.shop.vo.Buy;
import com.shop.vo.Cart;
import com.shop.vo.Member;
import com.shop.vo.Product;
import com.shop.vo.ProductFile;
import com.shop.vo.Review;

@Controller
public class ShopController {
	
	@Autowired
	@Qualifier("shopService")
	private ShopService shopService;
	int pageSize=10;
	
	@Autowired
	@Qualifier("managerService")
	private ManagerService managerService;
	
	@RequestMapping(value="/category", method = RequestMethod.GET)
	public String productList(Model model, String category, String sorting, String keyfield, String keyword){
//		List<Product> products = shopService.findProducts("all", "regDate", "all", "", 1, pageSize);
		if(sorting == null) {sorting = "regDate";}
		if(keyfield == null) {keyfield = "all";}
		if(keyword == null) {keyword = "";}
		if(category == null) {category = "all";}
		List<Product> products = shopService.findProducts(category, sorting, keyfield, keyword, 1, pageSize);
		List<HashMap<String, Object>> categories = shopService.findCategories();
		List<String> colors = shopService.findColors();
		
		for(Product product : products) {
			product.setFile(managerService.findUploadFile(product.getProductNo()));
		}

		int allCount = shopService.findProductsCount();

		model.addAttribute("colors", colors);
		model.addAttribute("categories", categories);
		model.addAttribute("category", category);
		model.addAttribute("allCount",allCount);
		model.addAttribute("products", products);
		model.addAttribute("keyfield", keyfield);
		model.addAttribute("keyword", keyword);
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
				cart.setFile(managerService.findUploadFile(cart.getProductNo()));
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
	
	@RequestMapping(value = "/checkout/cart/{cartNostrs}", method = RequestMethod.GET)
	public String checkout(Model model, HttpSession session, @PathVariable String cartNostrs) {
		Member loginuser = (Member) session.getAttribute("loginuser");

		if (loginuser != null) {
			List<Cart> carts = shopService.findCheckoutList(loginuser.getMemberId(), cartNostrs);
			
			model.addAttribute("loginuser", loginuser);
			model.addAttribute("products", carts);
			model.addAttribute("cartNostrs", cartNostrs);
			return "checkout";
		} else {
			return "redirect:/";
		}
	}
	
	@RequestMapping(value = "/checkout/buynow", method = RequestMethod.POST)
	public String buyNowCheckout(Model model, HttpSession session, Cart cart) {
		Member loginuser = (Member) session.getAttribute("loginuser");
		if (loginuser != null) {

			cart.setMemberId(loginuser.getMemberId());
			shopService.registerCart(cart);

			return "redirect:/checkout/cart/" + cart.getProductNo();
		} else {
			return "redirect:/";
		}
	}
	
	@RequestMapping(value="/confirmation/{rows}", method = RequestMethod.GET)
	public String confirmaion(@PathVariable int rows, Model model, HttpSession session){
		Member loginuser = (Member) session.getAttribute("loginuser");
		List<Buy> buyList = shopService.findLatelyBuyList(loginuser.getMemberId(),rows);
		System.out.println(buyList);
		model.addAttribute(buyList);
		return "confirmation";
	}
	
	@RequestMapping(value="/single-product/{productNo}", method = RequestMethod.GET)
	public String detail(@PathVariable int productNo, Model model, HttpSession session){
		Product product = shopService.findProductByProductNo(productNo);
		// 이미지
		List<ProductFile> files = managerService.findProductFilesByProductNo(productNo);
		
		product.setFiles((ArrayList<ProductFile>)files);
		
		product.setReviews((ArrayList<Review>) shopService.findReviewListByProductNo(productNo));
		int buyCount = 0;

		Member loginuser = (Member) session.getAttribute("loginuser");
		if (loginuser != null) {
			buyCount = shopService.selectBuyCountByMemberId(loginuser.getMemberId(), productNo);
		} 
		model.addAttribute("buyCount",buyCount);
		model.addAttribute("product", product);
		return "single-product";
	}
	
	@RequestMapping(value = "/buy/{cartNostrs}", method = RequestMethod.POST)
	public String buy(Buy buy, Member member, @PathVariable String cartNostrs, HttpSession session) {
		Member loginuser = (Member) session.getAttribute("loginuser");
		if (loginuser != null) {

			buy.setMemberId(loginuser.getMemberId());

			String address = "(" + member.getPostCode() + ") " + member.getRoadAddr() + " " 
							+ member.getDetailAddr() + " " + member.getExtraAddr();
			buy.setAddress(address);
			shopService.buy(buy, cartNostrs);

		}
		String[] cartNostr = cartNostrs.split(",");

		return "redirect:/confirmation/"+cartNostr.length;
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


	@RequestMapping(path="/review/write-review", 
					method=RequestMethod.POST, 
					produces="text/plain;charset=utf-8")//응답컨텐프의 종류 지정
	@ResponseBody//반환값은 뷰이름이 아니고 응답컨텐츠이다.
	public String writeReview(Review review){
		shopService.writeReview(review);
		return "success";
	}
	
	@RequestMapping(value = "/review/review-list", method = RequestMethod.POST)
	public String reviewList(int productNo, Model model) {
		
		List<Review> reviews = shopService.findReviewListByProductNo(productNo);
		model.addAttribute("reviews", reviews);
		
		return "reviews";
	}
	
	@RequestMapping(value = "/review/delete-review", method = RequestMethod.GET)
	@ResponseBody
	public String deleteReview(int reviewNo) {
		
		shopService.deleteReview(reviewNo);
		
		return "success";
	}
	
	@RequestMapping(value = "/review/update-review", method = RequestMethod.POST)
	@ResponseBody
	public String updateReview(Review review) {
		
		shopService.updateReview(review);
		
		return "success";
	}
	
	
	
	@RequestMapping(path = "/review/write-comment", 
			method = RequestMethod.POST, 
			produces = "text/plain;charset=utf-8") //응답 컨텐츠의 종류 지정
	@ResponseBody //반환 값은 뷰이름이 아니고 응답컨텐츠입니다
	public String writeRereview(Review review) {
	
		shopService.writeComment(review);
		
		return "success"; // WEB-INF/views/success.jsp
	}
	
//	회원 구매내역
	@RequestMapping(value="/account/myBuyList", method = RequestMethod.GET)
	public String MyBuyList(Model model, HttpSession session){
		
		Member loginuser = (Member) session.getAttribute("loginuser");
		List<Buy> buyList = shopService.findMyBuyList(loginuser.getMemberId());

		model.addAttribute(buyList);
		return "account/myBuyList";
	}
}
