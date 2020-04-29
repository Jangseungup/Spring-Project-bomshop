package com.bomshop.www.member.service;

import java.util.List;

import com.bomshop.www.common.util.Criteria;
import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.member.vo.CouponVO;
import com.bomshop.www.member.vo.DeliveryCountDTO;
import com.bomshop.www.member.vo.GoodsVO;
import com.bomshop.www.member.vo.MemberCouponVO;
import com.bomshop.www.member.vo.OrderComDTO;
import com.bomshop.www.member.vo.OrderDeliveryDTO;
import com.bomshop.www.member.vo.OrderNonDTO;
import com.bomshop.www.member.vo.QnaAdminVO;
import com.bomshop.www.member.vo.QnaGoodsVO;
import com.bomshop.www.member.vo.ReviewVO;

public interface MypageService {

	// 내 쿠폰 총 개수
	int couponCnt(int mid) throws Exception;

	// 회원의 쿠폰 리스트
	List<MemberCouponVO> getMemberCouponList(int mno, Criteria cri) throws Exception;

	// 쿠폰의 정보
	CouponVO getCouponeInfo(int cno) throws Exception;

	PageMaker getPageMaker(int mno, Criteria cri) throws Exception;

	boolean passwordCheck(int mno, String mpw) throws Exception;

	void cashCharge(int mno, int cash) throws Exception;

	void setMailCode(int mno, String tempString) throws Exception;

	String getMailCode(int mno) throws Exception;

	int getLikeGoodsCnt(int mno) throws Exception;

	List<GoodsVO> getLikeGoodsList(int mno) throws Exception;

	List<OrderComDTO> getOrderComList(int mno) throws Exception;

	List<OrderComDTO> getOrderComListAjax(int mno, String type) throws Exception;

	List<OrderDeliveryDTO> getOrderDeliveryDTO(int mno, String type) throws Exception;

	DeliveryCountDTO getDeliveryCount(int mno) throws Exception;

	String refundSetReason(int orderno, int status_reason) throws Exception;

	String exchangeSetReason(int orderno, int exchange_reason) throws Exception;

	String cancelTransaction(int orderno) throws Exception;

	String purchaseComplete(ReviewVO vo, int orderno) throws Exception;

	String noReviewPurchaseComplete(int orderno, int mno) throws Exception;

	List<QnaGoodsVO> getQnaGoodsList(int mno, int page) throws Exception;

	PageMaker getQuestionPageMaker(int mno, int page) throws Exception;

	List<ReviewVO> getReviewList(int mno, int page) throws Exception;

	PageMaker getReviewPageMaker(int mno, int page) throws Exception;

	List<QnaAdminVO> getQnaAdminList(int mno, int page) throws Exception;

	PageMaker getQnaAdminPageMaker(int mno, int page) throws Exception;

	void registQnaAdmin(QnaAdminVO vo) throws Exception;

	void setMailFindCode(String email, String tempString) throws Exception;

	String getMailFindCode(String email) throws Exception;

	List<OrderNonDTO> getOrderNonDTOByNonMember(int orderno, String order_email, String order_phone) throws Exception;

	String addCouponCode(int mno,String coupon_code) throws Exception;

}
