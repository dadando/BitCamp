package com.spring.mapper;
// mapper.xml�� ������ ��Ű���� �ҽ����� �����Ұ�  

import java.util.ArrayList;

import com.spring.mybatissungjuk.SungjukVO;

public interface SungjukMapper {
	public ArrayList<SungjukVO> getSungjuklist();
	public int insertSungjuk(SungjukVO sungjukvo);
	public SungjukVO selectSungjuk(SungjukVO sungjukvo);
	public int updateSungjuk(SungjukVO sungjukvo);
	public int deleteSungjuk(SungjukVO sungjukvo);
}