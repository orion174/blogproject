package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.Guestbook;
import vo.Photo;

public class PhotoDao {
	public PhotoDao() {} // 생성자 메서드
	
	// 이미지 입력 코드
	public void insertPhoto(Photo photo) throws Exception {
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
			"INSERT INTO photo(photo_name, photo_original_name, photo_type, photo_pw, writer, create_date, update_date) VALUES(?,?,?,?,?,NOW(),NOW())";
		
		// 데이터 생성
		String photoName = photo.photoName;
		String photoOriginalName = photo.photoOriginalName;
		String photoType = photo.photoType;
		String photoPw = photo.photoPw;
		String writer = photo.writer;
		
		// photo 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, photo.photoName);
		stmt.setString(2, photo.photoOriginalName);
		stmt.setString(3, photo.photoType);
		stmt.setString(4, photo.photoPw);
		stmt.setString(5, photo.writer);
		
		// 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴
		rs = stmt.executeQuery();
		
		// DB 데이터 변환(가공)
		if(rs.next()) { 
			photoName = rs.getString("photo_name");
			photoOriginalName = rs.getString("photo_original_name");
			photoType = rs.getString("photo_type");
			photoPw = rs.getString("photo_pw");
			writer = rs.getString("writer");
		}
		// DB 자원들 반환, 종료
		rs.close();
		stmt.close();
		conn.close();
	}
	
	// 이미지 삭제 코드
	public int deletePhoto(int photoNo, String photoPw) throws Exception { 
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
			"DELETE FROM photo WHERE photo_no=? AND photo_pw=?";
		
		// photo 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		stmt.setString(2, photoPw);
		// 디버깅 코드
		System.out.println(stmt + " <-- sql deletePhoto"); 
		
		// 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴
		row = stmt.executeUpdate();
		
		// DB 자원들 반환, 종료
		stmt.close();
		conn.close();
		
		// 정수값 반환
		return row;
	}
	
	// 전체 행의 수
	public int selectPhotoTotalRow() throws Exception {
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
			"SELECT COUNT(*) cnt FROM photo";
	
		// photo 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		// 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴
		rs = stmt.executeQuery();
		
		// DB 자원 가공
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		// DB 자원들 반환, 종료
		rs.close();
		stmt.close();
		conn.close();
		// 정수값 반환
		return row;
	}
	
	// photobook n행씩 반환 메서드
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Photo> list = new ArrayList<Photo>(); // 배열리스트 선언
		
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
			"SELECT photo_no photoNo, photo_name photoName, photo_original_name photoOriginalName, photo_type photoType, photo_pw photoPw, writer, create_date createDate, update_date updateDate FROM photo ORDER BY create_date DESC LIMIT ?, ?";
		
		// photo 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		// 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴
		rs = stmt.executeQuery();
		
		// 데이터 변환(가공)
		while(rs.next()) {
			Photo photo = new Photo(); 
			photo.photoNo = rs.getInt("photoNo");
			photo.photoName = rs.getString("photoName");
			photo.photoOriginalName = rs.getString("photoOriginalName");
			photo.photoType = rs.getString("photoType");
			photo.photoPw = rs.getString("photoPw");
			photo.writer = rs.getString("writer");
			photo.createDate = rs.getString("createDate");
			photo.updateDate = rs.getString("updateDate");
			list.add(photo);
		}
		
		// 데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		// 요청값에 list 리턴 해줌
		return list;
	}
	
	// 이미지 하나 상세보기
	public Photo selectPhotoOne(int photoNo) throws Exception {
		Photo photo = null; // class 선언 후 초기화
		
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
			"SELECT photo_no photoNo, photo_name photoName, writer, create_date createDate, update_date updateDate FROM photo WHERE photo_no=?";
		// photo 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		// 디버깅 코드
		System.out.println(stmt + " <-- sql selectphotoOne");
		// 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴
		rs = stmt.executeQuery();
		
		// DB 자원 가공
		if(rs.next()) {
			photo = new Photo();
			photo.photoNo = rs.getInt("photoNo");
			photo.photoName = rs.getString("photoName");
			photo.writer = rs.getString("writer");
			photo.createDate = rs.getString("createDate");
			photo.updateDate = rs.getString("updateDate");
		}
		// DB 자원들 반환, 종료
		rs.close();
		stmt.close();
		conn.close();
		// 요청값에 photo class를 리턴해줌
		return photo;
	}
}
