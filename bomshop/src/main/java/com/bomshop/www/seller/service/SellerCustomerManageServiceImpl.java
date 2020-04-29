package com.bomshop.www.seller.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.dao.SellerCustomerManageDAO;
import com.bomshop.www.seller.dto.QnAGoodsDTO;
import com.bomshop.www.seller.dto.ReviewDTO;
import com.bomshop.www.seller.vo.BanListVO;
import com.bomshop.www.seller.vo.QnAGoodsVO;
import com.bomshop.www.seller.vo.ReviewVO;
import com.mysql.fabric.xmlrpc.base.Array;

@Service
public class SellerCustomerManageServiceImpl implements SellerCustomerManageService{
	
	@Inject
	SellerCustomerManageDAO dao;

	@Override
	public int getNewQuestionCount(int mno)  throws Exception {
		return dao.getNewQuestionCount(mno);
	}

	@Override
	public int getLatestReviewsCount(int mno)  throws Exception {
		return dao.getLatestReviewsCount(mno);
	}

	@Override
	public int getRegularCustomerCount(int mno) throws Exception  {
		return dao.getRegularCustomerCount(mno);
	}

	@Override
	public List<QnAGoodsDTO> getNewQuestionList(SearchCriteria cri, int mno) throws Exception  {
		List<QnAGoodsVO> voList = dao.getNewQuestionList(cri, mno);
		List<QnAGoodsDTO> list = new ArrayList<>();
		for(QnAGoodsVO vo : voList) {
			QnAGoodsDTO dto = new QnAGoodsDTO();
			dto.setQna(vo);
			dto.setGname(dao.getGname(vo.getGno()));
			dto.setMid(dao.getMid(vo.getMno()));
			list.add(dto);
		}
		return list;
	}

	@Override
	public List<ReviewDTO> getLatestReviewsList(SearchCriteria cri, int mno) throws Exception  {
		List<ReviewVO> voList = dao.getLatestReviewsList(cri, mno);
		List<ReviewDTO> list = new ArrayList<>();
		for(ReviewVO vo : voList) {
			ReviewDTO dto = new ReviewDTO();
			dto.setReview(vo);
			dto.setGname(dao.getGname(vo.getGno()));
			dto.setMid(dao.getMid(vo.getMno()));
			list.add(dto);
		}
		return list;
	}

	@Override
	public PageMaker getCustomerManagePageMaker(SearchCriteria cri, int mno) throws Exception  {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		if(cri.getSearchType().equals("question")) {
			pageMaker.setTotalCount(dao.getNewQuestionCount(mno));
		}else if(cri.getSearchType().equals("review")) {
			pageMaker.setTotalCount(dao.getLatestReviewsCount(mno));
		}
		return pageMaker;
	}

	@Override
	public String getCustomerManageSubTitle(SearchCriteria cri) throws Exception  {
		String subTitle = "";
		if(cri.getSearchType().equals("question")) {
			subTitle = "신규 문의";
		}else if(cri.getSearchType().equals("review")) {
			subTitle = "신규 리뷰";
		}
		return subTitle;
	}

	@Override
	public QnAGoodsDTO getQnAbyQno(int qno)  throws Exception {
		QnAGoodsDTO dto = new QnAGoodsDTO();
		QnAGoodsVO vo = dao.getQnAbyQno(qno); 
		dto.setQna(vo);
		dto.setGname(dao.getGname(vo.getGno()));
		dto.setMid(dao.getMid(vo.getMno()));
		return dto;
	}

	@Override
	@Transactional
	public void answer(QnAGoodsVO vo) throws Exception {
		dao.answer(vo);
		dao.ckeckAnswer(vo.getQno());
	}

	@Override
	public void addBlackList(BanListVO vo) {
		dao.addBlackList(vo);
	}

	@Override
	public void rejectReply(int qno) throws Exception {
		dao.ckeckAnswer(qno);
	}

	@Override
	public List<BanListVO> getBlackList(SearchCriteria cri, int mno) {
		return dao.getBlackList(cri, mno);
	}

	@Override
	public PageMaker getBanPageMaker(SearchCriteria cri, int mno) {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.getBanCount(mno));
		return pageMaker;
	}
	
	
}
