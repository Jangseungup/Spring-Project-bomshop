package com.bomshop.www.goods.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bomshop.www.admin.vo.CouponVO;
import com.bomshop.www.common.util.Criteria;
import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.goods.dao.GoodsDAO;
import com.bomshop.www.goods.vo.AdvertiseVO;
import com.bomshop.www.goods.vo.CartVO;
import com.bomshop.www.goods.vo.GoodsVO;
import com.bomshop.www.goods.vo.Goods_OptionVO;
import com.bomshop.www.goods.vo.OrderComVO;
import com.bomshop.www.goods.vo.OrderTempVO;
import com.bomshop.www.goods.vo.OrderVO;
import com.bomshop.www.goods.vo.ReportGoodsVO;

@Service
public class GoodsServiceImpl implements GoodsService {

	@Inject
	GoodsDAO dao;

	@Override
	public List<GoodsVO> goods_list(SearchCriteria cri) throws Exception {
		return null;
	}

	// 전체 목록 불러오기(등록순)
	@Override
	public List<GoodsVO> list(SearchCriteria cri) throws Exception {
		System.out.println("서비스 list호출");
		return dao.list(cri);
	}


	// 베스트 목록 불러오기
	@Override
	public List<GoodsVO> best_list(SearchCriteria cri) throws Exception {
		System.out.println("서비스 best_list호출");
		return dao.best_list(cri);
	}
	

	@Override
	public List<GoodsVO> searchList(SearchCriteria cri) throws Exception {
		if(cri.getSearchType() == null) {
			return dao.getList(cri);
		}else if(cri.getSearchType().equals("new")) {
			return dao.n_list(cri);
		}else if(cri.getSearchType().equals("best")) {
			return dao.b_list(cri);
		}else if(cri.getSearchType().equals("아우터")){
			return dao.getOuterList(cri);
		}else if(cri.getSearchType().equals("상의")){
			return dao.getTopClothList(cri);
		}else if(cri.getSearchType().equals("하의")){
			return dao.getDownClothList(cri);
		}else if(cri.getSearchType().equals("기타")){
			return dao.getEtcClothList(cri);
		}else if(cri.getSearchType().equals("악세사리")){
			return dao.getAccList(cri);
		}else if(cri.getSearchType().equals("패딩")){
			return dao.getPadingList(cri);
		}else if(cri.getSearchType().equals("코트")){
			return dao.getCoutList(cri);
		}else if(cri.getSearchType().equals("자켓")){
			return dao.getJaketList(cri);
		}else if(cri.getSearchType().equals("긴팔티셔츠")){
			return dao.getLongTshirtList(cri);
		}else if(cri.getSearchType().equals("반팔티셔츠")){
			return dao.getShortTshirtList(cri);
		}else if(cri.getSearchType().equals("맨투맨")){
			return dao.getMtoMList(cri);
		}else if(cri.getSearchType().equals("후드")){
			return dao.getHudList(cri);
		}else if(cri.getSearchType().equals("청바지")){
			return dao.JeanList(cri);
		}else if(cri.getSearchType().equals("반바지")){
			return dao.shortJean(cri);
		}else if(cri.getSearchType().equals("캐주얼바지")){
			return dao.casualJean(cri);
		}else if(cri.getSearchType().equals("트레이닝복")){
			return dao.trainingList(cri);
		}else if(cri.getSearchType().equals("정장")){
			return dao.junjangList(cri);
		}else if(cri.getSearchType().equals("한복")){
			return dao.hanbokList(cri);
		}else if(cri.getSearchType().equals("작업복")){
			return dao.jobClothList(cri);
		}else if(cri.getSearchType().equals("수영복")){
			return dao.waterClothList(cri);
		}else if(cri.getSearchType().equals("가방")){
			return dao.bagList(cri);
		}else if(cri.getSearchType().equals("신발")){
			return dao.shoseList(cri);
		}else if(cri.getSearchType().equals("벨트")){
			return dao.beltList(cri);
		}else if(cri.getSearchType().equals("넥타이")){
			return dao.tieList(cri);
		}else {
			return dao.getList(cri);
		}
	}

