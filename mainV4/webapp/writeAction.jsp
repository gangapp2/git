<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="trade.TradeDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="trade" class="trade.Trade" scope="page"/>
<jsp:setProperty name="trade" property="tradeTitle"/>
<jsp:setProperty name="trade" property="tradeContent"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>책 사세요 게시글작성</title>

</head>
<body>
	<%request.setCharacterEncoding("utf-8");%>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");	
		}
		if(userID == null){
			out.println("<script>");
			out.println("alert('로그인을 하세요');");
	        out.println("location.href = 'login.jsp'");
	        out.println("</script>");
		} else {
			// 로
			if(trade.getTradeTitle() == null || trade.getTradeContent() == null){
				PrintWriter script = response.getWriter();
				out.println("<script>");
				out.println("alert('모든 정보를 입력해주십시오.');");
			    out.println("history.back();");
			    out.println("</script>");
			}else{
			
				TradeDAO tradeDAO = new TradeDAO();
				// 첫 게시글 작성시 테이블 생성
				tradeDAO.createTradeTableIfNotExist();
				
				int result = tradeDAO.write(trade.getTradeTitle(),userID,trade.getTradeContent());
				
			    if(result == -1){
			    	// db 오류
			    	out.println("<script>");
				    out.println("alert('글쓰기에 실패했습니다.');");
				    out.println("history.back();");
				    out.println("</script>");
			    }
			    else {
			    	// 글쓰기 성공
			        out.println("<script>");
			        out.println("alert('게시글이 등록되었습니다.');");
			        out.println("location.href = 'trade.jsp'");
			        out.println("</script>");
			    }
			}
		}

	    
	    
		%>

</body>
</html>