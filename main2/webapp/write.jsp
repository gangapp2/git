<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name='viewport' content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">

<title>책 사세요 웹 사이트</title>

</head>
<body>	
	<%
		String userID = null;
		// 로그인 한 사람이라면 userID 변수에 유저아이디가 담기고 아니면 null값 저장
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");	
		}
	%>
	<!-- 화면 상단 바 - (중고서적판매, 소통공간 , 접속하기)가 있는 상태바-->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">	
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>	
				<span class="icon-bar"></span>	
			</button>
			<a class="navbar-brand" href="trade.jsp">책 사세요 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a class="active" href="trade.jsp">중고 서적거래</a></li>
				<li><a href="communication.jsp">소통 공간</a></li>
			</ul>
			
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
						<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"> 마이페이지 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li ><a href="logoutAction.jsp">로그아웃</a></li>
						
						<!-- href="#" #은 추가해야할 jsp (회원정보수정은 회원가입 jsp 활용 , 
							회원 탈퇴는 logoutAction.jsp와 같이 데이터베이스에서 회원정보 삭제후, login페이지로 이동 -->
						
						<li><a href="updateInfo.jsp">회원정보 수정</a></li>
						<li><a href="unRegister.jsp">회원탈퇴</a></li>
					</ul>
						
				</li>
			</ul>
		</div>
	</nav>
	
	<div class="container">
		<div class="row">
		<form method="post" action="writeAction.jsp">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>

				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="tradeTitle" maxlength="50"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="글 내용" name="tradeContent" maxlength="4096" style="height:700px;"></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-pripary pull-right" value="글쓰기">
		</form>		
		</div> 
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>





