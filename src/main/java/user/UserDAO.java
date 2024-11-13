package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.DriverManager; // 드라이버용 라이브러리

public class UserDAO {

	private Connection conn; // DB에 접근하게 해주는 하나의 객체
	private PreparedStatement pstmt; // 어떤 정해진 문장을 DB에 삽입
	private ResultSet rs; // 어떤 정보를 담을 수 있느 하나의 객체
	// Ctrl + Shift + Key 'O' -> 외부 라이브러리를 추가
	
	public UserDAO() { // 생성자
		try { // 자동 db 커넥션이 이뤄지도록 함
			String dbURL = "jdbc:mysql//localhost:3306/BBS3";
			String dbID = "root";
			String dbPassword = "bently2021@"; // 계정 로그인하기
			Class.forName("com.mysql.jdbc.Driver"); // mysql 드라이브 접속( mysql 접속용 라이브러리 역할 )
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // conn - 접속 정보 담기는 객체
		} catch (Exception e) { // 예외처리
			e.printStackTrace(); // 오류가 뭔지 출력
		}
	}
// 미리 매개변수 ID, PW를 가져온다 -> SQL 명령문을 작성( 조건에 ? 삽입 ) -> 예외처리하여 실행 잘 되면, ID를 조건으로 PW를 알아낸다.
// 근데 만약, 잘 실행되지 않으면 StackTrace 즉, 어떤 오류인지 메시지와 함께 오류를 출력한다.
		public int login(String userID, String userPassword) { // 매개변수로 넘어옴
			String SQL = "SELECT userPassword FROM USER WHERE userID = ?"; // 명령문
			try { // 예외처리
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID); // 해킹 기법을 방어하기 위함 SQL 문장의 (?)에 삽입
				rs = pstmt.executeQuery(); // 결과 값이 도출된다.
				if (rs.next()) {
					if(rs.getString(1).equals(userPassword)) { // 아이디가 있으면 PW를 받아서
						return 1; // 로그인 성공 출력 -> 함수 강제 종료
					}
					else
						return 0; // 비밀번호 불일치
				} 
				return -1; //데이터가 없으면 아이디가 없다고 메시지가 뜬다.
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -2; // DB 오류
		}
}
