package com.bomshop.www.member.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.member.dao.MemberDAO;
import com.bomshop.www.member.vo.LoginDTO;
import com.bomshop.www.member.vo.MemberAddressVO;

@Service
public class MemberServiceImpl implements MemberService{

	@Inject
	MemberDAO mDao;
	
	
	
	@Override
	public MemberVO getMember(int mno) throws Exception {
		return mDao.getMember(mno);
	}

	@Override
	public boolean idCheck(String mid) throws Exception {
		int resultCnt = mDao.idCheck(mid);
		if(resultCnt > 0) {
			return false;
		}
		return true;
	}

	@Override
	public boolean emailCheck(String memail) throws Exception {
		int resultCnt = mDao.emailCheck(memail);
		if(resultCnt > 0) {	// member 존재
			return false;
		}
		return true;
	}

	@Override
	@Transactional
	public boolean addMember(MemberVO vo, String zipNo, String addr1, String addr2) throws Exception {
			boolean isSuccess = mDao.insertMember(vo);
			int mno = mDao.getLastInsertId();
			mDao.addMemberAddr(mno,zipNo,addr1,addr2);
			mDao.addMemberJoinCoupon(mno);
			return isSuccess;
	}

	@Override
	public MemberVO signIn(LoginDTO dto) throws Exception {
		return mDao.signIn(dto);
	}

	@Override
	public MemberVO getUserById(String value) throws Exception {
		return mDao.getUserById(value);
	}

	@Override
	public String updateAll(int mno, String memail, String mpw) throws Exception {
		String msg = null;
		int isUpdate = mDao.updateAllMember(mno,memail,mpw);
		if(isUpdate > 0) {
			msg = "정보 수정 완료";
		}else {
			msg = "정보 수정 실패";
		}
		return msg;
	}

	@Override
	public String updatePassword(int mno, String mpw) throws Exception {
		String msg = null;
		int isUpdate = mDao.updatePassword(mno,mpw);
		if(isUpdate > 0) {
			msg = "정보 수정 완료";
		}else {
			msg = "정보 수정 실패";
		}
		return msg;
	}
	
	

	@Override
	public String updatePasswordUsingID(String mid, String mpw) throws Exception {
		String msg = null;
		int isUpdate = mDao.updatePasswordUsingID(mid,mpw);
		if(isUpdate > 0) {
			msg = "정보 수정 완료";
		}else {
			msg = "정보 수정 실패";
		}
		return msg;
	}

	@Override
	public List<MemberAddressVO> getAddrList(int mno) throws Exception {
		return mDao.getAddrList(mno);
	}

	@Override
	public void addAddrInfo(MemberAddressVO vo) throws Exception {
		mDao.addAddrInfo(vo);
	}

	@Override
	public void deleteAddr(int mno, String memo) throws Exception {
		mDao.deleteAddr(mno,memo);
	}

	@Override
	public void setMainAddr(int mno, String memo) throws Exception {
		mDao.updateOldMainAddr(mno,memo);
		mDao.setMainAddr(mno,memo);
	}

	@Override
	public void exchangeSeller(MemberVO vo) throws Exception {
		mDao.excahngeSeller(vo);
	}

	@Override
	public String findMemberID(String email) throws Exception {
		return mDao.findMemberID(email);
	}

	@Override
	public int blackMember(String mid) throws Exception {
		System.out.println("mid : " + mid);
		int mno = mDao.blackMno(mid);
		System.out.println("mno : " + mno);
		System.out.println("count : " + mDao.blackMember(mno));
		return mDao.blackMember(mno);
	}

}
