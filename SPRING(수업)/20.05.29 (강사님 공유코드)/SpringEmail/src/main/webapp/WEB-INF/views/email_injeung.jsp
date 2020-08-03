<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<br>
<form action="join_injeung.do" method="post"> <!-- 받아온 인증코드를 컨트롤러로 넘겨서 일치하는지 확인  -->
<input type="hidden" name="num" value="${num}">
<table border="1" width="450" height="70" align= "center">
	<tr>        
		<td align="center">
			 인증번호 입력 : <input type="number" name="email_injeung" 
			 	placeholder=" 인증번호를 입력하세요.">
             <input type="submit" name="submit" value="인증번호 전송">
        </td>
    </tr>
</table>
</form>

</body>
</html>
