	<%@ page language="java" contentType="text/html; charset=utf-8"
	    pageEncoding="utf-8"%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="utf-8">
	<meta name='viewport' content="width-device-width", initial-scale="1">
	<link rel="stylesheet" href="css/bootstrap.css">
	
	<title>책 사세요 로그인</title>
	
	</head>
	<body>
		<nav class="navbar navbar-default">
			<div class="container text-center">
				<h1> 책 사세요 웹 사이트</h1>
			</div>
			
		</nav>
		<div class="container"></div>
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="jumbotron" style="padding-top: 20px;"> 
					<form method="post" action="updateInfoAction.jsp">
						<h3 style="text-align: center;">회원정보수정</h3>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호를 입력하세요" name="userPassword" maxlength="20">
						</div>
						<input type="submit" class="btn btn-primary form-control" value="비밀번호 확인">					
					</form>
			</div>
			
			<div class="col-lg-4"></div>
		</div>
	</body>
	</html>
	
	
	
	
	
