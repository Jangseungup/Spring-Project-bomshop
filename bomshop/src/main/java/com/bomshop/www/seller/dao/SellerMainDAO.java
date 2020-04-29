package com.bomshop.www.seller.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.seller.vo.CommentVO;
import com.bomshop.www.seller.vo.GoodsOptionVO;
import com.bomshop.www.seller.vo.GoodsVO;
import com.bomshop.www.seller.vo.QnAAdminVO;

public interface SellerMainDAO {

	//	goods 테이블에 상품 등록
	@Insert("INSERT INTO goods(cat1,cat2,gname_ko,gname_en,tag1,tag2,tag3,sdate,cost_origin,cost,"
			+ "img1,gdetail,gexchange,gmodel,mno)"
			+ " VALUES(#{goods.cat1},#{goods.cat2},#{goods.gname_ko},#{goods.gname_en},#{goods.tag1},#{goods.tag2},#{goods.tag3},"
			+ "DATE_ADD(now(),INTERVAL #{goods.setSdate} DAY),#{goods.cost_origin},#{goods.cost},'temp.jpg',"
			+ "#{goods.gdetail},#{goods.gexchange},#{goods.gmodel},#{mno})")
	void goodsRegister(@Param("mno")int mno,@Param("goods") GoodsVO goods);

	//	등록된 상품 gno 가져오기
	@Select("SELECT LAST_INSERT_ID() FROM DUAL")
	int getInsertGno();

	//	goods_option 테이블에 옵션 등록
	@Insert("INSERT INTO goods_option VALUES(null,#{gno},#{vo.size},#{vo.color},#{vo.count})")
	void optionRegister(@Param("gno")int gno,@Param("vo") GoodsOptionVO vo);

	//	이미지 주소 수정
	@Update("UPDATE goods SET img1=#{img1},img2=#{img2},img3=#{img3},img4=#{img4},gdetail=#{gdetail} WHERE gno=#{gno}")
	void updateImg(GoodsVO goods);

	//	이미지 파일 이름 임시 저장
	@Insert("INSERT INTO temp_img VALUES(#{temp_img})")
	void addTempImg(String fileName);

	//	이미지 파일 이름 가져오기
	@Select("SELECT * FROM temp_img")
	List<String> getTempImg();

	//	이미지 파일 이름 지우기
	@Delete("DELETE FROM temp_img")
	void tempImgEmpty();

	//	회원 정보 가져오기
	@Select("SELECT * FROM member WHERE mno=#{mno}")
	MemberVO getMemberInfo(int mno);

	//	상점 정보 수정
	@Update("UPDATE member SET shopname=#{shopname},shop_post_code=#{shop_post_code},shopaddr1=#{shopaddr1},"
			+ "shopaddr2=#{shopaddr2},shopphone=#{shopphone},bankname=#{bankname},maccount=#{maccount} WHERE mno=#{mno}")
	void privacyModify(MemberVO vo);

	//	문의하기 리스트
	@Select("SELECT * FROM qna_admin WHERE mno=#{mno} ORDER BY qano DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<QnAAdminVO> getQnAList(@Param("cri") SearchCriteria cri, @Param("mno") int mno);

	//	문의하기 총 개수
	@Select("SELECT count(*) FROM qna_admin WHERE mno=#{mno}")
	int getQnATotalCount(int mno);

	//	문의하기 가져오기
	@Select("SELECT * FROM qna_admin WHERE qano=#{qano}")
	QnAAdminVO getQnA(int qano);

	//	문의답변 가져오기
	@Select("SELECT * FROM comment WHERE qano=#{qano}")
	CommentVO getComment(int qano);

	//	문의 작성하기
	@Insert("INSERT INTO qna_admin VALUES(null, #{mno}, #{title}, #{content}, now(), 'N')")
	void addQuestion(QnAAdminVO vo);

}
