package com.bomshop.www.seller.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bomshop.www.common.vo.MemberVO;


//	로그인된 사용자가 판매 회원인지 확인한다.
public class CheckSellerInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		MemberVO memberInfo = (MemberVO)session.getAttribute("memberInfo");
		//	로그인을 안했을 경우
		if(memberInfo == null) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('로그인이 되어있지 않습니다.');");
			//	로그인 페이지로 이동
			out.print("location.href='"+request.getContextPath()+"/';");
			out.print("</script>");
			return false;
		}else if(memberInfo.getMtype() != 2){
			//	판매회원이 아닌 경우(bomshop 메인으로 이동)
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('판매 회원이 아닙니다.');");
			out.print("location.href='"+request.getContextPath()+"/';");
			out.print("</script>");
			return false;
		}
		//MemberVO memberInfo = new MemberVO();
		//memberInfo.setMno(4);
		//session.setAttribute("memberInfo", memberInfo);
		
		return true;
	}
	

}
