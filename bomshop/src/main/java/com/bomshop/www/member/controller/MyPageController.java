package com.bomshop.www.member.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bomshop.www.common.util.Criteria;
import com.bomshop.www.common.util.FileUtils;
import com.bomshop.www.common.util.MailUtil;
import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.member.service.MemberService;
import com.bomshop.www.member.service.MypageService;
import com.bomshop.www.member.vo.CouponDTO;
import com.bomshop.www.member.vo.CouponVO;
import com.bomshop.www.member.vo.DeliveryCountDTO;
import com.bomshop.www.member.vo.GoodsVO;
import com.bomshop.www.member.vo.MemberAddressVO;
import com.bomshop.www.member.vo.MemberCouponVO;
import com.bomshop.www.member.vo.OrderComDTO;
import com.bomshop.www.member.vo.OrderDeliveryDTO;
import com.bomshop.www.member.vo.OrderNonDTO;
import com.bomshop.www.member.vo.OrderNonVO;
import com.bomshop.www.member.vo.QnaAdminVO;
import com.bomshop.www.member.vo.QnaGoodsVO;
import com.bomshop.www.member.vo.ReviewVO;

@Controller
@RequestMapping("**/mypage/**")
public class MyPageController {

	@Inject
	MypageService service;
	
	@Inject
	MemberService mService;
	
	@Inject
	MailUtil mu;
	
	@Inject
	HttpSession session;
	
	@Resource(name="uploadPath")
	String uploadPath;
	
	@Resource(name="uploadFolder")
	String uploadFolder;
	
	@Inject
	ServletContext context;
	
	@GetMapping("/main")
	public String mypageMainGet(Model model, HttpSession session) throws Exception{
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		session.setAttribute("memberInfo", mService.getMember(member.getMno()));
		int couponCnt = service.couponCnt(member.getMno());
		model.addAttribute("couponCnt", couponCnt);
		return "mypage/mypage_main";
	}
	
	@GetMapping("/getPageList")
	@ResponseBody
	public List<CouponDTO> getPageList(int page, HttpSession session) throws Exception{
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		Criteria cri = new Criteria(page,5);
		List<CouponDTO> list = new ArrayList<>();
		List<MemberCouponVO> couponList = service.getMemberCouponList(member.getMno(),cri);
		
		for(MemberCouponVO vo : couponList) {
			CouponDTO dto = new CouponDTO();
			CouponVO coupon = new CouponVO();
			coupon = service.getCouponeInfo(vo.getCno());
			dto.setCno(coupon.getCno());
			dto.setMno(member.getMno());
			dto.setCoupon_code(coupon.getCoupon_code());
			dto.setCname(coupon.getCname());
			dto.setSale(coupon.getSale());
			dto.setClimit(coupon.getClimit());
			dto.setCdate(vo.getCdate());
			dto.setCheck_use(vo.getCheck_use());
			list.add(dto);
		}
		
		return list;
	}
	
	@GetMapping("getPageMaker")
	@ResponseBody
	public PageMaker getPageMaker(int page,HttpSession session) throws Exception{
		Criteria cri = new Criteria(page,5);
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		PageMaker pm = service.getPageMaker(member.getMno(), cri);
		return pm;
	}
	// mypage 화면 전환 요청-----------------------
	@PostMapping("/memberGradePage")
	public String memberGradePage() {
		return "mypage/memberGradePage";
	}
	
	@PostMapping("/memberCashPage")
	public String memberCashPage() {
		return "mypage/memberCashPage";
	}
	
	@GetMapping("/memberCashPage")
	public String memberCashPageGet() {
		return "mypage/memberCashPage";
	}
	
	@PostMapping("/memberPointPage")
	public String memberPointPage() {
		return "mypage/memberPointPage";
	}
	
