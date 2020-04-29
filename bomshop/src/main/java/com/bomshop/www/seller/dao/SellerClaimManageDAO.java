package com.bomshop.www.seller.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.vo.OrderVO;

public interface SellerClaimManageDAO {
	
	//	전체 클레임 주문 개수
	@Select("SELECT count(*) FROM order_member WHERE order_status IN(3,4,5,6,7)"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getTotalClaimCount(int mno);

	//	반품요청 주문 개수
	@Select("SELECT count(*) FROM order_member WHERE order_status=3"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getRequestRefundCount(int mno);

	//	교환요청 주문 개수
	@Select("SELECT count(*) FROM order_member WHERE order_status=4"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getRequestExchangeCount(int mno);
	
	//	취소요청 주문 개수
	@Select("SELECT count(*) FROM order_member WHERE order_status=5"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getRequestCancelCount(int mno);
	
	//	반품처리중 주문 개수
	@Select("SELECT count(*) FROM order_member WHERE order_status=6"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getReturningCount(int mno);

	//	교환처리중 주문 개수
	@Select("SELECT count(*) FROM order_member WHERE order_status=7"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getInExchangeCount(int mno);

	//	전체 클레임 주문 리스트
	@Select("SELECT * FROM order_member WHERE order_status IN(3,4,5,6,7)"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY orderno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<OrderVO> getTotalClaimList(@Param("cri")SearchCriteria cri, @Param("mno")int mno);

	//	반품요청 주문 리스트
	@Select("SELECT * FROM order_member WHERE order_status=3"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY orderno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<OrderVO> getRequestRefundList(@Param("cri")SearchCriteria cri, @Param("mno")int mno);

	//	교환요청 주문 리스트
	@Select("SELECT * FROM order_member WHERE order_status=4"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY orderno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<OrderVO> getRequestExchangeList(@Param("cri")SearchCriteria cri, @Param("mno")int mno);

	//	취소요청 주문 리스트
	@Select("SELECT * FROM order_member WHERE order_status=5"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY orderno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<OrderVO> getRequestCancelList(@Param("cri")SearchCriteria cri, @Param("mno")int mno);
	
	//	반품처리중 주문 리스트
	@Select("SELECT * FROM order_member WHERE order_status=6"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY orderno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<OrderVO> getReturningList(@Param("cri")SearchCriteria cri, @Param("mno")int mno);

	//	교환처리중 주문 리스트
	@Select("SELECT * FROM order_member WHERE order_status=7"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY orderno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<OrderVO> getInExchangelList(@Param("cri")SearchCriteria cri, @Param("mno")int mno);

	//	요청 거절로 인한 상태 변경
	@Update("UPDATE order_member SET order_status=#{status} WHERE orderno=#{orderno}")
	void refusal(@Param("orderno")int orderno, @Param("status")int status);

	//	요청 처리 완료오 인한 상태 변경(메세지 추가시 비워주기)
	@Update("UPDATE order_member SET order_status=#{status} WHERE orderno=#{orderno}")
	void processingCompleted(@Param("orderno")int orderno, @Param("status")int status);

	//	상품 취소 요청 승인
	@Delete("DELETE FROM order_member WHERE orderno=#{orderno}")
	void deleteOrder(int orderno);

	//	주문정보 가져오기
	@Select("SELECT * FROM order_member WHERE orderno=#{orderno}")
	OrderVO getOrderVO(int orderno);

	//	주문 취소 환불하기
	@Update("UPDATE member SET cash=cash+#{cash} WHERE mno=#{mno}")
	void refundCash(@Param("mno")int mno, @Param("cash")int cash);
}
