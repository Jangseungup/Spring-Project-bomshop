package com.bomshop.www.seller.service;

import java.util.List;

import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.dto.OrderDTO;
import com.bomshop.www.seller.vo.OrderVO;

public interface SellerOrderManageService {
	
	//	주문한 모든 주문 개수
	int getTotalOrderCount(int mno);
	
	//	오늘 주문한 주문 개수
	int getTodayOrderCount(int mno);
	
	//	배송 대기중인 주문 개수
	int getAwaitingDeliveryCount(int mno);

	//	배송중인 주문 개수
	int getShippingCount(int mno);
	
	//	배송완료 주문 개수
	int getCompletedCount(int mno);

	//	주문관리 페이지용 주문 리스트 가져오기
	List<OrderDTO> gerOrderList(SearchCriteria cri, int mno);

	//	주문관리 페이지용 PageMaker 가져오기
	PageMaker getOrderManagePageMaker(SearchCriteria cri, int mno);

	//	서브타이틀
	String getOrderManageSubTitle(SearchCriteria cri);

	//	주문 미확인 -> 확인 변경
	void orderConfirm(int mno);

	//	개별 주문정보 불러오기
	OrderDTO getOrderDTO(int orderno);

	//	주문 배송지 정보 수정
	void changeInfo(OrderVO vo);

	//	주문 배송 시작
	void startDelivery(int orderno);

	//	주문 배송 취소
	void sendCancel(int orderno);

	//	주문 취소
	void cancelOrder(int orderno);

	

	
}
