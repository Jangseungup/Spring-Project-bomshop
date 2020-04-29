package com.bomshop.www.seller.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	private int orderno;				//	주문 번호
	private int ono; 					//	주문한 옵션 번호
	private int mno;					//	주문한 회원번호(비회원일시 null)
	private int count;					//	수량
	private int price;					//	총가격
	private Date orderdate;				//	주문일
	private String order_name;			//	주문자 이름
	private String delivery_name;		//	배송지 이름
	private String order_phone;			//	주문자 전화번호
	private String delivery_phone;		//	배송지 전화번호
	private String order_email;			//	주문자 email
	private String delivery_post_code;	//	배송지 우편번호
	private String delivery_addr1;		//	배송지 주소
	private String delivery_addr2;		//	배송지 주소 나머지
	private int order_status;			//	주문상태(0: 배송대기 / 1 : 배송 중 / 2 : 배송완료 / 3 : 환불요청 4 : 교환요청)
	private String order_check;			//	판매자 주문확인 유무
}
