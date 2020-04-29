package com.bomshop.www.seller.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.dao.SellerGoodsManageDAO;
import com.bomshop.www.seller.vo.GoodsOptionVO;
import com.bomshop.www.seller.vo.GoodsVO;

@Service
public class SellerGoodsManageServiceImpl implements SellerGoodsManageService{

	@Inject
	SellerGoodsManageDAO dao;
	
	@Override
	public PageMaker getGoodsManagePageMaker(SearchCriteria cri, int mno) {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		//	서치타입이 없을 경우엔 total로 세팅
		if(cri.getSearchType() == null) cri.setSearchType("total");
		
		//	각 타입에 맞는 값을 넣어준다.
		if(cri.getSearchType().equals("total")) {
			pageMaker.setTotalCount(dao.getTotalGoodsCount(mno));
		}else if(cri.getSearchType().equals("sales")) {
			pageMaker.setTotalCount(dao.getSalesCount(mno));
		}else if(cri.getSearchType().equals("soldOut")) {
			pageMaker.setTotalCount(dao.getSoldOutCount(mno));
		}else if(cri.getSearchType().equals("goodsExpiration")) {
			pageMaker.setTotalCount(dao.getGoodsExpirationCount(mno));
		}else if(cri.getSearchType().equals("discontinued")) {
			pageMaker.setTotalCount(dao.getDiscontinuedCount(mno));
		}
		return pageMaker;
	}
	
	@Override
	public List<GoodsVO> getGoodsList(SearchCriteria cri, int mno) {
		List<GoodsVO> list = null;
		
		if(cri.getSearchType() == null) cri.setSearchType("total");
		
		if(cri.getSearchType().equals("total")) {
			list = dao.getTotalGoodsList(cri, mno);
		}else if(cri.getSearchType().equals("sales")) {
			list = dao.getSalesList(cri, mno);
		}else if(cri.getSearchType().equals("soldOut")) {
			list = dao.getSoldOutList(cri, mno);
		}else if(cri.getSearchType().equals("goodsExpiration")) {
			list = dao.getGoodsExpirationList(cri, mno);
		}else if(cri.getSearchType().equals("discontinued")) {
			list = dao.getDiscontinuedList(cri, mno);
		}
		return list;
	}
	
	@Override
	public String getGoodsManageSubTitle(SearchCriteria cri) {
		String subTitle = "";
		
		if(cri.getSearchType() == null) cri.setSearchType("total");
		
		if(cri.getSearchType().equals("total")) {
			subTitle = "전체 상품";
		}else if(cri.getSearchType().equals("sales")) {
			subTitle = "판매 중인 상품";
		}else if(cri.getSearchType().equals("soldOut")) {
			subTitle = "재고 10개 이하";
		}else if(cri.getSearchType().equals("goodsExpiration")) {
			subTitle = "판매마감 7일전";
		}else if(cri.getSearchType().equals("discontinued")) {
			subTitle = "판매 중지 상품";
		}
		return subTitle;
	}
	
	@Override
	public int getTotalGoodsCount(int mno) {
		return dao.getTotalGoodsCount(mno);
	}

	@Override
	public int getSalesCount(int mno) {
		return dao.getSalesCount(mno);
	}
	
	@Override
	public int getSoldOutCount(int mno) {
		return dao.getSoldOutCount(mno);
	}

	@Override
	public int getGoodsExpirationCount(int mno) {
		return dao.getGoodsExpirationCount(mno);
	}

	@Override
	public int getDiscontinuedCount(int mno) {
		return dao.getDiscontinuedCount(mno);
	}

	@Override
	public void changeStatus(int gno, String gstatusValue) {
		String gstatus = "";
		
		if(gstatusValue.equals("판매중")) {
			gstatus = "N";
		}else if(gstatusValue.equals("판매중지")){
			gstatus = "Y";
		}
		GoodsVO vo = new GoodsVO();
		vo.setGno(gno);
		vo.setGstatus(gstatus);
		
		dao.changeStatus(vo);
	}

	@Override
	public void extendSdate(int gno, int addDate) {
		dao.extendSdate(gno, addDate);
	}

	@Override
	public List<GoodsOptionVO> getOptionList(int gno) {
		return dao.getOptionList(gno);
	}

	@Override
	public void countChange(List<GoodsOptionVO> list) {
		for(GoodsOptionVO vo : list) {
			dao.countChange(vo);
		}
	}

	@Override
	public void removeGoods(int gno) {
		dao.removeGoods(gno);
	}

	@Override
	public GoodsVO getGoodsByGno(int gno) {
		return dao.getGoodsByGno(gno);
	}

	@Override
	public void goodsModify(GoodsVO vo) {
		dao.goodsModify(vo);
	}
	
	
}
