<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
	// board one에서 수정할 게시판 특정 번호를 받아옴
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
	
	// 2) 카테고리 SQL 쿼리 저장
	// 카테고리 쿼리 문자열 저장
	String sql = "SELECT category_name categoryName FROM category ORDER BY category_name ASC";
    // 카테고리 쿼리를 저장
	PreparedStatement stmt = conn.prepareStatement(sql);
    System.out.println(stmt  + " <-- stmt");	// 디버깅 코드
	// 카테고리 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴	
	ResultSet rs = stmt.executeQuery();
	System.out.println(rs + " <-- rs");	// 디버깅 코드 
	// 블로그 카테고리를 선택할 수 있게 리스트로 저장
	ArrayList<String> list = new ArrayList<String>();
	while(rs.next()) {
	      list.add(rs.getString("categoryName"));
	}	

	// 3) SELECT SQL 쿼리 저장
	// 업데이트 문을 작성할 쿼리를 SELECET 문으로 선택
	// SELECT 쿼리 문자열 저장
	String selectSql = 
		"select board_no, category_name, board_title, board_content from board where board_no=?";
	// SELECT 쿼리를 저장
	PreparedStatement selectStmt = conn.prepareStatement(selectSql);
	System.out.println(selectStmt  + " <-- selectStmt"); // 디버깅코드
	// 요청받은 값 저장
	selectStmt.setInt(1, boardNo);
	// SELECT 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴	
	ResultSet dateRs = selectStmt.executeQuery();
	System.out.println(dateRs + " <--dateRs");
	
	// 4) 수정할 게시물의 번호, 카테고리, 제목, 내용을 받아서 ResultSet에 저장 
	Board b = null;
	if(dateRs.next()) {
		b = new Board();
		b.boardNo = dateRs.getInt("board_no");
		b.categoryName = dateRs.getString("category_name");
		b.boardTitle = dateRs.getString("board_title");
		b.boardContent = dateRs.getString("board_content");
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
	<!-- 카테고리 아레  -->
	<div class="row">
	
	<div class="col-sm-2" style="text-align : center; margin : 0 auto;">
		<img src="광고1.png"  width="300px" height="600px" class="rounded" alt="Cinque Terre">
	</div>
	
	<!-- 메인메뉴 -->
	<div>
	<h1>
		<div class="mt-3 p-3 bg-primary text-white text-center">게시글 수정</div>
	</h1>
	<form method="post" action="./board/updateBoardAction.jsp">
		<table class="table table-bordered border">
			<tr>
				<td>boardNo</td>
				<td>
					<input type="number" name="boardNo" readonly="readonly" value="<%=b.boardNo%>">
				</td>
			</tr>
			<tr>
           	    <td>cetegoryName</td>
            	<td>
              	 <select name="categoryName">
                 	<%
                   		for(String s : list) { 
                   			if(s.equals(b.categoryName)) {
                 	%>
                      <!-- 변수는 바뀔수 있음 -->
                      <option selected="selected" value="<%=s%>"><%=s%></option>
                   <%      
                   	 } else {
                   %>
                   		<option value="<%=s%>"><%=s%></option>
                   <%
                   	 		}
                   	 	}
                   %>
                </select>
               </td>
         </tr>
			<tr>
				<td>boardTitle</td>
				<td>
					<input type="text" name="boardTitle" value="<%=b.boardTitle%>">
				</td>
			</tr>
			<tr>
				<td>boardContent</td>
				<td>
					<textarea rows="5" cols="50" name="boardContent"><%=b.boardContent%></textarea>
				</td>
			</tr>
			<tr>
				<td>boardPw</td>
				<td>
					<input type="password" name="boardPw">
				</td>
			</tr>
		</table>
		<button class="btn btn-success" style="float: right;" type="submit">수정</button>
	</form>
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