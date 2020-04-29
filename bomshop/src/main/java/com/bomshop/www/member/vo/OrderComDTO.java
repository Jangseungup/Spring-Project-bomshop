package com.bomshop.www.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrderComDTO {
	private int orderno;
	private int gno;
	private int ono;
	private int mno;
	private int count;
	private int price;
	private Date order_date;
	private String gname_ko;
	private String gname_en;
	private String color;
	private String size;
	private Date order_com_date;
}
