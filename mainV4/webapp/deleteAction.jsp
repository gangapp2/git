<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="trade.TradeDAO" %>
<%@ page import="trade.Trade" %>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
		} 
		
		// 게시글 번호
		int tradeID = 0;

		if(request.getParameter("tradeID") != null) {
			if (session.getAttribute("tradeID") != null) {
			    // 세션에서 tradeID를 가져와서 int로 변환
			    tradeID = Integer.parseInt(session.getAttribute("tradeID").toString());
			} 
		}
		
		// 글이 없는 경우
		if(tradeID == 0) {
			out.println("<script>");
			out.println("alert('유효하지 않은 글입니다.')");
		    out.println("location.href = 'trade.jsp'");
		    out.println("</script>");
		}
		
		Trade trade = new TradeDAO().getTrade(tradeID);
		// 작성자와 사용자가 일치하는지 비교
		if(!userID.equals(trade.getUserID())) {
			out.println("<script>");
			out.println("alert('권한이 없습니다.')");
		    out.println("location.href = 'trade.jsp'");
		    out.println("</script>");
		}else {
			// 
			CommentDAO commentDAO = new CommentDAO();
			TradeDAO tradeDAO = new TradeDAO();
			
			int result = tradeDAO.delete(tradeID);
			int result2 = commentDAO.delete(tradeID);
			
		    if(result == -1){
		    	// db 오류
		    	out.println("<script>");
			    out.println("alert('게시글 삭제에 실패했습니다.');");
			    out.println("history.back();");
			    out.println("</script>");
		    }
		    else {
		    	// 글쓰기 성공
		        out.println("<script>");
		        out.println("alert('게시글이 삭제되었습니다.');");
		        out.println("location.href = 'trade.jsp'");
		        out.println("</script>");
		    }
		    
		    if(result == -1){
		    	// db 오류
		    	out.println("<script>");
			    out.println("alert('댓글 삭제에 실패했습니다.');");
			    out.println("</script>");
		    }
		    else {
		    	// 글쓰기 성공
		        out.println("<script>");
		        out.println("alert('댓글이 삭제되었습니다.');");
		        out.println("</script>");
		    }
			
		}    
	    
		%>

</body>
</html>