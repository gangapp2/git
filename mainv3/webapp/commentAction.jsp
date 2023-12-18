<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="comment.CommentDAO" %>
<jsp:useBean id="comment" class="comment.Comment" scope="page"/>

<jsp:setProperty name="trade" property="tradeComment"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>책 사세요 댓글작성</title>

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
			if(comment.getTradeComment()== null){
				PrintWriter script = response.getWriter();
				out.println("<script>");
				out.println("alert('댓글을 입력하세요.');");
			    out.println("history.back();");
			    out.println("</script>");
			} else{
			
				CommenetDAO commentDAO = new CommenetDAO();
				
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