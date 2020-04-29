package com.bomshop.www.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bomshop.www.common.util.Criteria;
import com.bomshop.www.member.vo.CouponVO;
import com.bomshop.www.member.vo.GoodsOptionVO;
import com.bomshop.www.member.vo.GoodsVO;
import com.bomshop.www.member.vo.MemberCouponVO;
import com.bomshop.www.member.vo.OrderComVO;
import com.bomshop.www.member.vo.OrderMemberVO;
import com.bomshop.www.member.vo.OrderNonVO;
import com.bomshop.www.member.vo.QnaAdminVO;
import com.bomshop.www.member.vo.QnaGoodsVO;
import com.bomshop.www.member.vo.ReviewVO;

public interface MypageDAO {

	@Select("SELECT COUNT(*) FROM member_coupon WHERE mno = #{mno} AND check_use='N'")
	int couponCnt(int mno) throws Exception;

	@Select("SELECT * FROM member_coupon WHERE mno = #{mno} AND check_use='N' LIMIT #{pageStart},#{perPageNum}")
	List<MemberCouponVO> getMemberCouponList(@Param("mno")int mno, @Param("pageStart") int pageStart, @Param("perPageNum") int perPageNum) throws Exception;

	@Select("SELECT * FROM coupon WHERE cno = #{cno}")
	CouponVO getCouponInfo(int cno) throws Exception;
	
	@Select("SELECT COUNT(*) FROM member WHERE mno = #{mno} AND mpw = #{mpw}")
	int passwordCheck(@Param("mno")int mno, @Param("mpw") String mpw) throws Exception;

	@Update("UPDATE member SET cash = cash + #{cash} WHERE mno = #{mno}")
	void addCash(@Param("mno") int mno, @Param("cash") int cash) throws Exception;

	@Insert("INSERT INTO mail_code(mno,mail_code) VALUES(#{mno},#{tempString})")
	void addMailCode(@Param("mno") int mno, @Param("tempString") String tempString) throws Exception;

	@Select("SELECT mail_code FROM mail_code WHERE mno = #{mno}")
	String getMailCode(int mno) throws Exception;

	@Select("SELECT COUNT(*) FROM likegoods WHERE mno = #{mno}")
	int getLikeGoodsCnt(int mno) throws Exception;

	@Select("SELECT * FROM goods WHERE gno = ANY(SELECT gno FROM likegoods WHERE mno = #{mno});")
	List<GoodsVO> getLikeGoodsList(int mno) throws Exception;

	@Select("SELECT * FROM order_com WHERE mno = #{mno} ORDER BY order_date DESC")
	List<OrderComVO> getOrderComList(int mno) throws Exception;

	@Select("SELECT * FROM goods_option")
	List<GoodsOptionVO> getGoodsOptionList() throws Exception;

	@Select("SELECT * FROM goods WHERE gno = #{gno}")
	GoodsVO getGoodsVO(int gno) throws Exception;

	@Select("SELECT * FROM order_com WHERE mno = #{mno} AND order_date BETWEEN DATE_ADD(now(),interval #{day} day) and now() ORDER BY order_date DESC")
	List<OrderComVO> getOrderComListAjax(@Param("mno")int mno,@Param("day") int day) throws Exception;

	@Select("SELECT * FROM order_member WHERE mno = #{mno} AND orderdate BETWEEN DATE_ADD(now(),interval #{day} day) AND now() ORDER BY orderdate DESC")
	List<OrderMemberVO> orderMemberList(@Param("mno")int mno, @Param("day")int day) throws Exception;

	@Select("SELECT * FROM order_member WHERE mno = #{mno} ORDER BY orderdate DESC")
	List<OrderMemberVO> orderMemberListAll(int mno) throws Exception;

	@Update("UPDATE order_member SET order_status = 3,status_reason = #{status_reason} WHERE orderno = #{orderno} ORDER BY orderdate DESC")
	int updateReason(@Param("orderno") int orderno,@Param("status_reason") int status_reason) throws Exception;

	@Update("UPDATE order_member SET order_status = 4, status_reason = #{exchange_reason} WHERE orderno = #{orderno} ORDER BY orderdate DESC")
	int updateExchangeReason(@Param("orderno") int orderno,@Param("exchange_reason") int exchange_reason) throws Exception;

