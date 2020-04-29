package com.bomshop.www.admin.seller.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrderComVO {
	private int orderno;
	private int mno;
	private int price;
	private Date order_date;
	private int ono;
	private Date order_com_date;
	private String com_status;
}
