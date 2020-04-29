package com.bomshop.www.goods.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bomshop.www.common.util.MailUtil;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.goods.service.GoodsService;
import com.bomshop.www.goods.vo.CartVO;
import com.bomshop.www.goods.vo.GoodsVO;
import com.bomshop.www.goods.vo.OrderComVO;
import com.bomshop.www.goods.vo.OrderTempVO;
import com.bomshop.www.goods.vo.OrderVO;
import com.bomshop.www.goods.vo.ReportGoodsVO;

@Controller
@RequestMapping("/goods/*")
public class GoodsController {

	@Inject
	GoodsService gs;

	@Inject
	ServletContext context;

	@Inject
	MailUtil mu;

	/*
	 * @GetMapping("main") public String goods_list(@ModelAttribute("cri")
	 * SearchCriteria cri, Model model) throws Exception {
	 * System.out.println("goods_list 요청"); // 신상품 목록 model.addAttribute("list",
	 * gs.list(cri)); // 베스트 목록 model.addAttribute("best_list", gs.best_list(cri));
	 * // 광고 목록 model.addAttribute("gnoList", gs.getAdvertise());
	 * model.addAttribute("pageMaker",gs.getPageMaker(cri)); return "goods/main"; }
	 */

	@GetMapping("detail")
	public String goods_detail(Model model, int gno) throws Exception {
		System.out.println("goods detail 요청");

		MemberVO member = gs.getUrl(gno);

		model.addAttribute("seller", member);
		model.addAttribute("goods", gs.detail(gno));
		model.addAttribute("color", gs.color(gno));
		model.addAttribute("size", gs.size(gno));
		return "goods/detail";
	}

	// 상품 목록 불러오기
	@GetMapping("list")
	public String list(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		// 베스트 목록
		model.addAttribute("list", gs.searchList(cri));
		model.addAttribute("pageMaker", gs.getPageMaker(cri));
		return "goods/list";
	}

	// 개인샵 링크
	@GetMapping("shopSearch")
	public String shopSearch(Model model, String shopname) throws Exception {
		int sellerMno = gs.getSellerMnoFromShopname(shopname);
		// shop 정보
		model.addAttribute("shopInfo", gs.getShopInfo(sellerMno));
		// shop의 상품들 정보
		model.addAttribute("shopGoodsList", gs.getShopGoodsList(sellerMno));
		model.addAttribute("like", gs.likecount(shopname));
		return "goods/shopInfo";
	}

	@GetMapping("cart")
	public String cart(HttpSession session, Model model) throws Exception {
		System.out.println("장바구니 요청");

		MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");

		if (memberInfo != null) {
			model.addAttribute("cart", gs.getCartList(memberInfo.getMno()));
		} else {
			// 비회원 장바구니
			model.addAttribute("cart", session.getAttribute("cart"));
		}
		return "goods/cart";
	}

	@PostMapping("cart")
	public String cart_mem(HttpSession session, RedirectAttributes rttr, HttpServletRequest request,
			HttpServletResponse response, int gno, String[] color, String[] size, int[] count, int[] price)
			throws Exception {
		System.out.println("member 장바구니 요청");

		List<CartVO> list = new ArrayList<>();
		for (int i = 0; i < color.length; i++) {
			CartVO vo = new CartVO();
			vo.setGno(gno);
			vo.setColor(color[i]);
			vo.setSize(size[i]);
			vo.setCount(count[i]);
			vo.setPrice(price[i] * count[i]);

			// ono 찾기
			int ono = gs.getOno(gno, color[i], size[i]);
			vo.setOno(ono);

			String gname = gs.getGname(gno);
			vo.setGname_ko(gname);

			list.add(vo);
		}
		System.out.println(list);
		MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");

		if (memberInfo != null) {
			// 디비에 넣기
			gs.reg_cart(memberInfo.getMno(), list);
			rttr.addFlashAttribute("message", "장바구니에 추가 되었습니다.");
		} else {
			// 그냥 세션에 넣자..
			if (session.getAttribute("cart") != null) {
				List<CartVO> cartList = (List<CartVO>) session.getAttribute("cart");
				list.addAll(cartList);
			}
			session.setAttribute("cart", list);

			rttr.addFlashAttribute("message", "장바구니에 추가 되었습니다.");
		}
		// rttr.addFlashAttribute("message", "장바구니에 추가 되었습니다.");
		return "redirect:/goods/detail?gno=" + gno;
	}

	//
	@PostMapping("orderDirect")
	public String order(HttpSession session, Model model, int gno, String[] color, String[] size, int[] count,
			int[] price) throws Exception {
		System.out.println("바로 구매하기 페이지 요청");

		MemberVO member = (MemberVO) session.getAttribute("memberInfo");
		List<CartVO> list = new ArrayList<>();
		CartVO vo = null;
		int totalPrice = 0;

		// 회원일 경우
		if (member != null) {
			for (int i = 0; i < color.length; i++) {
				vo = new CartVO();
				vo.setGno(gno);
				vo.setMno(member.getMno());
				vo.setColor(color[i]);
				vo.setSize(size[i]);
				vo.setCount(count[i]);
				vo.setPrice(price[i] * count[i]);
				totalPrice += price[i] * count[i];

				// ono 찾기
				int ono = gs.getOno(gno, color[i], size[i]);
				vo.setOno(ono);
				// 상품명 찾기
				vo.setGname_ko(gs.getGname(gno));
				list.add(vo);
			}
			model.addAttribute("couponList", gs.getCouponList(member.getMno(), totalPrice));
		} else {
			// 비회원일 경우
			for (int i = 0; i < color.length; i++) {
				vo = new CartVO();
				vo.setGno(gno);
				vo.setColor(color[i]);
				vo.setSize(size[i]);
				vo.setCount(count[i]);
				vo.setPrice(price[i] * count[i]);
				totalPrice += price[i] * count[i];

				// ono 찾기
				int ono = gs.getOno(gno, color[i], size[i]);
				vo.setOno(ono);
				// 상품명 찾기
				vo.setGname_ko(gs.getGname(gno));
				list.add(vo);
			}
		}
		model.addAttribute("list", list);
		model.addAttribute("totalPrice", totalPrice);

		return "goods/order";
	}

