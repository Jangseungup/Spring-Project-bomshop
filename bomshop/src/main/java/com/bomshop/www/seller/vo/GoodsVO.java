package com.bomshop.www.seller.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GoodsVO {
	private int gno;			//	상품번호
	private int cat1;			//	카테고리 1
	private int cat2; 			//	카테고리 2
	private String gname_ko;	//	한글 상품명
	private String gname_en;	//	영어 상품명
	private String tag1;		//	검색어 1
	private String tag2;		//	검색어 2
	private String tag3;		//	검색어 3
	private Date sdate;			//	판매 기간(xxxx년xx웙xx일) 
	private int setSdate;		//	판매 기간(xx일)
	private int cost_origin;	//	상품 판매 원가
	private int cost;			//	상품 판매가
	private String gstatus;		//	상품 판매상태
	private String img1; 		//	상품 이미지(대표)
	private String img2; 		//	상품 이미지(추가)
	private String img3; 		//	상품 이미지(추가)
	private String img4; 		//	상품 이미지(추가)
	private String gdetail;		//	상품 상세 정보
	private String gexchange;	//	상품 교환,반품 내용
	private String gmodel;		//	모델 정보
	private int mno;			//	상품 판매자 멤버 번호
	private int scount;			//	상품 판매 횟수	
}
