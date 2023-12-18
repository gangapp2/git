<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="trade.Trade" %>
<%@ page import="trade.TradeDAO" %>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.util.ArrayList"%>

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
		
		// 게시글 번호
		int tradeID = 0;
		if(request.getParameter("tradeID")!=null) {
			// 게시글 번호를 받아옴
			tradeID = Integer.parseInt(request.getParameter("tradeID"));
		}
		
		if(tradeID == 0) {
			PrintWriter script = response.getWriter();
			out.println("<script>");
			out.println("alert('유효하지 않은 글입니다');");
			out.println("location.href = 'trade.jsp'");
		    out.println("</script>");
		}
		
		Trade trade = new TradeDAO().getTrade(tradeID);
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
	
	<!-- 게시글 보기-->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%=trade.getTradeTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=trade.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= trade.getTradeDate().substring(0, 11) + trade.getTradeDate().substring(11, 13) + "시" + trade.getTradeDate().substring(14,16) + "분"%></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="height:500px; text-align: Left;"><%=trade.getTradeContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\n", "<br>")%></td>
					</tr>
				</tbody>
			</table>
			

			
			<!-- 댓글작성란-->
			<div class="container">
				<div class="row">
				<form method="post" action="commentAction.jsp">
					<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
						<tbody>
							<tr>
								<td><input type="text" class="form-control" placeholder="댓글" name="comment" maxlength="50"></td>
							</tr>
						</tbody>
					</table>
					<input type="submit" class="btn btn-pripary pull-right" value="댓글작성">
				</form>		
				</div> 
			</div>
			
			<div style="text-align: left; width: 100%;">
				<a href="trade.jsp" class="btn btn-primary">목록</a>
				<%
					if(userID != null && userID.equals(trade.getUserID())) {
				%>
						<a href="update.jsp?tradeID=<%= tradeID %>" class="btn btn-primary">수정</a>
						
						<a href="deleteAction.jsp?tradeID=<%= tradeID %>" class="btn btn-primary">삭제</a>
				<%		
					}
				%>	
        	</div>
		</div> 
		
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>





