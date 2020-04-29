package com.bomshop.www.seller.service;

import java.util.List;

import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.vo.AdvertiseVO;
import com.bomshop.www.seller.vo.GoodsVO;

public interface SellerAdvertisingManageService {

	//	총 광고 관련 개수(광고 신청 대기, 광고 중, 광고 종료 직전)
	int getTotalCount(int mno);

	//	광고중인 상품 개수
	int getAdvertisingCount(int mno);

	//	광고 신청 대기 개수
	int getAwaitingAdvertisingCount(int mno);

	//	광고 종료 3일전 개수
	int getAdvertisingEndCount(int mno);

	//	광고 관리 페이지용 리스트
	List<AdvertiseVO> gerAdvertisingList(SearchCriteria cri, int mno);

	//	광고 관리 페이지용 pageMaker
	PageMaker getAdvertisingManagePageMaker(SearchCriteria cri, int mno);

	//	서브 타이틀
	String getAdvertisingManageSubTitle(SearchCriteria cri);

	//	광고 신청 가능한 상품 리스트
	List<GoodsVO> getGoodsListForAD(SearchCriteria cri, int mno);

	//	광고 신청 가능한 상품 리스트용 pageMaker
	PageMaker getGoodsListForADPageMaker(SearchCriteria cri, int mno);

	//	광고 신청 취소
	void cancelAD(int ano) throws Exception;

	//	광고 신청
	void applicationAD(int gno) throws Exception;
}
