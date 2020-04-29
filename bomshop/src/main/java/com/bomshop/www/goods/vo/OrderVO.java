package com.bomshop.www.goods.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	
	private int orderno;
	private int ono;
	private int mno;
	private int count;
	private int price;
	private Date orderdate;
	private String order_name;
	private String delivery_name;
	private String order_phone;
	private String delivery_phone;
	private String order_email;
	private String delivery_post_code;
	private String delivery_addr1;
	private String delivery_addr2;
	private int order_status;
	private String order_check;

}
