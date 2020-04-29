package com.bomshop.www.common.util;

import java.util.List;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.bomshop.www.goods.vo.OrderComVO;

import lombok.Data;

@Data
public class MailUtil {
	private static final int port = 465;
	private String host;
	private String user;
	private String tail;
	private String password;
	
	private Properties props = System.getProperties();
	private void setEnv() {
		props.put("mail.smtp.host", host );
		props.put("mail.smtp.port", port );
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.trust", host);
	}
	
	public void sendMail(String receiver, String title, String text) throws Exception{
		setEnv();
		Message msg = sendingHead();
		sendingBody(msg, receiver, title, text);
		
		msg.setText(text);
        Transport.send(msg);	
	}
	
	private Message sendingHead() {
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un = user;
			String pw = password;
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});
		session.setDebug(true); //for debug  
		Message msg = new MimeMessage(session); //MimeMessage 생성 
		return msg;
	}
	
	private void sendingBody(Message msg, String receiver, String title, String text) throws Exception{
		msg.setFrom(new InternetAddress(user + tail)); //발신자 셋팅 , 보내는 사람의 이메일주소를 한번 더 입력합니다. 이때는 이메일 풀 주소를 다 작성해주세요.  
		msg.setRecipient(Message.RecipientType.TO, new InternetAddress(receiver)); //수신자셋팅  
		msg.setSubject(title); //제목셋팅  
	}
	
	public String getRandomString() {
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 8; i++) {
		    int rIndex = rnd.nextInt(3);
		    switch (rIndex) {
		    case 0:
		        // a-z
		        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
		        break;
		    case 1:
		        // A-Z
		        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
		        break;
		    case 2:
		        // 0-9
		        temp.append((rnd.nextInt(10)));
		        break;
		    }
		}
		return temp.toString();
	}

	// 여기입니다. GoodsController / goods/ ordercom 에서 불러옴
	public void sendOrderComMail(List<OrderComVO> list) throws Exception {
		// 메일 보내기
		for(OrderComVO vo : list) {
			setEnv();
			Message msg = sendingHead();
			sendingBody(msg, vo.getOrder_email(), "BOMSHOP 상품 주문 완료", vo.getGname_ko());
			
			msg.setText(vo.getGname_ko());
	        Transport.send(msg);
		}
	}
}
