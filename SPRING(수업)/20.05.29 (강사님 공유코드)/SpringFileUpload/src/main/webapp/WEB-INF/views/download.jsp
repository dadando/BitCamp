<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Home</title>
</head>
<body>
<h1>
    업로드 완료  
</h1>
    이름 : ${name} <br/><br/>
    <c:if test="${not empty fileName}">
	    파라미터이름: ${paramName} <br/>
	    파일명:    ${fileName}<br/>
	    파일사이즈: ${fileSize}<br/>
    	<a href="${downlink}">다운로드</a><br />
    	<img src="<spring:url value='/upload/${storedFileName }' />" /><br /><br />
    	<img src="/springfileupload/upload/${storedFileName }" />
    </c:if>
    <br>
</body>
</html>