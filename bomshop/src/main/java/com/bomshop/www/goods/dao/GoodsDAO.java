package com.bomshop.www.goods.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;

import com.bomshop.www.admin.vo.CouponVO;
import com.bomshop.www.common.util.Criteria;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.goods.provider.GoodsQueryProvider;
import com.bomshop.www.goods.vo.AdvertiseVO;
import com.bomshop.www.goods.vo.CartVO;
import com.bomshop.www.goods.vo.GoodsVO;
import com.bomshop.www.goods.vo.Goods_OptionVO;
import com.bomshop.www.goods.vo.OrderComVO;
import com.bomshop.www.goods.vo.OrderVO;
import com.bomshop.www.goods.vo.ReportGoodsVO;

public interface GoodsDAO {

	  // 상품 목록 불러오기 (검색된 게시물 페이징처리)
	   @SelectProvider(type=GoodsQueryProvider.class, method="searchSelectSql")
	   List<GoodsVO> goods_list(SearchCriteria cri) throws Exception;
	   
	   // 상품 개수 검색 (검색어)
	   @SelectProvider(type=GoodsQueryProvider.class, method="searchSelectCount")
	   int goodsListCount(SearchCriteria cri) throws Exception;
	   
	   // 상품 목록(메인)
	   @Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' ORDER BY gno DESC LIMIT 10")
	   List<GoodsVO> list(SearchCriteria cri) throws Exception;
	   
	   // 상품 목록(전체-desc gno)
	   @Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' ORDER BY gno DESC")
	   List<GoodsVO> n_list(SearchCriteria cri) throws Exception;
	   
	   // 베스트 목록 불러오기(메인화면용)
	   @Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' ORDER BY scount DESC LIMIT 10")
	   List<GoodsVO> best_list(SearchCriteria cri) throws Exception;
	   
	   // 베스트 목록 불러오기(더보기)
	   @Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' ORDER BY scount DESC")
	   List<GoodsVO> b_list(SearchCriteria cri) throws Exception;
	   
	   //	검색상품 불러오기
	   @Select("SELECT DISTINCT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND (g.gname_ko LIKE CONCAT('%',#{keyword},'%')"
	   		+ " OR g.tag1 LIKE CONCAT('%',#{keyword},'%') OR g.tag2 LIKE CONCAT('%',#{keyword},'%') OR g.tag3 LIKE CONCAT('%',#{keyword},'%'))")
	   List<GoodsVO> getList(SearchCriteria cri);
	   
	   // 등록된 상품 전체 개수
	   @Select("SELECT count(*) FROM goods WHERE gstatus = 'Y'")
	   int goodsCount(SearchCriteria cri) throws Exception;

	   // 상품번호로 상품정보 불러오기
	   @Select("SELECT g.*, m.shopname, m.shopurl, m.shopaddr1, m.shopaddr2, m.shop_post_code, m.shopphone FROM goods g LEFT OUTER JOIN member m on g.mno = m.mno WHERE gno = #{gno}")
	   GoodsVO readDetail(int gno) throws Exception;
	   
	   // 상품번호로 색상 불러오기
	   @Select("SELECT DISTINCT color FROM goods_option WHERE gno = #{gno}")
	   List<Goods_OptionVO> option_color(int gno) throws Exception;

	   // 상품번호로 사이즈 불러오기
	   @Select("SELECT DISTINCT size FROM goods_option WHERE gno = #{gno}")
	   List<Goods_OptionVO> option_size(int gno) throws Exception;

	   // 상품번호로 판매자정보 불러오기
	   @Select("SELECT * FROM member WHERE mno = (SELECT mno FROM goods WHERE gno = #{gno})")
	   MemberVO getUrl(int gno) throws Exception;

	   // 회원번호로 판매목록 가져오기
	   @Select("SELECT * FROM goods WHERE mno = #{mno}")
	   List<GoodsVO> sale(int mno) throws Exception;
	   
	   // ono 검색
	   @Select("SELECT ono FROM goods_option WHERE gno = #{gno} AND color = #{color} AND size = #{size}")
	   int getOno(@Param("gno") int gno, @Param("color") String color, @Param("size") String size ) throws Exception;
	   
	   // 장바구니 등록
	   @Insert("INSERT INTO cart(mno,ono,count,price) VALUES(#{mno},#{vo.ono},#{vo.count},#{vo.price})")
	   void reg_cart(@Param("mno")int mno, @Param("vo")CartVO cartVO) throws Exception;

	// 좋아요 추가
	@Insert("INSERT INTO likegoods(mno, gno) VALUES(#{mno}, #{gno})")
	void favorite(@Param("mno")int mno,@Param("gno") int gno) throws Exception;

