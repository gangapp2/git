<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="User.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="user" class="User.User" scope="page"/>
<jsp:setProperty name="user" property="userID" param="userID"/>
<jsp:setProperty name="user" property="userPassword" param="userPassword"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>책 사세요 로그인</title>

</head>
<body>
	<%request.setCharacterEncoding("utf-8");%>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");	
		} else {
			out.println("로그인 되어있지 않습니다!");
			out.println("location.href = 'login.jsp';");
		}
		
		UserDAO userDAO = new UserDAO();
	    int result = userDAO.login(userID, user.getUserPassword()); // 세션에 저장된 값(현재 아이디), 입력한 비번 전달
	    
	    // 비번 일치시 회원정보수정 창으로 이동
	    if(result == 1){
	    	session.setAttribute("userPassword", user.getUserPassword());
	        out.println("<script>");
	        out.println("location.href = 'updateInfo_2.jsp';");
	        out.println("</script>");
	    }
	    //비번 틀리게 입력시 경고문 출력
	    else if(result == 0){
	        out.println("<script>");
	        out.println("alert('비밀번호가 틀립니다.');");
	        out.println("history.back();");
	        out.println("</script>");
	    }
	    //디비 오류
	    else if(result == -2){
	        out.println("<script>");
	        out.println("alert('데이터베이스 오류 발생');");
	        out.println("history.back();");
	        out.println("</script>");
	    }
		%>

</body>
</html>