	// 신상품 더보기화면목록
	@Override
	public List<GoodsVO> n_list(SearchCriteria cri) throws Exception {
		return dao.n_list(cri);
	}
	
	// 베스트 더보기화면 목록
	@Override
	public List<GoodsVO> b_list(SearchCriteria cri) throws Exception {
		return dao.b_list(cri);
	}

	@Override
	public PageMaker getPageMaker(SearchCriteria cri) throws Exception {
		int totalCount = dao.goodsCount(cri);

		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(totalCount);
		System.out.println("pm.cri : " + cri);
		System.out.println("pm : " + pm);

		return pm;
	}

	// 상품번호로 판매자 정보불러오기
	@Override
	public MemberVO getUrl(int gno) throws Exception {
		return dao.getUrl(gno);
	}

	@Override
	public List<GoodsVO> sale(int mno) throws Exception {
		return dao.sale(mno);
	}

	// 상품 정보 불러오기
	@Override
	public GoodsVO detail(int gno) throws Exception {
		System.out.println("service detail 요청");
		return dao.readDetail(gno);
	}

	// 색상 정보 불러오기
	@Override
	public List<Goods_OptionVO> color(int gno) throws Exception {
		System.out.println("service color 요청");
		return dao.option_color(gno);
	}

	// 사이즈 정보 불러오기
	@Override
	public List<Goods_OptionVO> size(int gno) throws Exception {
		System.out.println("service size 요청");
		return dao.option_size(gno);
	}

	// 좋아요 추가
	@Override
	public boolean favorite(int mno, int gno) throws Exception {
		System.out.println("service 좋아요 요청");
		int resultNum = dao.checkFavorite(mno, gno);
		boolean result = false;

		if (resultNum == 0) {
			result = true;
		}

		System.out.println(result);

		if (!result) {
			dao.deleteFavorite(mno, gno);
		} else {
			dao.favorite(mno, gno);
		}
		return result;
	}

	// member 장바구니 등록
	@Override
	public void reg_cart(int mno,List<CartVO> list) throws Exception {
		System.out.println("member 장바구니 등록");
		for (int i = 0; i < list.size(); i++) {
			dao.reg_cart(mno, list.get(i));
		}
	}

	// 상품 옵션번호 검색
	@Override
	public int getOno(int gno, String color, String size) throws Exception {
		return dao.getOno(gno, color, size);
	}

	// 좋아요 체크
	@Override
	public boolean favCheck(int gno, int mno) throws Exception {
		int resultNum = dao.checkFavorite(mno, gno);
		boolean result = false;
		if (resultNum > 0) {
			result = true;
		}
		return result;
	}

	// 회원 장바구니 목록
	@Override
	public List<CartVO> getCartList(int mno) throws Exception {
		return dao.getCartList(mno);
	}

	// 상품 이름 찾기
	@Override
	public String getGname(int gno) throws Exception {
		return dao.getGname(gno);
	}

	@Override
	public List<CartVO> getListByCartNo(int[] cart_no) {
		List<CartVO> list = new ArrayList<>();
		for(int i=0;i<cart_no.length;i++) {
			CartVO vo = dao.getCartByNo(cart_no[i]);
			list.add(vo);
		}
		return list;
	}

	@Override
	public void deleteCart(int cart_no) {
		dao.deleteCart(cart_no);
	}

	@Override
	public int getTotalPrice(int[] cart_no) throws Exception {
		int totalPrice = 0;
		for(int i=0;i<cart_no.length;i++) {
			totalPrice += dao.getPrice(cart_no[i]);
		}
		return totalPrice;
	}

	@Override
	public List<CouponVO> getCouponList(int mno, int totalPrice) throws Exception {
		return dao.getCouponList(mno,totalPrice);
	}