	@PostMapping("order")
	public String order(HttpSession session, OrderTempVO order, int[] ono, int[] count, int[] price, int[] cart_no,
			Model model, RedirectAttributes rttr) throws Exception {
		System.out.println("구매처리 요청");
		MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
		List<OrderVO> list = new ArrayList<>();
		List<OrderComVO> orderComList = new ArrayList<>();

		if (memberInfo != null) {
			// 회원구매
			for (int i = 0; i < ono.length; i++) {
				OrderVO vo = new OrderVO();
				vo.setOno(ono[i]);
				vo.setCount(count[i]);
				vo.setPrice(price[i]);
				vo.setOrder_name(order.getOrder_name());
				vo.setOrder_phone(order.getOrder_phone());
				vo.setOrder_email(order.getOrder_email());
				vo.setDelivery_name(order.getDelivery_name());
				vo.setDelivery_phone(order.getDelivery_phone());
				vo.setDelivery_addr1(order.getDelivery_addr1());
				vo.setDelivery_addr2(order.getDelivery_addr2());
				vo.setDelivery_post_code(order.getDelivery_post_code());
				list.add(vo);
			}
			// 주문
			orderComList = gs.order(list, order, cart_no, memberInfo.getMno());
		} else {
			for (int i = 0; i < ono.length; i++) {
				OrderVO vo = new OrderVO();
				vo.setOno(ono[i]);
				vo.setCount(count[i]);
				vo.setPrice(price[i]);
				vo.setOrder_name(order.getOrder_name());
				vo.setOrder_phone(order.getOrder_phone());
				vo.setOrder_email(order.getOrder_email());
				vo.setDelivery_name(order.getDelivery_name());
				vo.setDelivery_phone(order.getDelivery_phone());
				vo.setDelivery_addr1(order.getDelivery_addr1());
				vo.setDelivery_addr2(order.getDelivery_addr2());
				vo.setDelivery_post_code(order.getDelivery_post_code());
				list.add(vo);
			}
			// 비회원 주문
			orderComList = gs.orderNon(list, order);
		}
		// 주문완료 메일 발송
		mu.sendOrderComMail(orderComList);
		rttr.addFlashAttribute("message", "상품구매를 완료하였습니다.");
		return "redirect:/goods/main";
	}

	/*
	 * @PostMapping("orderNon") public String orderNon() throws Exception{
	 * 
	 * }
	 */

	@GetMapping("orderCart")
	public String order(int[] cart_no, Model model, HttpSession session) throws Exception {
		System.out.println("구매하기 페이지 요청");
		MemberVO member = (MemberVO) session.getAttribute("memberInfo");
		if (member != null) {
			// 로그인
			model.addAttribute("list", gs.getListByCartNo(cart_no));
			int totalPrice = gs.getTotalPrice(cart_no);
			System.out.println(totalPrice);
			model.addAttribute("couponList", gs.getCouponList(member.getMno(), totalPrice));
			model.addAttribute("totalPrice", totalPrice);
		} else {
			// 비로그인
			model.addAttribute("list", session.getAttribute("cart"));
		}
		return "goods/order";
	}

	// 상품신고
	@PostMapping("reportGoods")
	public ResponseEntity<String> enrollCoupon(@RequestBody ReportGoodsVO reportGoodsVO) {
		System.out.println("reportGoods");
		ResponseEntity<String> entity = null;

		try {
			System.out.print("couponVO : " + reportGoodsVO);
			gs.reportGoods(reportGoodsVO);
			entity = new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.OK);
		}

		return entity;
	}

	@PostMapping("deleteCart")
	public String deleteCart(int cart_no) {
		System.out.println(cart_no);
		gs.deleteCart(cart_no);

		return "redirect:/goods/cart";
	}

	@PostMapping("favorite")
	@ResponseBody
	public boolean favorite(@RequestParam("gno") int gno, @RequestParam("mno") int mno) throws Exception {
		System.out.println("controller 상품 좋아요 요청");

		return gs.favorite(mno, gno);
	}

	@GetMapping("favorite")
	@ResponseBody
	public boolean favCheck(int gno, int mno) throws Exception {

		boolean result = gs.favCheck(gno, mno);

		return result;
	}

	@GetMapping("getListByCategory")
	@ResponseBody
	public List<GoodsVO> getListByCategory(int mno, int type) throws Exception {
		List<GoodsVO> list = null;
		if (type == 0) {
			list = gs.getGoodsListByMnoAll(mno);
		} else {
			list = gs.getGoodsListByMnoType(mno, type);
		}
		return list;
	}

	@GetMapping("like")
	@ResponseBody
	public boolean likeCheck(@RequestParam("mno") int mno, @RequestParam("shopmno") int shopmno) throws Exception {

		boolean result = gs.likeCheck(mno, shopmno);

		return result;
	}

	@PostMapping("like")
	@ResponseBody
	public boolean like(@RequestParam("mno") int mno, @RequestParam("shopmno") int shopmno) throws Exception {
		System.out.println("controller 좋아요 요청");
		System.out.println("mno : " + mno + ", shopmno : " + shopmno);
		return gs.like(mno, shopmno);
	}
}
