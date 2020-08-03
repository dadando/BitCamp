<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.spring.springsungjuk.SungjukVO" %>
 
<%
	SungjukVO vo = (SungjukVO)request.getAttribute("vo");
%>
<html>
<head>
<title>성적관리 시스템</title>
</head>
<body>
<br /><br />
<center>
<%
if (vo != null)
{
%>
<table border=1 width=300>
	<tr align=center><td>학번 : </td><td><%=vo.getHakbun() %></td></tr>
	<tr align=center><td>이름 : </td><td><%=vo.getIrum() %></td></tr>
	<tr align=center><td>국어 : </td><td><%=vo.getKor() %></td></tr>
	<tr align=center><td>영어 : </td><td><%=vo.getEng() %></td></tr>
	<tr align=center><td>수학 : </td><td><%=vo.getMath() %></td></tr>
	<tr align=center><td>총점 : </td><td><%=vo.getTot() %></td></tr>
	<tr align=center><td>평균 : </td><td><%=vo.getAvg() %></td></tr>
	<tr align=center><td>등급 : </td><td><%=vo.getGrade() %></td></tr>

	<tr align=center>
		<td colspan=2><a href="sungjuklist.su">리스트로 돌아가기</a></td>
	</tr>
</table>
<%
}
else
{
%>
성적 입력 전입니다!!
<%
}
%>
</center>
</body>
</html>
