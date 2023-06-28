<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="<%=request.getContextPath()%>/resources/image/faviconWhiskeyWestern.png">
<title>
	JMC  
</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- jQuery 2.2.4 -->
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
div.admin {
   	margin: 0 auto;
    width: 1800px;
    height: 750px;
        
}

div.left {   
	width: 15%;
	float: left;
	box-sizing: border-box;
	border: 1px solid #000;
	background-color: #efeeee;
	height: 800px;
}
 
div.right {
    width: 85%;
    float: right;
    box-sizing: border-box;    
  	border-top-style: solid;
	border-bottom-style: solid;
   	border-right-style: solid;
  	border-width: 1px;
  	height: 800px;
}

h2{
   padding-left : 50px;
}

p{
   padding-left : 50px;
}

a {
   text-decoration: none !important;
	color: black;
}

a:visited {
	color : black;
}
 
.right{
	overflow-y:scroll;
}  
</style>
<style type="text/css">
 *{
 font-family: 'Noto Sans KR', sans-serif;
 }
.innerTitle {
	margin: 0 auto;
	border-radius: 30px; 
	background-color : #03a9f46e; 
	width: 600px;  
	text-align: center; 
	padding-bottom: 5px;
}
</style>
</head> 
<body>
<h1><a href="/admin/main"  style = "padding-top : 20px; padding-left : 30px; width: 400px;" >관리자 메인 페이지</a></h1>
<br>
<div class="admin">
	<div class="left">
	
	
	<h2 style = "padding-top : 50px;">회원관리</h2>
	<p><a class="userModify" href="<%=request.getContextPath()%>/admin/user/mg/list">회원 정보 수정</a><br></p>
	<p><a class="blackManage" href="<%=request.getContextPath()%>/admin/user/black/list">블랙리스트 관리</a><br><br></p>
	<h2>신고관리</h2>
	<p><a class="reportBoardCheck" href="<%=request.getContextPath()%>/admin/report/post/list">신고글 확인</a><br></p>
	<p><a class="reportMeetingCheck" href="<%=request.getContextPath()%>/admin/report/meeting/list">모임 신고 확인</a><br></p>
	<p><a class="reportUserCheck" href="<%=request.getContextPath()%>/admin/report/user/list">신고 계정 확인</a><br><br></p>
	<h2>판매관리</h2>
	<p><a class="itemWrite" href="<%=request.getContextPath()%>/admin/item/itemview/write">상품 등록</a><br></p>
	<p><a class="itemModify" href="<%=request.getContextPath()%>/admin/item/itemview/list">상품 삭제/수정</a><br></p>
	<p><a class="itemQ" href="<%=request.getContextPath()%>/admin/item/itemqna/list">상품 문의</a><br><br></p>
	<h2>고객센터관리</h2>
	<p><a class="noticeManage" href="<%=request.getContextPath()%>/admin/main/boardCategory?boardOption=notice">공지사항 관리</a><br></p>
	<p><a class="eventManage" href="<%=request.getContextPath()%>/admin/main/boardCategory?boardOption=event">이벤트 관리</a><br></p>
	<p><a class="qnAManage" href="<%=request.getContextPath()%>/admin/board/qna/list">Q & A 관리</a><br><br></p>
	
	<div>
	<a href="<%=request.getContextPath()%>/login/main">메인 페이지로</a>
	</div>
	</div>
	
	<div class="right">
