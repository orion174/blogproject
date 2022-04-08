<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%
	// *페이징 코드 1
	// boardList을 실행하면 최근10개의 목록을 보여주고 현재 페이지의 기본값을 1페이지로 설정
	int currentPage = 1; 
	if(request.getParameter("currentPage") != null) { // 이전, 다음 링크로 현재 페이지로 접속했다고 가정
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+ " <-- currentPage"); // 디버깅 코드
	// 이전, 다음링크에서 null값을 넘기는 것이 불가능함 -> null 값을 공백으로 치환해서 코드를 처리 
	String categoryName = "";
	if(request.getParameter("categoryName") != null) {
		categoryName = request.getParameter("categoryName");
	}
	// 페이징 코드 알고리즘
	// 링크에 따라 페이지가 바뀌면, 가지고 오는 데이터가 변경되어야 한다.
	/*
		SELECT .... LIMIT ?, 10"
		
		currentPage	beginRow
		1			0
		2			10
		3			20
		4			30
		
		? <----- (currentPage-1)*10
	*/
	int rowPerPage = 10; // rowPerPage는 변경될 수 있음
	// 현재 페이지 currentPage 변경 -> beginRow로 
	int beginRow = (currentPage-1)*rowPerPage;
	
	// 0) 마리아 db 드라이버 
	Class.forName("org.mariadb.jdbc.Driver");
	// 1) 계정 로그인
	Connection conn = null; // 연결 초기화
	String dburl = "jdbc:mariadb://localhost:3306/blog";
	String dbuser = "root";
	String dbpw = "java1234";
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + " <-- conn"); // 디버깅 코드
	
	// 2) SQL 쿼리 저장
	/*
		SELECT category_name categoryName, COUNT(*) cnt
		FROM board
		GROUP BY category_name
	*/
	String categorySql = 
		"SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
	System.out.println(categoryStmt + " <-- categoryStmt"); // 디버깅 코드
	
	// 3) 자료형으로 저장
	ResultSet categoryRs = categoryStmt.executeQuery();
	System.out.println(categoryRs + " <-- categoryRs"); // 디버깅 코드
	
	// 쿼리에 결과를 Category, Board vo로 저장할 수 없을때, HashMap을 사용해서 저장
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	while(categoryRs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("categoryName", categoryRs.getString("categoryName"));
		map.put("cnt", categoryRs.getInt("cnt"));
		categoryList.add(map);
	}
	
	// *boardList 코드
	// SQL 쿼리 저장
	String boardSql = null; // 초기화
	PreparedStatement boardStmt = null; // 초기화
	// categoryName에서 값을 받아올때와 아닐때를 구분 -> 받아올때는 해당 카테고리의 데이터만 출력
	// 카테고리에서 공백(null)로 받아올 때
	if(categoryName.equals("")) { 
		boardSql = 
			"SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
		boardStmt = conn.prepareStatement(boardSql);
		// 바뀐 페이지 변수값과 페이지로 나타낸 데이터 수 까지 같이 저장
		boardStmt.setInt(1, beginRow);
		boardStmt.setInt(2, rowPerPage);
	// 카테고리에서 값을 받아올 때
	} else {
		boardSql = 
			"SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT ?, ?";
		boardStmt = conn.prepareStatement(boardSql);
		// 카테고리값을 받았으니 저장해야함
		boardStmt.setString(1, categoryName);
		// 바뀐 페이지 변수값과 페이지로 나타낸 데이터 수 까지 같이 저장
		boardStmt.setInt(2, beginRow);
		boardStmt.setInt(3, rowPerPage);
	}
	
	// 해당 데이터를 자료형으로 저장
	ResultSet boardRs = boardStmt.executeQuery();
	System.out.println(boardRs + " <-- boardRs"); // 디버깅 코드
	
	// vo class로 자료구조 생성
	ArrayList<Board> boardList = new ArrayList<Board>();
	while(boardRs.next()) {
		Board b = new Board();
		b.boardNo = boardRs.getInt("boardNo");
		b.categoryName = boardRs.getString("categoryName");
		b.boardTitle = boardRs.getString("boardTitle");
		b.createDate = boardRs.getString("createDate");
		boardList.add(b);
	}
	
	// *페이징 코드 2
	// 전체 데이터를 출력하는 코드와 마지막 페이지 변수 값을 표현하는 코드
	int totalRow = 0; // 초기화
	// SQL 집계 쿼리
	// select count(*) from board;
	String totalRowSql = 
		"SELECT COUNT(*) cnt FROM board";
	// 자료형으로 저장
	PreparedStatement totalRowStmt = conn.prepareStatement(totalRowSql);
	ResultSet totalRowRs = totalRowStmt.executeQuery();
	// 전체 데이터값 저장 후 출력하는 코드
	if(totalRowRs.next()) {
		totalRow = totalRowRs.getInt("cnt");
		System.out.println(totalRow + " <-- totalRow(1000)");
	}
	// 마지막 페이지 변수 값 저장 코드
	int lastPage = 0; // 초기화
	// 만약, 전체 데이터수와 화면당 보여지는 데이터수를 나눠서 나머지가 없으면,..
	// 마지막 페이지는 (전체 데이터 수 / 화면당 보여지는 데이터 수) 가 됨
	if(totalRow % rowPerPage == 0) {
		lastPage = totalRow / rowPerPage;
	// 만약 나머지가 있으면, 마지막 페이지수는 나머지값과 상관없이 + 1만큼 늘어남
	} else {
		lastPage = (totalRow / rowPerPage) + 1;
	}
	
	// 4) 종료
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
		<nav class="navbar navbar-expand-sm bg-primary navbar-dark justify-content-center">
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
	<!-- 방명록 왼쪽광고 -->
	<div class="col-sm-2" style="text-align : center; margin : 0 auto;">
		<img src="광고1.png"  width="300px" height="600px" class="rounded" alt="Cinque Terre">
	</div>
	
	<!-- 메인메뉴 -->
	<div style="text-align: center; margin : 0 auto;" class="col bg-white" style="width:20px margin : auto 0">
	<h1>게시글 목록(total : <%=totalRow%>)</h1>
	<a class="btn btn-primary" style="float: right;" href="<%=request.getContextPath()%>/board/insertBoardForm.jsp">게시글 입력</a>
	<table class="table table-bordered">
		<thead>
			<tr class="table-primary">
				<th>categoryName</th>
				<th>boardTitle</th>
				<th>createDate</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Board b : boardList) {
			%>
					<tr>
						<td><%=b.categoryName%></td>
						<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.boardNo%>"><%=b.boardTitle%></a></td>
						<td><%=b.createDate%></td>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
	<div>
		<!-- 페이지가 만약 10페이지였다면 이전을 누르면 9페이지, 다음을 누르면 11페이지 -->
		<%
			if(currentPage > 1) { // 현재페이지가 1이면 이전페이지가 존재해서는 안된다.
		%>
				<a class="btn btn-primary" style="float: right;" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>">이전</a>
		<%	
			}
		%>
		<%
			if(currentPage < lastPage) {
		%>
				<a class="btn btn-primary" style="float: right;" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>">다음</a>	
		<%		
			}
		%>
	</div>
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