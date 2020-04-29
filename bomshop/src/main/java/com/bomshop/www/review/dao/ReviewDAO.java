package com.bomshop.www.review.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.bomshop.www.review.vo.ReviewVO;

public interface ReviewDAO {
	
	// 리뷰 전체 목록
	@Select("select re.*, m.mid from review re left outer join member m on re.mno = m.mno where re.gno = #{gno} order by rno desc")
	List<ReviewVO> allList(int gno) throws Exception;
	
	// 전체 리뷰 개수
	@Select("SELECT count(*) FROM review WHERE gno = #{gno}")
	int reviewCnt(int gno) throws Exception;
	
	// 포토 리뷰
	@Select("SELECT re.*, m.mid FROM review re left outer join member m on re.mno = m.mno WHERE re.gno = #{gno} AND img is not null ORDER BY rno DESC")
	List<ReviewVO> pList(int gno) throws Exception;
	
	// 포토 리뷰 개수
	@Select("SELECT count(*) FROM review WHERE gno = #{gno} AND img is not null")
	int pCount(int gno) throws Exception;
	
	// 텍스트 리뷰
	@Select("SELECT *, m.mid FROM review re left outer join member m on re.mno = m.mno WHERE re.gno = #{gno} AND img is null ORDER BY rno DESC")
	List<ReviewVO> tList(int gno) throws Exception;
	
	// 텍스트 리뷰 개수
	@Select("SELECT count(*) FROM review WHERE gno = #{gno} AND img is null")
	int tCount(int gno) throws Exception;
	
}
