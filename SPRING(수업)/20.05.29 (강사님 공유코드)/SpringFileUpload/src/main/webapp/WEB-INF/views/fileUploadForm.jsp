<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Home</title>
</head>
<body>
<h1>Hello world! File Upload!!</h1>
<form id="multiform" action="fileUpload2.bo" method="post" enctype="multipart/form-data">
    이름 : <input type="text" name="name" /> <br/><br/>
    파일 : <input type="file" name="file" /> <br/><br/>
    <input type="button" value="서버전달1" onclick="fnAction('fileUpload1.bo')"/>
    <input type="button" value="서버전달2" onclick="fnAction('fileUpload2.bo')"/>
</form>
<script>
    function fnAction(url) {
        var frm = document.getElementById("multiform");
        frm.action = url;
        frm.submit();
    }
</script>
</body>
</html>