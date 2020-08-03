<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.spring.springsungjuk.SungjukVO" %>
 
<%
	SungjukVO vo = (SungjukVO)request.getAttribute("vo");
%>
<html>
<head>
<title>성적관리 시스템 관리자모드(성적 수정 하기)</title>
</head>
<body>
<form name="updateform" action="sungjukupdate.su" method="post">
<center>
<table border=1 width=300>
	<input type="hidden" name="hakbun" value="<%=vo.getHakbun() %>">
	<tr>
		<td>학번 : </td>
		<td><%=vo.getHakbun() %></td>
	</tr>
	<tr>
		<td>이름 : </td>
		<td><%=vo.getIrum() %></td>
	</tr>
	<tr>
		<td>국어 : </td>
		<td><input type="text" name="kor" value="<%=vo.getKor() %>"></td>
	</tr>
	<tr>
		<td>영어 : </td>
		<td><input type="text" name="eng" value="<%=vo.getEng() %>"></td>
	</tr>
	<tr>
		<td>수학 : </td>
		<td><input type="text" name="math" value="<%=vo.getMath() %>"></td>
	</tr>
	<tr>
		<td colspan="2" align=center>
			<a href="javascript:updateform.submit()">성적수정</a>&nbsp;&nbsp;
			<a href="javascript:updateform.reset()">다시작성</a>
		</td>
	</tr>	
</table>
</center>
</body>
</html>
