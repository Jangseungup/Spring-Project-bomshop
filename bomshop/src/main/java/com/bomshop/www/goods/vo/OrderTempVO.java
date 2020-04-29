package com.bomshop.www.goods.vo;

import lombok.Data;

@Data
public class OrderTempVO {
	private String order_name;
	private String delivery_name;
	private String order_phone;
	private String delivery_phone;
	private String order_email;
	private String delivery_post_code;
	private String delivery_addr1;
	private String delivery_addr2;
	private int totalPrice;
	private int cno;
	private int mpoint;
}
