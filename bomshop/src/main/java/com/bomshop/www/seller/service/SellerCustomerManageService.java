package com.bomshop.www.seller.service;

import java.util.List;

import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.dto.QnAGoodsDTO;
import com.bomshop.www.seller.dto.ReviewDTO;
import com.bomshop.www.seller.vo.BanListVO;
import com.bomshop.www.seller.vo.QnAGoodsVO;

public interface SellerCustomerManageService {

	//	신규 문의 개수
	int getNewQuestionCount(int mno) throws Exception ;

	//	최근 리뷰 개수(7일)
	int getLatestReviewsCount(int mno) throws Exception ;

	//	단골 고객 수
	int getRegularCustomerCount(int mno) throws Exception ;

	//	신규 문의 리스트
	List<QnAGoodsDTO> getNewQuestionList(SearchCriteria cri, int mno) throws Exception ;

	//	최근 리뷰 리스트
	List<ReviewDTO> getLatestReviewsList(SearchCriteria cri, int mno) throws Exception ;

	//	고객관리 페이지용 pageMaker
	PageMaker getCustomerManagePageMaker(SearchCriteria cri, int mno) throws Exception ;

	//	서브타이틀
	String getCustomerManageSubTitle(SearchCriteria cri) throws Exception ;

	//	문의내용 상세보기
	QnAGoodsDTO getQnAbyQno(int qno) throws Exception ;

	//	문의내용 답변하기
	void answer(QnAGoodsVO vo) throws Exception ;

	//	상점 블랙리스트 추가
	void addBlackList(BanListVO vo) throws Exception;

	//	문의내용 답변거부
	void rejectReply(int qno) throws Exception;

	//	블랙리스트 불러오기
	List<BanListVO> getBlackList(SearchCriteria cri, int mno);

	//	블랙리스트 페이지용 pageMaker
	PageMaker getBanPageMaker(SearchCriteria cri, int mno);
}
