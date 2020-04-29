package com.bomshop.www.goods.vo;

import lombok.Data;

@Data
public class CartVO {
	
	private int cart_no;
	private int gno;
	private int ono;
	private String color;
	private String size;
	private int mno;
	private int count;
	private int price;

	private String gname_ko;
	private String img1;
}
