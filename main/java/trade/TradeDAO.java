package trade;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class TradeDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public TradeDAO() {
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

		String SQL = "SELECT tradeID FROM trade ORDER BY tradeID DESC"; // 게시글 마지막 번호를 가져옴
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
	
	public int write(String tradeTitle, String userID, String tradeContent) {
		
		String SQL = "INSERT INTO trade VALUES (?,?,?,?,?,?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, getNext());
			pstmt.setString(2, tradeTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, tradeContent);
			pstmt.setInt(6, 1); // 1은 게시글이 등록된 상태, 0은 등록되지 않은 상태
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		// db 오류
		return -1;
	}
	
	public void createTradeTableIfNotExist() {
    	try {
            // 유저 테이블이 없는 경우에만 생성합니다.
            if (!isTableExists("trade")) {
                String createTableSQL = "CREATE TABLE trade ("
                        + "tradeID INT PRIMARY KEY,"
                        + "tradeTitle VARCHAR(50),"
                        + "userID VARCHAR(20),"
                        + "tradeDate DATETIME,"
                        + "tradeContent VARCHAR(4096),"
                        + "tradeAvialable INT"
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
    
}
