package com.bomshop.www.seller.service;

import java.util.List;

import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.vo.GoodsOptionVO;
import com.bomshop.www.seller.vo.GoodsVO;

public interface SellerGoodsManageService {

	//	상품관리 페이지용 pageMaker 가져오기
	PageMaker getGoodsManagePageMaker(SearchCriteria cri, int mno);
	
	//	상품관리 페이지용 상품 리스트 가져오기
	List<GoodsVO> getGoodsList(SearchCriteria cri, int mno);
	
	//	서브타이틀
	String getGoodsManageSubTitle(SearchCriteria cri);

	//	등록한 모든 상품 개수
	int getTotalGoodsCount(int mno);

	//	판매중인 상품 개수
	int getSalesCount(int mno);
	
	//	재고 10개 이하 상품 개수
	int getSoldOutCount(int mno);

	//	상품판매기간 7일 이내 상품 개수
	int getGoodsExpirationCount(int mno);
	
	//	판매중지 상품 개수
	int getDiscontinuedCount(int mno);

	//	상품 판매 상태 변경
	void changeStatus(int gno, String gstatusValue);

	//	상품 판매 기간 연장
	void extendSdate(int gno, int addDate);

	//	상품의 옵션리스트 가져오기
	List<GoodsOptionVO> getOptionList(int gno);

	//	상품 재고 수량 수정
	void countChange(List<GoodsOptionVO> list);

	//	판매상품 삭제
	void removeGoods(int gno);

	//	상품번호로 상품정보 가져오기
	GoodsVO getGoodsByGno(int gno);

	//	상품 정보 수정
	void goodsModify(GoodsVO vo);
}
