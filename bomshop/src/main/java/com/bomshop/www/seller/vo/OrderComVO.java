package com.bomshop.www.seller.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrderComVO {
	private int orderno;			//	주문번호
	private int ono; 				//	옵션번호
	private int mno;				//	회원번호
	private int count;				//	구매수량
	private int price;				//	구매금액
	private Date order_date;		//	주문날짜
	private Date order_com_date;	//	구매완료날짜
	private String com_status;		//	정산 상태
}
