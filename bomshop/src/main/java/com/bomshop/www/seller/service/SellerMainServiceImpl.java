package com.bomshop.www.seller.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.bomshop.www.common.util.PageMaker;
import com.bomshop.www.common.util.SearchCriteria;
import com.bomshop.www.common.util.SellerFileUpload;
import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.seller.dao.SellerMainDAO;
import com.bomshop.www.seller.dao.SellerOrderManageDAO;
import com.bomshop.www.seller.vo.CommentVO;
import com.bomshop.www.seller.vo.GoodsOptionVO;
import com.bomshop.www.seller.vo.GoodsVO;
import com.bomshop.www.seller.vo.QnAAdminVO;

@Service
public class SellerMainServiceImpl implements SellerMainService{
	
	@Inject
	SellerMainDAO dao;
	
	@Inject
	SellerOrderManageDAO sellerOrderManageDAO; 
	
	@Autowired
	ServletContext context;

	@Override
	public int getUnconfirmedOrderCount(int mno)  throws Exception{
		return sellerOrderManageDAO.getUnconfirmedOrderCount(mno);
	}

	@Override
	@Transactional
	public void goodsRegister(int mno, GoodsVO goods, List<GoodsOptionVO> list,
			MultipartFile mainImg, MultipartFile[] subImg) throws Exception {
		//	상품 등록
		dao.goodsRegister(mno, goods);
		//	상품 번호 가져오기
		int gno = dao.getInsertGno();
		goods.setGno(gno);
		//	옵션 등록
		for(GoodsOptionVO vo : list) {
			dao.optionRegister(gno, vo);
		}
		String uploadPath = context.getRealPath(File.separator+"upload");

		//	상품 메인 이미지 업로드
		goods.setImg1(SellerFileUpload.uploadMainImg(gno, uploadPath, mainImg.getBytes()));
		List<MultipartFile> subList = new ArrayList<>();
		for(int i=0; i<subImg.length; i++) {
			if(!subImg[i].isEmpty()) {
				subList.add(subImg[i]);
			}
		}
		
		//	상품 서브 이미지 업로드
		if(subImg != null) {
			String subImgNames[] = SellerFileUpload.uploadSubImg(gno, uploadPath, subList);
			if(subImgNames.length == 1) {
				goods.setImg2(subImgNames[0]);
			}else if(subImgNames.length == 2) {
				goods.setImg2(subImgNames[0]);
				goods.setImg3(subImgNames[1]);
			}else if(subImgNames.length == 3) {
				goods.setImg2(subImgNames[0]);
				goods.setImg3(subImgNames[1]);
				goods.setImg4(subImgNames[2]);
			}
		}
		//	상품 상세 정보 수정
		List<String> temp_img = dao.getTempImg();
		goods.setGdetail(SellerFileUpload.changeDetailImg(gno, uploadPath, goods.getGdetail(), temp_img));
		dao.tempImgEmpty();
		//	상품 이미지 주소 수정
		dao.updateImg(goods);
	}

	@Override
	public void addTempImg(String fileName) throws Exception {
		dao.addTempImg(fileName);
	}

	@Override
	public MemberVO getMemberInfo(int mno) {
		return dao.getMemberInfo(mno);
	}

	@Override
	public void privacyModify(MemberVO vo) {
		dao.privacyModify(vo);
	}

	@Override
	public List<QnAAdminVO> getQnAList(SearchCriteria cri, int mno) {
		return dao.getQnAList(cri, mno);
	}

	@Override
	public PageMaker getQnAPageMaker(SearchCriteria cri, int mno) {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.getQnATotalCount(mno));
		return pageMaker;
	}

	@Override
	public QnAAdminVO getQnA(int qano) {
		return dao.getQnA(qano);
	}

	@Override
	public CommentVO getComment(int qano) {
		return dao.getComment(qano);
	}

	@Override
	public void addQuestion(QnAAdminVO vo) {
		dao.addQuestion(vo);
	}
	
	
}
