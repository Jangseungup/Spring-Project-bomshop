package com.bomshop.www.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.member.vo.LoginDTO;
import com.bomshop.www.member.vo.MemberAddressVO;

public interface MemberDAO {

	@Select("SELECT COUNT(*) FROM member WHERE mid = #{mid}")
	public int idCheck(String mid) throws Exception;

	@Select("SELECT COUNT(*) FROM member WHERE memail = #{memail}")
	public int emailCheck(String memail) throws Exception;

	@Insert("INSERT INTO member(mid,mpw,memail) VALUES(#{mid},#{mpw},#{memail})")
	public boolean insertMember(MemberVO vo) throws Exception;

	@Insert("INSERT INTO member_address(mno,post_code,addr1,addr2,memo) VALUES(#{mno},#{zipNo},#{addr1},#{addr2},'기본주소지')")
	public void addMemberAddr(@Param("mno") int mno,@Param("zipNo") String zipNo, @Param("addr1") String addr1, @Param("addr2") String addr2);

	@Select("SELECT * FROM member WHERE mid=#{mid} AND mpw=#{mpw}")
	public MemberVO signIn(LoginDTO dto) throws Exception;

	@Select("SELECT * FROM member WHERE mid=#{value}")
	public MemberVO getUserById(String value) throws Exception;

	@Insert("INSERT INTO member_coupon(cno,mno,cdate) VALUES((SELECT cno FROM coupon WHERE coupon_code = '신규회원 가입기념'),"
			+ "#{mno}, date_add(now(),interval +1 month))")
	public void addMemberJoinCoupon(int mno) throws Exception;

	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId() throws Exception;

	@Update("UPDATE member SET memail = #{memail}, mpw = #{mpw} WHERE mno = #{mno}")
	public int updateAllMember(@Param("mno") int mno,@Param("memail") String memail,@Param("mpw") String mpw) throws Exception;

	@Update("UPDATE member SET mpw = #{mpw} WHERE mno = #{mno}")
	public int updatePassword(@Param("mno") int mno,@Param("mpw") String mpw) throws Exception;

	@Select("SELECT * FROM member_address WHERE mno = #{mno}")
	public List<MemberAddressVO> getAddrList(int mno) throws Exception;

	@Insert("INSERT INTO member_address(mno,post_code,addr1,addr2,memo) VALUES(#{mno},#{post_code},#{addr1},#{addr2},#{memo})")
	public void addAddrInfo(MemberAddressVO vo) throws Exception;

	@Delete("DELETE FROM member_address WHERE mno=#{mno} AND memo = #{memo}")
	public void deleteAddr(@Param("mno") int mno,@Param("memo") String memo) throws Exception;

	@Update("UPDATE member_address SET memo='기본주소지' WHERE mno=#{mno} AND memo = #{memo}")
	public void setMainAddr(@Param("mno")int mno, @Param("memo")String memo) throws Exception;

	@Update("UPDATE member_address SET memo='주소지' WHERE memo = '기본주소지' AND mno = #{mno}")
	public void updateOldMainAddr(@Param("mno")int mno, @Param("memo")String memo) throws Exception;

	@Select("SELECT * FROM member WHERE mno = #{mno}")
	public MemberVO getMember(int mno) throws Exception;

	@Update("UPDATE member SET mpoint = #{mpoint}, mgrade = #{mgrade}, gpoint = #{gpoint} WHERE mno = #{mno}")
	public void purchaseCompleteAfterMemberUpdate(MemberVO member) throws Exception;

	@Update("UPDATE member SET mtype=2, spw=#{spw},shopname=#{shopname},shopurl=#{shopurl},shopaddr1=#{shopaddr1},shopaddr2=#{shopaddr2},shop_post_code=#{shop_post_code},shopphone=#{shopphone},bankname=#{bankname},maccount=#{maccount},ex_type=#{ex_type} WHERE mno = #{mno}")
	public void excahngeSeller(MemberVO vo) throws Exception;

	@Select("SELECT mid FROM member WHERE memail = #{email}")
	public String findMemberID(String email) throws Exception;

	@Update("UPDATE member SET mpw = #{mpw} WHERE mid = #{mid}")
	public int updatePasswordUsingID(@Param("mid") String mid,@Param("mpw") String mpw);
	
	@Select("SELECT mno FROM member WHERE mid = #{mid}")
	public int blackMno(String mid) throws Exception;
	
	@Select("SELECT count(*) FROM blacklist WHERE black_mno = #{mno}")
	public int blackMember(int mno) throws Exception;
	
	
}
