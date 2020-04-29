package com.bomshop.www.admin.vo;

import java.util.Date;

import lombok.Data;

@Data
public class QuestionVO {

	private int qano;
	private int mno;
	private String title;
	private String content;
	private Date regdate;
	private String re_check;
	
}
