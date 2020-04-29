package com.bomshop.www.member.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bomshop.www.common.util.Criteria;
import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.member.dao.MemberDAO;
import com.bomshop.www.member.dao.MypageDAO;
import com.bomshop.www.member.vo.CouponVO;
import com.bomshop.www.member.vo.DeliveryCountDTO;
import com.bomshop.www.member.vo.GoodsOptionVO;
import com.bomshop.www.member.vo.GoodsVO;
import com.bomshop.www.member.vo.MemberCouponVO;
import com.bomshop.www.member.vo.OrderComDTO;
import com.bomshop.www.member.vo.OrderComVO;
import com.bomshop.www.member.vo.OrderDeliveryDTO;
import com.bomshop.www.member.vo.OrderMemberVO;
import com.bomshop.www.member.vo.OrderNonDTO;
import com.bomshop.www.member.vo.OrderNonVO;
import com.bomshop.www.member.vo.QnaAdminVO;
import com.bomshop.www.member.vo.QnaGoodsVO;
import com.bomshop.www.member.vo.ReviewVO;

@Service
public class MypageServiceImpl implements MypageService{

	@Inject
	MypageDAO dao;
	
	@Inject
	MemberDAO mDao;
	
	@Override
	public int couponCnt(int mid) throws Exception {
		return dao.couponCnt(mid);
	}

	@Override
	public List<MemberCouponVO> getMemberCouponList(int mno, Criteria cri) throws Exception {
		int pageStart = cri.getPageStart();
		int perPageNum = cri.getPerPageNum();
		return dao.getMemberCouponList(mno,pageStart,perPageNum);
	}

	@Override
	public CouponVO getCouponeInfo(int cno) throws Exception {
		return dao.getCouponInfo(cno);
	}

