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
<title>�������� �ý��� �����ڸ��(���� ���� �ϱ�)</title>
</head>
<body>
<form name="updateform" action="sungjukupdate.su" method="post">
<center>
<table border=1 width=300>
	<input type="hidden" name="hakbun" value="<%=vo.getHakbun() %>">
	<tr>
		<td>�й� : </td>
		<td><%=vo.getHakbun() %></td>
	</tr>
	<tr>
		<td>�̸� : </td>
		<td><%=vo.getIrum() %></td>
	</tr>
	<tr>
		<td>���� : </td>
		<td><input type="text" name="kor" value="<%=vo.getKor() %>"></td>
	</tr>
	<tr>
		<td>���� : </td>
		<td><input type="text" name="eng" value="<%=vo.getEng() %>"></td>
	</tr>
	<tr>
		<td>���� : </td>
		<td><input type="text" name="math" value="<%=vo.getMath() %>"></td>
	</tr>
	<tr>
		<td colspan="2" align=center>
			<a href="javascript:updateform.submit()">��������</a>&nbsp;&nbsp;
			<a href="javascript:updateform.reset()">�ٽ��ۼ�</a>
		</td>
	</tr>	
</table>
</center>
</body>
</html>
