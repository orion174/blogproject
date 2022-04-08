<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// board one 에서 boardNo 받아옴
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	System.out.println(boardNo); // 디버깅 코드 
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
	<div class="row">
	
	<div class="col-sm-2" style="text-align : center; margin : 0 auto;">
		<img src="광고1.png"  width="300px" height="600px" class="rounded" alt="Cinque Terre">
	</div>
	
	<!-- 메인메뉴 -->
	<div>
	<h1>
		<div class="mt-3 p-3 bg-primary text-white text-center">게시글 삭제</div>
	</h1>
	<form method="post" action="./board/deleteBoardAction.jsp">
			게시판 번호 : 
			<input type="text" name="boardNo" value="<%=boardNo%>" readonly="readonly">
		<div>
			비밀번호 입력 : 
			<input type="password" name="boardPw">
		</div>
		<div>
			<button class="btn btn-danger" style="float: right;" type = "summit">글 삭제</button>
		</div>
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
