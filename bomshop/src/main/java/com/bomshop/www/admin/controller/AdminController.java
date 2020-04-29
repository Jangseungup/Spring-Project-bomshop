package com.bomshop.www.admin.controller;

import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bomshop.www.admin.service.AdminService;
import com.bomshop.www.admin.vo.AnswerCommentVO;
import com.bomshop.www.admin.vo.CouponVO;
import com.bomshop.www.admin.vo.ReportVO;
import com.bomshop.www.admin.vo.SendBuyerVO;
import com.bomshop.www.common.util.SearchCriteria;




@Controller
@RequestMapping("admin/")
public class AdminController {
	
	@Inject
	AdminService service;
	
	@GetMapping("adminMain")
	public String adminMainPage(
			Model model
			) throws Exception {
		System.out.println("adminMain");
		Map<String,Object> map = service.totalRequest();
		model.addAttribute("reportCount",map.get("reportCount"));
		model.addAttribute("couponCount",map.get("couponCount"));
		model.addAttribute("goodsCount",map.get("goodsCount"));
		model.addAttribute("advertiseCount",map.get("advertiseCount"));
		model.addAttribute("serviceCount",map.get("serviceCount"));
		return "admin/adminMain";
	}
	
	// 신고 관리
	@GetMapping("memberManagement")
	public String memberManagement(
			@ModelAttribute("cri") SearchCriteria cri,
			HttpServletRequest request,
			Model model
			) throws Exception {
		model.addAttribute("list",service.reportList(cri));
		model.addAttribute("pageMaker", service.getReportPageMaker(cri));
		return "admin/memberManagement";
	}
	
	//블랙리스트 등록
	@PostMapping("addBlacklist")
	public ResponseEntity<String> blacklistAdd(
			@RequestBody ReportVO reportVO
			) throws Exception {
		System.out.println("blacklistAdd");
		ResponseEntity<String> entity = null;
		
		try {
			System.out.print("reportVO : " + reportVO);
			service.addBlacklist(reportVO);
			entity = new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.OK);
		}
		