	@Select("SELECT count(*) FROM likegoods WHERE mno = #{mno} AND gno = #{gno}")   
	int checkFavorite(@Param("mno")int mno,@Param("gno") int gno);

	@Delete("DELETE FROM likegoods WHERE mno= #{mno} AND gno = #{gno}")
	void deleteFavorite(@Param("mno")int mno, @Param("gno")int gno);

	// 회원 장바구니 목록
	@Select("SELECT a.*, b.gno, b.gname_ko, b.img1, c.color, c.size FROM cart a, goods b, goods_option c"
			+ " WHERE a.ono = c.ono AND b.gno = c.gno AND a.mno = #{mno}")
	List<CartVO> getCartList(int mno);

	// 상품 이름 찾기
	@Select("SELECT gname_ko FROM goods WHERE gno = #{gno}")
	String getGname(int gno);

	//	번호로 장바구니 가져오기
	@Select("SELECT a.*, b.gno, b.gname_ko, b.img1, c.color, c.size FROM cart a, goods b, goods_option c"
			+ " WHERE a.ono = c.ono AND b.gno = c.gno AND a.cart_no = #{cart_no}")
	CartVO getCartByNo(int cart_no);

	// 장바구니 삭제
	@Delete("DELETE FROM cart WHERE cart_no = #{cart_no}")
	void deleteCart(int cart_no);

	@Select("SELECT price FROM cart WHERE cart_no = #{i}")
	int getPrice(int i) throws Exception;

	// 회원별 쿠폰리스트 가져오기
	@Select("SELECT * FROM coupon WHERE cno = ANY(SELECT cno FROM member_coupon WHERE mno = #{mno} AND check_use = 'N') AND climit <= #{totalPrice}")
	List<CouponVO> getCouponList(@Param("mno") int mno,@Param("totalPrice") int totalPrice) throws Exception;

	// 회원 상품 구매
	@Insert("INSERT INTO order_member VALUES(null,#{ono},#{mno},#{count},#{price},now(),#{order_name},#{delivery_name},#{order_phone},"
			+ "#{delivery_phone},#{order_email},#{delivery_post_code},#{delivery_addr1},#{delivery_addr2},0,'N',0,null)")
	void order(OrderVO vo);

	// point 사용 수정
	@Update("UPDATE member SET mpoint = mpoint-#{mpoint} WHERE mno=#{mno}")
	void usePoint(@Param("mpoint")int mpoint,@Param("mno") int mno);

	// 쿠폰 사용 수정
	@Update("UPDATE member_coupon SET check_use = 'Y' WHERE mno=#{mno} AND cno=#{cno}")
	void useCoupon(@Param("cno")int cno, @Param("mno")int mno);

	// 캐쉬 사용 수정
	@Update("UPDATE member SET cash = cash-#{totalPrice} WHERE mno=#{mno}")
	void useCash(@Param("totalPrice")int totalPrice, @Param("mno")int mno);

	// 비회원 상품 구매
	@Insert("INSERT INTO order_member VALUES(null,#{ono},null,#{count},#{price},now(),#{order_name},#{delivery_name},#{order_phone},"
			+ "#{delivery_phone},#{order_email},#{delivery_post_code},#{delivery_addr1},#{delivery_addr2},0,'N',0,null)")
	void orderNon(OrderVO vo);

	//	방금 등록한 주문번호 가져오기 
	@Select("SELECT LAST_INSERT_ID()")
	int getOrderNo();

	//	색상, 사이즈 가져오기
	@Select("SELECT color,size FROM goods_option WHERE ono=#{ono}")
	OrderComVO getOrderComVO(int ono);

	//	상품명 가져오기
	@Select("SELECT gname_ko FROM goods WHERE gno=(SELECT gno FROM goods_option WHERE ono=#{ono})")
	String getGnameByOno(int ono);

