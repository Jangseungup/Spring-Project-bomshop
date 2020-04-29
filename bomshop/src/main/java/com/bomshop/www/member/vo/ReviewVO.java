package com.bomshop.www.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	private int rno;
	private int mno;
	private int gno;
	private String content;
	private Date regdate;
	private String img;
	private int grade;
}
