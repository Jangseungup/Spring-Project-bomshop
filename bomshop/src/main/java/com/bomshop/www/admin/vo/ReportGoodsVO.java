package com.bomshop.www.admin.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReportGoodsVO {
	
	private int rgno;
	private int mno;
	private int gno;
	private Date report_date;
	private String reason;
	private int report_status;
	
}
