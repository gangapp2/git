<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name='viewport' content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">

<title>책 사세요 회원가입</title>

</head>
<body>
	<!-- 화면 상단 바 - (중고서적판매, 소통공간 , 접속하기)가 있는 상태바-->
	<nav class="navbar navbar-default">
			<div class="container text-center">
				<h1> 책 사세요 웹 사이트</h1>
			</div>
			
		</nav>
	<!-- 아래부터는 메인화면 css-->
	<div class="container"></div>
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;"> 
				<form method="post" action="signupAction.jsp">
					<h3 style="text-align: center;">회원가입</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="10">
					</div>
					<div class="form-group">
						<input type="tel" class="form-control" placeholder="핸드폰 번호 (-없이 입력)" name="phoneNum" maxlength="15">
					</div>
					<div class="form-group">
						<input type="date" class="form-control" name="birthDate">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="회원가입">	
				</form>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>





