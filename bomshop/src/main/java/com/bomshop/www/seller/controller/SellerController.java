package com.bomshop.www.seller.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.compress.utils.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.common.util.SellerFileUpload;
import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.seller.dto.OrderDTO;
import com.bomshop.www.seller.dto.QnAGoodsDTO;
import com.bomshop.www.seller.dto.WithdrawDTO;
import com.bomshop.www.seller.service.SellerAdvertisingManageService;
import com.bomshop.www.seller.service.SellerClaimManageService;
import com.bomshop.www.seller.service.SellerCustomerManageService;
import com.bomshop.www.seller.service.SellerGoodsManageService;
import com.bomshop.www.seller.service.SellerMainService;
import com.bomshop.www.seller.service.SellerOrderManageService;
import com.bomshop.www.seller.service.SellerSettlementMemberService;
import com.bomshop.www.seller.vo.BanListVO;
import com.bomshop.www.seller.vo.GoodsOptionVO;
import com.bomshop.www.seller.vo.GoodsVO;
import com.bomshop.www.seller.vo.OrderVO;
import com.bomshop.www.seller.vo.QnAAdminVO;
import com.bomshop.www.seller.vo.QnAGoodsVO;
import com.google.gson.JsonObject;

@Controller
@RequestMapping("seller")
public class SellerController {
	
	@Inject
	SellerMainService sellerMainService;
	
	@Inject
	SellerGoodsManageService sellerGoodsManageService;
	
	@Inject
	SellerOrderManageService sellerOrderManageService; 
	
	@Inject
	SellerClaimManageService sellerClaimManageService;
	
	@Inject
	SellerSettlementMemberService sellerSettlementMemberService;
	
	@Inject
	SellerAdvertisingManageService sellerAdvertisingManageService;
	
	@Inject
	SellerCustomerManageService sellerCustomerManageService; 
	
	@Autowired
	ServletContext context;
	
	//	seller_main 페이지
	@GetMapping("/")
	public String sellerHome(@SessionAttribute("memberInfo") MemberVO memberInfo, Model model) throws Exception{
		System.out.println("판매자 메인 페이지");
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		//	날짜 정보 출력
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		model.addAttribute("today", sdf.format(new Date()));
		
		//	오늘의 주문 정보(미확인주문, 오늘주문)
		model.addAttribute("unconfirmedOrderCount", sellerMainService.getUnconfirmedOrderCount(mno));
		model.addAttribute("todayOrderCount", sellerOrderManageService.getTodayOrderCount(mno));
		
		//	판매 현황(발송예정, 배송중, 반품요청, 교환요청, 취소요청, 질문미답변, 신규리뷰)
		model.addAttribute("awaitingDeliveryCount", sellerOrderManageService.getAwaitingDeliveryCount(mno));
		model.addAttribute("shippingCount", sellerOrderManageService.getShippingCount(mno));
		model.addAttribute("requestRefundCount", sellerClaimManageService.getRequestRefundCount(mno));
		model.addAttribute("requestExchangeCount", sellerClaimManageService.getRequestExchangeCount(mno));
		model.addAttribute("requestCancelCount", sellerClaimManageService.getRequestCancelCount(mno));
		model.addAttribute("newQuestionCount", sellerCustomerManageService.getNewQuestionCount(mno));
		model.addAttribute("latestReviewsCount", sellerCustomerManageService.getLatestReviewsCount(mno));
		
		//	나의 상품 정보(재고10개이하, 7일이내 판매중지, 광고등록대기, 광고 마감 7일전) 
		model.addAttribute("soldOutCount", sellerGoodsManageService.getSoldOutCount(mno));
		model.addAttribute("goodsExpirationCount", sellerGoodsManageService.getGoodsExpirationCount(mno));
		model.addAttribute("awaitingAdvertisingCount", sellerAdvertisingManageService.getAwaitingAdvertisingCount(mno));
		model.addAttribute("advertisingEndCount", sellerAdvertisingManageService.getAdvertisingEndCount(mno));
		
		return "seller/seller_main";
	}
	

