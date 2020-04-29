package com.bomshop.www.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bomshop.www.common.util.MailUtil;
import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.member.service.MemberService;
import com.bomshop.www.member.service.MypageService;
import com.bomshop.www.member.vo.QnaAdminVO;
import com.bomshop.www.member.vo.QnaGoodsVO;
import com.bomshop.www.member.vo.ReviewVO;

@Controller
@RequestMapping("**/customerService/**")
public class CustomerServiceController {
	
	@Inject
	MypageService service;
	
	@Inject
	MemberService mService;
	
	@Inject
	MailUtil mu;
	
	@GetMapping("/main")
	public String customer_service_main() {
		return "customer_service/customer_service_main";
	}
	
	@GetMapping("/customer_service_main")
	public String customer_service_mainGet() {
		return "customer_service/customer_service_main";
	}
	
	@PostMapping("FAQpage1")
	public String FAQpage1() throws Exception{
		return "customer_service/FAQ1";
	}
	
	@PostMapping("FAQpage2")
	public String FAQpage2() throws Exception{
		return "customer_service/FAQ2";
	}
	
	@PostMapping("FAQpage3")
	public String FAQpage3() throws Exception{
		return "customer_service/FAQ3";
	}
	
	@PostMapping("FAQpageall")
	public String FAQpageall() throws Exception{
		return "customer_service/FAQall";
	}
	
	@PostMapping("qnaAdminRegistPage")
	public String qnaAdminRegistPage() throws Exception{
		return "customer_service/QnaAdminRegist";
	}
	
	@GetMapping("FAQ1")
	public String FAQ1() {return "customer_service/FAQ1";}
	
	@GetMapping("FAQ2")
	public String FAQ2() {return "customer_service/FAQ2";}
	
	@GetMapping("FAQ3")
	public String FAQ3() {return "customer_service/FAQ3";}
	
	@GetMapping("FAQall")
	public String FAQall() {return "customer_service/FAQall";}
	
	@GetMapping("QnaAdminRegist")
	public String QnaAdminRegist() {return "customer_service/QnaAdminRegist";}
	
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
	
	@PostMapping("/qnaAdminRegist")
	public String qnaAdminRegist(QnaAdminVO vo) throws Exception{
		System.out.println(vo);
		service.registQnaAdmin(vo);
		return "redirect:/customerService/customer_service_main";
	}
	
	@GetMapping(value="/mailFindSend",produces = "application/text; charset=utf8")
	@ResponseBody
	public String sendMail(String email) {
		try {
			String tempString = mu.getRandomString();
			service.setMailFindCode(email,tempString);
			System.out.println(tempString + "..........");
			mu.sendMail(email, "BOMSHOP 임시 코드입니다.",tempString);
			return "인증코드가 발송되었습니다.";
		}catch(Exception e){
			e.printStackTrace();
			return "인증코드 발송에 실패하였습니다.";
		}
	}
	
	@GetMapping("/getMailFindCode")
	@ResponseBody
	public Map<String,Object> getMailCode(String email) throws Exception{
		Map<String,Object> map = new HashMap<>();
		String code = service.getMailFindCode(email);
		System.out.println("code : " + code);
		String id = mService.findMemberID(email);
		map.put("code",code);
		map.put("memberID",id);
		return map;
	}
}
