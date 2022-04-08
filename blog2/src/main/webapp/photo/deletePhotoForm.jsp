<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import ="vo.*" %>
<%@page import ="dao.*" %>
<%
	// deletePhotoForm에서 데이터 요청 값 받는 코드
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoPw = request.getParameter("photoPw");
	// 디버깅 코드
	System.out.println(photoNo + " <-- photoNo");
	System.out.println(photoPw + " <-- photoPw");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>photoList</title>
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
	
	<!-- 메인 컨테이너 -->
	<div class="row">
	
		<!-- 방명록 왼쪽광고 -->
		<div class="col-sm-2" style="text-align : center; margin : 0 auto;">
			<img src="광고5.png"  width="300px" height="600px" class="rounded" alt="Cinque Terre">
		</div>
		
	<!-- 삭제 메뉴 -->
	<div class="col bg-white" style="width:20px margin : auto 0">
		<h1>
			<div class="mt-3 p-3 bg-primary text-white text-center">사진 삭제</div>
		</h1>
		<body>
			<div>
				<form method="post" action="<%=request.getContextPath()%>/photo/deletePhotoAction.jsp">
					<table class="table table-bordered text-center">
						<tr>
							<td>번호</td>
							<td><input class="text-center" type="text" name="photoNo" value="<%=photoNo%>" readonly="readonly"></td>
							<td>비밀번호</td>
							<td><input type="password" name="photoPw" value=""></td>
						</tr>
						<tr>
							<td colspan="4">
								<button class="btn btn-danger" style="float: right;" type="submit">삭제</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
	 </div>
	
		<!-- 오른쪽 광고 -->
		<div class="col-sm-2" style="text-align : center; margin : 0 auto;">
			<img src="광고6.png"  width="300px" height="600px" class="rounded" alt="Cinque Terre">
		</div>
		
		</div>
		</div>
	
		<!-- 하단 메뉴 -->
		<div class="bg-secondary">
			롤체지지 참고
		</div>
	</body>
</html>

