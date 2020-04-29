package com.bomshop.www.admin.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bomshop.www.common.vo.MemberVO;

public class AdminInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("preHandle 시작");
		HttpSession session = request.getSession();
		MemberVO memberInfo = (MemberVO)session.getAttribute("memberInfo");
		if(memberInfo == null) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('접근할 수 없는 권한입니다.');");
			out.print("location.href='"+request.getContextPath()+"/';");
			out.print("</script>");			
			return false;
		}else if(memberInfo.getMtype() != 0) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('접근할 수 없는 권한입니다.');");
			out.print("location.href='"+request.getContextPath()+"/';");
			out.print("</script>");	
			return false;
		}
		System.out.println("preHandle 끝");
		return true;
	}
	
}
