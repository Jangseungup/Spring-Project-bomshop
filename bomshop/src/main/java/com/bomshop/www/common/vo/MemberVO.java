package com.bomshop.www.common.vo;

import lombok.Data;

@Data
public class MemberVO {
   private int mno;
   private String mid;
   private String mpw;
   private String memail;
   private int mpoint;
   private int cash;
   private int mgrade;
   private int gpoint;
   private int strike;
   private String ban;
   private int mtype;
   private String spw;
   private String shopname;
   private String shopurl;
   private String shop_post_code;
   private String shopaddr1;
   private String shopaddr2;
   private String shopphone;
   private String bankname;
   private String maccount;
   private int ex_type;
   private int likecount;
   private int bankmoney;
}