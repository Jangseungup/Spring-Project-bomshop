package com.bomshop.www.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CouponVO {
	private int cno;
	private String coupon_code;
	private String cname;
	private Date limit_date;
	private int climit;
	private int sale;
}
