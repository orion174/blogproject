<%@page import="vo.Photo"%>
<%@page import="dao.PhotoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// photoList에서 요청값 받아옴
	int photoNo = Integer.parseInt(request.getParameter("photoNo")); 
	System.out.println(photoNo + " <-- photoNo"); // 디버깅 코드

	// photoDao 클래스에서 selectPhotoOne 호출
	PhotoDao photoDao = new PhotoDao();
	Photo photo = photoDao.selectPhotoOne(photoNo);
	// 디버깅 코드
	System.out.println(photo.photoNo + " <-- photo.photoNo");
	System.out.println(photo.photoName + " <-- photo.photoName");
	System.out.println(photo.writer + " <-- photo.writer");
	System.out.println(photo.createDate + " <-- photo.createDate");
	System.out.println(photo.updateDate + " <-- photo.updateDate");
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
		
		<!-- 메인메뉴 -->
		<div class="col bg-white" style="width:20px margin : auto 0">
		<h1>
			<div class="mt-3 p-3 bg-primary text-white text-center">사진 상세 보기</div>
		</h1>
		<div>
			<table class="table table-bordered text-center table-dark table-striped">
				<tr>
					<td>번호</td>
					<td><%=photo.photoNo%></td>
					<td>작성자</td>
					<td><%=photo.writer%></td>
				</tr>
				<tr>
					<td colspan="4">
						<img src="<%=request.getContextPath()%>/upload/<%=photo.photoName%>">
					</td>
				</tr>
				<tr>
					<td>작성날짜</td>
					<td><%=photo.createDate%></td>
					<td>수정날짜</td>
					<td><%=photo.updateDate%></td>
				</tr>
				<tr>
					<td colspan="4"><a class = "btn btn-danger float-right" href="<%=request.getContextPath()%>/photo/deletePhotoForm.jsp?photoNo=<%=photo.photoNo%>">삭제</a></td>
				</tr>
			</table>
		</div>
		</div>
			<!-- 오른쪽 광고 -->
			<div class="col-sm-2" style="text-align : center; margin : 0 auto;">
				<img src="광고6.png"  width="300px" height="600px" class="rounded" alt="Cinque Terre">
			</div>
		</div>
		
		<!-- 하단 메뉴 -->
		<div class="bg-secondary">
			롤체지지 참고
		</div>
</body>
</html>

