package com.bomshop.www.member.session;

import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.stereotype.Component;

import com.bomshop.www.common.vo.MemberVO;

@Component
public class MySessionEventListener implements HttpSessionListener, HttpSessionAttributeListener{

	public static MySessionEventListener mySessionEventListener = null;
	
	public static Hashtable<String, Object> sessionRepository;
	
	public MySessionEventListener() {
		System.out.println("MySessionEventListener created");
		if(sessionRepository == null) {
			sessionRepository = new Hashtable<String, Object>();
		}
	}
	
	public static synchronized MySessionEventListener getInstance() {
		if(mySessionEventListener == null) {
			mySessionEventListener = new MySessionEventListener();
		}
		return mySessionEventListener;
	}
	
	public boolean exireDuplicatedSession(String mid, String sessionId) {
		boolean result = false;
		
		System.out.println("Active Session count : " + sessionRepository.size());
		
		Enumeration<Object> enumeration = sessionRepository.elements();
		System.out.println("session id : " + sessionId + " mid : " + mid);
		while(enumeration.hasMoreElements()) {
			HttpSession session = (HttpSession)enumeration.nextElement();
			
			MemberVO member = (MemberVO)session.getAttribute("memberInfo");
			
			// 시용자 정보 존재
			if(member != null) {
				if(member.getMid().equals(mid)) {
					if(!session.getId().equals(sessionId)) {
						System.out.println("login - user " + member.getMid() + ", sessionId : " + sessionId);
						session.invalidate();
						return true;
					}
				}
				
				
			}
		}
		
		return result;
	}
	
	@Override
	public void attributeAdded(HttpSessionBindingEvent event) {
		System.out.println("attributeAdded 호출");
		if("memberInfo".equals(event.getName())) {
			HttpSession session = event.getSession();
			synchronized (sessionRepository) {
				System.out.println("session regist : " + session.getId());
				sessionRepository.put(session.getId(),session);
			}
		}
	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent event) {
		
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent event) {
		
	}

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		HttpSession session = se.getSession();
		synchronized (sessionRepository) {
			System.out.println("session destroy : " + session.getId());
			sessionRepository.remove(session.getId());
		}
	}
	
}
