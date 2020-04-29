package com.bomshop.www.seller.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.dao.SellerOrderManageDAO;
import com.bomshop.www.seller.dto.OrderDTO;
import com.bomshop.www.seller.vo.OrderVO;

@Service
public class SellerOrderManageServiceImpl implements SellerOrderManageService{

	@Inject
	SellerOrderManageDAO dao;
	
	@Override
	public int getTotalOrderCount(int mno) {
		return dao.getTotalOrderCount(mno);
	}
	
	@Override
	public int getTodayOrderCount(int mno) {
		return dao.getTodayOrderCount(mno);
	}

	@Override
	public int getAwaitingDeliveryCount(int mno) {
		return dao.getAwaitingDeliveryCount(mno);
	}

	@Override
	public int getShippingCount(int mno) {
		return dao.getShippingCount(mno);
	}
	
	@Override
	public int getCompletedCount(int mno) {
		return dao.getCompletedCount(mno);
	}

	@Override
	public List<OrderDTO> gerOrderList(SearchCriteria cri, int mno) {
		List<OrderVO> orderVOList = null;
		
		if(cri.getSearchType() == null) cri.setSearchType("total");
		
		if(cri.getSearchType().equals("total")) {
			orderVOList = dao.getTotalOrderList(cri, mno);
		}else if(cri.getSearchType().equals("today")) {
			orderVOList = dao.getTodayOrderList(cri, mno);
		}else if(cri.getSearchType().equals("awaiting")) {
			orderVOList = dao.getAwaitingDeliveryList(cri, mno);
		}else if(cri.getSearchType().equals("shipping")) {
			orderVOList = dao.getShippingList(cri, mno);
		}else if(cri.getSearchType().equals("completed")) {
			orderVOList = dao.getCompletedList(cri, mno);
		}else if(cri.getSearchType().equals("unconfirmed")) {
			orderVOList = dao.getUnconfirmedOrderList(cri, mno);
		}
		
		List<OrderDTO> list = new ArrayList<>();
		
		for(OrderVO vo : orderVOList) {
			OrderDTO dto = new OrderDTO();
			dto.setOrder(vo);
			dto.setOption(dao.getOption(vo.getOno()));
			dto.setGname(dao.getGname(vo.getOno()));
			dto.setMid(dao.getMid(vo.getMno()));
			list.add(dto);
		}
		return list;
	}

	@Override
	public PageMaker getOrderManagePageMaker(SearchCriteria cri, int mno) {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		//	서치타입이 없을 경우엔 total로 세팅
		if(cri.getSearchType() == null) cri.setSearchType("total");
		
		//	각 타입에 맞는 값을 넣어준다.
		if(cri.getSearchType().equals("total")) {
			pageMaker.setTotalCount(dao.getTotalOrderCount(mno));
		}else if(cri.getSearchType().equals("today")) {
			pageMaker.setTotalCount(dao.getTodayOrderCount(mno));
		}else if(cri.getSearchType().equals("awaiting")) {
			pageMaker.setTotalCount(dao.getAwaitingDeliveryCount(mno));
		}else if(cri.getSearchType().equals("shipping")) {
			pageMaker.setTotalCount(dao.getShippingCount(mno));
		}else if(cri.getSearchType().equals("completed")) {
			pageMaker.setTotalCount(dao.getCompletedCount(mno));
		}else if(cri.getSearchType().equals("unconfirmed")) {
			pageMaker.setTotalCount(dao.getUnconfirmedOrderCount(mno));
		}
		return pageMaker;
	}

	@Override
	public String getOrderManageSubTitle(SearchCriteria cri) {
		String subTitle = "";
		
		if(cri.getSearchType() == null) cri.setSearchType("total");
		
		if(cri.getSearchType().equals("total")) {
			subTitle = "전체 상품";
		}else if(cri.getSearchType().equals("today")) {
			subTitle = "오늘 주문 상품";
		}else if(cri.getSearchType().equals("awaiting")) {
			subTitle = "발송대기 상품";
		}else if(cri.getSearchType().equals("shipping")) {
			subTitle = "배송중 상품";
		}else if(cri.getSearchType().equals("completed")) {
			subTitle = "배송완료 상품";
		}else if(cri.getSearchType().equals("unconfirmed")) {
			subTitle = "신규 주문";
		}
		return subTitle;
	}

	@Override
	public void orderConfirm(int mno) {
		dao.orderConfirm(mno);
	}

	@Override
	public OrderDTO getOrderDTO(int orderno) {
		OrderDTO dto = new OrderDTO();
		OrderVO vo = dao.getOrderVO(orderno);
		dto.setOrder(vo);
		dto.setOption(dao.getOption(vo.getOno()));
		dto.setGname(dao.getGname(vo.getOno()));
		dto.setMid(dao.getMid(vo.getMno()));
		System.out.println(vo);
		return dto;
	}

	@Override
	public void changeInfo(OrderVO vo) {
		dao.changeInfo(vo);
	}

	@Override
	public void startDelivery(int orderno) {
		dao.startDelivery(orderno);
	}

	@Override
	public void sendCancel(int orderno) {
		dao.sendCancel(orderno);
	}

	@Override
	public void cancelOrder(int orderno) {
		dao.cancelOrder(orderno);
	}
}
