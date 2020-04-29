package com.bomshop.www.seller.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.seller.vo.AdvertiseVO;
import com.bomshop.www.seller.vo.GoodsVO;

public interface SellerAdvertisingManageDAO {

	//	총 광고 관련 개수(광고 신청 대기, 광고 중, 광고 종료 직전)
	@Select("SELECT count(*) FROM advertise WHERE gno=ANY(SELECT gno FROM goods WHERE mno=#{mno})")
	int getTotalCount(int mno);

	//	광고중인 상품 개수
	@Select("SELECT count(*) FROM advertise WHERE astatus=1 AND gno=ANY(SELECT gno FROM goods WHERE mno=#{mno})")
	int getAdvertisingCount(int mno);

	//	광고 신청 대기 개수
	@Select("SELECT count(*) FROM advertise WHERE astatus=0 AND gno=ANY(SELECT gno FROM goods WHERE mno=#{mno})")
	int getAwaitingAdvertisingCount(int mno);

	//	광고 종료 3일전 개수
	@Select("SELECT count(*) FROM advertise WHERE astatus=1 AND adate < DATE_ADD(now(),INTERVAL 3 DAY)"
			+ " AND gno=ANY(SELECT gno FROM goods WHERE mno=#{mno})")
	int getAdvertisingEndCount(int mno);

	//	총 광고 관리 리스트 
	@Select("SELECT a.*, b.gname_ko FROM advertise a, goods b WHERE a.gno = b.gno AND a.gno=ANY(SELECT gno FROM goods WHERE mno=#{mno})"
			+ " ORDER BY a.ano DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<AdvertiseVO> getTotalADList(@Param("cri")SearchCriteria cri, @Param("mno")int mno);

	//	광고 중 리스트
	@Select("SELECT a.*, b.gname_ko FROM advertise a, goods b WHERE a.gno = b.gno AND a.astatus=1"
			+ " AND a.gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}) ORDER BY a.ano DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<AdvertiseVO> getADList(@Param("cri")SearchCriteria cri, @Param("mno")int mno);

	//	광고 신청 대기 리스트
	@Select("SELECT a.*, b.gname_ko FROM advertise a, goods b WHERE a.gno = b.gno AND a.astatus=0"
			+ " AND a.gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}) ORDER BY a.ano DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<AdvertiseVO> getAwaitingADList(@Param("cri")SearchCriteria cri, @Param("mno")int mno);

	//	광고 종료 3일전 리스트
	@Select("SELECT a.*, b.gname_ko FROM advertise a, goods b WHERE a.gno = b.gno AND a.astatus=1 AND adate < DATE_ADD(now(),INTERVAL 3 DAY)"
			+ " AND a.gno=ANY(SELECT gno FROM goods WHERE mno=#{mno}) ORDER BY a.ano DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<AdvertiseVO> getADEndList(@Param("cri")SearchCriteria cri, @Param("mno")int mno);

	//	광고 신청 가능한 상품 리스트
	@Select("SELECT * FROM goods WHERE mno=#{mno} AND gno!=ALL(SELECT gno FROM advertise)"
			+ " ORDER BY gno DESC limit #{cri.pageStart},#{cri.perPageNum}")
	List<GoodsVO> getGoodsListForAD(@Param("cri")SearchCriteria cri, @Param("mno")int mno);

	//	광고 신청 가능한 상품 개수
	@Select("SELECT count(*) FROM goods WHERE mno=#{mno} AND gno!=ALL(SELECT gno FROM advertise)")
	int getGoodsListForADCount(int mno);

	//	광고 신청 취소
	@Delete("DELETE FROM advertise WHERE ano=#{ano}")
	void cancelAD(int ano);
	
	//	광고 신청
	@Insert("INSERT INTO advertise VALUES(null, #{gno}, now(), 0)")
	void applicationAD(int gno);

}
