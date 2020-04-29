package com.bomshop.www.seller.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BanListVO {
	private int bno;		//	번호
	private int mno;		//	등록한 상점 회원번호
	private String mid;		//	밴당한 아이디
	private int ban_mno;	//	밴당한 회원번호
	private Date bandate;	//	밴당한 날짜
	private String reason;	//	밴당한 사유
}
