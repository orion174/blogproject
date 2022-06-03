package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DButil;
import vo.Pdf;

public class PdfDao {
	public PdfDao() {} // 생성자 메서드
	
	// pdf n행씩 반환 메서드
	public ArrayList<Pdf> selectPdfListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Pdf> list = new ArrayList<Pdf>(); // 정보를 담아줄 ArrayList<Pdf> 생성
		
		// MySql 드라이버 로딩
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// MySql RDBMS에 접속(IP주소, 접속계정 아이디, 패스워드)
		conn = DButil.getConnection();
		
		// SQL 쿼리를 문자열로 저장
		String sql = 
			"SELECT pdf_no pdfNo, pdf_name pdfName, pdf_original_name pdfOriginalName, pdf_type pdfType, pdf_pw pdfPw, writer, create_date createDate, update_date updateDate FROM pdf ORDER BY create_date DESC LIMIT ?, ?";
		
		// pdf 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow); 
		stmt.setInt(2, rowPerPage);
		// 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴
		rs = stmt.executeQuery(); 
		
		// 데이터 변환(가공)
		while(rs.next()) {
			Pdf pdf = new Pdf();
			pdf.pdfNo = rs.getInt("pdfNo");
			pdf.pdfName = rs.getString("pdfName");
			pdf.pdfOriginalName = rs.getString("pdfOriginalName");
			pdf.pdfType = rs.getString("pdfType");
			pdf.pdfPw = rs.getString("pdfPw");
			pdf.writer = rs.getString("writer");
			pdf.createDate = rs.getString("createDate");
			pdf.updateDate = rs.getString("updateDate");
			list.add(pdf); 
		}
	
		// 데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		// 요청값에 list 리턴 해줌
		return list;
	}
	
	// pdf  하나 상세보기
	public Pdf selectPdfOne(int pdfNo) throws Exception {
		Pdf pdf = null; // class 선언 후 초기화
		
		// MySql 드라이버 로딩
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// MySql RDBMS에 접속(IP주소, 접속계정 아이디, 패스워드)
		conn = DButil.getConnection();
		
		// SQL 쿼리를 문자열로 저장
		String sql = 
			"SELECT pdf_no pdfNo, pdf_name pdfName, writer, create_date createDate, update_date updateDate FROM pdf WHERE pdf_no=?";
		
		// pdf 쿼리를 저장
		stmt = conn.prepareStatement(sql); 
		stmt.setInt(1, pdfNo); 
		// 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴
		rs = stmt.executeQuery();
		
		// DB 자원 가공
		if(rs.next()) {
			pdf = new Pdf();
			pdf.pdfNo = rs.getInt("pdfNo");
			pdf.writer = rs.getString("writer");
			pdf.pdfName = rs.getString("pdfName");
			pdf.createDate = rs.getString("createDate");
			pdf.updateDate = rs.getString("updateDate");
		}
		
		// DB 자원들 반환, 종료
		rs.close();
		stmt.close();
		conn.close();
		// 요청값에 pdf class를 리턴해줌
		return pdf;
	}
	
	// pdf 업로드 코드
	public void insertPdf(Pdf pdf) throws Exception {
		// MySql 드라이버 로딩
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// MySql RDBMS에 접속(IP주소, 접속계정 아이디, 패스워드)
		conn = DButil.getConnection();
		
		// SQL 쿼리를 문자열로 저장
		String sql = 
			"INSERT INTO pdf(pdf_no, pdf_name, pdf_original_name, pdf_type, pdf_pw, writer, create_date, update_date)VALUES(?, ?, ?, ?, ?, ?, NOW(), NOW())";
		
		// pdf 쿼리를 저장
		stmt = conn.prepareStatement(sql); 
		stmt.setInt(1, pdf.pdfNo);
		stmt.setString(2, pdf.pdfName);
		stmt.setString(3, pdf.pdfOriginalName);
		stmt.setString(4, pdf.pdfType);
		stmt.setString(5, pdf.pdfPw);
		stmt.setString(6, pdf.writer);
		// 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴
		rs = stmt.executeQuery(); // 쿼리 저장
		
		// DB 데이터 변환(가공)
		if(rs.next()) { 
			pdf.pdfNo = rs.getInt("pdf_no");
			pdf.pdfName = rs.getString("pdf_name");
			pdf.pdfOriginalName = rs.getString("pdf_original_name");
			pdf.pdfType = rs.getString("pdf_type");
			pdf.pdfPw = rs.getString("pdf_pw");
			pdf.writer = rs.getString("writer");
		}
		// DB 자원들 반환, 종료
		rs.close();
		stmt.close();
		conn.close();
	}
	
	// pdf 삭제 코드
	public int deletePdf(Pdf pdf) throws Exception {
		int row = 0; // 함수 결과값(쩡수) 반환해줄 변수 선언 후 초기화
		
		// MySql 드라이버 로딩
		Connection conn = null;
		PreparedStatement stmt = null;
	
		// MySql RDBMS에 접속(IP주소, 접속계정 아이디, 패스워드)
		conn = DButil.getConnection();
		
		// SQL 쿼리를 문자열로 저장
		String sql =
			"DELETE FROM pdf WHERE pdf_no=? AND pdf_pw=?";
		// pdf 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, pdf.pdfNo);
		stmt.setString(2, pdf.pdfPw);
		// 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴
		row = stmt.executeUpdate();
		
		// DB 자원들 반환, 종료
		stmt.close();
		conn.close();
		// 정수값 반환
		return row;
	}
	
	// pdf list 전체 행의 수
	public int selectPdfTotalRow() throws Exception {
		int row = 0; // 함수 결과값(쩡수) 반환해줄 변수 선언 후 초기화
		
		// MySql 드라이버 로딩
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// MySql RDBMS에 접속(IP주소, 접속계정 아이디, 패스워드)
		conn = DButil.getConnection();
		
		// SQL 쿼리를 문자열로 저장
		String sql =
			"SELECT COUNT(*) cnt FROM pdf";
		
		// pdf 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		// 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴
		rs = stmt.executeQuery();
		
		// DB 자원 가공
		if(rs.next()) { // 데이터가 있으면
			row = rs.getInt("cnt");
		}
		// DB 자원들 반환, 종료
		rs.close();
		stmt.close();
		conn.close();
		// 정수값 반환
		return row;
	}
}