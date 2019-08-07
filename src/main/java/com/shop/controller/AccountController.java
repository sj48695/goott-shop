package com.shop.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.shop.service.MemberService;
import com.shop.service.QuestionService;
import com.shop.service.ShopService;
import com.shop.vo.Buy;
import com.shop.vo.Cart;
import com.shop.vo.Member;
import com.shop.vo.Question;

@Controller
@RequestMapping(value = "/account")
public class AccountController {
	
	@Autowired
	@Qualifier("memberService")
	private MemberService memberService;
	
	@Autowired
	@Qualifier("shopService")
	private ShopService shopService;
	
	@Autowired
	@Qualifier("questionService")
	private QuestionService questionService;
	

	@RequestMapping(path = "/login", method = RequestMethod.GET)
	public String showLoginForm() {
		return "account/login";
	}

	@RequestMapping(path = "/login", method = RequestMethod.POST)
	public String login(String memberId, String pwd, HttpSession session) {

		Member member = memberService.selectMemberByIdAndPasswd(memberId, pwd);

		if (member != null) {
			session.setAttribute("loginuser", member);
			return "redirect:/";
		} else {
			return "account/login";
		}

	}

	@RequestMapping(path = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {

		session.removeAttribute("loginuser");
		return "redirect:/";

	}

	@RequestMapping(path = "/register", method = RequestMethod.GET)
	public String showRegisterForm() {
		return "account/register";
	}

	@RequestMapping(path = "/register", method = RequestMethod.POST)
	public String register(Member member) {
		memberService.insertMember(member);
		return "redirect:/account/login";
	}
	
//	마이페이지
	
	@RequestMapping(path = "/mypage", method = RequestMethod.GET)
	public String MypageForm(Model model, HttpSession session) {

		Member member = (Member) session.getAttribute("loginuser");
		String memberId = member.getMemberId();
		
		List<Cart> carts = shopService.findMyCartList(memberId);
		List<Buy> buyList = shopService.findMyBuyList(member.getMemberId());
		List<Question> questions = questionService.findMyQuestionList(memberId);

		model.addAttribute("member", member);
		model.addAttribute("carts", carts);
		model.addAttribute("buyList", buyList);
		model.addAttribute("questions", questions);
		
		return "account/mypage";

	}

	@RequestMapping(path = "/update", method = RequestMethod.GET)
	public String updateForm (Model model, HttpSession session) {   

		Member member = (Member) session.getAttribute("loginuser");
		
		if (member == null) {
			return "redirect:/";
		}		

		model.addAttribute("member", member);

		return "account/update"; 
	}
	
	@RequestMapping(path = "/update", method = RequestMethod.POST)
	public String updateForm (HttpSession session, Member member, Model model) {  
		
		Member loginuser = (Member) session.getAttribute("loginuser");	
		member.setMemberId(loginuser.getMemberId());
		
		memberService.updateMember(member);
		
		model.addAttribute("loginuser", loginuser);
		return "redirect:/account/mypage"; 
		
	}
	
}
