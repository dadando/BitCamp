package com.spring.mybatissungjuk;

import java.util.ArrayList;

public interface SungjukService {
	public int insertSungjuk(SungjukVO sungjukvo) throws Exception;
	public ArrayList<SungjukVO> getSungjuklist() throws Exception;
	public SungjukVO selectSungjuk(SungjukVO sungjukvo) throws Exception;
	public int updateSungjuk(SungjukVO sungjukvo) throws Exception;
	public int deleteSungjuk(SungjukVO sungjukvo) throws Exception;
}
