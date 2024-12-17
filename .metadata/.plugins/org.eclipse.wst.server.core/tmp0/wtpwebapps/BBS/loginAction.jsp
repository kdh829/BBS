<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> <!-- 클래스를 가져오겠다. -->
<%@ page import="java.io.PrintWriter"%> <!-- JAVA.IO에 있는 자바스크립트를 사용하겠다는 뜻 -->
<% request.setCharacterEncoding("UTF-8"); %> 
<jsp:useBean id="user" class="user.User" scope="page" /> <!-- ID 생성해주고 User라는 빈즈를 사용하겠다. 이 페이지에서만 이라는 뜻 -->
<jsp:setProperty name="user" property="userID"/> <!-- user라는 ID를 생성하고 userID를 특정해서 받겠다는 뜻 -->
<jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html> <!-- 어떤 버전을 쓸 거다라고 자동 인식 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title> <!--  -->
</head>
<body>
	<% // 이 안에 자바스크립트를 사용하겠다는 의미
		String userID = null;
		if(session.getAttribute("userID") != null) { // 세션 확인해서 사용자ID가 존재하면,
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO(); // 인스턴스 생성
		int result = userDAO.login(user.getUserID(), user.getUserPassword()); // 로그인 시도( 로그인 페이지에서 넘어온 값을 입력 )
		if (result == 1){ // 로그인 성공 시,
			session.setAttribute("userID", user.getUserID());			
			PrintWriter script = response.getWriter(); //하나의 스크립트 문장을 넣어주겠다는 의미
			script.println("<script>"); // 스크립트 문장을 유동적으로 사용하겠다. 하단과 같이
			script.println("location.href = 'main.jsp'"); 
			script.println("</script>");
		}
		else if (result == 0){ // 로그인 실패 시
			PrintWriter script = response.getWriter();
			script.println("<script>"); 
			script.println("alert('비밀번호가 틀립니다.')"); // 오류 메시지 출력과
			script.println("history.back()"); // 이전 화면으로 돌아간다.
			script.println("</script>");
		}
		else if (result == -1){ // ID가 존재하지 않을 때,
			PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않은 아이디입니다.')");
		script.println("history.back()");
		script.println("</script>");
		}
		else if (result == -2){ // DB 접속 실패할 때,
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} // MySQL에 접속하기 위해 드라이버를 추가해줄 필요가 있다.( .jar )
	%>	
</body>
</html> 