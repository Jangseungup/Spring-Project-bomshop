package com.bomshop.www.admin.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReportVO {
	
	private int rno;  
	private int mno;			// 신고자
	private String reporter_id;	
	private int report_mno;		// 신고
	private String report_id; 
	private Date report_date;
	private String reason;
	private int alert;
	private int qno;
	
}
