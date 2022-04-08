<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%
	// 글자 깨짐 방지
	request.setCharacterEncoding("utf-8"); 

    // actionform에서 4개의 값을 받음
	String categoryName = request.getParameter("categoryName"); // 카테고리이름
	String boardTitle = request.getParameter("boardTitle"); // 게시판제목
	String boardContent = request.getParameter("boardContent"); // 게시판내용
	String boardPw = request.getParameter("boardPw"); // 비밀번호
	// 디버깅코드
	System.out.println(categoryName+ " <--categoryName");
	System.out.println(boardTitle + " <--boardTitle");
	System.out.println(boardContent + " <--boardContent");
	System.out.println(boardPw + " <--boardPw");
	
	// vo 패키지 사용하여 Board 생성
	Board b = new Board();
	b.categoryName = categoryName;
	b.boardTitle = boardTitle;
	b.boardContent = boardContent;
	b.boardPw = boardPw;
	
	// DB 연결
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
	 /*
    INSERT INTO board(
          category_name,
          board_title,
          board_content,
          board_pw,
          create_date,
          update_date
    ) VALUES (
       ?, ?, ?, ?, NOW(), NOW()
    )
   */
	// 인서트 쿼리
	String insertSql = 
		"INSERT INTO board(category_name, board_title, board_content, board_pw, create_date, update_date) values(?, ?, ?, ?, NOW(), NOW())";
	System.out.println(insertSql + " <-- insertSql"); // 디버깅 코드
	// 인서트 쿼리를 저장
	PreparedStatement insertStmt = conn.prepareStatement(insertSql);
	System.out.println(insertStmt + " <-- insertStmt"); // 디버깅 코드
	
	// 받아온 값을 저장
	insertStmt.setString(1, b.categoryName);
	insertStmt.setString(2, b.boardTitle );
	insertStmt.setString(3, b.boardContent );
	insertStmt.setString(4, b.boardPw);

	// 3) DB 연결 상태 확인
	// 몇행을 입력했는지 return 하는 코드
	int row = insertStmt.executeUpdate(); 
	if(row==1){
		System.out.println(row + "행 입력성공");
	} else {
		System.out.println("입력실패");
	}
	
	// 4) 종료
	conn.close(); //코드 사용 끝나면 닫아주기
	
	//입력 실패or성공 후 boardList.jsp로이동
    response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
%>































