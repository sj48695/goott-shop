package com.shop.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

//public class AuthInterceptor implements HandlerInterceptor // interface 구현
public class AuthInterceptor extends HandlerInterceptorAdapter { // class 상속

	//컨트롤러를 호출하기 전에 호출하는 메서드
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		
		String uri = req.getRequestURI();
		
		if (uri.contains("/qa-write")) {
			HttpSession session = req.getSession();
			if (session.getAttribute("loginuser") == null) {//로그인하지 않은 경우				
				resp.sendRedirect("/shop/account/login");
				return false; //컨트롤러 호출 취소
			}
		}
		
	
		
		return true; // 정상적으로 컨트롤러 호출
	}

	//컨트롤러를 호출한 후에 호출하는 메서드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {		
	}
	//화면(뷰) 처리가 끝난 후에 호출되는 메서드
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {		
	} 

}
