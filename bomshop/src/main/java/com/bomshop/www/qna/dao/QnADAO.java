package com.bomshop.www.qna.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bomshop.www.common.util.Criteria;
import com.bomshop.www.qna.vo.QnA_goodsVO;

public interface QnADAO {

	// 상품별 qna 전체 목록
	@Select("SELECT count(*) FROM qna_goods WHERE gno = #{gno}")
	int totalCount(int gno) throws Exception;

	// 상품번호로 qna 목록 불러오기
	@Select("select q.*, m.mid from qna_goods q left outer join member m on q.mno = m.mno where q.gno = #{gno} order by q.qno desc limit #{cri.pageStart}, #{cri.perPageNum}")
	List<QnA_goodsVO> qnaList(@Param("gno")int gno,@Param("cri") Criteria cri) throws Exception;

	// qna등록
	@Insert("INSERT INTO qna_goods(mno,gno,title,content,img1,img2,sec_status) "
			+ " VALUES(#{mno}, #{gno}, #{title}, #{content}, #{img1}, #{img2}, #{sec_status})")
	void regist_sec(QnA_goodsVO qnaVO) throws Exception;
	
	@Update("UPDATE qna_goods SET origin = LAST_INSERT_ID() WHERE qno = LAST_INSERT_ID()")
	void updateOrigin() throws Exception;
	
	@Insert("INSERT INTO qna_goods(mno,gno,title,content) "
			+ " VALUES(#{mno}, #{gno}, #{title}, #{content})")
	void regist(QnA_goodsVO qnaVO) throws Exception;

	// img 추가
	@Update("UPDATE qna_goods SET img1 = #{img1}, img2 = #{img2} WHERE qno = LAST_INSERT_ID()")
	void addImg(String fullName) throws Exception;

	@Select("SELECT img1 FROM qna_goods WHERE qno = #{qno}")
	String img1(int qno) throws Exception;

	@Select("SELECT img2 FROM qna_goods WHERE qno = #{qno}")
	String img2(int qno) throws Exception;

	
	
}
