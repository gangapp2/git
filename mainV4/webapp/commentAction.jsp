<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="comment.CommentDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="comment" class="comment.Comment" scope="page"/>

<jsp:setProperty name="comment" property="tradeComment"/>
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
			
				// 게시글 번호
				int tradeID = 0;
				if (session.getAttribute("tradeID") != null) {
				    // 세션에서 tradeID를 가져와서 int로 변환
				    tradeID = Integer.parseInt(session.getAttribute("tradeID").toString());
				} 
				
				if(request.getParameter("tradeID")!=null) {
					// 게시글 번호를 받아옴
					tradeID = Integer.parseInt(request.getParameter("tradeID"));
				}
				
				CommentDAO commentDAO = new CommentDAO();
				
				commentDAO.createCommentTableIfNotExist();
				
				int result = commentDAO.write(userID,comment.getTradeComment(),tradeID); // 전달값에 view에서 tradeID 전달, 시간 전달
				
			    if(result == -1){
			    	// db 오류
			    	out.println("<script>");
				    out.println("alert('댓글 등록에 실패했습니다.');");
				    out.println("history.back();");
				    out.println("</script>");
			    }
			    else {
			    	// 글쓰기 성공
			        out.println("<script>");
			        out.println("alert('댓글이 등록되었습니다.');");
			        out.println("location.href = 'trade.jsp'");
			        out.println("</script>");
			    }
			}
		}

	    
	    
		%>

</body>
</html>