	/*
	 *	seller_privacy 페이지(판매자 정보)
	 */
	@GetMapping("/privacy")
	public String privacy(@SessionAttribute("memberInfo") MemberVO memberInfo, Model model) throws Exception{
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		//	임시로 가져옴(이미 세션에 이썽야 함)
		model.addAttribute("memberInfo",sellerMainService.getMemberInfo(mno));
		return "seller/seller_privacy";
	}
	@GetMapping("/privacyModify")
	public String privacyModify(@SessionAttribute("memberInfo") MemberVO memberInfo, Model model) throws Exception{
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		//	임시로 가져옴(이미 세션에 이썽야 함)
		model.addAttribute("memberInfo",sellerMainService.getMemberInfo(mno));
		return "seller/seller_privacy_modify";
	}
	@PostMapping("/privacyModify")
	public String privacyModifyPost(@SessionAttribute("memberInfo") MemberVO memberInfo, MemberVO vo, Model model) throws Exception{
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		vo.setMno(mno);
		sellerMainService.privacyModify(vo);
		return "v";
	}
	
	/*
	 *	service_center 페이지
	 */
	@GetMapping("/service_center")
	public String serviceCenter(@SessionAttribute("memberInfo") MemberVO memberInfo,
					@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		model.addAttribute("qnaList", sellerMainService.getQnAList(cri, mno));
		model.addAttribute("pageMaker", sellerMainService.getQnAPageMaker(cri, mno));
		return "seller/seller_service_center";
	}
	//	문의하기 상세보기
	@GetMapping("/qnaDetail")
	public String qnaDetail(int qano, Model model) {
		model.addAttribute("qna", sellerMainService.getQnA(qano));
		model.addAttribute("comment", sellerMainService.getComment(qano));
		return "seller/seller_qna_detail";
	}
	//	문의하기 페이지
	@GetMapping("/addQuestion")
	public String addQuestion() throws Exception{
 		return "seller/seller_add_question";
	}
	//	문의하기 작성
	@PostMapping("/addQuestion")
	public String addQuestion(@SessionAttribute("memberInfo") MemberVO memberInfo, QnAAdminVO vo) throws Exception{
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		vo.setMno(mno);
		sellerMainService.addQuestion(vo);
		return "redirect:/seller/service_center";
	}
	
	
	/*
	 *	seller_goods_regist 페이지
	 */
	@GetMapping("/register")
	public String register(@SessionAttribute("memberInfo") MemberVO memberInfo) throws Exception{
		return "seller/seller_goods_regist";
	}
	//	상품 등록
	@PostMapping("/goodsRegister")
	public String goodsRegister(@SessionAttribute("memberInfo") MemberVO memberInfo,
			GoodsVO goods, String[] color, String[] size, int[] count, MultipartFile mainImg, MultipartFile[] subImg,
			RedirectAttributes rttr) throws Exception{
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		List<GoodsOptionVO> list = new ArrayList<>();
		for(int i=0; i<color.length; i++) {
			GoodsOptionVO vo = new GoodsOptionVO();
			vo.setColor(color[i]);
			vo.setSize(size[i]);
			vo.setCount(count[i]);
			list.add(vo);
		}
		sellerMainService.goodsRegister(mno, goods, list, mainImg, subImg);
		rttr.addFlashAttribute("message", "상품 등록이 완료되었습니다.");
		return "redirect:/seller/goods_manage";
	}
	//	상품 상세 정보 사진 업로드
	@PostMapping("/uploadDetail")
	@ResponseBody
	public String fileUpload(HttpServletRequest req, HttpServletResponse resp, 
                 MultipartFile upload) throws Exception {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=utf-8");
		JsonObject json = new JsonObject();
		PrintWriter printWriter = null;
		OutputStream out = null;
		if(upload != null){
			if(upload.getSize() > 0 && !StringUtils.isEmpty(upload.getName())){
				if(upload.getContentType().toLowerCase().startsWith("image/")){
					try{
						String fileName = upload.getOriginalFilename();
						byte[] bytes = upload.getBytes();
						String uploadPath = req.getServletContext().getRealPath("/upload");
						File uploadFile = new File(uploadPath);
						if(!uploadFile.exists()){
							uploadFile.mkdirs();
						}
						String temp = UUID.randomUUID().toString().substring(0, 8);
						fileName = temp + "_" + fileName;
						sellerMainService.addTempImg(fileName);
						uploadPath = uploadPath + "/" + fileName;
						out = new FileOutputStream(new File(uploadPath));
                        out.write(bytes);
                        
                        printWriter = resp.getWriter();
                        resp.setContentType("text/html");
                        String fileUrl = req.getContextPath() + "/upload/" + fileName;
                        System.out.println(fileUrl);
                        
                        // json 데이터로 등록
                        // {"uploaded" : 1, "fileName" : "test.jpg", "url" : "/img/test.jpg"}
                        // 이런 형태로 리턴이 나가야함.
                        json.addProperty("uploaded", 1);
                        json.addProperty("fileName", fileName);
                        json.addProperty("url", fileUrl);
                        
                        printWriter.println(json);
                    }catch(IOException e){
                        e.printStackTrace();
                    }finally{
                        if(out != null){
                            out.close();
                        }
                        if(printWriter != null){
                            printWriter.close();
                        }		
					}
				}
			}
		}
		return null;
	}	
	