	@Update("UPDATE order_member SET order_status = 5 WHERE orderno = #{orderno}")
	int cancelTransaction(int orderno) throws Exception;

	@Insert("INSERT INTO review(mno,gno,content,regdate,img,grade) VALUES(#{mno},#{gno},#{content},now(),#{img},#{grade})")
	int insertReview(ReviewVO vo) throws Exception;

	@Select("SELECT * FROM order_member WHERE orderno = #{orderno}")
	OrderMemberVO getOrderMember(int orderno) throws Exception;

	@Insert("INSERT INTO order_com(mno,count,price,order_date,ono,order_com_date) VALUES(#{mno},#{count},#{price},#{order_date},#{ono},now())")
	void insertOrderCom(OrderComVO orderCom) throws Exception;

	@Delete("DELETE FROM order_member WHERE orderno = #{orderno}")
	void deleteOrderMember(int orderno) throws Exception;

	@Select("SELECT * FROM qna_goods WHERE mno = #{mno} ORDER BY qno DESC LIMIT #{pageStart}, #{perPageNum}")
	List<QnaGoodsVO> getQnaGoodsList(@Param("mno") int mno,@Param("pageStart") int pageStart, @Param("perPageNum") int perPageNum) throws Exception;
	
	@Select("SELECT * FROM review WHERE mno = #{mno} ORDER BY rno DESC LIMIT #{pageStart}, #{perPageNum}")
	List<ReviewVO> getReviewList(@Param("mno") int mno,@Param("pageStart") int pageStart, @Param("perPageNum") int perPageNum) throws Exception;

	@Select("SELECT COUNT(*) FROM qna_goods WHERE mno = #{mno}")
	int getQuestionListCount(@Param("mno") int mno,@Param("pageStart") int pageStart, @Param("perPageNum") int perPageNum) throws Exception;

	@Select("SELECT COUNT(*) FROM review WHERE mno = #{mno}")
	int getReviewListCount(@Param("mno") int mno,@Param("pageStart") int pageStart, @Param("perPageNum") int perPageNum) throws Exception;

	@Select("SELECT * FROM qna_admin WHERE mno = #{mno} ORDER BY regdate DESC LIMIT #{pageStart},#{perPageNum}")
	List<QnaAdminVO> getQnaAdminList(@Param("mno") int mno,@Param("pageStart") int pageStart,@Param("perPageNum") int perPageNum) throws Exception;

	@Select("SELECT COUNT(*) FROM qna_admin WHERE mno = #{mno}")
	int getQnaAdminListCount(@Param("mno") int mno,@Param("pageStart") int pageStart,@Param("perPageNum") int perPageNum) throws Exception;

	@Insert("INSERT INTO qna_admin(mno,title,content) VALUES(#{mno},#{title},#{content})")
	void insertQnaAdmin(QnaAdminVO vo) throws Exception;

	@Insert("INSERT INTO mail_code(mail_code,email) VALUES(#{tempString},#{email})")
	void addMailFindCode(@Param("email") String email,@Param("tempString") String tempString) throws Exception;

	@Select("SELECT mail_code FROM mail_code WHERE email = #{email}")
	String getMailFindCode(String email) throws Exception;

	@Select("SELECT * FROM order_member WHERE orderno = #{orderno} AND order_email = #{order_email} AND order_phone = #{order_phone}")
	List<OrderMemberVO> orderNonMemberListAll(@Param("orderno") int orderno,@Param("order_email") String order_email,@Param("order_phone") String order_phone) throws Exception;

	@Select("SELECT COUNT(*) FROM coupon WHERE coupon_code = #{coupon_code}")
	int couponCheck(String coupon_code) throws Exception;

	@Select("SELECT check_use FROM member_coupon WHERE mno=#{mno} AND cno= #{cno}")
	String isUseCoupon(@Param("mno")int mno,@Param("cno") int cno) throws Exception;

	@Insert("INSERT INTO member_coupon VALUES(#{cno},#{mno},now(),'N')")
	void addCouponToMember(@Param("mno")int mno,@Param("cno") int cno) throws Exception;

	@Select("SELECT cno FROM coupon WHERE coupon_code = #{coupon_code}")
	int getCnoFromCouponCode(String coupon_code) throws Exception;

	@Select("SELECT COUNT(*) FROM member_coupon WHERE mno=#{mno}")
	int isUseCouponCnt(@Param("mno") int mno) throws Exception;
}
