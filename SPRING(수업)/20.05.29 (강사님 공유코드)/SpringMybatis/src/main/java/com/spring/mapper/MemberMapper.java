package com.spring.mapper;
// mapper.xml�� ������ ��Ű���� �ҽ����� �����Ұ�  
/*
create table tab_mybatis (
  id varchar2(30) primary key,
  name varchar2(30),
  email varchar2(30),
  phone varchar2(30)
);
*/
import java.util.ArrayList;
import java.util.HashMap;

import com.spring.springmybatis.MemberVO;

public interface MemberMapper {
	ArrayList<MemberVO> getMembers();
	//ArrayList<MemberVO> getMembers(String t);
	//MemberVO getMember(String id);
	HashMap<String, String> getMember(String id); // HashMap �̿�� �߰��κ�
	//������ ������ ��� ���� ��ȯ�ϱ� ���� ��ȯ���� int�� ������
	int insertMember(MemberVO member); 
	void insertMember2(HashMap<String, String> map);
	void updateMember(MemberVO member);
	void deleteMember(String id);
	int getCount();
}