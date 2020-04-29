package com.bomshop.www.review.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bomshop.www.review.service.ReviewService;

@RestController
@RequestMapping("/review/*")
public class ReviewController {
	
	@Inject
	ReviewService rs;
	
	@GetMapping("review/{gno}")
	public ResponseEntity<Map<String, Object>> allList(
				@PathVariable("gno") int gno
			) throws Exception{
		
		// 상품에 등록된 전체 리뷰 받아오기
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<>();
		
		try {
			// 전체 목록
			map.put("allList", rs.allList(gno));
			map.put("pList",rs.pList(gno));
			map.put("tList",rs.tList(gno));
			map.put("reviewCnt", rs.reviewCnt(gno));
			map.put("pCount", rs.pCount(gno));
			map.put("tCount", rs.tCount(gno));
			entity = new ResponseEntity<>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

}
