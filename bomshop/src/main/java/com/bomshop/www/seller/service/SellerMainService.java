package com.bomshop.www.seller.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.seller.vo.CommentVO;
import com.bomshop.www.seller.vo.GoodsOptionVO;
import com.bomshop.www.seller.vo.GoodsVO;
import com.bomshop.www.seller.vo.QnAAdminVO;

public interface SellerMainService {

	//	판매자가 확인안한 주문 개수
	int getUnconfirmedOrderCount(int mno) throws Exception;

	//	상품 등록
	void goodsRegister(int mno, GoodsVO goods, List<GoodsOptionVO> list, MultipartFile mainImg, MultipartFile[] subImg) throws Exception;

	//	이미지 파일 이름 임시 저장
	void addTempImg(String fileName) throws Exception;

	//	회원 정보 가져오기
	MemberVO getMemberInfo(int mno);

	//	상점 정보 수정
	void privacyModify(MemberVO vo);

	//	문의 리스트
	List<QnAAdminVO> getQnAList(SearchCriteria cri, int mno);

	//	문의하기 용 페이지 메이커
	PageMaker getQnAPageMaker(SearchCriteria cri, int mno);

	//	문의하기 가져오기
	QnAAdminVO getQnA(int qano);

	//	답변
	CommentVO getComment(int qano);

	//	문의 작성하기
	void addQuestion(QnAAdminVO vo);

}
