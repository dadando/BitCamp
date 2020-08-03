<%@ page language="java" contentType="text/html; charset=utf-8"%>
<html>
<head>
<title>성적관리 시스템 성적입력 페이지</title>
</head>
<body>
<form name="sungjukform" action="sungjukinput.su" method="post">
<center>
<table border=1>
	<tr>
		<td colspan="2" align=center>
			<b><font size=5>성적입력 페이지</font></b>
		</td>
	</tr>
	<tr><td>학번 : </td><td><input type="text" name="hakbun"/></td></tr>
	<tr><td>이름 : </td><td><input type="text" name="irum"/></td></tr>
	<tr><td>국어 : </td><td><input type="text" name="kor" maxlength=3 size=5/></td></tr>
	<tr><td>영어 : </td><td><input type="text" name="eng" maxlength=3 size=5/></td></tr>
	<tr><td>수학 : </td><td><input type="text" name="math" maxlength=3 size=5/></td></tr>
	<tr>
		<td colspan="2" align=center>
			<a href="javascript:sungjukform.submit()">성적입력</a>&nbsp;&nbsp;
			<a href="javascript:sungjukform.reset()">다시작성</a>
		</td>
	</tr>
</table>
</center>
</form>
</body>
</html>
