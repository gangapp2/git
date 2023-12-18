package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class CommentDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public CommentDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/member";
			String dbID = "root";
			String dbPass = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPass);
			
		} catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		// 현재 시간을 가져오는 함수 (게시판 작성시 서버시간)
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				// 현재 날짜 반환 성공
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	// 몇번째 게시글인지 찾느 함수
	public int getNext() {

		String SQL = "SELECT commentID FROM comment ORDER BY commentID DESC"; // 게시글 마지막 번호를 가져옴
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1; // 인덱스값 + 1
			}
			return 1; // 첫 번쨰 게시글인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(String userID, String tradeComment,int tradeID) {
		
		String SQL = "INSERT INTO comment VALUES (?,?,?,?,?,?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, tradeComment);
			pstmt.setInt(4, 1);
			pstmt.setInt(5, tradeID);
			pstmt.setString(6,getDate());
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		// db 오류
		return -1;
	}
	
	public void createCommentTableIfNotExist() {
    	try {
            // 유저 테이블이 없는 경우에만 생성합니다.
            if (!isTableExists("comment")) {
                String createTableSQL = "CREATE TABLE comment ("
                		  + "commentID INT PRIMARY KEY,"
                          + "userID VARCHAR(20),"
                          + "tradeComment VARCHAR(200),"
                          + "commentAvailable INT,"
                          + "tradeID INT,"
                          + "commentDate DATETIME"
                          + ")";
                
                pstmt = conn.prepareStatement(createTableSQL);
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	// 테이블이 존재하는지 확인하는 메서드
    private boolean isTableExists(String tableName) {
        try {
            // MySQL에서 테이블이 존재하는지 확인하는 쿼리
            String checkTableSQL = "SHOW TABLES LIKE ?";
            pstmt = conn.prepareStatement(checkTableSQL);
            pstmt.setString(1, tableName);
            rs = pstmt.executeQuery();
            return rs.next(); // 테이블이 존재하면 true, 그렇지 않으면 false 반환
        } catch (Exception e) {
            e.printStackTrace();
            return false; // 오류 발생 시 false 반환
        }
    }
	
 // CommentDAO.java의 getList 메서드 수정
    public ArrayList<Comment> getList(int pageNumber, int tradeID) {
        String SQL = "SELECT * FROM comment WHERE commentID < ? AND tradeID = ? AND commentAvailable = 1 ORDER BY commentID DESC LIMIT 5";
        ArrayList<Comment> list = new ArrayList<Comment>();

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 5); // 페이지 번호
            pstmt.setInt(2, tradeID); // tradeID 조건 추가
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Comment comment = new Comment();
                comment.setCommentID(rs.getInt(1));
                comment.setUserID(rs.getString(2));
                comment.setTradeComment(rs.getString(3));
                comment.setCommentAvailable(rs.getInt(4));
                comment.setTradeID(rs.getInt(5));
                comment.setCommentDate(rs.getString(6));
                list.add(comment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

	
	// 최대 게시글 단위로 끊기는 경우에는 다음 페이지를 표시하면 안됨
    public boolean nextPage(int pageNumber) {
    	String SQL = "SELECT * FROM comment WHERE commentID < ? AND commentAvailable = 1";
    	
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 5); // 페이지 번호
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
    }
    
    // 게시글 불러오는 함수
    public Comment getComment(int commentID) {
    	// 게시글 번호에 해당하는 글을 가져옴
    	String SQL = "SELECT * FROM comment WHERE commentID = ?";
    	try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, commentID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				Comment comment = new Comment();
				comment.setCommentID(rs.getInt(1));
				comment.setUserID(rs.getString(2));
				comment.setTradeComment(rs.getString(3));
				comment.setCommentAvailable(rs.getInt(4));
				comment.setTradeID(rs.getInt(5));
				comment.setCommentDate(rs.getString(6));
				return comment;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
    }
    
    public int delete(int tradeID) {
    	String SQL = "UPDATE comment SET commentAvailable = 0 WHERE tradeID = ?";
    	
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, tradeID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		// db 오류
		return -1;
    }

}
