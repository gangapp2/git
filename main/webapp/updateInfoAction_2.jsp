<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="User.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="user" class="User.User" scope="page"/>
<jsp:setProperty name="user" property="userID" param="userID"/>
<jsp:setProperty name="user" property="userPassword" param="userPassword"/>
<jsp:setProperty name="user" property="userName" param="userName"/>
<jsp:setProperty name="user" property="phoneNum" param="phoneNum"/>
<jsp:setProperty name="user" property="birthDate" param="birthDate"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>책 사세요 로그인</title>

</head>
<body>
	<%request.setCharacterEncoding("utf-8");%>
	<%
		if(user.getUserPassword() == null || user.getUserName() == null ||
				user.getPhoneNum() == null || user.getBirthDate() == null){
			out.println("<script>");
			out.println("alert('모든 정보를 입력해주십시오.');");
		    out.println("history.back();");
		    out.println("</script>");
		}else{
			UserDAO userDAO = new UserDAO();
			
			// getAttribute로 현재 ID값을 받아옴
			String userID = null;
			if(session.getAttribute("userID") != null){
				userID = (String) session.getAttribute("userID");	
			}
			
		    int result = userDAO.changeInfo(user,userID); // 현재 ID를 넘겨줌으로써 ID와 같은 행의 정보를 변경
		    
		    if(result == 1){
		    	// 정보수정 완료
		    	out.println("<script>");
		    	out.println("alert('정보가 변경되었습니다.');");
			    out.println("location.href = 'trade.jsp'");
			    out.println("</script>");
		    }
		    else if(result == 0){
		    	//정보수정 실패
		        out.println("<script>");
		        out.println("alert('변경되지 않았습니다.');");
		        out.println("history.back();'");
		        out.println("</script>");
		    }
		    else{
		    	// db오류
		    	out.println("<script>");
		        out.println("alert('데이터베이스 오류');");
		        out.println("history.back();'");
		        out.println("</script>");
		    }

		}
		
		%>

</body>
</html>