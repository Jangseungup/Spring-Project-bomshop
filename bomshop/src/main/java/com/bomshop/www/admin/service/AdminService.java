package com.bomshop.www.admin.service;

import java.util.List;
import java.util.Map;

import com.bomshop.www.admin.dto.AdvertiseDTO;
import com.bomshop.www.admin.dto.QuestionDTO;
import com.bomshop.www.admin.dto.ReportGoodsDTO;
import com.bomshop.www.admin.vo.AnswerCommentVO;
import com.bomshop.www.admin.vo.CouponVO;
import com.bomshop.www.admin.vo.ReportVO;
import com.bomshop.www.admin.vo.SendBuyerVO;
import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;




public interface AdminService {
	
	// 관리자 메인 페이지 총 요청 수
	Map<String,Object> totalRequest() throws Exception;
	
	// 신고 리스트
	List<ReportVO> reportList(SearchCriteria cri) throws Exception;
	
	// 신고 페이지 정보
	PageMaker getReportPageMaker(SearchCriteria cri) throws Exception;
	
	// 블랙리스트 등록 
	void addBlacklist(ReportVO reportVO) throws Exception;

	// 경고 횟수 증가
	String increaseAlert(int rno) throws Exception;
	
	// 신고 거절
	void parole(int rno) throws Exception;

	// 블랙리스트 목록
	Map<String, Object> blacklistModal(int page) throws Exception;
	
	// 블랙리스트 해제
	void deleteBlacklist(int black_no) throws Exception;

	// 작성글 보기
	Map<String, Object> getWritedBoard(int rno) throws Exception;
	
	// 쿠폰 리스트
	List<CouponVO> getCouponList(SearchCriteria cri) throws Exception;
	
	// 쿠폰 페이징
	PageMaker getCouponPageMaker(SearchCriteria cri) throws Exception;
	
	// 쿠폰 등록
	void enrollCoupon(CouponVO couponVO) throws Exception;
	
	// 쿠폰 수정
	void updateCoupon(CouponVO couponVO) throws Exception;
	
	// 쿠폰 삭제	
	void deleteCoupon(int cno) throws Exception;
	
	// 신고 상품 리스트
	List<ReportGoodsDTO> getReportGoodsList(SearchCriteria cri) throws Exception;
	
	// 신고 상품 페이징
	PageMaker getReportGoodsPageMaker(SearchCriteria cri) throws Exception;
	
	// 신고 처리 완료
	void deleteReportGoods(int rgno) throws Exception;

	// 상품 신고 사유 판매자에게 문의
	void snedBuyer(SendBuyerVO sendBuyerVO) throws Exception;
	
	// 판매자 ID 조회
	Map<String, Object> getBuyerInfo(int gno) throws Exception;
	
	// 관리자 고객센터 리스트
	List<QuestionDTO> getQuetionList(SearchCriteria cri) throws Exception;
	
	// 관리자 고객센터 페이징
	PageMaker getQuetionPageMaker(SearchCriteria cri) throws Exception;
	
	// 관리자 고객센터 미답변 개수
	String questionCount() throws Exception;

	// 문의 답변
	void sendAnswer(AnswerCommentVO answerCommentVO) throws Exception;
	
	// 광고 전체 수
	int advertiseTotalCount() throws Exception;
	
	// 광고 승인 대기
	int advertisingCount() throws Exception;

	// 광고 중
	int watingApproved() throws Exception;
	
	// 광고 목록 리스트
	List<AdvertiseDTO> getAdvertiseList(SearchCriteria cri) throws Exception;

	// 광고 페이징
	PageMaker getAdvertisePageMaker(SearchCriteria cri) throws Exception;
	
	// 광고 종료 3일 전 
	int getDeadline() throws Exception;

	// 광고 신청 승인
	String acceptAdvertise(int ano) throws Exception;

	// 광고 신청 취소
	void deleteAdvertise(int ano) throws Exception;
	 
	
}
