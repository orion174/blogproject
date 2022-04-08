<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 페이징 알고리즘
    int currentPage = 1; // 현재 페이지
    
    // 사용자가 photo의 페이즈를 넘기면 currentPage 값 받아옴
	if(request.getParameter("currentPage") != null) { 
		currentPage = Integer.parseInt(request.getParameter("currentPage")); 
	}
	System.out.println(currentPage + " <-- cureentPage"); // 디버깅 코드
	// photoList을 실행하면 최근"5"개의 목록을 보여주고 현재 페이지의 기본값을 1페이지로 설정
	int rowPerPage = 5; // 내가 보고싶은 정보 갯수
	// 현재 페이지 currentPage 변경 -> beginRow로
	int beginRow = (currentPage-1) * rowPerPage; // (현재페이지-1) * (내가 보고싶은 정보 갯수) -> 처음 시작하는 행이 어디부터 시작인지 알 수 있음 
	
	// PhotoDao 클래스에서 selectGuestPhotoListByPage 호출
	PhotoDao photoDao = new PhotoDao(); 
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage); // 메서드 사용후 반환값이 ArrayList이므로 ArrayList에 저장
	// photo의 총 이미지 수 합
	int totalRow = photoDao.selectPhotoTotalRow(); 
	
	// 마지막 페이지 변수 값 저장 코드
	int lastPage = 0; 
	// 마지막 페이지는 (전체 데이터 수 / 화면당 보여지는 데이터 수) 가 됨
	if(totalRow % rowPerPage == 0) {
		lastPage = totalRow / rowPerPage;
	// 마지막 페이지의 수가 rowPerPage보다 적을 때
	} else {
		lastPage = (totalRow / rowPerPage) + 1;
	}
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
			<div class="mt-3 p-3 bg-primary text-white text-center">사진 등록</div>
		</h1>
		<!-- 
			1) form태그안에 값을 넘기는 기본값(enctype속성)은 문자열이다.
			2) 파일을 넘길 수 없다. 기본값(application/x-www-form-urlencoded)을 변경해야 한다.
			3) 기본값을 "multipart/form-data"로 변경하면 기본값이 문자열에서 바이너리(이진수)로 변경된다.
			4) 같은 폼안에 모든 값이 바이너리로 넘어간다. 글자를 넘겨받는 request.getParameter()를 사용할 수 없다.
			5) 복잡한 코드를 통해서만 바이너리 내용을 넘겨 받을 수있다.
			6) 외부 라이브러리(cos.jar)를 사용해서 복잡은 코드 간단하게 구현하자.
		-->
		<form action="<%=request.getContextPath()%>/photo/insertPhotoAction.jsp" method="post" enctype="multipart/form-data">
			<table class="table table-bordered">
				<tr>
					<td>이미지파일</td>
					<td><input type="file" name="photo"></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input type="text" name="writer"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="photoPw"></td>
				</tr>
				
			</table>
			<button class="btn btn-success" style="float: right;" type="submit">사진 등록</button>
		</form>
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
