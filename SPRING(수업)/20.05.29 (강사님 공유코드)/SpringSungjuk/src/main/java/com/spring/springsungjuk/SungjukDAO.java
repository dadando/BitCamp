package com.spring.springsungjuk;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.springframework.stereotype.Repository;

@Repository
public class SungjukDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public ArrayList<SungjukVO> getSungjuklist()
	{
		SungjukVO vo = null;
		ArrayList<SungjukVO> sungjuk_list = new ArrayList<SungjukVO>();

		try
		{
			conn = JDBCUtil.getConnection();

			pstmt = conn.prepareStatement("select * from sungjuk order by hakbun");
			rs = pstmt.executeQuery();

			if (rs.next())
			{
				do
				{
					vo = new SungjukVO();
					vo.setHakbun(rs.getString("hakbun"));
					vo.setIrum(rs.getString("irum"));
					vo.setKor(rs.getInt("kor"));
					vo.setEng(rs.getInt("eng"));
					vo.setMath(rs.getInt("math"));
					vo.setTot(rs.getInt("tot"));
					vo.setAvg(rs.getDouble("avg"));
					vo.setGrade(rs.getString("grade"));
					
					sungjuk_list.add(vo);
				}while(rs.next());
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			JDBCUtil.closeResource(pstmt, conn);
		}

		return sungjuk_list;
	}
	
	public int insertSungjuk(SungjukVO sungjukvo)
	{ 
		int result = 0;

		try
		{
			conn = JDBCUtil.getConnection();

			sungjukvo.process();
			
			pstmt = conn.prepareStatement("insert into sungjuk values(?,?,?,?,?,?,?,?)");
			pstmt.setString(1, sungjukvo.getHakbun());
			pstmt.setString(2, sungjukvo.getIrum());
			pstmt.setInt(3, sungjukvo.getKor());
			pstmt.setInt(4, sungjukvo.getEng());
			pstmt.setInt(5, sungjukvo.getMath());
			pstmt.setInt(6, sungjukvo.getTot());
			pstmt.setDouble(7, sungjukvo.getAvg());
			pstmt.setString(8, sungjukvo.getGrade());
			result = pstmt.executeUpdate();
		}
		catch(Exception ex)
		{
			System.out.println("성적입력오류" + ex.getMessage());
			ex.printStackTrace();
		}
		finally
		{
			JDBCUtil.closeResource(pstmt, conn);
		}
		
		return result;
	}
	
	public SungjukVO selectSungjuk(SungjukVO sungjukvo) throws Exception
	{ 
		SungjukVO vo = null;

		try
		{
			conn = JDBCUtil.getConnection();

			pstmt = conn.prepareStatement("select * from sungjuk where hakbun = ?");
			pstmt.setString(1, sungjukvo.getHakbun());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new SungjukVO();
				vo.setHakbun(rs.getString("hakbun"));
				vo.setIrum(rs.getString("irum"));
				vo.setKor(rs.getInt("kor"));
				vo.setEng(rs.getInt("eng"));
				vo.setMath(rs.getInt("math"));
				vo.setTot(rs.getInt("tot"));
				vo.setAvg(rs.getDouble("avg"));
				vo.setGrade(rs.getString("grade"));
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			JDBCUtil.closeResource(pstmt, conn);
		}
		
		return vo;
	}
	
	public int updateSungjuk(SungjukVO sungjukvo) throws Exception
	{ 
		int result = 0;

		try
		{
			conn = JDBCUtil.getConnection();

			sungjukvo.process();
			
			pstmt = conn.prepareStatement("update sungjuk set kor=?, eng=?, math=?, tot=?, avg=?, grade=? where hakbun=?");
			pstmt.setInt(1, sungjukvo.getKor());
			pstmt.setInt(2, sungjukvo.getEng());
			pstmt.setInt(3, sungjukvo.getMath());
			pstmt.setInt(4, sungjukvo.getTot());
			pstmt.setDouble(5, sungjukvo.getAvg());
			pstmt.setString(6, sungjukvo.getGrade());
			pstmt.setString(7, sungjukvo.getHakbun());
			result = pstmt.executeUpdate();
		}
		catch(Exception ex)
		{
			System.out.println("성적수정오류" + ex.getMessage());
			ex.printStackTrace();
		}
		finally
		{
			JDBCUtil.closeResource(pstmt, conn);
		}
		
		return result;
	}
	
	public int deleteSungjuk(SungjukVO sungjukvo) throws Exception
	{ 
		int result = 0;

		try
		{
			conn = JDBCUtil.getConnection();

			pstmt = conn.prepareStatement("delete from sungjuk where hakbun = ?");
			pstmt.setString(1, sungjukvo.getHakbun());
			result = pstmt.executeUpdate();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			JDBCUtil.closeResource(pstmt, conn);
		}
		
		return result;
	}
}
