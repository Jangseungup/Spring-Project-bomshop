package com.bomshop.www.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberCouponVO {
	private int cno;
	private int mno;
	private String check_use;
	private Date cdate;
	
}
