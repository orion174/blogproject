<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import ="vo.*" %>
<%@page import ="dao.*" %>
<%
	// 만약, 방명록 작성에 null이 들어가면 다시 guestbookList.jsp로 리턴해주는 코드
	if(request.getParameter("guestbookNo")==null){
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp?msg=null");
		return;
	}

	// vo.guestbook 호출 후 guestbook 생성 후 요청 데이터 처리
	Guestbook guestbook  = new Guestbook();
	guestbook.guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	guestbook.guestbookPw = request.getParameter("guestbookPw");
	// 디버깅 코드
	System.out.println(guestbook.guestbookNo + " <-- guestbookNo");
	System.out.println(guestbook.guestbookPw + " <-- guestbookPw");
	
	// GuestbookDao 클래스 호출 
	GuestbookDao guestbookDao = new GuestbookDao();
	// GuestbookDao 클래스의 deleteGuestbook 함수의 반환할 정수형 데이터 선언 
	int row = guestbookDao.deleteGuestbook(guestbook.guestbookNo, guestbook.guestbookPw);
	
	// DB 연결 상태 확인
	// 몇행을 삭제 했는지 return 하는 코드
	if(row == 1) {
		// 삭제 성공했으면 guestbook list로 돌아감
		System.out.println("삭제성공!!");
		response.sendRedirect(request.getContextPath() + "/guestbook/guestbookList.jsp");
		return;
	} else if(row == 0) {
		// 삭제 실패하면 다시 delete form으로 돌아감
		System.out.println("삭제실패!!");
		response.sendRedirect(request.getContextPath() + "/guestbook/deleteGuestbookForm.jsp?guestbookNo=" + guestbook.guestbookNo);
		return;
	} else {
		System.out.println("error!");
	}
%>