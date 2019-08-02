package com.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class QnAController {

	@RequestMapping(value="/qna", method = RequestMethod.GET)
	public String qna(){
		return "qna/blog";
	}
	
	@RequestMapping(value="/qnaproduct", method = RequestMethod.GET)
	public String qnaproduct(){
		return "qna/single-product";
	}
	
}
