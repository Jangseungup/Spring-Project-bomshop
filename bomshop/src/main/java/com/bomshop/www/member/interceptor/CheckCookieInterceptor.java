package com.bomshop.www.member.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.member.service.MemberService;

public class CheckCookieInterceptor extends HandlerInterceptorAdapter{

	@Inject
	MemberService mService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("Check Cookie START");
		
		HttpSession session = request.getSession();
		if(session.getAttribute("memberInfo")!=null) {
			System.out.println("사용자 정보 이미 존재");
			return true;
		}
		
		Cookie cookie = WebUtils.getCookie(request, "signInCookie");
		if(cookie != null) {
			MemberVO memberInfo = mService.getUserById(cookie.getValue());
			System.out.println("cookie user : " + memberInfo);
			if(memberInfo != null) {
				session.setAttribute("memberInfo", memberInfo);
			}
		}
		
		System.out.println("Check Cookie END");
		
		return true;
	}
	
}
