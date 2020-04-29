package com.bomshop.www.admin.dto;

import com.bomshop.www.admin.vo.AdvertiseVO;

import lombok.Data;

@Data
public class AdvertiseDTO {

	private AdvertiseVO advertiseVO;
	private String mid;
	private String gname_ko;
	private int remaining_period;
	

	
}
