	<%@ page language="java" contentType="text/html; charset=utf-8"
	    pageEncoding="utf-8"%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="utf-8">
	<meta name='viewport' content="width-device-width", initial-scale="1">
	<link rel="stylesheet" href="css/bootstrap.css">
	
	<title>책 사세요 회원탈퇴</title>
	
	</head>
	<body>
		<nav class="navbar navbar-default">
			<div class="container text-center">
				<h1> 회원 탈퇴</h1>
			</div>
			
		</nav>
		<div class="container"></div>
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="jumbotron" style="padding-top: 20px;"> 
					<form method="post" action="unRegisterAction.jsp">
						<h3 style="text-align: center;">정보를 입력하세요</h3>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
						</div>
						<input type="submit" class="btn btn-primary form-control" value="탈퇴하기" onclick="moveToSignupPage();">						
					</form>
			</div>
			
			<div class="col-lg-4"></div>
		</div>
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="js/bootstrap.js"></script>
		
		<script>
			function moveToLoginPage(){
				 window.location.href = 'login.jsp';
			}
		</script>
	</body>
	</html>
	
	
	
	
	
