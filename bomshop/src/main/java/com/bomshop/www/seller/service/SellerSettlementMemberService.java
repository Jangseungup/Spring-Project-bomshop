package com.bomshop.www.seller.service;

import java.util.List;

import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.dto.OrderComDTO;
import com.bomshop.www.seller.dto.WithdrawDTO;

public interface SellerSettlementMemberService {

	//	미정산된 구매완료 주문 개수
	int getUnsettledCount(int mno);

	//	미정산된 구매완료 주문 총액
	int getUnsettledAmount(int mno);

	//	개인 금고에 저장된 금액
	int getHoldingAmount(int mno);

	//	정산관리 페이지용 리스트
	List<OrderComDTO> getSettlementList(SearchCriteria cri, int mno);

	//	정산관리 페이지용 pageMaker
	PageMaker getSettlementManagePageMaker(SearchCriteria cri, int mno);

	//	출금 신청
	String withdraw(int mno, WithdrawDTO withdraw);

	//	정산내역이 존재하는 월 리스트 가져오기
	List<String> getMonthList(int mno);

	//	선택한 월의 정산내역 가져오기
	List<OrderComDTO> getHistoryList(SearchCriteria cri, int mno);

	//	선택한 월 정산내역 pageMaker
	PageMaker getHistoryListPageMaker(SearchCriteria cri, int mno);

	//	선택한 월 정산내역 총금액
	int getTotalAmount(SearchCriteria cri, int mno);

	//	선택한 월의 모든내역 가져오기
	String outputExcelFile(int mno, SearchCriteria cri);
}
