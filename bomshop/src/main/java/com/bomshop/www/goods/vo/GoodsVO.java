package com.bomshop.www.goods.vo;

import lombok.Data;

@Data
public class GoodsVO {
	
	private int gno;			// 상품번호
	private int cat1;			// 카테고리1
	private int cat2;			// 카테고리2
	private String gname_ko;	// 한글 상품명
	private String gname_en;	// 영문 상품명
	private String tag1;		// 검색어1
	private String tag2;		// 검색어2
	private String tag3;		// 검색어3
	private String sdate;		// 판매기간?
	private int cost_origin;	// 원가
	private int cost;			// 판매가
	private String gstatus;		// 판매상태
	private String img1;		// 상품 이미지1(대표 이미지)
	private String img2;		// 상품 이미지2
	private String img3;		// 상품 이미지3
	private String img4;		// 상품 이미지4
	private String gdetail;		// 상세정보
	private String gexchange;	// 교환/반품정보
	private String gmodel;		// 모델정보
	private int mno;			// 판매자번호
	private int scount;			// 판매수량
	
	private String shopurl;
	private String shopname;
	private String shopaddr1;
	private String shopaddr2;
	private String shop_post_code;
	private String shopphone;
	private int likecount;
}
