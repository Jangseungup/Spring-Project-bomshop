package com.bomshop.www.seller.dto;

import com.bomshop.www.seller.vo.GoodsOptionVO;
import com.bomshop.www.seller.vo.OrderComVO;

import lombok.Data;

@Data
public class OrderComDTO {
	private OrderComVO order;
	private GoodsOptionVO option;
	private String gname;
}