	@Override
	public PageMaker getPageMaker(int mno,Criteria cri) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.couponCnt(mno));
		return pageMaker;
	}

	@Override
	public boolean passwordCheck(int mno, String mpw) throws Exception {
		int cnt = dao.passwordCheck(mno,mpw);
		if(cnt>0) {
			return true;
		}
		return false;
	}

	@Override
	public void cashCharge(int mno, int cash) throws Exception {
		dao.addCash(mno,cash);
	}

	@Override
	public void setMailCode(int mno,String tempString) throws Exception{
		dao.addMailCode(mno,tempString);
	}
	

	@Override
	public void setMailFindCode(String email, String tempString) throws Exception {
		dao.addMailFindCode(email,tempString);
	}

	@Override
	public String getMailCode(int mno) throws Exception{
		return dao.getMailCode(mno);
	}

	@Override
	public int getLikeGoodsCnt(int mno) throws Exception {
		return dao.getLikeGoodsCnt(mno);
	}

	@Override
	public List<GoodsVO> getLikeGoodsList(int mno) throws Exception {
		return dao.getLikeGoodsList(mno);
	}

	@Override
	public List<OrderComDTO> getOrderComList(int mno) throws Exception {
		List<OrderComVO> orderComList = dao.getOrderComList(mno);
		List<GoodsOptionVO> optionList = dao.getGoodsOptionList();
		List<OrderComDTO> list = new ArrayList<>();
		for(OrderComVO ocVO : orderComList) {
			for(GoodsOptionVO goVO : optionList) {
				if(ocVO.getOno() == goVO.getOno()) {
					GoodsVO goods = dao.getGoodsVO(goVO.getGno());
					OrderComDTO dto = new OrderComDTO();
					dto.setMno(mno);
					dto.setGno(goVO.getGno());
					dto.setOno(ocVO.getOno());
					dto.setOrderno(ocVO.getOrderno());
					dto.setSize(goVO.getSize());
					dto.setColor(goVO.getColor());
					dto.setGname_ko(goods.getGname_ko());
					dto.setGname_en(goods.getGname_en());
					dto.setCount(ocVO.getCount());
					dto.setOrder_date(ocVO.getOrder_date());
					dto.setPrice(ocVO.getPrice());
					dto.setOrder_com_date(ocVO.getOrder_com_date());
					list.add(dto);
				}
			}
		}
		return list;
	}

	@Override
	public List<OrderComDTO> getOrderComListAjax(int mno, String type) throws Exception {
		List<OrderComVO> orderComList = null;
		switch(type) {
			case "ALL":
				orderComList = dao.getOrderComList(mno);
				break;
			case "purchaseList7d":
				orderComList = dao.getOrderComListAjax(mno,-7);
				break;
			case "purchaseList15d":
				orderComList = dao.getOrderComListAjax(mno,-15);
				break;
			case "purchaseList30d":
				orderComList = dao.getOrderComListAjax(mno,-30);
				break;
		}
		
		List<GoodsOptionVO> optionList = dao.getGoodsOptionList();
		List<OrderComDTO> list = new ArrayList<>();
		for(OrderComVO ocVO : orderComList) {
			for(GoodsOptionVO goVO : optionList) {
				if(ocVO.getOno() == goVO.getOno()) {
					GoodsVO goods = dao.getGoodsVO(goVO.getGno());
					OrderComDTO dto = new OrderComDTO();
					dto.setMno(mno);
					dto.setGno(goVO.getGno());
					dto.setOno(ocVO.getOno());
					dto.setOrderno(ocVO.getOrderno());
					dto.setSize(goVO.getSize());
					dto.setColor(goVO.getColor());
					dto.setGname_ko(goods.getGname_ko());
					dto.setGname_en(goods.getGname_en());
					dto.setCount(ocVO.getCount());
					dto.setOrder_date(ocVO.getOrder_date());
					dto.setPrice(ocVO.getPrice());
					dto.setOrder_com_date(ocVO.getOrder_com_date());
					list.add(dto);
				}
			}
		}
		return list;

	}

	@Override
	public List<OrderDeliveryDTO> getOrderDeliveryDTO(int mno, String type) throws Exception {
		List<OrderDeliveryDTO> list = new ArrayList<>();
		List<OrderMemberVO> omVOList = null;
		switch(type) {
			case "all":
				omVOList = dao.orderMemberListAll(mno);
				break;
			case "7d":
				omVOList = dao.orderMemberList(mno,-7);
				break;
			case "15d":
				omVOList = dao.orderMemberList(mno,-15);
				break;
			case "30d":
				omVOList = dao.orderMemberList(mno,-30);
				break;
		}
		List<GoodsOptionVO> goVOList = dao.getGoodsOptionList();
		for(OrderMemberVO omVO : omVOList) {
			for(GoodsOptionVO goVO : goVOList) {
				if(omVO.getOno() == goVO.getOno()) {
					GoodsVO goods = dao.getGoodsVO(goVO.getGno());
					OrderDeliveryDTO dto = new OrderDeliveryDTO();
					dto.setOrderno(omVO.getOrderno());
					dto.setColor(goVO.getColor());
					dto.setCount(omVO.getCount());
					dto.setDelivery_addr1(omVO.getDelivery_addr1());
					dto.setDelivery_addr2(omVO.getDelivery_addr2());
					dto.setDelivery_name(omVO.getDelivery_name());
					dto.setDelivery_phone(omVO.getDelivery_phone());
					dto.setGname_en(goods.getGname_en());
					dto.setGname_ko(goods.getGname_ko());
					dto.setGno(goods.getGno());
					dto.setMno(mno);
					dto.setOno(omVO.getOno());
					dto.setOrder_check(omVO.getOrder_check());
					dto.setOrder_email(omVO.getOrder_email());
					dto.setOrder_name(omVO.getOrder_name());
					dto.setOrder_phone(omVO.getOrder_phone());
					dto.setOrder_status(omVO.getOrder_status());
					dto.setOrderdate(omVO.getOrderdate());
					dto.setPrice(omVO.getPrice());
					dto.setSize(goVO.getSize());
					dto.setStatus_reason(omVO.getStatus_reason());
					list.add(dto);
				}
			}
		}
		return list;
	}

	@Override
	public DeliveryCountDTO getDeliveryCount(int mno) throws Exception {
		List<OrderMemberVO> omVOList = dao.orderMemberListAll(mno);
		DeliveryCountDTO cntDto = new DeliveryCountDTO();
		for(OrderMemberVO vo : omVOList) {
			switch(vo.getOrder_status()) {
			case 0:
				cntDto.setDeliveryWaitCnt(cntDto.getDeliveryWaitCnt()+1);
				break;
			case 1:
				cntDto.setDeliveryRunningCnt(cntDto.getDeliveryRunningCnt()+1);
				break;
			case 2:
				cntDto.setDeliveryCompleteCnt(cntDto.getDeliveryCompleteCnt()+1);
				break;
			case 3:
				cntDto.setRefundRequestCnt(cntDto.getRefundRequestCnt()+1);
				break;
			case 4:
				cntDto.setExchangeRequestCnt(cntDto.getExchangeRequestCnt()+1);
				break;
			case 5:
				cntDto.setCancellationCnt(cntDto.getCancellationCnt()+1);
				break;
			}
		}
		return cntDto;
	}

	@Override
	public String refundSetReason(int orderno, int status_reason) throws Exception {
		String result = null;
	
		int cnt = dao.updateReason(orderno,status_reason);

		if(cnt > 0) {
			result = "반품신청이 완료되었습니다.";
		}else {
			result = "반품신청에 실패하였습니다.";
		}
		return result;
	}

	@Override
	public String exchangeSetReason(int orderno, int exchange_reason) throws Exception {
		String result = null;
		int cnt = dao.updateExchangeReason(orderno,exchange_reason);
		if(cnt > 0) {
			result = "교환신청이 완료되었습니다.";
		}else {
			result = "교환신청에 실패하였습니다.";
		}
		return result;
	}

	@Override
	public String cancelTransaction(int orderno) throws Exception {
		String result = null;
		int cnt = dao.cancelTransaction(orderno);
		if(cnt > 0) {
			result = "거래가 취소되었습니다.";
		}else {
			result = "거래 취소에 실패하였습니다. 관리자에게 문의해주세요.";
		}
		return result;
	}

	@Override
	@Transactional
	public String purchaseComplete(ReviewVO vo, int orderno) throws Exception {
		String result = null;
		
		int cnt = dao.insertReview(vo);
		if (cnt > 0) {
			OrderMemberVO omVO = dao.getOrderMember(orderno);
			// move order_member -> order_com
			OrderComVO orderCom = new OrderComVO();
			orderCom.setMno(omVO.getMno());
			orderCom.setOno(omVO.getOno());
			orderCom.setCount(omVO.getCount());
			orderCom.setOrder_date(omVO.getOrderdate());
			orderCom.setOrderno(orderno);
			orderCom.setPrice(omVO.getPrice());
			dao.insertOrderCom(orderCom);
			dao.deleteOrderMember(orderno);

			// 가격, 등급포인트, 등급, 포인트 적립 계산
			int price = omVO.getPrice();			// 가격
			MemberVO member = mDao.getMember(vo.getMno());
			// 등급포인트 계산
			int grade = member.getMgrade();			// 현재등급
			int gradePoint = member.getGpoint();	// 등급포인트
			int point = 0;
			
			switch(grade) {
				case 1:		
					point = 0;						// 포인트 적립 x
					break;
				case 2:
					point = price/100*1;	// 1% 적립
					break;
				case 3:
					point = price/100*2;	// 2% 적립
					System.out.println("포인트 갱신"+point);
					break;
				case 4:
					point = price/100*2;	// 3% 적립
					System.out.println("포인트 갱신"+point);
					break;
				case 5:
					point = price/100*5;	// 5% 적립
					break;
				case 6:
					point = price/100*7;	// 7% 적립
					break;
				case 7:
					point = price/100*10;	// 10% 적립
					break;
			}
			
			gradePoint = gradePoint + price;
			grade = calGrade(gradePoint);
			
			int currentPoint = member.getMpoint();			// 현재포인트
			
			int totalPoint = currentPoint + point;
			
			// totalPoint, grade, gradePoint 갱신
			member.setMpoint(totalPoint);
			member.setGpoint(gradePoint);
			member.setMgrade(grade);
			mDao.purchaseCompleteAfterMemberUpdate(member);

			result = "구매확정이 완료되었습니다.";
		}else {
			result = "구매확정에 실패하였습니다.";
		}
		
		return result;
	}
	
	
	
	@Override
	@Transactional
	public String noReviewPurchaseComplete(int orderno, int mno) throws Exception {
		OrderMemberVO omVO = dao.getOrderMember(orderno);
		// move order_member -> order_com
		OrderComVO orderCom = new OrderComVO();
		orderCom.setMno(omVO.getMno());
		orderCom.setOno(omVO.getOno());
		orderCom.setCount(omVO.getCount());
		orderCom.setOrder_date(omVO.getOrderdate());
		orderCom.setOrderno(orderno);
		orderCom.setPrice(omVO.getPrice());
		dao.insertOrderCom(orderCom);
		dao.deleteOrderMember(orderno);
		
		// 가격, 등급포인트, 등급, 포인트 적립 계산
		int price = omVO.getPrice();			// 가격
		MemberVO member = mDao.getMember(mno);
		// 등급포인트 계산
		int grade = member.getMgrade();			// 현재등급
		int gradePoint = member.getGpoint();	// 등급포인트
		
		gradePoint = gradePoint + price;
		grade = calGrade(gradePoint);
		
		//  grade, gradePoint 갱신
		member.setGpoint(gradePoint);
		member.setMgrade(grade);
		mDao.purchaseCompleteAfterMemberUpdate(member);

		return "구매확정이 완료되었습니다.";
	}

	private int calGrade(int gradePoint) {
		int grade = 0;
		if(gradePoint >= 10000000) {
			grade = 7;
		}else if(gradePoint >= 5000000) {
			grade = 6;
		}else if(gradePoint >= 1000000) {
			grade = 5;
		}else if(gradePoint >= 500000) {
			grade = 4;
		}else if(gradePoint >= 100000) {
			grade = 3;
		}else if(gradePoint >= 10000) {
			grade = 2;
		}else {
			grade = 1;
		}
		return grade;
	}

	@Override
	public List<QnaGoodsVO> getQnaGoodsList(int mno, int page) throws Exception {
		Criteria cri = new Criteria(page,5);
		int pageStart = cri.getPageStart();
		int perPageNum = cri.getPerPageNum();
		return dao.getQnaGoodsList(mno,pageStart,perPageNum);
	}

	@Override
	public PageMaker getQuestionPageMaker(int mno, int page) throws Exception {
		Criteria cri = new Criteria(page,5);
		int pageStart = cri.getPageStart();
		int perPageNum = cri.getPerPageNum();
		int totalCount = dao.getQuestionListCount(mno,pageStart,perPageNum);
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(totalCount);
		return pm;
	}

	@Override
	public List<ReviewVO> getReviewList(int mno, int page) throws Exception {
		Criteria cri = new Criteria(page,5);
		int pageStart = cri.getPageStart();
		int perPageNum = cri.getPerPageNum();
		return dao.getReviewList(mno,pageStart,perPageNum);
	}

	@Override
	public PageMaker getReviewPageMaker(int mno, int page) throws Exception {
		Criteria cri = new Criteria(page,5);
		int pageStart = cri.getPageStart();
		int perPageNum = cri.getPerPageNum();
		int totalCount = dao.getReviewListCount(mno,pageStart,perPageNum);
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(totalCount);
		return pm;
	}

	@Override
	public List<QnaAdminVO> getQnaAdminList(int mno, int page) throws Exception {
		Criteria cri = new Criteria(page,5);
		int pageStart = cri.getPageStart();
		int perPageNum = cri.getPerPageNum();
		return dao.getQnaAdminList(mno,pageStart,perPageNum);
	}

	@Override
	public PageMaker getQnaAdminPageMaker(int mno, int page) throws Exception {
		Criteria cri = new Criteria(page,5);
		int pageStart = cri.getPageStart();
		int perPageNum = cri.getPerPageNum();
		int totalCount = dao.getQnaAdminListCount(mno,pageStart,perPageNum);
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(totalCount);
		return pm;
	}

	@Override
	public void registQnaAdmin(QnaAdminVO vo) throws Exception {
		dao.insertQnaAdmin(vo);
	}

	@Override
	public String getMailFindCode(String email) throws Exception {
		return dao.getMailFindCode(email);
	}

	@Override
	public List<OrderNonDTO> getOrderNonDTOByNonMember(int orderno, String order_email, String order_phone) throws Exception{
		List<OrderNonDTO> list = new ArrayList<>();
		List<OrderMemberVO> ocVOList = null;

		ocVOList = dao.orderNonMemberListAll(orderno,order_email,order_phone);
		List<GoodsOptionVO> goVOList = dao.getGoodsOptionList();
		for(OrderMemberVO omVO : ocVOList) {
			for(GoodsOptionVO goVO : goVOList) {
				if(omVO.getOno() == goVO.getOno()) {
					GoodsVO goods = dao.getGoodsVO(goVO.getGno());
					OrderNonDTO dto = new OrderNonDTO();
					// 상품정보
					dto.setOrderno(omVO.getOrderno());
					dto.setGno(goods.getGno());
					dto.setGname_ko(goods.getGname_ko());
					dto.setCount(omVO.getCount());
					dto.setPrice(omVO.getPrice());
					dto.setColor(goVO.getColor());
					dto.setSize(goVO.getSize());
					dto.setOrderdate(omVO.getOrderdate());
					// 주문자 정보
					dto.setOrder_name(omVO.getOrder_name());
					dto.setOrder_email(omVO.getOrder_email());
					dto.setOrder_phone(omVO.getOrder_phone());
					// 배송지 정보
					dto.setDelivery_name(omVO.getDelivery_name());
					dto.setDelivery_phone(omVO.getDelivery_phone());
					dto.setDelivery_post_code(omVO.getDelivery_post_code());
					dto.setDelivery_addr1(omVO.getDelivery_addr1());
					dto.setDelivery_addr2(omVO.getDelivery_addr2());
					// 판매자 확인 유무
					dto.setOrder_check(omVO.getOrder_check());
					dto.setOrder_status(omVO.getOrder_status());
					list.add(dto);
				}
			}
		}
		return list;
	}

	@Override
	public String addCouponCode(int mno,String coupon_code) throws Exception {
		String result = null;
		int isCoupon = dao.couponCheck(coupon_code);
		
		if(isCoupon > 0) {
			int cno = dao.getCnoFromCouponCode(coupon_code);
			int couponCnt = dao.isUseCouponCnt(mno);
			if(couponCnt > 0) {
				String check_use = dao.isUseCoupon(mno,cno);
				if(check_use.equals("Y") || check_use.equals("N")) {
					result = "이미 등록된 쿠폰코드입니다.";
				}else {
					dao.addCouponToMember(mno,cno);
					result = "쿠폰 등록 성공";
				}
			}else {
				dao.addCouponToMember(mno,cno);
				result = "쿠폰 등록 성공";
			}
			
		}else {
			result = "존재하지 않는 쿠폰코드입니다.";
		}
		return result;
	}
	
	
	
}
