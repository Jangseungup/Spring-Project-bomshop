package com.bomshop.www.seller.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CommentVO {
	private int cno;
	private int qano;
	private int mno;
	private String content;
	private Date regdate;
}