	@Transactional
	@Override
	public List<OrderComVO> order(List<OrderVO> list, OrderTempVO order, int[] cart_no, int mno) throws Exception {
		List<OrderComVO> orderComList = new ArrayList<>();
		//	주문등록
		for(OrderVO vo: list) {
			vo.setMno(mno);
			dao.order(vo);
			
			OrderComVO orderComVO = new OrderComVO();
			orderComVO = dao.getOrderComVO(vo.getOno());
			orderComVO.setGname_ko(dao.getGnameByOno(vo.getOno()));
			orderComVO.setOrderno(dao.getOrderNo());
			orderComVO.setOrder_email(vo.getOrder_email());
			orderComList.add(orderComVO);
		}
		//	장바구니 삭제
		for(int i=0;i<cart_no.length;i++) {
			dao.deleteCart(cart_no[i]);
		}
		//	포인트 감소
		dao.usePoint(order.getMpoint(), mno);
		//	쿠폰 사용
		dao.useCoupon(order.getCno(), mno);
		//	캐쉬 사용
		dao.useCash(order.getTotalPrice(), mno);
		return orderComList;
	}

	@Override
	public List<OrderComVO> orderNon(List<OrderVO> list, OrderTempVO order) throws Exception {
		List<OrderComVO> orderComList = new ArrayList<>();
		for(OrderVO vo : list) {
			dao.orderNon(vo);
			
			OrderComVO orderComVO = new OrderComVO();
			orderComVO = dao.getOrderComVO(vo.getOno());
			orderComVO.setGname_ko(dao.getGnameByOno(vo.getOno()));
			orderComVO.setOrderno(dao.getOrderNo());
			orderComVO.setOrder_email(vo.getOrder_email());
			orderComList.add(orderComVO);
		}
		return orderComList;
	}

	@Override
	public List<AdvertiseVO> getAdvertise() {
		List<AdvertiseVO> list = dao.getAdvertise();
		System.out.println("list : " + list);
		for(AdvertiseVO vo : list) {
			System.out.println(vo);
		}
		return list;
	}

	@Override
	public int getSellerMnoFromShopname(String shopname) throws Exception {
		return dao.getSellerMnoFromShopname(shopname);
	}

	@Override
	public MemberVO getShopInfo(int sellerMno) throws Exception {
		return dao.getShopInfo(sellerMno);
	}

	@Override
	public List<GoodsVO> getShopGoodsList(int sellerMno) throws Exception {
		return dao.getShopGoodsList(sellerMno);
	}

	@Override
	public GoodsVO likecount(String shopname) {
		return dao.likecount(shopname);
	}
	
	@Override
	public List<GoodsVO> getGoodsListByMnoAll(int mno) throws Exception {
		return dao.getGoodsListByMnoAll(mno);
	}

	@Override
	public List<GoodsVO> getGoodsListByMnoType(int mno, int type) throws Exception {
		return dao.getGoodsListByMnoType(mno,type);
	}
	
	@Override
	public boolean likeCheck(int mno, int shopmno) throws Exception {
		int resultNum = dao.likeCheck(mno, shopmno);
		boolean result = false;
		if (resultNum > 0) {
			result = true;
		}
		return result;
	}
	
	@Override
	public boolean like(int mno, int shopmno) throws Exception {
		System.out.println("service 좋아요 요청");
		int resultNum = dao.likeCheck(mno, shopmno);
		boolean result = false;

		if (resultNum == 0) {
			result = true;
		}

		System.out.println(result);

		if (!result) {
			dao.downLike(shopmno);
			dao.deleteLike(mno, shopmno);
		} else {
			dao.upLike(shopmno);
			dao.like(mno, shopmno);
		}
		return result;
	}

	@Override
	public void reportGoods(ReportGoodsVO reportGoodsVO) throws Exception {
		System.out.println("reportGoodsService로 들어오는가?");
		System.out.println("reportId : " + reportGoodsVO.getReportId());
		int mno = dao.getMno(reportGoodsVO.getReportId());
		reportGoodsVO.setMno(mno);
		System.out.println("setMno후 : " + reportGoodsVO);
		dao.reportGoods(reportGoodsVO);
	}
	
}
