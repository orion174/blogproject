<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%@ page import = "java.util.ArrayList" %>
<%
	// 페이징 알고리즘
	// guestbookList을 실행하면 최근"5"개의 목록을 보여주고 현재 페이지의 기본값을 1페이지로 설정
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 4; // rowPerPage는 변경될 수 있음
	// 현재 페이지 currentPage 변경 -> beginRow로 
	int beginRow = (currentPage-1) * rowPerPage;
	
	// GuestbookDao 클래스에서 selectGuestbookListByPage 호출
	GuestbookDao guestbookDao = new GuestbookDao();
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);
	
	// 마지막 페이지 변수 값 저장 코드
	int lastPage = 0;
	// GuestbookDao 클래스 호출
	int totalCount = guestbookDao.selectGuestbookTotalRow();
	// 마지막 페이지는 (전체 데이터 수 / 화면당 보여지는 데이터 수) 가 됨
	/*
	lastPage = totalCount / rowPerPage;
	if(totalCount % rowPerPage != 0) {
		lastPage++;
	}
	*/
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 
	// 4.0 / 2.0 = 2.0 -> 2.0
	// 5.0 / 2.0 = 2.5 -> 3.0
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>guestbookList</title>
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
	<!-- 메인 컨테이너  -->
	<div class="row">
	<!-- 방명록 왼쪽광고 -->
	<div class="col-sm-2" style="text-align : center; margin : 0 auto;">
		<img src="광고3.png"  width="300px" height="600px" class="rounded" alt="Cinque Terre">
	</div>
	
	<!-- 메인메뉴 -->
	<div class="col bg-white" style="width:20px margin : auto 0">
	<h1>
		<div class="mt-3 p-3 bg-primary text-white text-center">방명록 목록(total : <%=totalCount%>)</div>
	</h1>
	<table class="table table-bordered border="1">
	     <tbody>
			<% 
				for(Guestbook g : list) {
			%>
	        <tr class="table-primary">
				<td ><%=g.writer%></td>
				<td><%=g.createDate%></td>
			</tr>
			<tr>
				<td colspan="2"><%=g.guestbookContent%></td>
			</tr>
			 	<td colspan="2">
					<a class="btn btn-danger" style="float: right;" href="<%=request.getContextPath()%>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=g.guestbookNo%>">삭제</a>
					<a class="btn btn-success" style="float: right;" href="<%=request.getContextPath()%>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=g.guestbookNo%>">수정</a>	
				</td>
			<%	
				}
			%>			
 		</tbody>
   </table>
   
   <!--  방명록 페이징 코드 -->
	<div>
		<%
			if(currentPage > 1) {
		%>
				<a class="btn btn-primary" style="float: right;" href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%		
			}
		%>
		<%
			if(currentPage < lastPage) {
		%>
				<a class="btn btn-primary" style="float: right;" href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>
	</div>
	<!-- 방명록 입력 -->
	<div>
	<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp">
		<table class="table table-bordered border="1">
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="writer"></td>
				<td>비밀번호</td>
				<td><input type="password" name="guestbookPw"></td>
			</tr>
			<tr>
				<td colspan="4"><textarea name="guestbookContent" rows="2" cols="60"></textarea></td>
			</tr>
		</table>
		<button class="btn btn-primary" style="float: right;" type="submit">입력</button>
	</form>
	</div>
	</div>
	
	<!-- 방명록 오른쪽 광고 -->
	<div class="col-sm-2" style="text-align : center; margin : 0 auto;">
		<img src="광고4.png"  width="300px" height="600px" class="rounded" alt="Cinque Terre">
	</div>
	</div>
	</div>
	<!-- 하단 메뉴 -->
	<div class="bg-secondary">
		롤체지지 참고
	</div>
</body>
</html>