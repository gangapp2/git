<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>책 사세요 로그인</title>

</head>
<body>
	<%
		session.removeAttribute("userID"); // 탈퇴할때 세션을뺐어 다시 로그인 가능하게 함
	%>

	<script>
		location.href = 'login.jsp';
	</script>
</body>
</html>