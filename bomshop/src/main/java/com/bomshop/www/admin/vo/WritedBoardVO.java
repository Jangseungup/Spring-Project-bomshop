package com.bomshop.www.admin.vo;

import java.util.Date;

import lombok.Data;

@Data
public class WritedBoardVO {
	
	private int qno;
	private int mno;
	private int gno;
	private String gname_ko;
	private String mid;
	private String title;
	private String content;
	private Date regdate;
	
}
