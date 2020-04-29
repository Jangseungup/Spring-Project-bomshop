package com.bomshop.www.seller.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.vo.GoodsOptionVO;
import com.bomshop.www.seller.vo.OrderVO;

public interface SellerOrderManageDAO {
	
	//	주문한 모든 주문 개수
	@Select("SELECT count(*) FROM order_member WHERE order_status IN(0,1,2)"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getTotalOrderCount(int mno);

	//	오늘 주문 개수
	@Select("SELECT count(*) FROM order_member WHERE SUBSTR(orderdate,1,10)=(SELECT CURDATE())"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getTodayOrderCount(int mno);

	//	배송 대기 주문 개수
	@Select("SELECT count(*) FROM order_member WHERE order_status=0"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getAwaitingDeliveryCount(int mno);

	//	배송 중인 주문 개수
	@Select("SELECT count(*) FROM order_member WHERE order_status=1"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getShippingCount(int mno);

	//	배송 완료 주문 개수
	@Select("SELECT count(*) FROM order_member WHERE order_status=2"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	int getCompletedCount(int mno);
	
	//	판매자가 확인 안한 주문 개수
	@Select("SELECT count(*) FROM order_member WHERE order_check='N'"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}));")
	int getUnconfirmedOrderCount(int mno);

	//	주문한 모든 주문 리스트
	@Select("SELECT * FROM order_member WHERE order_status IN(0,1,2)"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY orderno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<OrderVO> getTotalOrderList(@Param("cri") SearchCriteria cri,@Param("mno") int mno);
	
	//	오늘 주문 리스트
	@Select("SELECT * FROM order_member WHERE SUBSTR(orderdate,1,10)=(SELECT CURDATE())"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY orderno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<OrderVO> getTodayOrderList(@Param("cri") SearchCriteria cri,@Param("mno") int mno);

	//	배송 대기 주문 리스트
	@Select("SELECT * FROM order_member WHERE order_status=0"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY orderno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<OrderVO> getAwaitingDeliveryList(@Param("cri") SearchCriteria cri,@Param("mno") int mno);

	//	배송 중인 주문 리스트
	@Select("SELECT * FROM order_member WHERE order_status=1"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY orderno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<OrderVO> getShippingList(@Param("cri") SearchCriteria cri,@Param("mno") int mno);

	//	배송 완료 주문 리스트
	@Select("SELECT * FROM order_member WHERE order_status=2"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY orderno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<OrderVO> getCompletedList(@Param("cri") SearchCriteria cri,@Param("mno") int mno);
	
	//	판매자가 확인 안한 주문 리스트
	@Select("SELECT * FROM order_member WHERE order_check='N'"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))"
			+ " ORDER BY orderno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<OrderVO> getUnconfirmedOrderList(@Param("cri") SearchCriteria cri,@Param("mno") int mno);

	//	주문한 상품 옵션 가져오기
	@Select("SELECT * FROM goods_option WHERE ono=#{ono}")
	GoodsOptionVO getOption(int ono);
	
	//	주문한 상품명 가져오기
	@Select("SELECT gname_ko FROM goods WHERE gno=(SELECT gno FROM goods_option WHERE ono=#{ono})")
	String getGname(int ono);

	//	상품 주문 회원 id 가져오기
	@Select("SELECT mid FROM member WHERE mno=#{mno}")
	String getMid(int mno);
	
	//	주문 미확인 -> 확인 변경
	@Update("UPDATE order_member SET order_check='Y' WHERE order_check='N'"
			+ " AND ono=ANY(SELECT ono FROM goods_option WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}))")
	void orderConfirm(int mno);

	//	개별 주문정보 가져오기
	@Select("SELECT * FROM order_member WHERE orderno=#{orderno}")
	OrderVO getOrderVO(int orderno);

	//	주문 배송지 정보 수정
	@Update("UPDATE order_member SET delivery_name=#{delivery_name},delivery_phone=#{delivery_phone},delivery_addr1=#{delivery_addr1}"
			+ ",delivery_addr2=#{delivery_addr2},delivery_post_code=#{delivery_post_code} WHERE orderno=#{orderno}")
	void changeInfo(OrderVO vo);

	//	주문 배송 시작
	@Update("UPDATE order_member SET order_status=1 WHERE orderno=#{orderno}")
	void startDelivery(int orderno);

	//	주문 배송 취소
	@Update("UPDATE order_member SET order_status=0 WHERE orderno=#{orderno}")
	void sendCancel(int orderno);

	//	주문 취소
	@Delete("DELETE FROM order_member WHERE orderno=#{orderno}")
	void cancelOrder(int orderno);


	
}
