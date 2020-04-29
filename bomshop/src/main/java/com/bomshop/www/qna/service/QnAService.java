package com.bomshop.www.qna.service;

import java.util.List;
import java.util.Map;

import com.bomshop.www.qna.vo.QnA_goodsVO;

public interface QnAService {

	// qna 목록 불러오기(상품번호, 페이지)
	Map<String, Object> qnaList(int gno, int page) throws Exception;

	// qna 등록
	void regist(QnA_goodsVO qnaVO) throws Exception;

	// img요청
	List<String> display(int qno) throws Exception;

}
