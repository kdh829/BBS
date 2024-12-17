<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> <!-- 클래스를 가져오겠다. -->
<%@ page import="java.io.PrintWriter"%> <!-- JAVA.IO에 있는 자바스크립트를 사용하겠다는 뜻 -->
<% request.setCharacterEncoding("UTF-8"); %> 
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/> <!-- ID 생성해주고 User라는 빈즈를 사용하겠다. 이 페이지에서만 이라는 뜻 -->
<jsp:setProperty name="bbs" property="bbsTitle"/> <!-- user라는 ID를 생성하고 userID를 특정해서 받겠다는 뜻 -->
<jsp:setProperty name="bbs" property="bbsContent"/>
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
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>"); 
		} else {
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) 
			{	
				PrintWriter script = response.getWriter(); // 하나의 스크립트 문장을 넣어주겠다.
				script.println("<script>"); // 스크립트 문장을 유동적으로 사용하겠다. 하단과 같이 
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else { 
				BbsDAO bbsDAO = new BbsDAO(); // 인스턴스 생성
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent()); // 로그인 시도( 로그인 페이지에서 넘어온 값을 입력 )
			if (result == -1){ // 글쓰기에 실패하면,
				PrintWriter script = response.getWriter(); //하나의 스크립트 문장을 넣어주겠다는 의미
				script.println("<script>"); // 스크립트 문장을 유동적으로 사용하겠다. 하단과 같이
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {				
				PrintWriter script = response.getWriter();
				script.println("<script>"); 
				script.println("location.href = 'bbs.jsp'"); // 오류 메시지 출력과
				script.println("</script>");
			 }
		}
		}
	%>	
</body>
</html> 