package com.bomshop.www.seller.dto;

import com.bomshop.www.seller.vo.ReviewVO;

import lombok.Data;

@Data
public class ReviewDTO {
	private ReviewVO review;
	private String gname;
	private String mid;
}
