package com.bomshop.www.admin.member;

import java.util.Date;

import lombok.Data;

@Data
public class OrderMemberVO {
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
	private String delivery_addr;
	private int order_status;
	private String order_check;
	private int status_reason;
	private Date delivery_com_date;
}
