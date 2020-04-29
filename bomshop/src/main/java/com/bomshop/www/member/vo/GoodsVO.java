package com.bomshop.www.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GoodsVO {
	private int gno;
	private int cat1;
	private int cat2;
	private String gname_ko;
	private String gname_en;
	private String tag1;
	private String tag2;
	private String tag3;
	private Date sdate;
	private int cost_orgin;
	private int cost;
	private String gstatus;
	private String img1;
	private String img2;
	private String img3;
	private String img4;
	private String gdetail;
	private String gexchange;
	private String gmodel;
	private int mno;
	private int scount;
}
