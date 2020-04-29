package com.bomshop.www.qna.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bomshop.www.common.util.Criteria;
import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.qna.dao.QnADAO;
import com.bomshop.www.qna.vo.QnA_goodsVO;

@Service
public class QnAServiceImpl implements QnAService{
	
	@Inject
	QnADAO dao;

	// qna 목록 검색
	@Override
	public Map<String, Object> qnaList(int gno, int page) throws Exception {
		
		Criteria cri = new Criteria();
		cri.setPage(page);
		cri.setPerPageNum(3);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.totalCount(gno));
		
		List<QnA_goodsVO> list = dao.qnaList(gno,cri);
		
		Map<String, Object> map = new HashMap<>();
		map.put("qnaList", list);
		map.put("pageMaker",pm);
		
		return map;
	}

	// qna 등록
	@Override
	@Transactional
	public void regist(QnA_goodsVO qnaVO) throws Exception {
		// 정보 등록(mno, gno, title, content, sec_status)
		dao.regist_sec(qnaVO);
		dao.updateOrigin();
	}

	@Override
	@Transactional
	public List<String> display(int qno) throws Exception {
		List<String> list = new ArrayList<>();
		
		if(dao.img1(qno) != null) {
			list.add(dao.img1(qno));
		}
		if(dao.img2(qno) != null) {
			list.add(dao.img2(qno));
		}
		return list;
	}
	
	
	
	

}