	// 쿠폰 페이지
	@PostMapping("/memberCouponPage")
	public String memberCouponPage(Model model, HttpSession session) throws Exception{
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		System.out.println(member);
		
		// 쿠폰 총 개수
		int couponCnt = service.couponCnt(member.getMno());
		model.addAttribute("couponCnt", couponCnt);
		
		// 쿠폰 리스트
		Criteria cri = new Criteria(1,5);
		List<CouponDTO> list = new ArrayList<>();
		List<MemberCouponVO> couponList = service.getMemberCouponList(member.getMno(),cri);
		
		for(MemberCouponVO vo : couponList) {
			CouponDTO dto = new CouponDTO();
			CouponVO coupon = new CouponVO();
			coupon = service.getCouponeInfo(vo.getCno());
			dto.setCno(coupon.getCno());
			dto.setMno(member.getMno());
			dto.setCoupon_code(coupon.getCoupon_code());
			dto.setCname(coupon.getCname());
			dto.setSale(coupon.getSale());
			dto.setClimit(coupon.getClimit());
			dto.setCdate(vo.getCdate());
			dto.setCheck_use(vo.getCheck_use());
			list.add(dto);
		}
		model.addAttribute("couponList", list);
		model.addAttribute("pageMaker", service.getPageMaker(member.getMno(),cri));
		return "mypage/memberCouponPage";
	}
	
	// 구매내역 페이지
	@PostMapping("/purchaseListPage")
	public String purchaseListPage(Model model,HttpSession session) throws Exception{
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		List<OrderComDTO> list = service.getOrderComList(member.getMno());
		model.addAttribute("purchaseList", list);
		return "mypage/purchaseListPage";
	}
	
	// 구매내역 ( 전체, 7일, 15일, 30일 ) 리스트
	@GetMapping("purchaseListAll")
	@ResponseBody
	public List<OrderComDTO> purchaseListAll(HttpSession session) throws Exception{
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		List<OrderComDTO> list = service.getOrderComListAjax(member.getMno(),"ALL");
		return list;
	}
	
	@GetMapping("purchaseList7d")
	@ResponseBody
	public List<OrderComDTO> purchaseList7d(HttpSession session) throws Exception{
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		List<OrderComDTO> list = service.getOrderComListAjax(member.getMno(),"purchaseList7d");
		return list;
	}
	
	@GetMapping("purchaseList15d")
	@ResponseBody
	public List<OrderComDTO> purchaseList15d(HttpSession session) throws Exception{
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		List<OrderComDTO> list = service.getOrderComListAjax(member.getMno(),"purchaseList15d");
		return list;
	}
	
	@GetMapping("purchaseList30d")
	@ResponseBody
	public List<OrderComDTO> purchaseList30d(HttpSession session) throws Exception{
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		List<OrderComDTO> list = service.getOrderComListAjax(member.getMno(),"purchaseList30d");
		return list;
	}
	
	@PostMapping("/orderDeliveryPage")
	public String orderDeliveryPage(Model model,HttpSession session) throws Exception{
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		DeliveryCountDTO countDTO = service.getDeliveryCount(member.getMno());
		model.addAttribute("deliveryCntVO", countDTO);
		return "mypage/orderDeliveryPage";
	}
	
	@GetMapping("/orderDeliveryCnt")
	@ResponseBody
	public DeliveryCountDTO orderDeliveryCnt(HttpSession session) throws Exception{
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		DeliveryCountDTO countDTO = service.getDeliveryCount(member.getMno());
		return countDTO;
	}
	
	@PostMapping(value="/refundSetReason",produces = "application/text; charset=utf8")
	@ResponseBody
	public String refundSetReason(int status_reason, int orderno) throws Exception{
		String result = service.refundSetReason(orderno,status_reason);
		return result;
	}
	
	@PostMapping(value="/exchangeSetReason",produces = "application/text; charset=utf8")
	@ResponseBody
	public String exchangeSetReason(int status_reason, int orderno) throws Exception{
		String result = service.exchangeSetReason(orderno,status_reason);
		return result;
	}
	
	@PostMapping(value="/cancelTransaction" ,produces = "application/text; charset=utf8")
	@ResponseBody
	public String cancelTransaction(int orderno) throws Exception{
		String result = service.cancelTransaction(orderno);
		return result;
	}
	
