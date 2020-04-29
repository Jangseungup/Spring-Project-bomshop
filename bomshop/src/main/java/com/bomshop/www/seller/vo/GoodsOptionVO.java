package com.bomshop.www.seller.vo;

import lombok.Data;

@Data
public class GoodsOptionVO {
	private int ono;		//	옵션 번호	
	private int gno;		//	상품 번호
	private String color;	//	색상
	private String size;	//	사이즈
	private int count;		//	수량
}
