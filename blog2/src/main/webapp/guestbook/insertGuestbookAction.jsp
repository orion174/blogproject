<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.GuestbookDao" %>
<% 
    // 한글 깨짐 방지 코드
	request.setCharacterEncoding("utf-8"); 
	// GuestbookDao 클래스 호출 후 선언
	GuestbookDao guestbookDao = new GuestbookDao();
	
	// 방명록 글 작성시 DB에서 가져오는 데이터
	String writer = request.getParameter("writer");
	String guestbookPw = request.getParameter("guestbookPw");
	String guestbookContent = request.getParameter("guestbookContent");
	// 다버깅 코드
	System.out.println("writer : " + writer);
	System.out.println("guestbookPw : " + guestbookPw);
	System.out.println("guestbookContent : " + guestbookContent);

	// vo.guestbook 클래스 호출 후 데이터 가공
	Guestbook guestbook = new Guestbook();
	guestbook.writer = writer;
	guestbook.guestbookPw = guestbookPw;
	guestbook.guestbookContent = guestbookContent;
	
	// GuestbookDao 클래스에 있는 insertGuestbook 함수 호출
	guestbookDao.insertGuestbook(guestbook);
	
	// 글 작성후 리턴 해주는 페이지
	response.sendRedirect(request.getContextPath() + "/guestbook/guestbookList.jsp"); 
%>