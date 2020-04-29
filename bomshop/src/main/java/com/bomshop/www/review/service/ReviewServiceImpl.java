package com.bomshop.www.review.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bomshop.www.review.dao.ReviewDAO;
import com.bomshop.www.review.vo.ReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Inject
	ReviewDAO dao;

	// 전체 목록
	@Override
	public List<ReviewVO> allList(int gno) throws Exception {
		return dao.allList(gno);
	}

	// 포토리뷰 목록
	@Override
	public List<ReviewVO> pList(int gno) throws Exception {
		return dao.pList(gno);
	}

	// 텍스트 리뷰 목록
	@Override
	public List<ReviewVO> tList(int gno) throws Exception {
		return dao.tList(gno);
	}

	// 전체 개수
	@Override
	public int reviewCnt(int gno) throws Exception {
		return dao.reviewCnt(gno);
	}

	// 포토리뷰 개수
	@Override
	public int pCount(int gno) throws Exception {
		return dao.pCount(gno);
	}

	// 텍스트 리뷰 개수
	@Override
	public int tCount(int gno) throws Exception {
		return dao.tCount(gno);
	}
	
	
	
	

}
