package com.bomshop.www.member.interceptor;

import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.member.dao.MemberDAO;
import com.bomshop.www.member.service.MemberService;
import com.bomshop.www.member.session.MySessionEventListener;
import com.bomshop.www.member.vo.LoginDTO;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Inject
	MemberService mService;
	
	@Inject
	MemberDAO dao;
	
	@Inject
	MySessionEventListener listener;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("memberInfo")!=null) {
			session.removeAttribute("memberInfo");
		}
		
		// true : controller 동작
		System.out.println("login preHandle");
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView mav) throws Exception {
		System.out.println("login postHandle");
		HttpSession session = request.getSession();
		ModelMap modelObj = mav.getModelMap();
		
		LoginDTO dto = (LoginDTO)modelObj.get("loginDTO");
		
		System.out.println("LoginInterceptor postHandler : " + dto);
		
		MemberVO memberInfo = mService.signIn(dto);
		// 블랙리스트 유저 검사
		if(mService.blackMember(dto.getMid()) != 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			pw.print("<script>");
			pw.print("alert('관리자에 의해 접근이 금지 되셨습니다.');");
			pw.print("</script>");
			pw.flush();
			session.removeAttribute("memberInfo");
			mav.setViewName("/member/login");
			return;
		}else{
			if(memberInfo != null) {
				
				boolean result = listener.exireDuplicatedSession(dto.getMid(), session.getId());
				if(result) {
					// 중복 제거
					System.out.println("중복 제거");
				}else {
					// 첫 로그인
					System.out.println("첫 로그인");
				}
				
				// 로그인 성공
				// 세션 추가			
				session.setAttribute("memberInfo", memberInfo);
				if(memberInfo.getMtype() == 0) {
					mav.setViewName("redirect:/admin/adminMain");
				}else {
					String gno = (String)session.getAttribute("gno");
					System.out.println(gno);
					if(gno != null) {
						mav.setViewName("redirect:/goods/detail?gno="+gno);
					}else {
						mav.setViewName("redirect:/");
					}
					session.removeAttribute("gno");
				}
				// 쿠키
				if(dto.isUserCookie()) {
					Cookie cookie = new Cookie("signInCookie", memberInfo.getMid());
					cookie.setPath("/");
					cookie.setMaxAge(60 * 60 * 24 * 15);	// 15일
					response.addCookie(cookie);
				}
			}else {
				String message = "";
				
				mav.addObject("message", message);
				mav.setViewName("/member/login");
			}
		}
		
		
		
	}

}
