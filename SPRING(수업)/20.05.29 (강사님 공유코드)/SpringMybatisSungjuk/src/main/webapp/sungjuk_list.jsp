<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "com.spring.mybatissungjuk.SungjukVO" %>
<%
	ArrayList<SungjukVO> sungjuk_list = (ArrayList<SungjukVO>)request.getAttribute("sungjuk_list");
%>
<html>
<head>
<title>성적관리 시스템 관리자모드(성적 목록 보기)</title>
</head>
<body>
<center>
<table border=1 width=300>
	<tr align=center>
		<td colspan=2><B>성적 목록</B></td>
		<td><a href="sungjukinputform.su">성적입력</a></td>
	</tr>
<%
	for (int i=0; i<sungjuk_list.size(); i++)
	{
		SungjukVO vo = (SungjukVO)sungjuk_list.get(i);
	
%>
	<tr align=center>
		<td>
			<a href="sungjukinfo.su?hakbun=<%=vo.getHakbun() %>"><%=vo.getHakbun() %></a>
		</td>
		<td><a href="sungjukupdateform.su?hakbun=<%=vo.getHakbun() %>">수정</a></td>
		<td><a href="sungjukdelete.su?hakbun=<%=vo.getHakbun() %>">삭제</a></td>
	</tr>
<%
	} 
%>
</table>
</center>
</body>
</html>
