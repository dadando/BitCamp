package com.spring.memberboard2.member;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired(required=false) 
	private MemberDAO memberDAO=null;
	
	@Override
	public int insertMember(MemberVO memberVO) {
		int res  = memberDAO.insertMember(memberVO); 
		
		return res;
	}

	@Override
	public int userCheck(MemberVO memberVO) {
		int res  = memberDAO.userCheck(memberVO); 
		
		return res;
	}

	@Override
	public ArrayList<MemberVO> getMemberlist() {
		ArrayList<MemberVO> member_list = new ArrayList<MemberVO>();
		member_list = memberDAO.getMemberlist();
	
		return member_list;
	}

	@Override
	public MemberVO selectMember(MemberVO memberVO) {
		MemberVO vo  = memberDAO.selectMember(memberVO);
			
		return vo;
	}

	@Override
	public int deleteMember(MemberVO memberVO) {
		int res = memberDAO.deleteMember(memberVO); 
		
		return res;
	}

}
