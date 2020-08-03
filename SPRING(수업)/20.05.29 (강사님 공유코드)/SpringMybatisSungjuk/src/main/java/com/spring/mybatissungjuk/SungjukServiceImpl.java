package com.spring.mybatissungjuk;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.SungjukMapper;

@Service("sungjukService")
public class SungjukServiceImpl implements SungjukService {

	@Autowired
	private SqlSession sqlSession; 
	
	@Override
	public int insertSungjuk(SungjukVO sungjukvo) throws Exception {
		// sqlSession 객체를 이용하여 sungjukMapper 객체 생성(필드로 생성)
		SungjukMapper sungjukMapper = sqlSession.getMapper(SungjukMapper.class);
		int res = sungjukMapper.insertSungjuk(sungjukvo);
		
		return res;
	}

	@Override
	public ArrayList<SungjukVO> getSungjuklist() throws Exception {
		SungjukMapper sungjukMapper = sqlSession.getMapper(SungjukMapper.class);
		ArrayList<SungjukVO> list = sungjukMapper.getSungjuklist();
		
		return list;
	}

	@Override
	public SungjukVO selectSungjuk(SungjukVO sungjukvo) throws Exception {
		SungjukMapper sungjukMapper = sqlSession.getMapper(SungjukMapper.class);
		SungjukVO vo = sungjukMapper.selectSungjuk(sungjukvo);
		
		return vo;
	}

	@Override
	public int updateSungjuk(SungjukVO sungjukvo) throws Exception {
		SungjukMapper sungjukMapper = sqlSession.getMapper(SungjukMapper.class);
		int res = sungjukMapper.updateSungjuk(sungjukvo);
		
		return res;
	}

	@Override
	public int deleteSungjuk(SungjukVO sungjukvo) throws Exception {
		SungjukMapper sungjukMapper = sqlSession.getMapper(SungjukMapper.class);
		int res = sungjukMapper.deleteSungjuk(sungjukvo);
		
		return res;
	}
}
