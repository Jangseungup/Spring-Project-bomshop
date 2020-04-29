package com.bomshop.www.seller.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.vo.GoodsOptionVO;
import com.bomshop.www.seller.vo.GoodsVO;

public interface SellerGoodsManageDAO {

	//	등록한 모든 상품 개수
	@Select("SELECT count(*) FROM goods WHERE mno=#{mno}")
	int getTotalGoodsCount(int mno);
	
	//	등록한 모든 상품 리스트 가져오기
	@Select("SELECT * FROM goods WHERE mno=#{mno} ORDER BY gno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<GoodsVO> getTotalGoodsList(@Param("cri") SearchCriteria cri, @Param("mno") int mno);
	
	//	판매중인 상품 개수
	@Select("SELECT count(*) FROM goods WHERE mno=#{mno} AND gstatus='Y'")
	int getSalesCount(int mno);
	
	//	판매중인 상품 리스트 가져오기
	@Select("SELECT * FROM goods WHERE mno=#{mno} AND gstatus='Y' ORDER BY gno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<GoodsVO> getSalesList(@Param("cri") SearchCriteria cri, @Param("mno") int mno);
	
	//	재고 10개 이하 상품 개수
	@Select("SELECT count(o.gno) FROM (SELECT gno FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno})"
			+ " GROUP BY gno HAVING 10>sum(count)) as o")
	int getSoldOutCount(int mno);
	
	//	재고 10개 이하 상품 리스트 가져오기
	@Select("SELECT * FROM goods WHERE gno=ANY(SELECT gno FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno})"
			+ " GROUP BY gno HAVING 10>sum(count)) ORDER BY gno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<GoodsVO> getSoldOutList(@Param("cri") SearchCriteria cri, @Param("mno") int mno);

	//	상품판매기간 7일 이내 상품 개수
	@Select("SELECT count(*) FROM goods WHERE sdate < DATE_ADD(now(), INTERVAL 7 DAY) AND mno=#{mno}")
	int getGoodsExpirationCount(int mno);
	
	//	상품판매기간 7일 이내 상품 리스트 가져오기
	@Select("SELECT * FROM goods WHERE sdate < DATE_ADD(now(), INTERVAL 7 DAY) AND mno=#{mno}"
			+ " ORDER BY gno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<GoodsVO> getGoodsExpirationList(@Param("cri") SearchCriteria cri, @Param("mno") int mno);
	
	//	판매중지 상품 개수
	@Select("SELECT count(*) FROM goods WHERE mno=#{mno} AND gstatus='N'")
	int getDiscontinuedCount(int mno);
	
	//	판매중지 상품 개수
	@Select("SELECT * FROM goods WHERE mno=#{mno} AND gstatus='N' ORDER BY gno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<GoodsVO> getDiscontinuedList(@Param("cri") SearchCriteria cri, @Param("mno") int mno);

	//	상품 판매상태 변경
	@Update("UPDATE goods SET gstatus=#{gstatus} WHERE gno=#{gno}")
	void changeStatus(GoodsVO vo);

	//	상품 판매기간 연장
	@Update("UPDATE goods SET sdate=DATE_ADD(sdate, INTERVAL #{addDate} DAY) WHERE gno=#{gno}")
	void extendSdate(@Param("gno")int gno, @Param("addDate") int addDate);

	//	상품의 옵션리스트 가져오기
	@Select("SELECT * FROM goods_option WHERE gno=#{gno}")
	List<GoodsOptionVO> getOptionList(int gno);

	//	상품 재고 수량 변경
	@Update("UPDATE goods_option SET count=#{count} WHERE ono=#{ono}")
	void countChange(GoodsOptionVO vo);

	//	판매상품 삭제
	@Delete("DELETE FROM goods WHERE gno=#{gno}")
	void removeGoods(int gno);

	//	상품 번호로 상품 정보 가져오기
	@Select("SELECT * FROM goods WHERE gno=#{gno}")
	GoodsVO getGoodsByGno(int gno);

	//	상품 정보 수정
	@Update("UPDATE goods SET cat1=#{cat1},cat2=#{cat2},gname_ko=#{gname_ko},gname_en=#{gname_en},cost_origin=#{cost_origin},"
			+ "cost=#{cost},tag1=#{tag1},tag2=#{tag2},tag3=#{tag3},gexchange=#{gexchange},gmodel=#{gmodel} WHERE gno=#{gno}")
	void goodsModify(GoodsVO vo);
}