	@PostMapping(value = "/purchaseComplete",produces = "application/text; charset=utf8")
	@ResponseBody
	public String purchaseComplete(ReviewVO vo,int orderno) throws Exception{
		String result = service.purchaseComplete(vo,orderno);
		return result;
	}
	
	@PostMapping(value="/noReviewPurchaseComplete",produces = "application/text; charset=utf8")
	@ResponseBody
	public String noReviewPurchaseComplete(int orderno, int mno) throws Exception{
		String result = service.noReviewPurchaseComplete(orderno,mno);
		return result;
	}
	
	@GetMapping("/getDeliveryList")
	@ResponseBody
	public List<OrderDeliveryDTO> getDeliveryList(HttpSession session,String type) throws Exception{
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		List<OrderDeliveryDTO> list = service.getOrderDeliveryDTO(member.getMno(),type);
		return list;
	}
	
	@PostMapping("/interestGoodsPage")
	public String interestGoodsPage(Model model, HttpSession session) throws Exception {
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		int likegoodsCnt = service.getLikeGoodsCnt(member.getMno());
		
		List<GoodsVO> likegoodsList = service.getLikeGoodsList(member.getMno());
		
		model.addAttribute("likegoodsList", likegoodsList);
		model.addAttribute("likegoodsCnt", likegoodsCnt);
		return "mypage/interestGoodsPage";
	}
	@PostMapping("/memberInfoExchangePage")
	public String memberInfoExchangePage(Model model,HttpSession session) throws Exception{
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		List<MemberAddressVO> addrList = mService.getAddrList(member.getMno());
		model.addAttribute("addrList", addrList);
		return "mypage/memberInfoExchangePage";
	}
	@PostMapping("/myQuestionReviewPage")
	public String myQuestionReviewPage() {
		return "mypage/myQuestionReviewPage";
	}
	
	@GetMapping("/myQuestionReviewPage")
	public String myQuestionReviewGetPage() {
		return "mypage/myQuestionReviewPage";
	}
	
	@PostMapping("/exchangeSellerPage")
	public String exchangeSellerPage() {
		return "mypage/exchangeSellerPage";
	}
	
	//-------------------------------------
	@PostMapping(value="/cashCharge",produces = "application/text; charset=utf8")
	@ResponseBody
	public String cashCharge(int cash, String mpw, HttpSession session) throws Exception{
		String message = "";
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		boolean pwCheck = service.passwordCheck(member.getMno(),mpw);
		if(pwCheck) {
			// 비밀번호 일치 시
			service.cashCharge(member.getMno(),cash);
			message = "충전 완료";
			session.setAttribute("memberInfo",mService.getUserById(member.getMid()));
		}else {
			message = "비밀번호가 일치하지 않습니다.";
		}
		return message;
	}
	
	@GetMapping(value="/mailSend",produces = "application/text; charset=utf8")
	@ResponseBody
	public String sendMail(@RequestParam HashMap<Object, Object> param) {
		try {
			MemberVO vo = (MemberVO)session.getAttribute("memberInfo");
			String tempString = mu.getRandomString();
			service.setMailCode(vo.getMno(),tempString);
			System.out.println(tempString + "..........");
			mu.sendMail(vo.getMemail(), "BOMSHOP 임시 코드입니다.",tempString);
			return "인증코드가 발송되었습니다.";
		}catch(Exception e){
			e.printStackTrace();
			return "인증코드 발송에 실패하였습니다.";
		}
	}
	
	@GetMapping("/getMailCode")
	@ResponseBody
	public String getMailCode(int mno) throws Exception{
		String code = service.getMailCode(mno);
		System.out.println("code : " + code);
		return code;
	}
	