		return entity;
	}
	
	// 블랙리스트 목록
	@GetMapping("blacklist/{page}")
	public ResponseEntity<Map<String,Object>> blacklistModal(
			@PathVariable("page") int page
			) throws Exception{
		ResponseEntity<Map<String,Object>> entity = null;
		
		System.out.println("blacklistModal-------------------------------------------------------------------");
		
		try {
			System.out.println("page : " + page);
			Map<String,Object> map = service.blacklistModal(page);
			System.out.println("blacklistMap : " + map);
			entity = new ResponseEntity<>(map,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// 블랙리스트 해제
	@DeleteMapping("deleteBlacklist/{black_no}")
	public ResponseEntity<String> deleteBlacklist(
			@PathVariable("black_no") int black_no
			) throws Exception{
		ResponseEntity<String> entity = null;
		try {
			System.out.println("black_no Con : " + black_no);
			service.deleteBlacklist(black_no);
			entity = new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return entity;
	}
		
	// 경고 조치
	@PatchMapping(value="increaseAlert/{rno}",produces="text/json;charset=utf-8")
	public ResponseEntity<String> increaseAlert(
			@PathVariable("rno") int rno,
			@RequestBody ReportVO rvo
			) throws Exception{
		ResponseEntity<String> entity = null;
		System.out.println("rno :"+ rno +"increase : " + rvo);
		rvo.setRno(rno);
		System.out.println("rno :"+ rno +"increase1 : " + rvo);
		try {
			String message = service.increaseAlert(rno);
			System.out.println("message : " + message);
			entity = new ResponseEntity<String>(message,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 신고 거절
	@DeleteMapping("parole/{rno}")
	public ResponseEntity<String> deleteReport(
			@PathVariable("rno") int rno
			) throws Exception{
		ResponseEntity<String> entity = null;
		try {
			service.parole(rno);
			entity = new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return entity;
	}
	
	// 작성한 게시물 확인
	@GetMapping("showWirtedBoard/{rno}")
	public ResponseEntity<Map<String,Object>> showWirtedBoard(
			@PathVariable("rno") int rno
			) throws Exception{
		ResponseEntity<Map<String,Object>> entity = null;
		try {
			Map<String,Object> map = service.getWritedBoard(rno);
			entity = new ResponseEntity<>(map,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 쿠폰 관리 리스트
	@GetMapping("coupon")
	public String couponPage(
			@ModelAttribute("cri") SearchCriteria cri,
			HttpServletRequest request,
			Model model
			)throws Exception {
		model.addAttribute("couponList",service.getCouponList(cri));
		model.addAttribute("pageMaker",service.getCouponPageMaker(cri));
		return "admin/coupon";
	}
	
	// 쿠폰 등록
	@PostMapping("enrollCoupon")
	public ResponseEntity<String> enrollCoupon(
			@RequestBody CouponVO couponVO
			) {
		System.out.println("enrollCoupon");
		ResponseEntity<String> entity = null;
	
		try {
			System.out.print("couponVO : " + couponVO);
			service.enrollCoupon(couponVO);
			entity = new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.OK);
		}
		
		return entity;
	}
	
	// 쿠폰 수정
	@PatchMapping(value="updateCoupon",produces="text/json;charset=utf-8")
	public ResponseEntity<String> updateCoupon(
			@RequestBody CouponVO couponVO
			) throws Exception{
		ResponseEntity<String> entity = null;
		System.out.println("update : " + couponVO);
		try {
			service.updateCoupon(couponVO);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 쿠폰 삭제
	@DeleteMapping("deleteCoupon/{cno}")
	public ResponseEntity<String> deleteCoupon(
			@PathVariable("cno") int cno
			) throws Exception{
		ResponseEntity<String> entity = null;
		System.out.println("cno : " + cno);
		try {
			service.deleteCoupon(cno);
			entity = new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return entity;
	}
	
	// 쿠폰 관리 리스트
	@GetMapping("reportGoods")
	public String reportGoods(
			@ModelAttribute("cri") SearchCriteria cri,
			HttpServletRequest request,
			Model model
			)throws Exception {
		System.out.println("con getSearchType : " + cri.getSearchType());
		model.addAttribute("reportGoodsList",service.getReportGoodsList(cri));
		model.addAttribute("pageMaker",service.getReportGoodsPageMaker(cri));
		return "admin/reportGoods";
	}
	
	// 신고 완료 처리
	@DeleteMapping("deleteReportGoods/{rgno}")
	public ResponseEntity<String> deleteReportGoods(
			@PathVariable("rgno") int rgno
			) throws Exception{
		ResponseEntity<String> entity = null;
		System.out.println("rgno : " + rgno);
		try {
			service.deleteReportGoods(rgno);
			entity = new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return entity;
	}
	
	@GetMapping(value="getBuyerInfo/{gno}")
	public ResponseEntity<Map<String,Object>> getBuyerInfo(
			@PathVariable("gno") int gno
			) {
		ResponseEntity<Map<String,Object>> entity = null;
		System.out.println(gno);
		try {
			Map<String,Object> map = service.getBuyerInfo(gno);
			entity = new ResponseEntity<>(map,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// 신고 상품 판매자 문의
	@PatchMapping(value="sendBuyer/{rgno}",produces="text/json;charset=utf-8")
	public ResponseEntity<String> sendBuyer(
			@PathVariable("rgno") int rgno,
			@RequestBody SendBuyerVO sendBuyerVO
			) throws Exception {
		ResponseEntity<String> entity = null;
		sendBuyerVO.setRgno(rgno);
		System.out.println("sendBuyerVO : " + sendBuyerVO);

		try {
			service.snedBuyer(sendBuyerVO);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	// 서비스센터
	@GetMapping("serviceCenter")
	public String serviceCenterPage(@ModelAttribute("cri") SearchCriteria cri,
			HttpServletRequest request,
			Model model
			)throws Exception {
		model.addAttribute("questionList",service.getQuetionList(cri));
		model.addAttribute("pageMaker",service.getQuetionPageMaker(cri));
		model.addAttribute("questionCount",service.questionCount());
		return "admin/serviceCenter"; 
	}
	
	@PatchMapping("sendAnswer/{qano}")
	public ResponseEntity<String> sendAnswer(
			@PathVariable("qano") int qano,
			@RequestBody AnswerCommentVO answerCommentVO
			) throws Exception{
		ResponseEntity<String> entity = null;
		answerCommentVO.setQano(qano);
		System.out.println("con answer : " + answerCommentVO);
		try {
			service.sendAnswer(answerCommentVO);
			entity = new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;		
	}
	
	@GetMapping("advertise")
	public String advertisePage(
			@ModelAttribute("cri") SearchCriteria cri,
			HttpServletRequest request,
			Model model 
			) throws Exception{
		System.out.println("con getSearchType : " + cri.getSearchType());
		model.addAttribute("advertiseList",service.getAdvertiseList(cri));
		model.addAttribute("pageMaker",service.getAdvertisePageMaker(cri));
		model.addAttribute("advertiseTotal",service.advertiseTotalCount());
	    model.addAttribute("advertising",service.advertisingCount());
		model.addAttribute("waiting",service.watingApproved());
		model.addAttribute("deadline",service.getDeadline());
		 
		return "admin/advertise";
	}
	
	// 광고 신청 승인
	@PatchMapping(value="acceptAdvertise/{ano}",produces="text/json;charset=utf-8")
	public ResponseEntity<String> acceptAdvertise(
			@PathVariable("ano") int ano
			) throws Exception {
		ResponseEntity<String> entity = null;
		System.out.println("ano : " + ano);
		try {
			String message = service.acceptAdvertise(ano); 
			System.out.println("message : " + message);
			entity = new ResponseEntity<>(message,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	// 광고 신청 취소
	@DeleteMapping("deleteAdvertise/{ano}")
	public ResponseEntity<String> deleteAdvertise(
			@PathVariable("ano") int ano
			) throws Exception{
		ResponseEntity<String> entity = null;
		System.out.println("rgno : " + ano);
		try {
			service.deleteAdvertise(ano);
			entity = new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return entity;
	}
}
