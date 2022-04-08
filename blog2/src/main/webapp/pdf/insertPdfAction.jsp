<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="vo.Pdf"%>
<%@page import="dao.PdfDao"%>
<%
	// 한글 깨짐 방지 인코딩 코드
	request.setCharacterEncoding("utf-8");

	// 파일 이름이 중복됐을때 임의로 (1), (2)를 붙여서 중복을 피함
	DefaultFileRenamePolicy rp = new DefaultFileRenamePolicy(); 
	
	// application 변수 톰켓을 가르키는 변수
	String path = application.getRealPath("uploadPdf"); 
	System.out.println(path + " <-- path"); 
	
	// 2^10 byte = 1 kbyte 1024 byte = 1 kbte
	// 2^10 kbyte = 1 mbyte
	// 100 mbyte = 1024*1024*100 byte = 104857600 byte 곱셈을 계산해서 코딩하면 가독성이 떨어진다.  ex) 24*60*60 하루에 대한 초
	MultipartRequest multiReq = new MultipartRequest(request, path, 1024*1024*100, "utf-8", rp); 
	
	// insertPdfForm 에서 요청값 받아옴
	String pdfPw = multiReq.getParameter("pdfPw");
	String writer = multiReq.getParameter("writer");
	// 디버깅 코드
	System.out.println(pdfPw + " <-- pdfPw");
	System.out.println(writer + " <-- writer");
	
	// input type="file" name="pdf"
	String pdfOriginalName = multiReq.getOriginalFileName("pdf");
	String pdfName = multiReq.getFilesystemName("pdf");
	String pdfType = multiReq.getContentType("pdf");
	// 디버깅 코드
	System.out.println("pdfOriginalName : " + pdfOriginalName);
	System.out.println("pdfName : " + pdfName);
	System.out.println("pdfType : " + pdfType);
	
	// pdf업로드의 경우 pdf형식만 허용
	if(pdfType.equals("application/pdf")) {
		System.out.println("db고고!");
		PdfDao pdfDao = new PdfDao();
		Pdf pdf = new Pdf(); 
		pdf.pdfName = pdfName;
		pdf.pdfOriginalName = pdfOriginalName;
		pdf.pdfType = pdfType;
		pdf.writer = writer;
		pdf.pdfPw = pdfPw;
		
		pdfDao.insertPdf(pdf); // 메서드 구현
		
		response.sendRedirect(request.getContextPath() + "/pdf/pdfList.jsp"); 
	} else {
		System.out.println("pdf 파일만 업로드");
		// 잘못들어온 파일이므로 업로드된 파일 지우고 폼으로...이동
		File file = new File(path + "\\" + pdfName); // java.io.File 잘못된 파일을 불러온다.
		file.delete(); // 삭제
		response.sendRedirect(request.getContextPath() + "/pdf/insertPdfForm.jsp");
	}
%>