	/*
	 *	seller_goods_manage	페이지
	 */
	@GetMapping("/goods_manage")
	public String goods_manage(@SessionAttribute("memberInfo") MemberVO memberInfo,
							@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		System.out.println("상품 관리 페이지");
		//	판매자 회원번호
		int mno = memberInfo.getMno();

		//	상품관리 정보(전체, 판매중, 재고10개이하, 판매종료7일전, 판매중지)
		model.addAttribute("totalGoodsCount", sellerGoodsManageService.getTotalGoodsCount(mno));
		model.addAttribute("salesCount", sellerGoodsManageService.getSalesCount(mno));
		model.addAttribute("soldOutCount", sellerGoodsManageService.getSoldOutCount(mno));
		model.addAttribute("goodsExpirationCount", sellerGoodsManageService.getGoodsExpirationCount(mno));
		model.addAttribute("discontinuedCount", sellerGoodsManageService.getDiscontinuedCount(mno));
		
		//	상품 리스트
		model.addAttribute("goodsList", sellerGoodsManageService.getGoodsList(cri, mno));
		model.addAttribute("pageMaker", sellerGoodsManageService.getGoodsManagePageMaker(cri, mno));
		model.addAttribute("subTitle", sellerGoodsManageService.getGoodsManageSubTitle(cri));
		
		return "seller/seller_goods_manage";
	}
	//	상태 변경
	@PostMapping("/changeStatus")
	public String changeStatus(int gno, String gstatusValue, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		sellerGoodsManageService.changeStatus(gno,gstatusValue);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		return "redirect:/seller/goods_manage";
	}
	//	기간 변경
	@PostMapping("/extendSdate")
	public String extendSdate(int gno, int addDate, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		sellerGoodsManageService.extendSdate(gno,addDate);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		return "redirect:/seller/goods_manage";
	}
	//	상품 옵션 불러오기
	@GetMapping("/getOptionList/{gno}")
	public ResponseEntity<Map<String, Object>> getOptionList(@PathVariable("gno") int gno) throws Exception{
		ResponseEntity<Map<String, Object>> entity = null;
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", sellerGoodsManageService.getOptionList(gno));

		try {
			entity = new ResponseEntity<>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	//	재고수량 수정
	@PostMapping("/countChange")
	public String countChange(int gno, int[] ono, String[] size, String[] color, int[] count,
				SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		List<GoodsOptionVO> list = new ArrayList<>();
		for(int i=0; i<ono.length; i++) {
			GoodsOptionVO vo = new GoodsOptionVO();
			vo.setOno(ono[i]);
			vo.setGno(gno);
			vo.setSize(size[i]);
			vo.setColor(color[i]);
			vo.setCount(count[i]);
			list.add(vo);
		}
		sellerGoodsManageService.countChange(list);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		
		return "redirect:/seller/goods_manage";
	}
	//	상품 삭제
	@PostMapping("/removeGoods")
	public String removeGoods(int gno, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		sellerGoodsManageService.removeGoods(gno);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		return "redirect:/seller/goods_manage";
	}
	//	
	@GetMapping("/goodsModify")
	public String goodsModify(int gno, Model model, @ModelAttribute("cri") SearchCriteria cri) throws Exception{
		model.addAttribute("goods", sellerGoodsManageService.getGoodsByGno(gno));
		return "seller/seller_goods_modify";
	}
	@PostMapping("/goodsModify")
	public String goodsModify(GoodsVO vo)throws Exception{
		sellerGoodsManageService.goodsModify(vo);
		return "redirect:/seller/goods_manage";
	}
	
	/*
	 *	seller_order_manage 페이지
	 */
	@GetMapping("/order_manage")
	public String order_manage(@SessionAttribute("memberInfo") MemberVO memberInfo,
			@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		System.out.println("주문 관리 페이지");
		//	판매자 회원번호
		int mno = memberInfo.getMno();

		//	상품관리 정보(전체, 오늘 주문된 상품, 발송대기 상품, 배송중, 배송완료)
		model.addAttribute("totalOrderCount", sellerOrderManageService.getTotalOrderCount(mno));
		model.addAttribute("todayOrderCount", sellerOrderManageService.getTodayOrderCount(mno));
		model.addAttribute("awaitingDeliveryCount", sellerOrderManageService.getAwaitingDeliveryCount(mno));
		model.addAttribute("shippingCount", sellerOrderManageService.getShippingCount(mno));
		model.addAttribute("completedCount", sellerOrderManageService.getCompletedCount(mno));
		
		//	주문 리스트
		model.addAttribute("orderList", sellerOrderManageService.gerOrderList(cri, mno));
		model.addAttribute("pageMaker", sellerOrderManageService.getOrderManagePageMaker(cri, mno));
		model.addAttribute("subTitle", sellerOrderManageService.getOrderManageSubTitle(cri));
		
		//	주문 미확인 -> 확인 변경
		sellerOrderManageService.orderConfirm(mno);
		
		return "seller/seller_order_manage";
	}
	//	개별 주문 정보 가져오기
	@GetMapping("/getDetailOrderInfo/{orderno}")
	public ResponseEntity<OrderDTO> claim_manage(@PathVariable("orderno") int orderno) throws Exception{
		ResponseEntity<OrderDTO> entity = null;
		try {
			entity = new ResponseEntity<>(sellerOrderManageService.getOrderDTO(orderno), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	//	주문 배송지 정보 변경
	@PostMapping("/changeInfo")
	public String changeInfo(OrderVO vo, SearchCriteria cri, RedirectAttributes rttr)throws Exception{
		sellerOrderManageService.changeInfo(vo);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		return "redirect:/seller/order_manage";
	}
	//	주문 배송 시작
	@PostMapping("/startDelivery")
	public String startDelivery(int orderno, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		sellerOrderManageService.startDelivery(orderno);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		return "redirect:/seller/order_manage";
	}
	//	주문 배송 취소
	@PostMapping("/sendCancel")
	public String sendCancel(int orderno, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		sellerOrderManageService.sendCancel(orderno);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		return "redirect:/seller/order_manage";
	}
	//	주문 취소
	@PostMapping("/cancelOrder")
	public String cancelOrder(int orderno, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		sellerOrderManageService.cancelOrder(orderno);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		return "redirect:/seller/order_manage";
	}
	
	/*
	 *	seller_claim_manage 페이지
	 */
	@GetMapping("/claim_manage")
	public String claim_manage(@SessionAttribute("memberInfo") MemberVO memberInfo,
			@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		System.out.println("클레임 관리 페이지");
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		
		//	클레임관리 정보(전체, 반품요청, 교환요청, 취소요청)
		model.addAttribute("totalClaimCount", sellerClaimManageService.getTotalClaimCount(mno));
		model.addAttribute("requestRefundCount", sellerClaimManageService.getRequestRefundCount(mno));
		model.addAttribute("requestExchangeCount", sellerClaimManageService.getRequestExchangeCount(mno));
		model.addAttribute("requestCancelCount", sellerClaimManageService.getRequestCancelCount(mno));
		model.addAttribute("returningCount", sellerClaimManageService.getReturningCount(mno));
		model.addAttribute("inExchangeCount", sellerClaimManageService.getInExchangeCount(mno));
		
		//	클레임 리스트
		model.addAttribute("claimList", sellerClaimManageService.getClaimList(cri, mno));
		model.addAttribute("pageMaker", sellerClaimManageService.getClaimManagePageMaker(cri, mno));
		model.addAttribute("subTitle", sellerClaimManageService.getClaimManageSubTitle(cri));
		
		return "seller/seller_claim_manage";
	}
	@PostMapping("/refusal")
	public String refusal(int orderno, String rcontent, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		sellerClaimManageService.refusal(orderno, rcontent);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		return "redirect:/seller/claim_manage";
	}
	@PostMapping("/processingCompleted")
	public String processingCompleted(int orderno, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		sellerClaimManageService.processingCompleted(orderno);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		return "redirect:/seller/claim_manage";
	}
	
	/*
	 *	seller_settlement_manage 페이지
	 */
	@GetMapping("/settlement_manage")
	public String settlement_manage(@SessionAttribute("memberInfo") MemberVO memberInfo,
			@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		System.out.println("정산 관리 페이지");
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		
		//	임시로 가져옴(이미 세션에 있어야 함)
//		model.addAttribute("memberInfo",sellerMainService.getMemberInfo(mno));
		
		//	클레임관리 정보(전체, 반품요청, 교환요청, 취소요청)
		int unsettledCount = sellerSettlementMemberService.getUnsettledCount(mno);
		model.addAttribute("unsettledCount", unsettledCount);
		if(unsettledCount == 0) {
			model.addAttribute("unsettledAmount", 0);
		}else {
			model.addAttribute("unsettledAmount", sellerSettlementMemberService.getUnsettledAmount(mno));
		}
		model.addAttribute("holdingAmount", sellerSettlementMemberService.getHoldingAmount(mno));
		
		//	클레임 리스트
		model.addAttribute("settlementList", sellerSettlementMemberService.getSettlementList(cri, mno));
		model.addAttribute("pageMaker", sellerSettlementMemberService.getSettlementManagePageMaker(cri, mno));
		
		return "seller/seller_settlement_manage";
	}
	@PostMapping("/withdraw")
	public String withdraw(@SessionAttribute("memberInfo") MemberVO memberInfo,
			RedirectAttributes rttr, WithdrawDTO withdraw) throws Exception{
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		rttr.addFlashAttribute("withdrawMessage",sellerSettlementMemberService.withdraw(mno, withdraw));
		return "redirect:/seller/settlement_manage";
	}
	//	정산내역이 존재하는 월 리스트 가져오기
	@GetMapping("/settlementHistotyOpen")
	@ResponseBody
	public List<String> settlementHistotyOpen(@SessionAttribute("memberInfo") MemberVO memberInfo) throws Exception{
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		List<String> list = new ArrayList<>();
		//	존재하는 월 목록
		list = sellerSettlementMemberService.getMonthList(mno);
		return list;
	}
	//	선택한 월의 정산내역 리스트 불러오기
	@GetMapping("/getSettlementHistoty")
	@ResponseBody
	public Map<String, Object> getSettlementHistoty(@SessionAttribute("memberInfo") MemberVO memberInfo,
			@ModelAttribute("cri") SearchCriteria cri) throws Exception{
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		Map<String, Object> map = new HashMap<>();
		//	존재하는 월 목록
		System.out.println(cri);
		if(!cri.getSearchType().equals("none")) {
			map.put("totalAmount", sellerSettlementMemberService.getTotalAmount(cri, mno));
			map.put("historyList", sellerSettlementMemberService.getHistoryList(cri, mno));
			map.put("settlementPageMaker", sellerSettlementMemberService.getHistoryListPageMaker(cri, mno));
		}
		return map;
	}
	@GetMapping("downloadExcel")
	@ResponseBody
	public ResponseEntity<byte[]> downloadExcel(@SessionAttribute("memberInfo") MemberVO memberInfo,
			@ModelAttribute("cri") SearchCriteria cri) throws Exception{
		ResponseEntity<byte[]> entity = null;
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		String path = sellerSettlementMemberService.outputExcelFile(mno, cri);
		System.out.println(path);
		InputStream in = null;		
		HttpHeaders headers =null;
		try {
			File file = new File(path);
			System.out.println(file.length());
			headers = new HttpHeaders();
			in = new FileInputStream(file);
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			System.out.println("file : " + file.getName());
			headers.add("Content-disposition", "attachment;fileName=\""
					+ new String(file.getName().getBytes("UTF-8"),"ISO-8859-1")+"\"");
		} catch (Exception e) {
			e.printStackTrace();
		}
		entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),headers,HttpStatus.CREATED);
		return entity;
	}
	
	/*
	 *	seller_advertising_request 페이지
	 */
	@GetMapping("/advertising_request")
	public String advertising_request(@SessionAttribute("memberInfo") MemberVO memberInfo,
			@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		System.out.println("정산 관리 페이지");
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		
		//	상품관리 정보(전체, 광고중, 신청중, 광고종료 3일전)
		model.addAttribute("totalCount", sellerAdvertisingManageService.getTotalCount(mno));
		model.addAttribute("advertisingCount", sellerAdvertisingManageService.getAdvertisingCount(mno));
		model.addAttribute("awaitingAdvertisingCount", sellerAdvertisingManageService.getAwaitingAdvertisingCount(mno));
		model.addAttribute("advertisingEndCount", sellerAdvertisingManageService.getAdvertisingEndCount(mno));
		
		//	주문 리스트
		model.addAttribute("advertisingList", sellerAdvertisingManageService.gerAdvertisingList(cri, mno));
		model.addAttribute("pageMaker", sellerAdvertisingManageService.getAdvertisingManagePageMaker(cri, mno));
		model.addAttribute("subTitle", sellerAdvertisingManageService.getAdvertisingManageSubTitle(cri));
	
		return "seller/seller_advertising_request";
	}
	//	광고 신청용 상품 리스트
	@GetMapping("/getGoodsListForAD")
	@ResponseBody
	public Map<String, Object> getGoodsListForAD(@SessionAttribute("memberInfo") MemberVO memberInfo,
			@ModelAttribute("cri") SearchCriteria cri) throws Exception{
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		Map<String, Object> map = new HashMap<>();
		map.put("goodsList", sellerAdvertisingManageService.getGoodsListForAD(cri, mno));
		map.put("goodsListPageMaker", sellerAdvertisingManageService.getGoodsListForADPageMaker(cri, mno));
		
		return map;
	}
	//	광고 신청 취소
	@PostMapping("/cancelAD")
	public String cancelAD(int ano, int gno, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		String uploadPath = context.getRealPath(File.separator+"upload");
		System.out.println("uploadPath : " + uploadPath);
		SellerFileUpload.deleteADImg(gno, uploadPath);
		
		sellerAdvertisingManageService.cancelAD(ano);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		return "redirect:/seller/advertising_request";
	}
	//	광고 신청(광고 배너용 파일 업로드)
	@PostMapping("/applicationAD")
	public String applicationAD(MultipartFile file, int gno, SearchCriteria cri, RedirectAttributes rttr)throws Exception{
		String uploadPath = context.getRealPath(File.separator+"upload");
		
		if(SellerFileUpload.uploadAD(gno, uploadPath, file.getBytes())){
			sellerAdvertisingManageService.applicationAD(gno);
			rttr.addFlashAttribute("uploadMessage", "광고 신청을 완료하였습니다.");
		}else {
			rttr.addFlashAttribute("uploadMessage", "광고 신청에 실패하였습니다.");
		}
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		return "redirect:/seller/advertising_request";
	}
	
	/*
	 *	seller_customer_manage 페이지
	 */
	@GetMapping("/customer_manage")
	public String customer_manage(@SessionAttribute("memberInfo") MemberVO memberInfo,
			@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		System.out.println("정산 관리 페이지");
		//	판매자 회원번호
		int mno = memberInfo.getMno();
		
		//	상품관리 정보(신규문의, 최근리뷰, 단골고객)
		model.addAttribute("newQuestionCount", sellerCustomerManageService.getNewQuestionCount(mno));
		model.addAttribute("latestReviewsCount", sellerCustomerManageService.getLatestReviewsCount(mno));
		model.addAttribute("regularCustomerCount", sellerCustomerManageService.getRegularCustomerCount(mno));
		
		//	문의 / 리뷰 리스트
		if(cri.getSearchType() == null || cri.getSearchType().equals("question")) {
			cri.setSearchType("question");
			model.addAttribute("questionList", sellerCustomerManageService.getNewQuestionList(cri, mno));
		}else if(cri.getSearchType().equals("review")){
			model.addAttribute("reviewList", sellerCustomerManageService.getLatestReviewsList(cri, mno));
		}
		model.addAttribute("pageMaker", sellerCustomerManageService.getCustomerManagePageMaker(cri, mno));
		model.addAttribute("subTitle", sellerCustomerManageService.getCustomerManageSubTitle(cri));
		return "seller/seller_customer_manage";
	}
	//	문의내용 상세보기
	@GetMapping("/getQnAbyQno/{qno}")
	@ResponseBody
	public QnAGoodsDTO getQnAbyQno(@PathVariable("qno") int qno) throws Exception{
		return sellerCustomerManageService.getQnAbyQno(qno);
	}
	//	문의내용 답변하기
	@PostMapping("/answer")
	public String answer(@SessionAttribute("memberInfo") MemberVO memberInfo, QnAGoodsVO vo,
				SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		vo.setMno(memberInfo.getMno());
		sellerCustomerManageService.answer(vo);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		return "redirect:/seller/customer_manage";
	}
	//	상점 블랙리스트 추가
	@PostMapping("/addBlackList")
	public String addBlackList(@SessionAttribute("memberInfo") MemberVO memberInfo, BanListVO vo,
				SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		vo.setMno(memberInfo.getMno());
		sellerCustomerManageService.addBlackList(vo);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		return "redirect:/seller/customer_manage";
	}
	//	문의하기 답변거부
	@PostMapping("/rejectReply")
	public String rejectReply(int qno, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		sellerCustomerManageService.rejectReply(qno);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		return "redirect:/seller/customer_manage";
	}
	//
	@GetMapping("/getBlackList")
	@ResponseBody
	public Map<String, Object> getBlackList(@ModelAttribute("cri") SearchCriteria cri, @SessionAttribute("memberInfo") MemberVO memberInfo) throws Exception{
		int mno = memberInfo.getMno();
		Map<String, Object> map = new HashMap<>();
		map.put("banList", sellerCustomerManageService.getBlackList(cri, mno));
		map.put("banPageMaker", sellerCustomerManageService.getBanPageMaker(cri, mno));
		return map;
	}
}
