package com.bomshop.www.member.vo;

import lombok.Data;

@Data
public class LoginDTO {
	private String mid;
	private String mpw;
	private boolean userCookie;
}
