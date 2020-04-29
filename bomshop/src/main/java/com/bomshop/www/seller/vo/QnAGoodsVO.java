package com.bomshop.www.seller.vo;

import java.util.Date;

import lombok.Data;

@Data
public class QnAGoodsVO {
	private int qno;
	private int mno;
	private int gno;
	private String title;
	private String content;
	private Date regdate;
	private String img1;
	private String img2;
	private String re_check;
	private String del_status;
	private String sec_status;
	private int origin;
	private int lev;
}
