package com.bomshop.www.qna.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bomshop.www.qna.service.QnAService;
import com.bomshop.www.qna.vo.QnA_goodsVO;

@Controller
@RequestMapping("/qna/*")
public class QnAController {
	
	@Inject
	QnAService qs;
	
	@GetMapping("/{gno}/{page}")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> qnaList(
				@PathVariable("gno") int gno,
				@PathVariable("page") int page
			) throws Exception{
		ResponseEntity<Map<String, Object>> entity = null;
		
		try {
			Map<String, Object> map = qs.qnaList(gno,page);
			entity = new ResponseEntity<>(map,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@GetMapping("/display/{qno}")
	@ResponseBody
	public List<String> display(
				@PathVariable("qno") int qno
			) throws Exception{
		System.out.println("img qno : "+qno);
		return qs.display(qno);
	}
	
	@PostMapping("/regist")
	public String regist(
				QnA_goodsVO vo
			) throws Exception {
		
		System.out.println("qnaVO : "+vo);
		System.out.println("qnaVO.gno : "+vo.getGno());
		System.out.println("img1 : "+vo.getImg1());
		System.out.println("img2 : "+vo.getImg2());
		
		if(vo.getSec_status() == null) {
			vo.setSec_status("N");
			System.out.println("sec_status : "+vo.getSec_status());
		}
		qs.regist(vo);
		
		return "redirect:/goods/detail?gno="+vo.getGno();
	}
	

}
