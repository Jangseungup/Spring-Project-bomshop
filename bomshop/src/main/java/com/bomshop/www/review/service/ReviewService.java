package com.bomshop.www.review.service;

import java.util.List;

import com.bomshop.www.review.vo.ReviewVO;

public interface ReviewService {
	
	// 목록 불러오기
	List<ReviewVO> allList(int gno) throws Exception;
	
	// 포토리뷰 목록
	List<ReviewVO> pList(int gno) throws Exception;
	
	// 텍스트 리뷰 목록
	List<ReviewVO> tList(int gno) throws Exception;
	
	// 전체 리뷰 개수
	int reviewCnt(int gno) throws Exception;
	
	// 포토 리뷰 개수
	int pCount(int gno) throws Exception;
	
	// 텍스트 리뷰 개수
	int tCount(int gno) throws Exception;

}
