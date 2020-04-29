package com.bomshop.www.seller.dto;

import lombok.Data;

@Data
public class WithdrawDTO {
	private String bank;
	private String account;
	private String name;
	private int money;
	private String pass;
}
