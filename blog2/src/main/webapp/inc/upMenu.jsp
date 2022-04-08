<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 다른 페이지 링크 -->
<nav class="navbar navbar-expand-sm bg-light  justify-content-center">
	<ul class="nav nav-pills">
		<li class="nav-item">
			<a class="nav-link" data-toggle="pill" href="<%=request.getContextPath()%>/board/boardList.jsp">홈으로</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" data-toggle="pill" href="<%=request.getContextPath()%>/board/boardList.jsp">게시판</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" data-toggle="pill" href="<%=request.getContextPath()%>/photo/photoList.jsp">사진</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" data-toggle="pill" href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp">방명록</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" data-toggle="pill" href="<%=request.getContextPath()%>/pdf/pdfList.jsp">PDF자료실</a>
		</li>
	</ul>
</nav>


			
			