package com.bomshop.www.admin.vo;

import lombok.Data;

@Data
public class CouponVO {
	
	private int cno;
	private String cname;
	private int climit;
	private int sale;
	private String coupon_code;
	private int limit_date;
	
}
