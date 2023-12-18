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
    <title>책 사세요 회원탈퇴</title>
</head>
<body>
    <% request.setCharacterEncoding("utf-8"); %>
    <%
        // 로그인 상태 확인
        String userID = null;
        if (session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }

        if (userID == null) {
            // 로그인되어 있지 않은 경우
            out.println("<script>");
            out.println("alert('로그인이 필요합니다.');");
            out.println("location.href = 'login.jsp';");
            out.println("</script>");
        } else {
            UserDAO userDAO = new UserDAO();
            int result = userDAO.unregister(user.getUserID(), user.getUserPassword());

            if (result == 1) {
                // 회원탈퇴 성공
                session.removeAttribute("userID"); // 탈퇴할때 세션을뺐어 다시 로그인 가능하게 함
                out.println("<script>");
                out.println("alert('회원탈퇴가 완료되었습니다.');");
                out.println("location.href = 'login.jsp';"); // 로그아웃 페이지로 이동하거나 다른 처리를 할 수 있습니다.
                out.println("</script>");
            } else if (result == 0) {
                // 일치하는 사용자 정보가 없음
                out.println("<script>");
                out.println("alert('일치하는 사용자 정보가 없습니다.');");
                out.println("location.href = 'unRegister.jsp';"); // 메인 페이지로 이동하거나 다른 처리를 할 수 있습니다.
                out.println("</script>");
            } else {
                // 디비 오류
                out.println("<script>");
                out.println("alert('데이터베이스 오류 발생');");
                out.println("location.href = 'unRegister.jsp';"); // 메인 페이지로 이동하거나 다른 처리를 할 수 있습니다.
                out.println("</script>");
            }
        }
    %>
</body>
</html>
