package com.bomshop.www.seller.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.dto.OrderComDTO;
import com.bomshop.www.seller.dto.WithdrawDTO;
import com.bomshop.www.seller.vo.OrderComVO;

public interface SellerSettlementManageDAO {

	//	미정산된 구매완료 주문 개수
	@Select("SELECT count(*) FROM order_com WHERE com_status='N' AND"
			+ " ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getUnsettledCount(int mno);

	//	미정산된 구매완료 주문 총액
	@Select("SELECT sum(price) FROM order_com WHERE com_status='N' AND"
			+ " ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getUnsettledAmount(int mno);

	//	개인 금고에 저장된 금액
	@Select("SELECT bankmoney FROM member WHERE mno=#{mno}")
	int getHoldingAmount(int mno);

	//	정산관리 페이지용 리스트
	@Select("SELECT * FROM order_com WHERE com_status='N' AND"
			+ " ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY orderno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<OrderComVO> getOrderComList(@Param("cri")SearchCriteria cri, @Param("mno")int mno);

	//	출금하기
	@Update("UPDATE member SET bankmoney=bankmoney-#{withdraw.money} WHERE mno=#{mno} AND spw=#{withdraw.pass}")
	void withdraw(@Param("mno")int mno, @Param("withdraw")WithdrawDTO withdraw);

	//	비밀번호 가져오기
	@Select("SELECT spw FROM member WHERE mno=#{mno}")
	String getSPW(int mno);

	//	값이 있는 월 정보 가져오기
	@Select("SELECT date_format(order_com_date, '%Y-%m') mon FROM order_com"
			+ " WHERE ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " GROUP BY mon ORDER BY mon DESC")
	List<String> getMonthList(int mno);

	//	선택한 월의 페이징 처리된 주문내역 
	@Select("SELECT * FROM order_com WHERE SUBSTR(order_com_date,1,7) = #{cri.searchType}"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY order_com_date DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<OrderComVO> getgetHistoryList(@Param("cri")SearchCriteria cri, @Param("mno") int mno);

	//	선택한 월의 주문내역 개수
	@Select("SELECT count(*) FROM order_com WHERE SUBSTR(order_com_date,1,7) = #{cri.searchType}"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getMonthCount(@Param("cri")SearchCriteria cri, @Param("mno")int mno);

	//	선택한 월의 주문내역 총 금액
	@Select("SELECT sum(price) FROM order_com WHERE SUBSTR(order_com_date,1,7) = #{cri.searchType}"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getTotalAmount(@Param("cri")SearchCriteria cri, @Param("mno")int mno);
	
	//	선택한 월의 페이징 모든 주문내역 
	@Select("SELECT * FROM order_com WHERE SUBSTR(order_com_date,1,7) = #{cri.searchType}"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY order_com_date")
	List<OrderComVO> getExcelList(@Param("mno")int mno, @Param("cri") SearchCriteria cri);
}
