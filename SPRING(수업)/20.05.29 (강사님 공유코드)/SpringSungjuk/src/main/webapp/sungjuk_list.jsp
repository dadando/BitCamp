<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "com.spring.springsungjuk.SungjukVO" %>
<%
	ArrayList<SungjukVO> sungjuk_list = (ArrayList<SungjukVO>)request.getAttribute("sungjuk_list");
%>
<html>
<head>
<title>己利包府 矫胶袍 包府磊葛靛(己利 格废 焊扁)</title>
</head>
<body>
<center>
<table border=1 width=300>
	<tr align=center>
		<td colspan=2><B>己利 格废</B></td>
		<td><a href="sungjukinputform.su">己利涝仿</a></td>
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
		<td><a href="sungjukupdateform.su?hakbun=<%=vo.getHakbun() %>">荐沥</a></td>
		<td><a href="sungjukdelete.su?hakbun=<%=vo.getHakbun() %>">昏力</a></td>
	</tr>
<%
	} 
%>
</table>
</center>
</body>
</html>