	//	광고중인 상품 번호
	@Select("SELECT * FROM advertise WHERE astatus = 1 AND adate > now()")
	List<AdvertiseVO> getAdvertise();

	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat1 = 1 ORDER BY gno DESC")
	List<GoodsVO> getOuterList(SearchCriteria cri);
	
	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat1 = 2 ORDER BY gno DESC")
	List<GoodsVO> getTopClothList(SearchCriteria cri);

	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat1 = 3 ORDER BY gno DESC")
	List<GoodsVO> getDownClothList(SearchCriteria cri);
	
	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat1 = 4 ORDER BY gno DESC")
	List<GoodsVO> getEtcClothList(SearchCriteria cri);
	
	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat1 = 5 ORDER BY gno DESC")
	List<GoodsVO> getAccList(SearchCriteria cri);

	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 1 ORDER BY gno DESC")
	List<GoodsVO> getPadingList(SearchCriteria cri);

	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 2 ORDER BY gno DESC")
	List<GoodsVO> getCoutList(SearchCriteria cri);

	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 3 ORDER BY gno DESC")
	List<GoodsVO> getJaketList(SearchCriteria cri);

	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 4 ORDER BY gno DESC")
	List<GoodsVO> getLongTshirtList(SearchCriteria cri);

	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 5 ORDER BY gno DESC")
	List<GoodsVO> getShortTshirtList(SearchCriteria cri);

	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 6 ORDER BY gno DESC")
	List<GoodsVO> getMtoMList(SearchCriteria cri);

	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 7 ORDER BY gno DESC")
	List<GoodsVO> getHudList(SearchCriteria cri);

	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 8 ORDER BY gno DESC")
	List<GoodsVO> JeanList(SearchCriteria cri);

	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 9 ORDER BY gno DESC")
	List<GoodsVO> shortJean(SearchCriteria cri);

	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 10 ORDER BY gno DESC")
	List<GoodsVO> casualJean(SearchCriteria cri);

	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 11 ORDER BY gno DESC")
	List<GoodsVO> trainingList(SearchCriteria cri);
	
	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 12 ORDER BY gno DESC")
	List<GoodsVO> junjangList(SearchCriteria cri);
	
	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 14 ORDER BY gno DESC")
	List<GoodsVO> jobClothList(SearchCriteria cri);
	
	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 13 ORDER BY gno DESC")
	List<GoodsVO> hanbokList(SearchCriteria cri);
	
	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 15 ORDER BY gno DESC")
	List<GoodsVO> waterClothList(SearchCriteria cri);
	
	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 16 ORDER BY gno DESC")
	List<GoodsVO> bagList(SearchCriteria cri);
	
	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 17 ORDER BY gno DESC")
	List<GoodsVO> shoseList(SearchCriteria cri);
	
	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 18 ORDER BY gno DESC")
	List<GoodsVO> beltList(SearchCriteria cri);
	
	@Select("SELECT g.*, m.shopname, m.shopurl FROM goods g, member m WHERE g.mno = m.mno AND g.gstatus = 'Y' AND cat2 = 19 ORDER BY gno DESC")
	List<GoodsVO> tieList(SearchCriteria cri);

	@Select("SELECT mno FROM member WHERE shopname = #{shopname}")
	int getSellerMnoFromShopname(String shopname) throws Exception;

	@Select("SELECT * FROM member WHERE mno = #{sellerMno}")
	MemberVO getShopInfo(int sellerMno) throws Exception;

	@Select("SELECT * FROM goods WHERE mno = #{sellerMno}")
	List<GoodsVO> getShopGoodsList(int sellerMno) throws Exception;

	@Select("SELECT * FROM goods WHERE mno = #{mno} AND cat1 = #{type}")
	List<GoodsVO> getGoodsListByMnoType(@Param("mno") int mno,@Param("type") int type) throws Exception;

	@Select("SELECT * FROM goods WHERE mno = #{mno}")
	List<GoodsVO> getGoodsListByMnoAll(int mno) throws Exception;

	@Select("SELECT count(*) FROM likeshop WHERE mno = #{mno} AND shopmno = #{shopmno}")
	int likeCheck(@Param("mno") int mno,@Param("shopmno") int shopmno) throws Exception;
	
	@Insert("INSERT INTO likeshop(mno, shopmno) VALUES(#{mno}, #{shopmno})")
	void like(@Param("mno") int mno,@Param("shopmno") int shopmno);
	
	@Delete("DELETE FROM likeshop WHERE mno= #{mno} AND shopmno = #{shopmno}")
	void deleteLike(@Param("mno") int mno,@Param("shopmno") int shopmno);

	@Update("UPDATE member SET likecount = likecount - 1 WHERE mno=#{shopmno}")
	void downLike(int shopmno);

	@Update("UPDATE member SET likecount = likecount + 1 WHERE mno=#{shopmno}")
	void upLike(int shopmno);
	
	// 개인샵 좋아요 수
	@Select("SELECT mno,likecount FROM member WHERE shopname=#{shopname}")
	GoodsVO likecount(String shopname);
	
	// 신고자 mno
	@Select("SELECT mno FROM member WHERE mid = #{reportId}")
	int getMno(String reportId);
	
	// 상품신고
	@Insert("INSERT INTO report_goods VALUES(null,#{mno},#{gno},now(),#{reason},0)")
	void reportGoods(ReportGoodsVO reportGoodsVO);
	
}
