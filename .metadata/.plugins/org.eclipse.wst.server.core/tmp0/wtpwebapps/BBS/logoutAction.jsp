<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> <!-- 어떤 버전을 쓸 거다라고 자동 인식 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title> <!--  -->
</head>
<body>
	<% // 이 안에 자바스크립트를 사용하겠다는 의미
		session.invalidate();
	%>	
	<script>
		location.href = 'main.jsp';
	</script>
</body>
</html> 