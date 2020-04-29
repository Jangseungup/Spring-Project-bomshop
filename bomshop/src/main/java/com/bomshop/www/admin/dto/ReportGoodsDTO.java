package com.bomshop.www.admin.dto;

import com.bomshop.www.admin.vo.ReportGoodsVO;

import lombok.Data;

@Data
public class ReportGoodsDTO {

	private ReportGoodsVO rgv;
	private String reporterID;
	private String buyerID;
	private String goodsName;
	
}
