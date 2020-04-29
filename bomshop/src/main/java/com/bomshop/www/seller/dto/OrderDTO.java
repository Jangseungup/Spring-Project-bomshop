package com.bomshop.www.seller.dto;

import com.bomshop.www.seller.vo.GoodsOptionVO;
import com.bomshop.www.seller.vo.OrderVO;

import lombok.Data;

@Data
public class OrderDTO {
	private OrderVO order;
	private GoodsOptionVO option;
	private String gname;
	private String mid;
}
