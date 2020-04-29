package com.bomshop.www.admin.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bomshop.www.admin.member.OrderMemberVO;
import com.bomshop.www.admin.seller.vo.OrderComVO;
import com.bomshop.www.admin.vo.AdvertiseVO;
import com.bomshop.www.admin.vo.AnswerCommentVO;
import com.bomshop.www.admin.vo.BlacklistVO;
import com.bomshop.www.admin.vo.CouponVO;
import com.bomshop.www.admin.vo.QuestionVO;
import com.bomshop.www.admin.vo.ReportGoodsVO;
import com.bomshop.www.admin.vo.ReportVO;
import com.bomshop.www.admin.vo.SendBuyerVO;
import com.bomshop.www.admin.vo.WritedBoardVO;
import com.bomshop.www.common.util.SearchCriteria;



public interface AdminDAO {

	// 신고 현황 수
	@Select("SELECT count(*) FROM report")
	String reportCount() throws Exception;

	@Select("SELECT count(*) FROM coupon")
	String couponCount() throws Exception;

	// 신고 상품 총 수
	@Select("SELECT count(*) FROM report_goods")
	String reportGoodsCount() throws Exception;
	
	// 미처리 신고 상품
	@Select("SELECT count(*) FROM report_goods WHERE report_status = 0")
	String reportGoodsUntreatedCount() throws Exception;

	// 판매자 문의 상품
	@Select("SELECT count(*) FROM report_goods WHERE report_status = 1")
	String reportGoodsInquiryCount() throws Exception;
	
	// 판매자 문의 상품
	@Select("SELECT count(*) FROM report_goods WHERE report_status = 2")
	String reportGoodsCompletedCount() throws Exception;
		
	@Select("SELECT count(*) FROM qna_admin WHERE re_check = 'N'")
	String serviceCount() throws Exception;
	
	// 신고자 ID 조회
	@Select("SELECT mid FROM member WHERE mno = #{mno}")
	String getReporterID(int mno) throws Exception;
	
	// 신고 ID 조회
	@Select("SELECT mid FROM member WHERE mno=#{report_mno}")
	String getReportID(int report_mno) throws Exception;
	
	// 경고 횟수 조회
	@Select("SELECT strike FROM member WHERE mno = #{report_mno}")
	int strike(int mno) throws Exception;
	
	// 신고 리스트
	@Select("SELECT * FROM report ORDER BY rno DESC limit #{pageStart} , #{perPageNum} ")
	List<ReportVO> listReport(SearchCriteria cri);
	
	// 블랙리스트 등록
	@Update("UPDATE member SET ban='Y' WHERE mno = #{report_mno}")
	void updateBan(ReportVO reportVO) throws Exception;
	@Insert("INSERT INTO blacklist VALUES(null,#{report_mno},#{reason},now())")
	void addBlacklist(ReportVO reportVO) throws Exception;	
	
	// 신고 접수 제거
	@Delete("DELETE FROM report WHERE rno = #{rno}")
	void deleteReport(int rno) throws Exception;
	
	// 블랙리스트 멤버
	@Select("SELECT b.black_no,m.mid,b.black_content,b.black_date " + 
			" FROM member m, blacklist b " + 
			" WHERE m.mno = b.black_mno ORDER BY black_no DESC " +
			" limit  #{pageStart} , #{perPageNum}")
	List<BlacklistVO> blacklist(SearchCriteria cri) throws Exception;
	
	// 해당 신고 row 검색
	@Select("SELECT * FROM report WHERE rno = #{rno}")
	ReportVO searchRow(int rno) throws Exception;

	// 경고 횟수 증가
	@Update("UPDATE member SET strike = strike + 1 WHERE mno = #{report_mno}")
	void increaseAlert(ReportVO rvo) throws Exception;
	
	// 블랙리스트 테이블 총 수
	@Select("SELECT count(*) from blacklist")
	int blacklistCount() throws Exception;

	// 블랙리스트 해제
	@Delete("DELETE FROM blacklist WHERE black_no = #{black_no}")
	void deleteBlacklist(int black_no) throws Exception;

	// 블랙리스트 해제 -> 회원 정보 변경
	@Update("UPDATE member SET strike=0, ban='N' WHERE mno = (SELECT black_mno FROM blacklist WHERE black_no = #{black_no})")
	void updateBlacklist(int black_no) throws Exception;
	
