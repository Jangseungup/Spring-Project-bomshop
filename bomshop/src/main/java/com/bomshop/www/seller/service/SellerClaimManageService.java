package com.bomshop.www.seller.service;

import java.util.List;

import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.dto.OrderDTO;

public interface SellerClaimManageService {
	
	//	전체 클레임 주문 개수
	int getTotalClaimCount(int mno) throws Exception;
	
	//	환불요청 주문 개수
	int getRequestRefundCount(int mno) throws Exception;

	//	교환요청 주문 개수
	int getRequestExchangeCount(int mno) throws Exception;

	//	취소요청 주문 개수
	int getRequestCancelCount(int mno) throws Exception;
	
	//	반품 처리중 주문개수
	int getReturningCount(int mno) throws Exception;

	//	교환 처리중 주문개수
	int getInExchangeCount(int mno) throws Exception;

	//	클레임관리 페이지용 주문 리스트 가져오기
	List<OrderDTO> getClaimList(SearchCriteria cri, int mno) throws Exception;

	//	클레임관리 페이지용 pageMaker 가져오기
	PageMaker getClaimManagePageMaker(SearchCriteria cri, int mno) throws Exception;

	//	subTitle
	String getClaimManageSubTitle(SearchCriteria cri) throws Exception;

	//	요청 거절로 인한 상태 변경
	void refusal(int orderno, String rcontent) throws Exception;

	//	요청 처리 완료로 인한 상태 변경
	void processingCompleted(int orderno) throws Exception;


	
}
