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
	int rowPerPage = 3; // 내가 보고싶은 정보 갯수
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
			<div class="mt-3 p-3 bg-primary text-white text-center">사진 목록(total : <%=totalRow%>)</div>
		</h1>
		
		<table class="table table-dark table-striped text-center">
			<%
				for(Photo p : list) {
			%>
					<tr>
						<td>
							<a href="<%=request.getContextPath()%>/photo/selectPhotoOne.jsp?photoNo=<%=p.photoNo%>">
								<img src="<%=request.getContextPath()%>/upload/<%=p.photoName%>" width="200" height="200">
							</a>
						</td>
						<td>
							<%=p.createDate%>
						</td>
					</tr>
			<%
				}
			%>
			<tr class="bg-primary table-borderless">
				<td colspan="2"><span class="text-white"><%=currentPage%> / <%=lastPage%> Page</span></td>
			</tr>
				<!-- 사진 페이징 코드 -->
			<tr class="bg-light table-borderless">
				<td colspan ="2">
						<%
							if(currentPage > 1) {
						%>
								<a class="page-item float-right"><a class="btn btn-primary" style="float: right;" href="<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage-1%>">이전</a>
						<%
							}
							if(currentPage < lastPage) {
						%>
								<a class="page-item float-right"><a class="btn btn-primary" style="float: right;" href="<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage+1%>">다음</a>
						<%
							}
						%>
				</td>
			</tr>
		</table>
	        <a class="btn btn-success" style="float: right;" href="<%=request.getContextPath()%>/photo/insertPhotoForm.jsp">사진 등록</a>
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