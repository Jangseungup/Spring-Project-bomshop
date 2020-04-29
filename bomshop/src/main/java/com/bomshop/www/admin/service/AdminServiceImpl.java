package com.bomshop.www.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bomshop.www.admin.dao.AdminDAO;
import com.bomshop.www.admin.dto.AdvertiseDTO;
import com.bomshop.www.admin.dto.QuestionDTO;
import com.bomshop.www.admin.dto.ReportGoodsDTO;
import com.bomshop.www.admin.vo.AdvertiseVO;
import com.bomshop.www.admin.vo.AnswerCommentVO;
import com.bomshop.www.admin.vo.BlacklistVO;
import com.bomshop.www.admin.vo.CouponVO;
import com.bomshop.www.admin.vo.QuestionVO;
import com.bomshop.www.admin.vo.ReportGoodsVO;
import com.bomshop.www.admin.vo.ReportVO;
import com.bomshop.www.admin.vo.SendBuyerVO;
import com.bomshop.www.admin.vo.WritedBoardVO;
import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;

@Service
public class AdminServiceImpl implements AdminService{

	@Inject
	AdminDAO dao;
	
	@Override
	public Map<String,Object> totalRequest() throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("reportCount", dao.reportCount());
		map.put("couponCount", dao.couponCount());
		map.put("goodsCount", dao.reportGoodsCount());
		map.put("advertiseCount", dao.advertiseTotalCount());
		map.put("serviceCount", dao.serviceCount());
		return map;
	}
	
	// 회원 신고 리스트
	@Override
	public List<ReportVO> reportList(SearchCriteria cri) throws Exception{
		List<ReportVO> list = null;
		if(cri.getSearchType() == null) {
			list = dao.listReport(cri);
			for(ReportVO rvo : list) {
				// 신고자 ID
				rvo.setReporter_id(dao.getReporterID(rvo.getMno()));
				// 신고 ID
				rvo.setReport_id(dao.getReportID(rvo.getReport_mno()));
				rvo.setAlert(dao.strike(rvo.getReport_mno()));
			}
		}
		return list;
	}
	
	// 회원 신고 페이징
	@Override
	public PageMaker getReportPageMaker(SearchCriteria cri) throws Exception{
		int totalCount = Integer.parseInt(dao.reportCount());
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		System.out.println("totalCount : "  + totalCount);
		pm.setTotalCount(totalCount);
		System.out.println(cri);
		System.out.println(pm);
		return pm;
	}

	// 블랙리스트 등록
	@Override
	@Transactional
	public void addBlacklist(ReportVO reportVO) throws Exception {
		// rno 해당 row 검색
		ReportVO rvo = dao.searchRow(reportVO.getRno());
		System.out.println("rvo : " + rvo);
		// 블랙리스트 등록
		dao.updateBan(rvo);
		dao.addBlacklist(rvo);
		// 신고 접수 제거
		dao.deleteReport(reportVO.getRno());
	}
	
	// 경고 횟수 증가
	@Override
	@Transactional
	public String increaseAlert(int rno) throws Exception {
		String message = "";
		// rno 해당 row 검색
		ReportVO rvo = dao.searchRow(rno);
		System.out.println("increaseService rvo : " + rvo);
		// 경고 횟수 증가
		dao.increaseAlert(rvo);
		System.out.println("ReportMno : " + rvo.getReport_mno());
		Integer strike = dao.strike(rvo.getReport_mno());
		System.out.println("strike : " + strike);
		if(strike.equals(3)) {		
			System.out.println("strike~ out!");
			dao.updateBan(rvo);
			dao.addBlacklist(rvo);
			dao.deleteReport(rvo.getRno());
			message = "경고 3회 누적 블랙리스트로 등록됩니다.";
			return message;
		}
		// 신고 처리 후 삭제
		dao.deleteReport(rno);
		message = "처리 완료";
		return message;
	}
	
	// 신고 거절
	@Override
	public void parole(int rno) throws Exception {
		dao.deleteReport(rno);
	}
	
	// 블랙리스트 목록
	@Override
	@Transactional
	public Map<String, Object> blacklistModal(int page) throws Exception {
		SearchCriteria cri = new SearchCriteria();
		cri.setPage(page);
		System.out.println("blackService : " + page);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.blacklistCount());
		System.out.println("blackService pageMaker : " + pageMaker.getCri());
		System.out.println("blackService pageMaker : " + pageMaker.getTotalCount());
		List<BlacklistVO> list = dao.blacklist(cri);
		System.out.println("blacklist List : " + list);
		Map<String,Object> map = new HashMap<>();
		map.put("blacklist",list);
		map.put("page",pageMaker);
		return map;
	}
	
	// 블랙리스트 해제
	@Override
	@Transactional
	public void deleteBlacklist(int black_no) throws Exception {
		System.out.println("black_no Service : " + black_no);
		// 블랙리스트 해제된 멤버의 상태변경
		dao.updateBlacklist(black_no);
		// 블랙리스트 해제된 멤버 테이블에서 삭제
		dao.deleteBlacklist(black_no);
	}
	
	// 작성글 보기
	@Override
	public Map<String, Object> getWritedBoard(int rno) throws Exception {
		System.out.println("service rno : " + rno);

		Map<String, Object> map = new HashMap<>();
		WritedBoardVO wbv = dao.getWritedBoard(rno);
		System.out.println("service wbv : " + wbv);
		map.put("wbv", wbv);
		return map;
	}

	// 쿠폰 리스트
	@Override
	public List<CouponVO> getCouponList(SearchCriteria cri) throws Exception{
		return dao.getCouponList(cri);
	}
	
	// 쿠폰 페이징
	@Override
	public PageMaker getCouponPageMaker(SearchCriteria cri) throws Exception {
		int totalCount = Integer.parseInt(dao.couponCount());
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		System.out.println("totalCount : "  + totalCount);
		pm.setTotalCount(totalCount);
		System.out.println(cri);
		System.out.println(pm);
		return pm;
	}
	
	// 쿠폰 등록
	@Override
	public void enrollCoupon(CouponVO couponVO) throws Exception {
		dao.enrollCoupon(couponVO);
	}
	
	// 쿠폰 수정
	@Override
	public void updateCoupon(CouponVO couponVO) throws Exception {
		dao.updateCoupon(couponVO);
	}
	
	// 쿠폰 삭제
	@Override
	public void deleteCoupon(int cno) throws Exception {
		dao.deleteCoupon(cno);
	}
	
	// 신고 상품 리스트 
	@Override
	public List<ReportGoodsDTO> getReportGoodsList(SearchCriteria cri) throws Exception {
		
		List<ReportGoodsVO> reportGoodsVO = null;
		List<ReportGoodsDTO> reportGoodsList = null;
		if(cri.getSearchType() == null || cri.getSearchType() == "") {
			reportGoodsVO = dao.getReportGoodsList(cri);
		}
		else if(cri.getSearchType().equals("0")) {
			reportGoodsVO = dao.getReportGoodsUntreatedList(cri);
		}
		else if(cri.getSearchType().equals("1")) {
			reportGoodsVO = dao.getReportGoodsInquiryList(cri);
		}
		else if(cri.getSearchType().equals("2")) {
			reportGoodsVO = dao.getReportGoodsCompletedList(cri);
		}
		reportGoodsList = new ArrayList<>();
		for(ReportGoodsVO rvo : reportGoodsVO) {
			ReportGoodsDTO rgd = new ReportGoodsDTO();
			System.out.println("rvo : " + rvo);
			rgd.setRgv(rvo);
			rgd.setReporterID(dao.getReporterID(rvo.getMno()));
			rgd.setBuyerID(dao.getBuyerID(rvo.getGno()));
			rgd.setGoodsName(dao.getGoodsName(rvo.getGno()));
			reportGoodsList.add(rgd);
			System.out.println("DTO LIST : " + reportGoodsList);
		}
		return reportGoodsList;
	}
	
	// 신고 상품 페이징
	@Override
	public PageMaker getReportGoodsPageMaker(SearchCriteria cri) throws Exception{
		int totalCount = 0;
		if(cri.getSearchType()==null || cri.getSearchType().equals("")) {
			totalCount = Integer.parseInt(dao.reportGoodsCount());
		}else if(cri.getSearchType().equals("0")) {
			totalCount = Integer.parseInt(dao.reportGoodsUntreatedCount());
		}else if(cri.getSearchType().equals("1")) {
			totalCount = Integer.parseInt(dao.reportGoodsInquiryCount());
		}else if(cri.getSearchType().equals("1")) {
			totalCount = Integer.parseInt(dao.reportGoodsCompletedCount());
		}
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		System.out.println("totalCount : "  + totalCount);
		pm.setTotalCount(totalCount);
		System.out.println(cri);
		System.out.println(pm);
		return pm;
	}
	
	// 신고 처리 완료
	@Override
	public void deleteReportGoods(int rgno) throws Exception {
		dao.deleteReportGoods(rgno);
	}
		
	// 판매자 ID 조회
	@Override
	public Map<String, Object> getBuyerInfo(int gno) throws Exception {
		String buyerID = dao.getBuyerID(gno);
		Map<String, Object> map = new HashMap<>();
		map.put("buyerID",buyerID);
		return map;
	}
	// 상품 신고 사유 판매자에게 문의
	@Override
	public void snedBuyer(SendBuyerVO sendBuyerVO) throws Exception {
		dao.sendBuyer(sendBuyerVO);
	}
	
	// 관리자 문의 리스트
	@Override
	public List<QuestionDTO> getQuetionList(SearchCriteria cri) throws Exception {
		List<QuestionVO> list = dao.getQuetionList(cri);
		System.out.println("getQuestion List"+list);
		List<QuestionDTO> questionDTOList = new ArrayList<>();
		for(QuestionVO questionVO : list) {
			QuestionDTO questionDTO = new QuestionDTO();
			questionDTO.setQuestionVO(questionVO);
			questionDTO.setQuestionID(dao.getReportID(questionVO.getMno()));
			questionDTOList.add(questionDTO);
			System.out.println("questionDTOLIST : " + questionDTOList);
		}
		return questionDTOList; 
	}
	
	@Override
	public PageMaker getQuetionPageMaker(SearchCriteria cri) throws Exception {
		int totalCount = Integer.parseInt(dao.serviceCount());
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		System.out.println("totalCount : "  + totalCount);
		pm.setTotalCount(totalCount);
		System.out.println(cri);
		System.out.println(pm);
		return pm;
	}
	
	// 관리자 고객센터 문의 수
	@Override
	public String questionCount() throws Exception {
		return dao.serviceCount();
	}
	
	// 답변 후 답변 상태 변경 및 답변 테이블에 값 추가
	@Override
	@Transactional
	public void sendAnswer(AnswerCommentVO answerCommentVO) throws Exception {
		dao.sendAnswer(answerCommentVO.getQano());
		answerCommentVO.setMno(dao.getQuestionDetail(answerCommentVO.getQano())); 	
		dao.addComment(answerCommentVO);		
	}
	
	// 전체 광고 수
	@Override
	public int advertiseTotalCount() throws Exception {
		return dao.advertiseTotalCount();
	}
	
	// 광고 대기
	@Override
	public int watingApproved() throws Exception {
		return dao.advertiseCount();
	}
	
	// 광고 중
	@Override
	public int advertisingCount() throws Exception {
		return dao.advertisingCount();
	}
	
	// 광고 종료 3일 전
	@Override
	public int getDeadline() throws Exception {
		return dao.getDeadline();
	}
	
	// 광고 목록
	@Override
	public List<AdvertiseDTO> getAdvertiseList(SearchCriteria cri) throws Exception {
		List<AdvertiseVO> advertiseVO = null;
		List<AdvertiseDTO> advertiseDTO = null;
		
		if(cri.getSearchType() == null || cri.getSearchType().equals("")) {
			advertiseVO = dao.advertiseList(cri);
		}
		else if(cri.getSearchType().equals("advertising")) {
			advertiseVO = dao.advertisingList(cri);
		}
		else if(cri.getSearchType().equals("waiting")) {
			advertiseVO = dao.advertiseWaitingList(cri);
		}
		else if(cri.getSearchType().equals("deadline")) {
			advertiseVO = dao.advertiseDeadlineList(cri);
		}
		advertiseDTO = new ArrayList<>(); 
		for(AdvertiseVO av : advertiseVO) {
			AdvertiseDTO ad = new AdvertiseDTO();
			ad.setAdvertiseVO(av);
			ad.setMid(dao.getBuyerID(av.getGno()));
			ad.setGname_ko(dao.getGoodsName(av.getGno()));
			ad.setRemaining_period(dao.getRemaining_period(av.getAdate()));
			advertiseDTO.add(ad);
		}
		return advertiseDTO;
	}
	
	// 광고 페이징
	@Override
	public PageMaker getAdvertisePageMaker(SearchCriteria cri) throws Exception {
		int totalCount = 0;
		if(cri.getSearchType()==null || cri.getSearchType().equals("")){
			totalCount = dao.advertiseTotalCount();
		}else if(cri.getSearchType().equals("advertising")) {
			totalCount = dao.advertisingCount();
		}else if(cri.getSearchType().equals("waiting")) {
			totalCount = dao.advertiseCount();
		}else if(cri.getSearchType().equals("deadline")) {
			totalCount = dao.getDeadline();
		}
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		System.out.println("totalCount : "  + totalCount);
		pm.setTotalCount(totalCount);
		System.out.println(cri);
		System.out.println(pm);
		return pm;
	}
	// 광고 신청 승인
	@Override
	public String acceptAdvertise(int ano) throws Exception {
		int acceptCount = dao.acceptCount();
		String message = "";
		System.out.println("acceptCount : " + acceptCount);
		if(acceptCount < 5) {
			dao.acceptAdvertise(ano);
			message = "승인되었습니다.";
		}else {
			message = "승인된 광고 수가 초과했습니다.";
		}
		return message;
	}
	
	// 광고 신청 취소
	@Override
	public void deleteAdvertise(int ano) throws Exception {
		dao.deleteAdvertise(ano);
	}

	
}
