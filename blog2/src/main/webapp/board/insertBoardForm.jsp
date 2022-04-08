<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%
   //0) MySql 드라이버 로딩
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
   String sql = "SELECT category_name categoryName FROM category ORDER BY category_name ASC";
   // 카테고리 쿼리를 저장
   PreparedStatement stmt = conn.prepareStatement(sql);
   System.out.println(stmt  + " <-- stmt");	// 디버깅 코드
   // 카테고리 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴	
   ResultSet rs = stmt.executeQuery();
   System.out.println(rs + " <-- rs");	// 디버깅 코드
   
   // 3) 블로그 카테고리를 선택할 수 있게 리스트로 저장
   ArrayList<String> list = new ArrayList<String>();
   while(rs.next()) {
      list.add(rs.getString("categoryName"));
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
	<!-- 카테고리 아레  -->
	<div class="row">
	
	<div class="col-sm-2" style="text-align : center; margin : 0 auto;">
		<img src="광고1.png"  width="300px" height="600px" class="rounded" alt="Cinque Terre">
	</div>
	
	<!-- 메인메뉴 -->
	<div>
	<h1>
		<div class="mt-3 p-3 bg-primary text-white text-center">게시글 입력</div>
	</h1>
	<table class="table table-bordered border">
		   <tr>
				<td>board_title</td>
				<td>
					<input name="boardTitle" type="text"> 
				</td>
			</tr>
			<tr>
				<td>board_content</td>
				<td>
					<textarea rows="5" cols="80" name="boardContent"></textarea>
				</td>
			</tr>
			<tr>
				<td>board_pw</td>
				<td>
					<input name="boardPw" type="text"> 
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button class="btn btn-success" style="float: right;" type="submit">글 작성</button>
				</td>
			</tr>
	</table>
	
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

