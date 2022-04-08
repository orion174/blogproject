<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import ="vo.*" %>
<%@page import ="dao.*" %>
<%
	// deletePdfForm으로 삭제할 pdf의 번호와 비밀번호 데이터 받는 코드
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo")); 
	String pdfPw = request.getParameter("pdfPw");
	// 디버깅 코드
	System.out.println(pdfNo + " <-- pdfNo");
	System.out.println(pdfPw + " <-- pdfPw");

	// Pdf, PdfDao 클래스 호출 
	PdfDao pdfDao = new PdfDao();
	Pdf pdf = new Pdf();
	// 객체 저장
	pdf.pdfNo = pdfNo;
	pdf.pdfPw = pdfPw;
	
	// PdfDao 클래스의 deletePdf 함수의 반환할 정수형 데이터 선언 
	int row = pdfDao.deletePdf(pdf);
	System.out.println(row + " <-- row"); // 디버깅 코드
	
	// DB 연결 상태 확인
	// 몇행을 삭제 했는지 return 하는 코드
	if(row == 1) { 
		// 삭제 성공했으면 pdf list로 돌아감
		System.out.println("삭제성공!!");
		response.sendRedirect(request.getContextPath() + "/pdf/pdfList.jsp");
	} else if(row == 0) { 
		// 삭제 실패하면 다시 photo form으로 돌아감
		System.out.println("삭제실패!!");
		response.sendRedirect(request.getContextPath() + "/pdf/selectPdfOne.jsp?pdfNo=" + pdf.pdfNo);
	} else {
		System.out.println("error!!");
	}
%>