	@GetMapping("/reviewImageUpload")
	public String reviewImageUpload() {
		return "reviewImageUpload";
	}
	@PostMapping(value="/reviewImageUpload", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadReviceImage(MultipartFile file,int gno) throws Exception{
		uploadPath = context.getRealPath(File.separator+uploadFolder);
		
		File projectFile = new File(context.getRealPath(File.separator+uploadFolder));
		if(!projectFile.exists()) {
			projectFile.mkdirs();
			System.out.println("경로 생성 완료");
		}else {
			System.out.println("경로 이미 존재");
		}
		return new ResponseEntity<String>(
				FileUtils.uploadReviewImage(file.getOriginalFilename(),gno, uploadPath, file.getBytes()),
				HttpStatus.OK
			);
	}
	@GetMapping("displayFile")
	public ResponseEntity<byte[]> displayFile(
			String fileName
			) throws Exception{
		return FileUtils.displayFile(uploadPath,fileName);
	}

	@PostMapping("deleteReviewImage")
	public ResponseEntity<String> deleteFile(
			String fileName
			) throws Exception{
		return FileUtils.deleteFile(uploadPath,fileName);
	}
	
	@PostMapping("exchangeSeller")
	public String exchangeSeller(MemberVO vo, String zipNo, String address1, String address2) throws Exception{
		vo.setShopaddr1(address1);
		vo.setShopaddr2(address2);
		vo.setShop_post_code(zipNo);
		mService.exchangeSeller(vo);
		return "mypage/exchangeSellerComplete";
	}
	
	@GetMapping("exchangeSellerComplete")
	public String exchangeSellerComplete(HttpSession session) throws Exception {
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		session.setAttribute("memberInfo", mService.getMember(member.getMno()));
		return "mypage/exchangeSellerComplete";
	}
	
	@GetMapping("/myquestionList")
	@ResponseBody
	public Map<String,Object> myquestionList(int page, int mno) throws Exception{
		Map<String,Object> map = new HashMap<>();
		List<QnaGoodsVO> list = service.getQnaGoodsList(mno,page);
		PageMaker pm = service.getQuestionPageMaker(mno,page);
		map.put("qList", list);
		map.put("pageMaker",pm);
		System.out.println(map);
		return map;
	}
	
	@GetMapping("/myreviewList")
	@ResponseBody
	public Map<String,Object> myreviewList(int page, int mno) throws Exception{
		Map<String,Object> map = new HashMap<>();
		List<ReviewVO> list = service.getReviewList(mno,page);
		PageMaker pm = service.getReviewPageMaker(mno,page);
		map.put("rList", list);
		map.put("pageMaker",pm);
		System.out.println(map);
		return map;
	}
	
	@GetMapping("/myquestionAdminList")
	@ResponseBody
	public Map<String,Object> myquestionAdminList(int page, int mno) throws Exception{
		Map<String, Object> map = new HashMap<>();
		List<QnaAdminVO> list =service.getQnaAdminList(mno,page);
		PageMaker pm = service.getQnaAdminPageMaker(mno,page);
		map.put("aList", list);
		map.put("pageMaker", pm);
		return map;
	}
	
	// 비회원 주문조회
		@GetMapping("/nonMemberOrderDeliveryPage")
		public String nonMemberOrderDeliveryPage() throws Exception{
			return "mypage/nonMemberOrderDeliveryPage";
		}
		
		@PostMapping("/nonMemberOrderCheck")
		public String nonMemberOrderCheck(OrderNonVO vo,Model model) throws Exception{
			List<OrderNonDTO> list = service.getOrderNonDTOByNonMember(vo.getOrderno(),vo.getOrder_email(),vo.getOrder_phone());
			model.addAttribute("orderNonList", list);
			return "mypage/nonMemberOrderDeliveryListPage";
		}
		
		@GetMapping("/nonMemberOrderCheck")
		public String nonMemberOrderCheckGet(OrderNonVO vo,Model model) throws Exception{
			List<OrderNonDTO> list = service.getOrderNonDTOByNonMember(vo.getOrderno(),vo.getOrder_email(),vo.getOrder_phone());
			model.addAttribute("orderNonList", list);
			return "mypage/nonMemberOrderDeliveryListPage";
		}
		
		
		@PostMapping( value="/couponCodeInput", produces="text/plain;charset=UTF-8")
		@ResponseBody
		public String couponCodeInput(int mno, String coupon_code) throws Exception{
			String result = service.addCouponCode(mno,coupon_code);
			return result;
		}
}
