package com.bomshop.www.common.task;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.bomshop.www.admin.dao.AdminDAO;
import com.bomshop.www.admin.member.OrderMemberVO;
import com.bomshop.www.admin.seller.vo.OrderComVO;
import com.bomshop.www.admin.vo.AdvertiseVO;


@Component
public class BomTask {

	@Inject
	AdminDAO adminDao;
	
	@Autowired
	ServletContext context;
	
	// 10초 마다 실행
	//@Scheduled(cron="*/10 * * * * *")
	public void test() {
		System.out.println("10초마다 실행");
	}
	
	// 종료 된 광고 제거
	@Scheduled(cron="0 0 0 * * *")
	@Transactional
	public void deleteAdvertise() throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		String date = sdf.format(new Date());
		List<AdvertiseVO> list = adminDao.selectEndAdvertise();
		for(AdvertiseVO av : list) {
			String path = context.getRealPath(File.separator+"upload/"+av.getGno());
			new File(path+File.separator+"AD.png").delete();
			System.out.println("삭제완료");
		}
		adminDao.endAdverties();
		// 판매기가 지난 상품 판매중지
		adminDao.Discontinued();
		System.out.println("매일 정각 : " + date);
	}
	
	// 장바구니 7일 후 삭제
	@Scheduled(cron="0 0 3 * * *")
	public void deleteCart() throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		String date = sdf.format(new Date());
		// 장바구니 삭제
		adminDao.deleteCart();
		List<OrderMemberVO> list = adminDao.selectOrderMember();
		for(OrderMemberVO omv : list) {
			// 자동 구매 확정
			adminDao.insertOrderCom(omv);
			// 자동 구매 확정된 상품 지우지
			adminDao.deleteOrderMember(omv);
		}
		// 구매확정된 상품 중 30일 지난 상품 지우기
		adminDao.deleteOrderCom();
		System.out.println("매일 3시 : " + date);
	}
	
	@Scheduled(cron="0 0 6 * * SAT")
	@Transactional
	public void goodsCalculate() throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		String date = sdf.format(new Date());
		List<OrderComVO>list = adminDao.comStatus();
		for(OrderComVO ocv : list) {
			adminDao.calculate(ocv);
			adminDao.updateStatus(ocv.getOrderno());
		}
		System.out.println("매주 토요일 6시 : " + date);
	}

}
