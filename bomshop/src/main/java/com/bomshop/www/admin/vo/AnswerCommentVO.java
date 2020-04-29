package com.bomshop.www.admin.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AnswerCommentVO {
	
	private int cno;
	private int qano;
	private int mno;
	private String content;
	private Date regdate;
	
}
