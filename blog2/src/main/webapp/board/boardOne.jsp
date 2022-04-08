<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%
	// board_no을 받아옴
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	System.out.println(boardNo + " <-- boardNo"); // 디버깅 코드

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
	// 카테고리 쿼리
	String categorySql = 
			"SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
	// 카테고리 쿼리를 저장
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
	// 카테고리 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴	
	ResultSet categoryRs = categoryStmt.executeQuery();
	
	// 쿼리에 결과를 Category, Board VO로 전부 저장할 수 없으므로, HashMap사용
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	while(categoryRs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("categoryName", categoryRs.getString("categoryName"));
		map.put("cnt", categoryRs.getInt("cnt"));
		categoryList.add(map);
	}
	
	// 3) BoardList SQL 쿼리를 문자열로 저장
	String boardSql = null; // 문자열 초기화
	PreparedStatement boardStmt = null; // 연결초기화
	// BoardList SQL 쿼리
	boardSql = 
		"SELECT board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, create_date createDate, update_date updateDate FROM board WHERE board_no=? ORDER BY create_date DESC LIMIT 0, 10";
	// BoardList SQL 쿼리 저장
	boardStmt = conn.prepareStatement(boardSql);
	System.out.println(boardStmt + " <-- boardStmt"); // 디버깅코드
	// 받아온 값을 저장
	boardStmt.setInt(1, boardNo);
	// BoardList SQL 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴
	ResultSet boardRs = boardStmt.executeQuery();
	System.out.println(boardRs + " <-- boardRs"); // 디버깅코드
	
	// 4) BoardList의 ResultSet -> ArrayList<Board>으로 변경
	// board 동적 배열 -> boardList에 할당
	ArrayList<Board> boardList = new ArrayList<Board>();
	while(boardRs.next()) {
		Board b = new Board(); // Board 객체 생성
		b.boardNo = boardRs.getInt("boardNo"); // DB 기본키 값 (요청받는값)
		b.categoryName = boardRs.getString("categoryName");
		b.boardTitle = boardRs.getString("boardTitle");
		b.boardContent = boardRs.getString("boardContent");
		b.createDate = boardRs.getString("createDate");
		b.updateDate = boardRs.getString("updateDate");
		boardList.add(b);
	}
	
	// 5) 종료
	conn.close();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<style>
		ul li {list-style-type: none; float: left; margin-left: 25px}	
	</style>
</head>
<body>
	<!-- 상단 메뉴 -->
	<div class="bg-secondary">
		롤체지지 참고 
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	</div>
		<!-- 컨텐츠 담을 상자 -->
		<div class="container-fluid"> 
		<!-- 상단간판 -->
		<div class="mt-3 p-3 bg-dark text-white">
			<img src="말랑이.png" class="rounded" alt="Cinque Terre" align="middle" vspace="10" hspace="10">
				<font size="10em" color="white">
					웹 사이트 만들기 연습
				</font>
		</div>
		<!-- category별 게시글 링크 메뉴 -->
		<nav class="navbar navbar-expand-sm bg-primary navbar-dark">
			<ul class="navbar-nav">
				<%
					for(HashMap<String, Object> m : categoryList) {
				%>
						<li class="nav-item active">
							<a class="nav-link" href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%>(<%=m.get("cnt")%>)</a>
						</li>
				<%		
					}
				%>
			</ul>
		</nav>
	<!-- 카테고리 아레  -->
	<div class="row">
	
	<div class="col-sm-2" style="text-align : center; margin : 0 auto;">
		<img src="광고1.png"  width="300px" height="600px" class="rounded" alt="Cinque Terre">
	</div>
	<div class="col bg-white" style="width : 20px margin : auto 0">
	<!-- <div style="text-align: center; margin : 0 auto;" class="col bg-white" style="width:20px margin:auto 0"> -->
	<table class="table table-bordered border">
	<!-- 메인메뉴 -->
	<h1>
		<div class="mt-3 p-3 bg-primary text-white text-center">게시판 상세 보기</div>
	</h1>
			<%
				for(Board b : boardList) { 
			%>
		<tr>
			<td>boardNo</td>
			<td><%=b.boardNo%></td>
		</tr>
		<tr>
			<td>categoryName</td>
			<td><%=b.categoryName%></td>
		</tr>
		<tr>
			<td>boardTitle</td>
			<td><%=b.boardTitle%></td>
		</tr>
		<tr>
			<td>boardContent</td>
			<td><%=b.boardContent%></td>
		</tr>
		
		<tr>
			<td>createDate</td>
			<td><%=b.createDate%></td>
		</tr>
		
		<tr>
			<td>updateDate</td>
			<td><%=b.updateDate%></td>
		</tr>
		<%
			}
		%>
	</table>
	</div>
	<div>
		<a class="btn btn-danger" style="float: right;" href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%=boardNo%>">삭제</a>
		<a class="btn btn-success" style="float: right;" href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=boardNo%>">수정</a>
   	</div>
	
	
	<div class="col-sm-2" style="text-align : center; margin : 0 auto;">
		<img src="광고2.png"  width="300px" height="600px" class="rounded" alt="Cinque Terre">
	</div>
	</div>
	</div>
	<!-- 하단 메뉴 -->
	<div class="bg-secondary">
		롤체지지 참고 
	</div>
</body>
</html>






























