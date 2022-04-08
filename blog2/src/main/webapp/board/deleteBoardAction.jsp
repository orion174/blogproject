<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="vo.*" %>
<%
	// delete form으로 부터 boardNo, boardPw 요청값 받음
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	// 디버깅 코드
	System.out.println(boardNo + " <--boardNo"); 
	System.out.println(boardPw + " <--boardPw"); 
	
	// vo 패키지 사용하여 Board 생성
	Board b = new Board();
	b.boardNo = boardNo;
	b.boardPw = boardPw;
	
	// 0) MySql 드라이버 로딩
    Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공"); // 디버깅 코드
		
	// 1) MySql RDBMS에 접속(IP주소, 접속계정 아이디, 패스워드)
	// 연결 초기화
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";
	String dbuser = "root";
	String dbpw = "java1234";
	// Connection타입 연결된 데이터베이스에 SQL쿼리 명령을 전송할 수 있는 메서드를 가진 타입
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + " <-- conn");	// 디버깅 코드

	// 2) SQL 쿼리를 문자열로 저장
	// delete 쿼리 (번호와 패스워드가 일치해야 삭제 쿼리 실행)
	String deleteSql = 
		"delete from board where board_no=? and board_pw=?";
	PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
	System.out.println(deleteStmt  + "<--deleteStmt"); // 디버깅 코드
	// 받아온 값을 저장
	deleteStmt.setInt(1, b.boardNo);
	deleteStmt.setString(2, b.boardPw);
	

	// 3) DB 연결 상태 확인
	// 몇행을 입력했는지 return 하는 코드
	int row = deleteStmt.executeUpdate();
	if(row == 0) { 
		// 삭제 실패하면 다시 delete form으로 돌아감
		response.sendRedirect("./board/deleteBoardForm.jsp?boardNo=" + b.boardNo);
		System.out.println("삭제실패!");
	} else if(row == 1) {
		// 삭제 성공했으면 board list로 돌아감
		response.sendRedirect("./board/boardList.jsp");
		System.out.println("삭제성공!");
	} else {
		System.out.println("error!");
	}
	
	// 4) 종료
	conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>