package com.bomshop.www.goods.service;

import java.util.List;

import com.bomshop.www.admin.vo.CouponVO;
import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.goods.vo.AdvertiseVO;
import com.bomshop.www.goods.vo.CartVO;
import com.bomshop.www.goods.vo.GoodsVO;
import com.bomshop.www.goods.vo.Goods_OptionVO;
import com.bomshop.www.goods.vo.OrderComVO;
import com.bomshop.www.goods.vo.OrderTempVO;
import com.bomshop.www.goods.vo.OrderVO;
import com.bomshop.www.goods.vo.ReportGoodsVO;

public interface GoodsService {
	
	// 상품 등록
	//void goods_regist(GoodsVO goodsVO) throws Exception;
	
	// 옵션 등록
	//void option_regist(Goods_OptionVO optionVO) throws Exception;

	// 상품 목록 불러오기(검색)
	List<GoodsVO> goods_list(SearchCriteria cri) throws Exception;
	
	// 상품목록 불러오기
	List<GoodsVO> list(SearchCriteria cri) throws Exception;
	
	// 베스트 목록 불러오기
	List<GoodsVO> best_list(SearchCriteria cri) throws Exception;
	
	PageMaker getPageMaker(SearchCriteria cri) throws Exception;

	// 제품 상세보기
	GoodsVO detail(int gno) throws Exception;
	
	// 제품 색상 불러오기
	List<Goods_OptionVO> color(int gno) throws Exception;

	// 제품 사이즈 불러오기
	List<Goods_OptionVO> size(int gno) throws Exception;
	
	// 판매자 정보 불러오기
	MemberVO getUrl(int gno) throws Exception;
	
	// 회원번호로 판매상품 들고오기
	List<GoodsVO> sale(int mno) throws Exception;

	// 베스트 더보기 화면용
	List<GoodsVO> b_list(SearchCriteria cri) throws Exception;

	// 신상품 더보기 화면용
	List<GoodsVO> n_list(SearchCriteria cri) throws Exception;
		
	// 상품 좋아요 추가
	boolean favorite(int mno, int gno) throws Exception;
	   
	// 상품 좋아요 체크
	boolean favCheck(int gno, int mno) throws Exception;
	
	// 장바구니 등록
	void reg_cart(int mno, List<CartVO> list) throws Exception;
	
	// 상품 옵션번호 찾기
	int getOno(int gno, String color, String size) throws Exception;

	// 회원 장바구니 목록
	List<CartVO> getCartList(int mno) throws Exception;

	// 세션추가용 상품이름 찾기
	String getGname(int gno) throws Exception;

	//	장바구니 번호로 장바구니 목록 가져오기 
	List<CartVO> getListByCartNo(int[] cart_no);

	// 장바구니 삭제
	void deleteCart(int cart_no);

	// 구매하기 전체금액(쿠폰적용 리밋 검사용)
	int getTotalPrice(int[] cart_no) throws Exception;

	// 쿠폰리스트 가져오기
	List<CouponVO> getCouponList(int mno, int totalPrice) throws Exception;
	
	// 회원 구매
	List<OrderComVO> order(List<OrderVO> list, OrderTempVO order, int[] cart_no, int mno) throws Exception;

	// 비회원 구매
	List<OrderComVO> orderNon(List<OrderVO> list, OrderTempVO order) throws Exception;

	//	광고 중인 상품 번호
	List<AdvertiseVO> getAdvertise() throws Exception;

	List<GoodsVO> searchList(SearchCriteria cri) throws Exception;

	int getSellerMnoFromShopname(String shopname) throws Exception;

	MemberVO getShopInfo(int sellerMno) throws Exception;

	List<GoodsVO> getShopGoodsList(int sellerMno) throws Exception;

	List<GoodsVO> getGoodsListByMnoType(int mno, int type) throws Exception;

	List<GoodsVO> getGoodsListByMnoAll(int mno) throws Exception;

	GoodsVO likecount(String shopname);
	
	boolean likeCheck(int mno, int shopmno) throws Exception;
	
	boolean like(int mno, int shopmno) throws Exception;
	
	// 상품신고
	void reportGoods(ReportGoodsVO reportGoodsVO) throws Exception;
	
}
