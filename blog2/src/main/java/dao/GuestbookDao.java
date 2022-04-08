package dao;

import java.util.ArrayList;
import vo.Guestbook;
import java.sql.*;

public class GuestbookDao {
	public GuestbookDao() {} // 생성자 메서드
	
	// updateGuestbookForm.jsp에서 호출
	public Guestbook selectGuestbookOne(int guestbookNo) throws Exception {
		Guestbook guestbook = null; // class 선언 후 초기화
		
		// MySql 드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// MySql RDBMS에 접속(IP주소, 접속계정 아이디, 패스워드)
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		// SQL 쿼리를 문자열로 저장
		String sql = 
			"SELECT guestbook_no guestbookNo, guestbook_content guestbookContent FROM guestbook WHERE guestbook_no = ?";
		// guestbook 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, guestbookNo);
		// 디버깅 코드
		System.out.println(stmt + " <-- sql selectGuestbookOne");
		// 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴
		rs = stmt.executeQuery();
		
		// DB 자원 가공
		if(rs.next()) {
			guestbook = new Guestbook(); // 생성자메서드
			guestbook.guestbookNo = rs.getInt("guestbookNo");
			guestbook.guestbookContent = rs.getString("guestbookContent");
		}
		// DB 자원들 반환, 종료
		rs.close();
		stmt.close();
		conn.close();
		return guestbook;
	}
	
	// updateGuestbookAction.jsp에서 호출
	// 이름 - uddateGuestbook
	// 반환값 - 수정한 행의 수 반환 -> 0수정실패, 1수정성공 -> int
	// 입력 매개값 - guestbookNo, guestbookContent, guestbookPw 3개 -> 하나의 타입 매개변수로 받고 싶다 -> Guestbook 타입을 사용
	public int updateGuestbook(Guestbook guestbook) throws Exception {
		int row = 0; // 함수 결과값(쩡수) 반환해줄 변수 선언 후 초기화
		
		// MySql 드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		// MySql RDBMS에 접속(IP주소, 접속계정 아이디, 패스워드)
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
		// SQL 쿼리를 문자열로 저장
		String sql = 
			"UPDATE guestbook SET guestbook_content=? WHERE guestbook_no=? AND guestbook_pw=?";
		// guestbook 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, guestbook.guestbookContent);
		stmt.setInt(2, guestbook.guestbookNo);
		stmt.setString(3, guestbook.guestbookPw);
		// 디버깅 코드
		System.out.println(stmt + " <-- sql updateGuestbook"); 
		row = stmt.executeUpdate();
		
		// DB 자원들 반환, 종료
		stmt.close();
		conn.close();
		
		// 정수값 반환
		return row;
	}
	
	// 삭제(deleteGuestbook) 프로세스 deleteGuestbookAction.jsp 호출
	// 이름 - deleteGuestbook
	// 반환값 - 삭제한 행의 수 반환 -> 0수정실패, 1수정성공 -> int
	// 입력 매개값 - guestbookNo, guestbookPw 2개 -> int, String 타입을 사용 (Guestbook타입을 사용해도 된다.)
	public int deleteGuestbook(int guestbookNo, String guestbookPw) throws Exception {
		int row = 0; // 함수 결과값(쩡수) 반환해줄 변수 선언 후 초기화
		
		// MySql 드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		// MySql RDBMS에 접속(IP주소, 접속계정 아이디, 패스워드)
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
		// SQL 쿼리를 문자열로 저장
		String sql = 
			"DELETE FROM guestbook WHERE guestbook_no=? AND guestbook_pw=?";
		// guestbook 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, guestbookNo);
		stmt.setString(2, guestbookPw);
		// 디버깅 코드
		System.out.println(stmt + " <-- sql deleteGuestbook"); 
		
		row = stmt.executeUpdate();
		
		// DB 자원들 반환, 종료
		stmt.close();
		conn.close();
		
		// 정수값 반환
		return row;
	}
	
	// 입력 프로세스 insertGuestbookAction.jsp에서 호출
	public void insertGuestbook(Guestbook guestbook) throws Exception {
		// MySql 드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		// MySql RDBMS에 접속(IP주소, 접속계정 아이디, 패스워드)
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
	
		// SQL 쿼리를 문자열로 저장
		String sql = 
			"INSERT INTO guestbook(guestbook_content, writer, guestbook_pw, create_date, update_date) VALUES(?,?,?,NOW(),NOW())";
		// guestbook 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, guestbook.guestbookContent);
		stmt.setString(2, guestbook.writer);
		stmt.setString(3, guestbook.guestbookPw);
		
		// DB 자원 가공
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("입력성공");
		} else {
			System.out.println("입력실패");
		}
		// DB 자원들 반환, 종료
		stmt.close();
		conn.close();
	}

	// guestbook 전체 행의 수를 반환 메서드
	public int selectGuestbookTotalRow() throws Exception {
		int row = 0; // 함수 결과값(쩡수) 반환해줄 변수 선언 후 초기화
		
		// MySql 드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// MySql RDBMS에 접속(IP주소, 접속계정 아이디, 패스워드)
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
		// SQL 쿼리를 문자열로 저장
		String sql = 
			"SELECT COUNT(*) cnt FROM guestbook";
		// guestbook 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		// DB 자원 가공
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		
		// 정수값 반환
		return row;
	}
	
	
	// guestbook n행씩 반환 메서드
	public ArrayList<Guestbook> selectGuestbookListByPage(int beginRow, int rowPerPage) throws Exception {
		// guestbook 10행 반환되도록 구현
		ArrayList<Guestbook> list = new ArrayList<Guestbook>(); // 배열리스트 선언
		
		// MySql 드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// MySql RDBMS에 접속(IP주소, 접속계정 아이디, 패스워드)
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
	
		// SQL 쿼리를 문자열로 저장
		String sql = 
			"SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, writer, create_date createDate FROM guestbook ORDER BY create_date DESC LIMIT ?, ?";
	
		// guestbook 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		// DB 데이터 변환(가공)
		while(rs.next()) {
			Guestbook g = new Guestbook();
			g.guestbookNo = rs.getInt("guestbookNo");
			g.guestbookContent = rs.getString("guestbookContent");
			g.writer = rs.getString("writer");
			g.createDate = rs.getString("createDate");
			list.add(g);
		}
		
		// DB 자원들 반환, 종료
		rs.close();
		stmt.close();
		conn.close();
		
		// 배열리스트를 리턴해줌
		return list;
	}
}
