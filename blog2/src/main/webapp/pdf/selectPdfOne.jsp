<%@page import="vo.Pdf"%>
<%@page import="dao.PdfDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// pdfList에서 요청값 받아옴
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));
	System.out.println(pdfNo + " <-- pdfNo"); // 디버깅 코드
	
	// PdfDao 클래스에서 selectPdfoOne 호출
	PdfDao pdfDao = new PdfDao(); 
	Pdf pdf = pdfDao.selectPdfOne(pdfNo); 
	// 디버깅 코드
	System.out.println(pdf.pdfNo + " <-- pdf.pdfNo");
	System.out.println(pdf.pdfName + " <-- pdf.pdfName");
	System.out.println(pdf.writer + " <-- pdf.writer");
	System.out.println(pdf.createDate + " <-- pdf.createDate");
	System.out.println(pdf.updateDate+ " <-- pdf.updateDate");
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
			<img src="광고7.png"  width="300px" height="600px" class="rounded" alt="Cinque Terre">
		</div>
		
		<!-- 메인메뉴 -->
		<div class="col bg-white" style="width:20px margin : auto 0">
		<h1>
			<div class="mt-3 p-3 bg-primary text-white text-center">PDF 상세보기</div>
		</h1>
		
		<table class="table table-bordered text-center">
			<tr class="table-primary">
				<td>번호</td>
				<td><%=pdf.pdfNo%></td>
				<td>작성자</td>
				<td><%=pdf.writer%></td>
			</tr>
			<tr>
				<td colspan="4">
					PDF 열기 : <a href="<%=request.getContextPath()%>/uploadPdf/<%=pdf.pdfName%>"><%=pdf.pdfName%></a>
				</td>
			</tr>
			<tr>
				<td>생성날짜</td>
				<td><%=pdf.createDate%></td>				
				<td>수정날짜</td>
				<td><%=pdf.updateDate%></td>				
			</tr>
			<tr>
				<td colspan="4"><a class = "btn btn-danger float-right" href="<%=request.getContextPath()%>/pdf/deletePdfForm.jsp?pdfNo=<%=pdf.pdfNo%>">삭제</a></td>
			</tr>
		</table>
	  </div>
	
	<!-- 오른쪽 광고 -->
	<div class="col-sm-2" style="text-align : center; margin : 0 auto;">
		<img src="광고8.png"  width="300px" height="600px" class="rounded" alt="Cinque Terre">
	</div>
	
	</div>
	</div>
	
	<!-- 하단 메뉴 -->
	<div class="bg-secondary">
		롤체지지 참고
	</div>
</body>
</html>
