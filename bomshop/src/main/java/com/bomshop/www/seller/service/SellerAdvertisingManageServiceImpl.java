package com.bomshop.www.seller.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.common.util.SellerFileUpload;
import com.bomshop.www.seller.dao.SellerAdvertisingManageDAO;
import com.bomshop.www.seller.vo.AdvertiseVO;
import com.bomshop.www.seller.vo.GoodsVO;

@Service
public class SellerAdvertisingManageServiceImpl implements SellerAdvertisingManageService{
	
	@Inject
	SellerAdvertisingManageDAO dao;

	@Override
	public int getTotalCount(int mno) {
		return dao.getTotalCount(mno);
	}

	@Override
	public int getAdvertisingCount(int mno) {
		return dao.getAdvertisingCount(mno);
	}

	@Override
	public int getAwaitingAdvertisingCount(int mno) {
		return dao.getAwaitingAdvertisingCount(mno);
	}

	@Override
	public int getAdvertisingEndCount(int mno) {
		return dao.getAdvertisingEndCount(mno);
	}

	@Override
	public List<AdvertiseVO> gerAdvertisingList(SearchCriteria cri, int mno) {
		List<AdvertiseVO> list = null;
		
		if(cri.getSearchType() == null) cri.setSearchType("total");
		
		if(cri.getSearchType().equals("total")) {
			list = dao.getTotalADList(cri, mno);
		}else if(cri.getSearchType().equals("advertising")) {
			list = dao.getADList(cri, mno);
		}else if(cri.getSearchType().equals("awaiting")) {
			list = dao.getAwaitingADList(cri, mno);
		}else if(cri.getSearchType().equals("advertisingEnd")) {
			list = dao.getADEndList(cri, mno);
		}
		return list;
	}
	
	@Override
	public PageMaker getAdvertisingManagePageMaker(SearchCriteria cri, int mno) {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		//	서치타입이 없을 경우엔 total로 세팅
		if(cri.getSearchType() == null) cri.setSearchType("total");
		
		//	각 타입에 맞는 값을 넣어준다.
		if(cri.getSearchType().equals("total")) {
			pageMaker.setTotalCount(dao.getTotalCount(mno));
		}else if(cri.getSearchType().equals("sales")) {
			pageMaker.setTotalCount(dao.getAdvertisingCount(mno));
		}else if(cri.getSearchType().equals("soldOut")) {
			pageMaker.setTotalCount(dao.getAwaitingAdvertisingCount(mno));
		}else if(cri.getSearchType().equals("goodsExpiration")) {
			pageMaker.setTotalCount(dao.getAdvertisingEndCount(mno));
		}
		return pageMaker;
	}
	
	@Override
	public String getAdvertisingManageSubTitle(SearchCriteria cri) {
		String subTitle = "";
		
		if(cri.getSearchType() == null) cri.setSearchType("total");
		
		if(cri.getSearchType().equals("total")) {
			subTitle = "전체 상품";
		}else if(cri.getSearchType().equals("advertising")) {
			subTitle = "광고 중";
		}else if(cri.getSearchType().equals("awaiting")) {
			subTitle = "광고 신청 대기";
		}else if(cri.getSearchType().equals("advertisingEnd")) {
			subTitle = "3일이내 광고 종료";
		}
		return subTitle;
	}

	@Override
	public List<GoodsVO> getGoodsListForAD(SearchCriteria cri, int mno) {
		return dao.getGoodsListForAD(cri, mno);
	}

	@Override
	public PageMaker getGoodsListForADPageMaker(SearchCriteria cri, int mno) {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.getGoodsListForADCount(mno));
		return pageMaker;
	}

	@Transactional
	@Override
	public void cancelAD(int ano) throws Exception {
		dao.cancelAD(ano);
	}

	@Override
	public void applicationAD(int gno) {
		dao.applicationAD(gno);
	}

	
}
