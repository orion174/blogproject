<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import ="vo.*" %>
<%@page import ="dao.*" %>
<%@ page import = "java.io.*" %>

<%
    // 만약, deletePhotoForm요청값에 null이 들어가면 다시 deletePhotoForm.jsp로 리턴해주는 코드
	if(request.getParameter("photoNo")==null){
		response.sendRedirect(request.getContextPath()+"/photo/deletePhotoForm.jsp?msg=null");
		return;
	}

	// deletePhotoForm으로 삭제할 사진의 번호와 비밀번호 데이터 받는 코드
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoPw = request.getParameter("photoPw");
	// 디버깅 코드
	System.out.println(photoNo + " <-- photoNo");
	System.out.println(photoPw + " <-- photoPw");
	
	// PhotoDao 클래스 호출 
	PhotoDao photoDao = new PhotoDao();
	// PhotoDao 클래스의 deletePhoto 함수의 반환할 정수형 데이터 선언 
	int delRow = photoDao.deletePhoto(photoNo, photoPw); 
	System.out.println(delRow + " <-- delRow"); // 디버깅 코드
	
	/*
		String photoName = photoDao.selectPhotoOne(photoNo);
	*/
	
	
	// DB 연결 상태 확인
	// 몇행을 삭제 했는지 return 하는 코드
	if(delRow == 1) {
		// 삭제 성공했으면 photo list로 돌아감
		System.out.println("삭제성공!!");
		response.sendRedirect(request.getContextPath() + "/photo/photoList.jsp");
		/*
			String path = application.getRealPath("upload"); // application(현재프로젝트)안의 upload폴더의 실제 폴더경로를 반환
			File file = new File(path+"\\"+photoName); // 이미지 파일을 불러온다. java.io.File  
			file.delete(); // 이미지파일삭제
			// 오류가 나는데 좀 더 고쳐보겠습니다 일단 원래 했던 코드로 제출합니다 ... 
		*/
		
	} else if (delRow == 0) {
		// 삭제 실패하면 다시 photo form으로 돌아감
		System.out.println("삭제실패!!");
		response.sendRedirect(request.getContextPath() + "/photo/selectPhotoOne.jsp?photoNo=" + photoNo);
	} else {
		System.out.println("error!!");
	}
%>