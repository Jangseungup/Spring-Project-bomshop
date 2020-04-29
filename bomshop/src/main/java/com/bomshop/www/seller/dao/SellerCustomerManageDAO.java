package com.bomshop.www.seller.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.vo.BanListVO;
import com.bomshop.www.seller.vo.QnAGoodsVO;
import com.bomshop.www.seller.vo.ReviewVO;

public interface SellerCustomerManageDAO {

	//	신규 문의 개수
	@Select("SELECT count(*) FROM qna_goods WHERE re_check='N' AND lev=0 AND gno=ANY(SELECT gno FROM goods WHERE mno=#{mno})")
	int getNewQuestionCount(int mno);

	//	최근 리뷰 개수(7일)
	@Select("SELECT count(*) FROM review WHERE regdate > DATE_ADD(NOW(), INTERVAL -3 DAY)"
			+ " AND gno=ANY(SELECT gno FROM goods WHERE mno=#{mno})")
	int getLatestReviewsCount(int mno);

	//	단골 고객 수
	@Select("SELECT count(*) FROM likeshop WHERE shopmno=#{mno}")
	int getRegularCustomerCount(int mno);

	//	신규 문의 리스트
	@Select("SELECT * FROM qna_goods WHERE re_check='N' AND lev=0 AND gno=ANY(SELECT gno FROM goods WHERE mno=#{mno})"
			+ " ORDER BY qno limit #{cri.pageStart},#{cri.perPageNum}")
	List<QnAGoodsVO> getNewQuestionList(@Param("cri") SearchCriteria cri, @Param("mno") int mno);

	//	최근 리뷰 리스트
	@Select("SELECT * FROM review WHERE regdate > DATE_ADD(NOW(), INTERVAL -3 DAY) AND gno=ANY(SELECT gno FROM goods WHERE mno=#{mno})"
			+ " ORDER BY rno limit #{cri.pageStart},#{cri.perPageNum}")
	List<ReviewVO> getLatestReviewsList(@Param("cri") SearchCriteria cri, @Param("mno") int mno);

	//	상품명 가져오기
	@Select("SELECT gname_ko FROM goods WHERE gno=#{gno}")
	String getGname(int gno);

	//	회원 아이디 가져오기
	@Select("SELECT mid FROM member WHERE mno=#{mno}")
	String getMid(int mno);

	//	문의내용 상세보기
	@Select("SELECT * FROM qna_goods WHERE qno=#{qno}")
	QnAGoodsVO getQnAbyQno(int qno);

	//	문의내용 답변하기
	@Insert("INSERT INTO qna_goods VALUES(null,#{mno},#{gno},#{title},#{content},now(),null,null,'N','N','N',#{qno},1)")
	void answer(QnAGoodsVO vo) throws Exception;

	//	문의 한 게시물 문의 상태 변경
	@Update("UPDATE qna_goods SET re_check='Y' WHERE qno=#{qno}")
	void ckeckAnswer(int qno) throws Exception;

	//	상점 블랙리스트 추가
	@Insert("INSERT INTO banlist VALUES(null,#{mno},#{ban_mno},now(),#{reason})")
	void addBlackList(BanListVO vo);

	//	블랙리스트 가져오기
	@Select("SELECT ban.*, mem.mid FROM banlist ban, member mem WHERE ban.mno=#{mno} AND ban.ban_mno=mem.mno"
			+ " ORDER BY ban.bno limit #{cri.pageStart},#{cri.perPageNum}")
	List<BanListVO> getBlackList(@Param("cri") SearchCriteria cri, @Param("mno") int mno);

	//	블랙리스트 개수
	@Select("SELECT count(*) FROM banlist WHERE mno=#{mno}")
	int getBanCount(int mno);
}
