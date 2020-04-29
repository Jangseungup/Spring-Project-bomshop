package com.bomshop.www.seller.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.dao.SellerClaimManageDAO;
import com.bomshop.www.seller.dao.SellerOrderManageDAO;
import com.bomshop.www.seller.dto.OrderDTO;
import com.bomshop.www.seller.vo.OrderVO;

@Service
public class SellerClaimManageServiceImpl implements SellerClaimManageService{

	@Inject
	SellerClaimManageDAO dao;
	
	@Inject
	SellerOrderManageDAO sellerOrderManageDAO;
	
	@Override
	public int getTotalClaimCount(int mno) throws Exception {
		return dao.getTotalClaimCount(mno);
	}
	
	@Override
	public int getRequestRefundCount(int mno) throws Exception {
		return dao.getRequestRefundCount(mno);
	}

	@Override
	public int getRequestExchangeCount(int mno) throws Exception {
		return dao.getRequestExchangeCount(mno);
	}

	@Override
	public int getRequestCancelCount(int mno) throws Exception {
		return dao.getRequestCancelCount(mno);
	}
	
	@Override
	public int getReturningCount(int mno) throws Exception {
		return dao.getReturningCount(mno);
	}

	@Override
	public int getInExchangeCount(int mno) throws Exception {
		return dao.getInExchangeCount(mno);
	}

	@Override
	public List<OrderDTO> getClaimList(SearchCriteria cri, int mno)  throws Exception{
		List<OrderVO> orderVOList = null;
		
		if(cri.getSearchType() == null) cri.setSearchType("total");
		
		if(cri.getSearchType().equals("total")) {
			orderVOList = dao.getTotalClaimList(cri, mno);
		}else if(cri.getSearchType().equals("refund")) {
			orderVOList = dao.getRequestRefundList(cri, mno);
		}else if(cri.getSearchType().equals("exchange")) {
			orderVOList = dao.getRequestExchangeList(cri, mno);
		}else if(cri.getSearchType().equals("cancel")) {
			orderVOList = dao.getRequestCancelList(cri, mno);
		}else if(cri.getSearchType().equals("returning")) {
			orderVOList = dao.getReturningList(cri, mno);
		}else if(cri.getSearchType().equals("inExchange")) {
			orderVOList = dao.getInExchangelList(cri, mno);
		}
		
		List<OrderDTO> list = new ArrayList<>();
		
		for(OrderVO vo : orderVOList) {
			OrderDTO dto = new OrderDTO();
			dto.setOrder(vo);
			dto.setOption(sellerOrderManageDAO.getOption(vo.getOno()));
			dto.setGname(sellerOrderManageDAO.getGname(vo.getOno()));
			dto.setMid(sellerOrderManageDAO.getMid(vo.getMno()));
			list.add(dto);
		}
		return list;
	}

	@Override
	public PageMaker getClaimManagePageMaker(SearchCriteria cri, int mno) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		//	서치타입이 없을 경우엔 total로 세팅
		if(cri.getSearchType() == null) cri.setSearchType("total");
		
		//	각 타입에 맞는 값을 넣어준다.
		if(cri.getSearchType().equals("total")) {
			pageMaker.setTotalCount(dao.getTotalClaimCount(mno));
		}else if(cri.getSearchType().equals("refund")) {
			pageMaker.setTotalCount(dao.getRequestRefundCount(mno));
		}else if(cri.getSearchType().equals("exchange")) {
			pageMaker.setTotalCount(dao.getRequestExchangeCount(mno));
		}else if(cri.getSearchType().equals("cancel")) {
			pageMaker.setTotalCount(dao.getRequestCancelCount(mno));
		}else if(cri.getSearchType().equals("returning")) {
			pageMaker.setTotalCount(dao.getReturningCount(mno));
		}else if(cri.getSearchType().equals("inExchange")) {
			pageMaker.setTotalCount(dao.getInExchangeCount(mno));
		}
		return pageMaker;
	}
	
	@Override
	public String getClaimManageSubTitle(SearchCriteria cri) throws Exception {
		String subTitle = "";
		
		if(cri.getSearchType() == null) cri.setSearchType("total");
		
		if(cri.getSearchType().equals("total")) {
			subTitle = "전체 클레임";
		}else if(cri.getSearchType().equals("exchange")) {
			subTitle = "교환 요청";
		}else if(cri.getSearchType().equals("refund")) {
			subTitle = "반품 요청";
		}else if(cri.getSearchType().equals("cancel")) {
			subTitle = "취소 요청";
		}else if(cri.getSearchType().equals("returning")) {
			subTitle = "반품 처리중";
		}else if(cri.getSearchType().equals("inExchange")) {
			subTitle = "교환 처리중";
		}
		return subTitle;
	}
	
	//	거절사유 추가시 수정
	@Override
	public void refusal(int orderno, String rcontent) throws Exception {
		System.out.println("거절 사유 : " + rcontent);
		int order_status = sellerOrderManageDAO.getOrderVO(orderno).getOrder_status();
		if(order_status == 3) {			//	반품요청
			dao.refusal(orderno, 2);	//	배송완료 상태로 변경
		}else if(order_status == 4) {	//	교환요청
			dao.refusal(orderno, 2);	//	배송완료 상태로 변경
		}else if(order_status == 5) {	//	취소요청
			dao.refusal(orderno, 0);	//	발송대기 상태로 변경
		}
	}

	@Override
	public void processingCompleted(int orderno) throws Exception {
		int order_status = sellerOrderManageDAO.getOrderVO(orderno).getOrder_status();
		if(order_status == 3) {			//	반품요청
			dao.processingCompleted(orderno, 6);	//	반품처리 상태로 변경
		}else if(order_status == 4) {	//	교환요청
			dao.processingCompleted(orderno, 7);	//	교환중 상태로 변경
		}else if(order_status == 5) {	//	취소요청
			orderCancel(orderno);					//	 상품 주문 취소
		}else if(order_status == 6) {	//	반품처리중
			orderCancel(orderno);					//	 상품 주문 취소
		}else if(order_status == 7) {	//	교환처리중
			dao.processingCompleted(orderno, 1);	//	 배송중 상태로 변경
		}
	}
	
	@Transactional
	private void orderCancel(int orderno) throws Exception{
		OrderVO vo = dao.getOrderVO(orderno);
		dao.deleteOrder(orderno);
		dao.refundCash(vo.getMno(), vo.getPrice());
	}
	

	
	
}
