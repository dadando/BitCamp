<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page import="com.spring.springhelloex04.MemberVO" %>
<%
MemberVO vo = (MemberVO)request.getAttribute("vo");

String hobby_res = "";
int i;
for (i=0; i<vo.getHobby().length - 1; i++)
{
	hobby_res += vo.getHobby()[i] + ", ";
}
hobby_res += vo.getHobby()[i];
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<br>
<table align="center" border="1">
<tr>
	<td width="80">&nbsp;아이디</td>
	<td width="170">&nbsp;<%=vo.getId() %></td>
</tr>
<tr>
	<td width="80">&nbsp;비밀번호</td>
	<td width="170">&nbsp;<%=vo.getPw() %></td>
</tr>
<tr>
	<td width="80">&nbsp;주민번호</td>
	<td width="170">&nbsp;<%=vo.getJumin1() %>-<%=vo.getJumin2() %></td>
</tr>
<tr>
	<td width="80">&nbsp;성별</td>
	<td width="170">&nbsp;<%=vo.getGender() %></td>
</tr>
<tr>
	<td width="80">&nbsp;전화번호</td>
	<td width="170">&nbsp;<%=vo.getTel1() %>-<%=vo.getTel2() %>-<%=vo.getTel3() %></td>
</tr>
<tr>
	<td width="80">&nbsp;이메일</td>
	<td width="170">&nbsp;<%=vo.getEmail1() %>@<%=vo.getEmail2() %></td>
</tr>
<tr>
	<td width="80">&nbsp;취미</td>
	<td width="170">&nbsp;<%=hobby_res %> </td>
</tr>
<tr>
	<td width="80">&nbsp;자기소개</td>
	<td width="170">&nbsp;<%=vo.getIntro() %></td>
</tr>
</table>
</body>
</html>