	// 작성글 보기
	@Select("SELECT q.qno,m.mno,q.gno,g.gname_ko,m.mid,q.title,q.content,q.regdate "
			+ " FROM qna_goods q, member m, goods g "
			+ " WHERE m.mno = q.mno "
			+ " AND q.gno = g.gno "
			+ " AND m.mno=(SELECT report_mno FROM report WHERE rno = #{rno}) "
			+ " AND q.qno=(SELECT qno FROM report WHERE rno = #{rno})")
	WritedBoardVO getWritedBoard(int rno) throws Exception;
	
	// 쿠폰 리스트
	@Select("SELECT * from coupon ORDER BY cno DESC limit #{pageStart}, #{perPageNum}")
	List<CouponVO> getCouponList(SearchCriteria cri);

	// 쿠폰 등록
	@Insert("INSERT INTO coupon VALUES(null,#{cname},#{climit},#{sale},#{coupon_code},#{limit_date})")
	void enrollCoupon(CouponVO couponVO) throws Exception;

	// 쿠폰 수정
	@Update("UPDATE coupon "
			+ " SET coupon_code=#{coupon_code},cname=#{cname},climit=#{climit},sale=${sale},limit_date=#{limit_date} "
			+ " WHERE cno=#{cno}")
	void updateCoupon(CouponVO couponVO) throws Exception;
	
	// 쿠폰 삭제
	@Delete("DELETE FROM coupon WHERE cno=#{cno}")
	void deleteCoupon(int cno) throws Exception;
	
	// 신고 상품 리스트
	@Select("SELECT * FROM report_goods ORDER BY rgno DESC limit #{pageStart} , #{perPageNum}")
	List<ReportGoodsVO> getReportGoodsList(SearchCriteria cri);

	// 신고 미처리 상품 리스트
	@Select("SELECT * FROM report_goods WHERE report_status = 0 ORDER BY rgno DESC limit #{pageStart} , #{perPageNum}")
	List<ReportGoodsVO> getReportGoodsUntreatedList(SearchCriteria cri);
	
	// 판매자 문의 중 상품 리스트
	@Select("SELECT * FROM report_goods WHERE report_status = 1 ORDER BY rgno DESC limit #{pageStart} , #{perPageNum}")
	List<ReportGoodsVO> getReportGoodsInquiryList(SearchCriteria cri);
	
	// 판매자 처리 완료 리스트
	@Select("SELECT * FROM report_goods WHERE report_status = 2 ORDER BY rgno DESC limit #{pageStart} , #{perPageNum}")
	List<ReportGoodsVO> getReportGoodsCompletedList(SearchCriteria cri);
		
	// 상품명
	@Select("SELECT gname_ko FROM goods WHERE gno = #{gno}")
	String getGoodsName(int gno) throws Exception;
	
	// 판매자ID 조회
	@Select("SELECT mid FROM member WHERE mno = (SELECT mno FROM goods WHERE gno = #{gno})")
	String getBuyerID(int gno) throws Exception;

	// 신고 처리 완료
	@Delete("DELETE FROM report_goods WHERE rgno = #{rgno}")
	void deleteReportGoods(int rgno) throws Exception;

	// 상품 신고 사유 판매자에게 문의
	@Update("UPDATE report_goods SET reason = #{reason}, report_status = 1 WHERE rgno = #{rgno}")
	void sendBuyer(SendBuyerVO sendBuyerVO) throws Exception;
	
	// 관리자 고객센터 리스트
	@Select("SELECT * FROM qna_admin WHERE re_check='N' ORDER BY qano DESC limit #{pageStart} , #{perPageNum}")
	List<QuestionVO> getQuetionList(SearchCriteria cri) throws Exception;

	// 답변한 문의글 정보
	@Select("SELECT mno FROM qna_admin WHERE qano = #{qano}")
	int getQuestionDetail(int qano) throws Exception;

	// 답변 추가
	@Insert("INSERT INTO comment VALUES(null,#{qano},#{mno},#{content},now())")
	void addComment(AnswerCommentVO answerCommentVO) throws Exception;
	
	// 답변 상태 업데이트
	@Update("UPDATE qna_admin SET re_check='Y' WHERE qano=#{qano}")
	void sendAnswer(int qano) throws Exception;
	
	// 광고 전체 수
	@Select("SELECT count(*) FROM advertise")
	int advertiseTotalCount() throws Exception;
	
	// 광고대기
	@Select("SELECT count(*) FROM advertise WHERE astatus = 0")
	int advertiseCount() throws Exception;
	
	// 광고 중
	@Select("SELECT count(*) FROM advertise WHERE astatus=1")
	int advertisingCount() throws Exception;

	// 광고 목록
	@Select("SELECT * FROM advertise ORDER BY ano DESC limit #{pageStart}, #{perPageNum}")
	List<AdvertiseVO> advertiseList(SearchCriteria cri) throws Exception;

