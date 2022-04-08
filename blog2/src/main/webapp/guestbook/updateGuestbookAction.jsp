<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import ="java.sql.*" %>
<%@page import = "vo.*" %>
<%@page import ="dao.*" %>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	// null 데이터 체크 코드 -> 하나 이상 null값 들어올 시, updateGuestbookForm.jsp로 리톤
	if(request.getParameter("guestbookPw").equals("") || request.getParameter("guestbookContent").equals("") || request.getParameter("guestbookPw").equals("")) {
		response.sendRedirect(request.getContextPath()+"/guestbook/updateGuestbookForm.jsp?msg=null");	
		return;
	}
	// 디버깅 코드 
	System.out.println(request.getParameter("guestbookContent") + " <-- guestbookContent");
	System.out.println(request.getParameter("guestbookPw") + " <-- guestbookPw");
		
	// vo.guestbook 호출 후 guestbook 생성해 요청 데이터 처리
	Guestbook guestbook = new Guestbook();
	guestbook.guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	guestbook.guestbookContent = request.getParameter("guestbookContent");
	guestbook.guestbookPw = request.getParameter("guestbookPw");
	
	// GuestbookDao 클래스 호출 
	GuestbookDao guestbookDao = new GuestbookDao();
	// GuestbookDao 클래스의 updateGuestbook 함수의 반환할 정수형 데이터 선언 
	int row = guestbookDao.updateGuestbook(guestbook);
	
	// DB 연결 상태 확인
	// 몇행을 입력했는지 return 하는 코드
	if(row == 1) {
		// 수정 성공했으면 guestbook list로 돌아감
		System.out.println("수정성공!!");
		response.sendRedirect(request.getContextPath() + "/guestbook/guestbookList.jsp");
		return;
	} else if(row == 0) {
		// 수정 실패하면 다시 update form으로 돌아감
		System.out.println("수정실패!!");
		response.sendRedirect(request.getContextPath() + "/guestbook/updateGuestbookForm.jsp?guestbookNo=" + guestbook.guestbookNo);
		return;
	} else {
		// 에러 코드
		System.out.println("수정 error!");
	}
%> 