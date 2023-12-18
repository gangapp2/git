package User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	//로그인을 위한 함수.
	public int login(String userID, String userPassword) {
		//유저테이블에서 해당 사용자의 비밀번호를 가져옴
		String SQL = "SELECT userPassword FROM user WHERE userID = ?";
		try {
			//ptsmt에 정해진 sql문장을 가져옴
			pstmt = conn.prepareStatement(SQL);
			//준비해놓은 sql문장에 있는 ? 에 userID를 넣어줌
			pstmt.setString(1,userID);
			//결과를 담을 객체(rs)에 pstmt로 실행한 결과를 넣어줌
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공
				}
				else {
					return 0; //비밀번호 불일치
				}
			}
			
			return -1; //아이디 없음. rs.next()가 실행안될경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //디비오류
	}
		
	public int signup(User user) {
		
		String SQL = "INSERT INTO user VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getPhoneNum());
			pstmt.setString(5, user.getBirthDate());
			
			//insert문은 성공시 반드시 0이상의 숫자가 반환됨 따라서 -1이반환되는것이 아닌 이상 성공적으로 회원가입
			return pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //디비오류
	}
	
	// 회원정보수정 함수
	public int changeInfo(User user,String userID) {
	    String SQL = "UPDATE user SET userPassword=?, userName=?, phoneNum=?, birthDate=? WHERE userID=?";
	    
	    try {
	        pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, user.getUserPassword());
	        pstmt.setString(2, user.getUserName());
	        pstmt.setString(3, user.getPhoneNum());
	        pstmt.setString(4, user.getBirthDate());
	        pstmt.setString(5,userID); // 현재 ID값
	        
	        // executeUpdate는 영향을 받은 행의 수를 반환합니다
	        int rowsAffected = pstmt.executeUpdate();
	        
	        if (rowsAffected > 0) {
	            // 행이 성공적으로 업데이트되었습니다.
	            return 1;
	        } else {
	            // 행이 업데이트되지 않았습니다. 사용자 ID가 존재하지 않을 수 있습니다.
	            return 0;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        // 메모리 누수를 방지하기 위해 리소스(PreparedStatement, ResultSet)를 닫습니다.
	        closeResources();
	    }
	    return -1; // 데이터베이스 오류
	}

	// 리소스를 닫기 위한 메서드 추가
	private void closeResources() {
	    try {
	        if (pstmt != null) {
	            pstmt.close();
	        }
	        if (rs != null) {
	            rs.close();
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	// 회원탈퇴 함수
	public int unregister(String userID, String userPassword) {
	    // 유저테이블에서 해당 사용자의 정보를 삭제합니다.
	    String SQL = "DELETE FROM user WHERE userID = ? AND userPassword = ?";
	    try {
	        pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userID);
	        pstmt.setString(2, userPassword);
	        int result = pstmt.executeUpdate();
	        
	        if (result > 0) {
	            return 1; // 삭제 성공
	        } else {
	            return 0; // 일치하는 사용자 정보가 없음
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // 디비 오류
	}
	
	// 테이블을 생성합니다.
    public void createUserTableIfNotExist() {
    	try {
            // 유저 테이블이 없는 경우에만 생성합니다.
            if (!isTableExists("user")) {
                String createTableSQL = "CREATE TABLE user ("
                        + "userID VARCHAR(20) PRIMARY KEY,"
                        + "userPassword VARCHAR(20),"
                        + "userName VARCHAR(10),"
                        + "phoneNum VARCHAR(15),"
                        + "birthDate VARCHAR(15)"
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




