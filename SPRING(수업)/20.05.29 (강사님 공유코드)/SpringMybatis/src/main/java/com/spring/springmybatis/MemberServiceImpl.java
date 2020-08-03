package com.spring.springmybatis;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
 
	@Autowired
	private SqlSession sqlSession; // Mybatis(ibatis) ���̺귯���� �����ϴ� Ŭ����

	@Override
	public ArrayList<MemberVO> getMembers() { 
		ArrayList<MemberVO> memberList = new ArrayList<MemberVO>();
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		//getMembers()�� �޼ҵ��� mapper.xml�� id�� �����ؾ��Ѵ�.
		memberList = memberMapper.getMembers();
		System.out.println(memberMapper.getCount());
		//memberList = memberMapper.getMembers("tab_mybatis"); 
		
		return memberList;
	}

	@Override
	public void insertMember(MemberVO member) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		int res = memberMapper.insertMember(member); 
		System.out.println("res=" + res);
	}
	
	@Override
	public void insertMember2(HashMap<String, String> map) {
		System.out.println("hashmap");
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		memberMapper.insertMember2(map);
	}
	
	@Override
	public MemberVO getMember(String id) {
		MemberVO member = new MemberVO();
		HashMap<String, String> vo = new HashMap<String, String>();  // HashMap �̿�� �߰��κ�
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		//member = memberMapper.getMember(id);
		vo = memberMapper.getMember(id); 				// HashMap �̿�� �߰��κ�
		System.out.println("vo.id=" + vo.get("id")); 	// HashMap �̿�� �߰��κ�
		member.setId(vo.get("id")); 					// HashMap �̿�� �߰��κ�
		member.setName(vo.get("name")); 				// HashMap �̿�� �߰��κ�
		member.setEmail(vo.get("email")); 				// HashMap �̿�� �߰��κ�
		member.setPhone(vo.get("phone")); 				// HashMap �̿�� �߰��κ�
 		
		return member;
	}

	@Override
	public void updateMember(MemberVO member) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		memberMapper.updateMember(member);
	}
 
	@Override
	public void deleteMember(String id) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		memberMapper.deleteMember(id);
	}
}