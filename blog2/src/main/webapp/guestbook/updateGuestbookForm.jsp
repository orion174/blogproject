<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import ="vo.*" %>
<%
    // 만약, 데이터 삭제 코드에 null이 들어가면 다시 guestbookList.jsp로 리턴해주는 코드
	if(request.getParameter("guestbookNo")==null){
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp?msg=null");
		return;
	}
	
    // guestbookList에서 데이터 요청 값 받는 코드
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	System.out.println(guestbookNo + " <-- guestbookNo");
	
	// vo.Guestbook 호출 후 guestbook 생성
	Guestbook guestbook = new Guestbook();
	// GuestbookDao 클래스 호출 
	GuestbookDao guestbookDao = new GuestbookDao();
	// GuestbookDao 클래스의 selectGuestbookOne 함수에 반환할 guestbook 데이터 선언
	guestbook = guestbookDao.selectGuestbookOne(guestbookNo);
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
	<!-- 카테고리 아레  -->
	<div class="row">
	<!-- 방명록 왼쪽광고 -->
	<div class="col-sm-2" style="text-align : center; margin : 0 auto;">
		<img src="광고3.png"  width="300px" height="600px" class="rounded" alt="Cinque Terre">
	</div>
	
	<!-- 메인메뉴 -->
	<div class="col bg-white" style="width:20px margin : auto 0">
		<body>
		<h1>
			<div class="mt-3 p-3 bg-primary text-white text-center">방명록 수정</div>
		</h1>
		<form method = "post" action = "<%=request.getContextPath()%>/guestbook/updateGuestbookAction.jsp">
			<table class = "table table-bordered">
				<tr>
					<td>방명록 번호</td>
					<td><input type = "text" name ="guestbookNo"  value="<%=guestbook.guestbookNo %>" readonly="readonly"></td>
				</tr>
				<tr>
					<td>방명록 내용</td>
					<td>
					<textarea cols="120" name ="guestbookContent"><%=guestbook.guestbookContent%></textarea>
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="text" name ="guestbookPw"></td>
				</tr>
				<tr>
					<td colspan = "2">
						<button class="btn btn-success" style="float: right;" type ="submit">수정</button>
					</td>
				</tr>
			</table>
		</form>
		</body>
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
