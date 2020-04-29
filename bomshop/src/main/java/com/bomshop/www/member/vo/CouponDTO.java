package com.bomshop.www.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CouponDTO {
	private int cno;			// 쿠폰 번호
	private int mno;			// 회원 번호
	private String coupon_code;	// 쿠폰 코드
	private String cname;		// 쿠폰 이름
	private int climit;			// 금액 제한(얼마이상)
	private int sale;			// 할인 금액
	private String check_use;	// 사용 여부(default 'N')
	private Date cdate;			// 만료일
}