	// 광고 마감 3일 전
	@Select("SELECT count(*) FROM advertise WHERE astatus = 1 AND adate < DATE_ADD(now(),interval 3 day)")
	int getDeadline() throws Exception;

	// 남은 기간
	@Select("SELECT datediff(#{date},now())")
	int getRemaining_period(Date date) throws Exception;
	
	// 광고 중인 상품 목록
	@Select("SELECT * FROM advertise WHERE astatus = 1 ORDER BY ano DESC limit #{pageStart}, #{perPageNum}")
	List<AdvertiseVO> advertisingList(SearchCriteria cri);
	
	// 광고 대기 상품 목록
	@Select("SELECT * FROM advertise WHERE astatus = 0 ORDER BY ano DESC limit #{pageStart}, #{perPageNum}")
	List<AdvertiseVO> advertiseWaitingList(SearchCriteria cri);
	
	// 광고 종료 3일 전 목록
	@Select("SELECT * FROM advertise WHERE astatus = 1 AND adate < DATE_ADD(now(),interval 3 day) ORDER BY ano DESC limit #{pageStart}, #{perPageNum}")
	List<AdvertiseVO> advertiseDeadlineList(SearchCriteria cri);

	// 광고 승인 개수
	@Select("SELECT count(*) FROM advertise WHERE astatus = 1")
	int acceptCount() throws Exception;
	
	// 광고 신청 승인
	@Update("UPDATE advertise SET astatus = 1, adate = DATE_ADD(now(), INTERVAL 7 DAY) WHERE ano = #{ano}")
	void acceptAdvertise(int ano) throws Exception;
	
	// 광고 신청 취소
	@Delete("DELETE FROM advertise WHERE ano = #{ano}")
	void deleteAdvertise(int ano) throws Exception;
	
	// 종료된 광고 검색
	@Select("SELECT * FROM advertise WHERE astatus=1 AND adate < now()")
	List<AdvertiseVO> selectEndAdvertise() throws Exception;	
	
	// 종료된 광고 삭제
	@Delete("DELETE FROM advertise WHERE astatus=1 AND adate < now()")
	void endAdverties() throws Exception;
	
	// ---------------------문영이형 dao에 추가---------------------------
	// 장바구니에서 7일 지난 상품 삭제
	@Delete("DELETE FROM cart WHERE datediff(now(),regdate) = 7")
	void deleteCart() throws Exception;
	
	// 구매확정 안했을 경우 (7일 경과)
	@Delete("DELETE FROM order_member WHERE datediff(now(),delivery_com_date) = 7 AND order_status = 2 AND orderno = #{orderno}")
	void deleteOrderMember(OrderMemberVO omv) throws Exception;
	
	// 구매확정 하지않은 회원(7일 경과)
	@Select("SELECT * FROM order_member WHERE datediff(now(),delivery_com_date) = 7 AND order_status = 2")
	List<OrderMemberVO> selectOrderMember() throws Exception;
	
	// 자동으로 구매확정
	@Insert("INSERT INTO order_com(orderno,ono,mno,count,price,order_date,order_com_date,com_status) VALUES(null,#{ono},#{mno},#{count},#{price},#{orderdate},,#{delivery_com_date},'N')")
	void insertOrderCom(OrderMemberVO orderMemberVO) throws Exception;
	
	// 구매확정 리시트에서 30일 지난 상품 삭제
	@Delete("DELETE FROM order_com WHERE datediff(now(),order_date) = 30")
	void deleteOrderCom() throws Exception;
	
	// 판매기가 지난 상품 판매중지
	@Delete("UPDATE goods SET gstatus = 'N' WHERE datediff(now(),sdate) > 0")
	void Discontinued() throws Exception;

	// 판매정산되지 않은 상품
	@Select("SELECT * FROM order_com WHERE com_status='N'")
	List<OrderComVO> comStatus() throws Exception;

	// 정산
	@Update("UPDATE member SET bankmoney = bankmoney + #{price} "
			+ " WHERE mno = (SELECT mno from goods WHERE gno = "
			+ " (SELECT gno FROM goods_option WHERE ono = "
			+ " (SELECT ono FROM order_com WHERE orderno = #{orderno} AND ono = #{ono})))")
	void calculate(OrderComVO ocv) throws Exception;	
	
	// 정산 완료
	@Update("UPDATE order_com SET com_status = 'Y' WHERE orderno = #{orderno}")
	void updateStatus(int orderno) throws Exception;
	
}
