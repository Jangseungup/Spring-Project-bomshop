package com.bomshop.www.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrderComVO {
	private int orderno;
	private int ono;
	private int mno;
	private int count;
	private int price;
	private Date order_date;
	private Date order_com_date;
}
