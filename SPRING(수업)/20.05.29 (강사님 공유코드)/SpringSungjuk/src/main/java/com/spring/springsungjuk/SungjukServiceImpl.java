package com.spring.springsungjuk;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("sungjukService")
public class SungjukServiceImpl implements SungjukService {

	@Autowired(required=false) 
	private SungjukDAO sungjukDAO=null; 
	
	@Override
	public int insertSungjuk(SungjukVO sungjukvo) throws Exception {

		int res = sungjukDAO.insertSungjuk(sungjukvo);
		
		return res;
	}

	@Override
	public ArrayList<SungjukVO> getSungjuklist() throws Exception {
		
		ArrayList<SungjukVO> list = sungjukDAO.getSungjuklist();
		
		return list;
	}

	@Override
	public SungjukVO selectSungjuk(SungjukVO sungjukvo) throws Exception {
		
		SungjukVO vo = sungjukDAO.selectSungjuk(sungjukvo);
		
		return vo;
	}

	@Override
	public int updateSungjuk(SungjukVO sungjukvo) throws Exception {

		int res = sungjukDAO.updateSungjuk(sungjukvo);
		
		return res;
	}

	@Override
	public int deleteSungjuk(SungjukVO sungjukvo) throws Exception {
		
		int res = sungjukDAO.deleteSungjuk(sungjukvo);
		
		return res;
	}
}
