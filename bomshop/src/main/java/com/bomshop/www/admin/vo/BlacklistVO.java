package com.bomshop.www.admin.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BlacklistVO {
	
	private int black_no;
	private String mid;
	private String black_content;
	private Date black_date;
	
}
