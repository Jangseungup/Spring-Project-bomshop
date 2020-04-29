package com.bomshop.www.seller.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bomshop.www.common.util.DownloadExcel;
import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.dao.SellerOrderManageDAO;
import com.bomshop.www.seller.dao.SellerSettlementManageDAO;
import com.bomshop.www.seller.dto.OrderComDTO;
import com.bomshop.www.seller.dto.OrderDTO;
import com.bomshop.www.seller.dto.WithdrawDTO;
import com.bomshop.www.seller.vo.OrderComVO;
import com.mysql.fabric.xmlrpc.base.Array;

@Service
public class SellerSettlementMemberServiceImpl implements SellerSettlementMemberService{
	
	@Inject
	SellerSettlementManageDAO dao;
	
	@Inject
	SellerOrderManageDAO sellerOrderManageDAO; 

	@Override
	public int getUnsettledCount(int mno) {
		return dao.getUnsettledCount(mno);
	}

	@Override
	public int getUnsettledAmount(int mno) {
		return dao.getUnsettledAmount(mno);
	}

	@Override
	public int getHoldingAmount(int mno) {
		return dao.getHoldingAmount(mno);
	}

	@Override
	public List<OrderComDTO> getSettlementList(SearchCriteria cri, int mno) {
		List<OrderComVO> orderComList = dao.getOrderComList(cri, mno);
		List<OrderComDTO> list = new ArrayList<>();
		for(OrderComVO vo : orderComList) {
			OrderComDTO dto = new OrderComDTO();
			dto.setOrder(vo);
			dto.setOption(sellerOrderManageDAO.getOption(vo.getOno()));
			dto.setGname(sellerOrderManageDAO.getGname(vo.getOno()));
			list.add(dto);
		}
		return list;
	}

	@Override
	public PageMaker getSettlementManagePageMaker(SearchCriteria cri, int mno) {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.getUnsettledCount(mno));
		return pageMaker;
	}

	@Override
	public String withdraw(int mno, WithdrawDTO withdraw) {
		int bankMoney = dao.getHoldingAmount(mno);
		String message = "출금 할 수 없습니다.";
		//	금액 확인
		if(withdraw.getMoney() < 1000) {
			message += " 천원 미만의 금액은 출금할 수 없습니다.";
		}else if(bankMoney < withdraw.getMoney()) {
			message += " 잔액보다 큰 금액은 출금 할 수 없습니다.";
		}else if(bankMoney >= withdraw.getMoney()) {
			//	출금비밀번호 확인
			if(withdraw.getPass().equals(dao.getSPW(mno))) {
				dao.withdraw(mno, withdraw);
				message = withdraw.getMoney()+" 원이 출금되었습니다. 남은 금액은 ";
				message += dao.getHoldingAmount(mno)+" 원 입니다.";
			}else {
				message += " 비밀번호가 틀렸습니다.";
			}
		}
		return message;
	}

	@Override
	public List<String> getMonthList(int mno) {
		return dao.getMonthList(mno);
	}

	@Override
	public List<OrderComDTO> getHistoryList(SearchCriteria cri, int mno) {
		List<OrderComVO> orderList = dao.getgetHistoryList(cri, mno);
		List<OrderComDTO> list = new ArrayList<>();
		for(OrderComVO vo : orderList) {
			OrderComDTO dto = new OrderComDTO();
			dto.setOrder(vo);
			dto.setOption(sellerOrderManageDAO.getOption(vo.getOno()));
			dto.setGname(sellerOrderManageDAO.getGname(vo.getOno()));
			list.add(dto);
		}
		return list;
	}

	@Override
	public PageMaker getHistoryListPageMaker(SearchCriteria cri, int mno) {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.getMonthCount(cri, mno));
		return pageMaker;
	}

	@Override
	public int getTotalAmount(SearchCriteria cri, int mno) {
		return dao.getTotalAmount(cri, mno);
	}

	@Override
	public String outputExcelFile(int mno, SearchCriteria cri) {
		System.out.println();
 		List<OrderComVO> voList = dao.getExcelList(mno, cri);
 		List<OrderComDTO> list = new ArrayList<>();
		for(OrderComVO vo : voList) {
			OrderComDTO dto = new OrderComDTO();
			dto.setOrder(vo);
			dto.setOption(sellerOrderManageDAO.getOption(vo.getOno()));
			dto.setGname(sellerOrderManageDAO.getGname(vo.getOno()));
			list.add(dto);
		}
 		return DownloadExcel.createFile(cri.getSearchType(), list, dao.getTotalAmount(cri, mno));
	}
	
	
	
}
