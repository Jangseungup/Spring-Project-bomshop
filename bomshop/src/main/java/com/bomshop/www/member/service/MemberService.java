package com.bomshop.www.member.service;

import java.util.List;

import com.bomshop.www.common.vo.MemberVO;
import com.bomshop.www.member.vo.LoginDTO;
import com.bomshop.www.member.vo.MemberAddressVO;

public interface MemberService {

	boolean idCheck(String mid) throws Exception;

	boolean emailCheck(String memail) throws Exception;

	boolean addMember(MemberVO vo, String zipNo, String addr1, String addr2) throws Exception;

	MemberVO signIn(LoginDTO dto) throws Exception;

	MemberVO getUserById(String value) throws Exception;

	String updateAll(int mno, String memail, String mpw) throws Exception;

	String updatePassword(int mno, String mpw) throws Exception;

	List<MemberAddressVO> getAddrList(int mno) throws Exception;

	void addAddrInfo(MemberAddressVO vo) throws Exception;

	void deleteAddr(int mno, String memo) throws Exception;

	void setMainAddr(int mno, String memo) throws Exception;

	MemberVO getMember(int mno) throws Exception;

	void exchangeSeller(MemberVO vo) throws Exception;

	String findMemberID(String email) throws Exception;

	String updatePasswordUsingID(String email, String mpw) throws Exception;

	int blackMember(String mid) throws Exception;

}
