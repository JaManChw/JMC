

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>


<style>
table {
    margin-left:auto; 
    margin-right:auto;
}

table, td, th {
    border-collapse : collapse;
    text-align: center; 
}

div.admin1 {
        height: 650x;
      	padding-left: 60px;
    width: 98%;
        
}


</style>

<c:import url="../../main.jsp"></c:import>


<div id="Alltitle" style="text-align: center; padding-top: 10px;">
	<h1  style="margin: 0 auto;border-radius: 30px; background-color : #03a9f46e; width: 600px;  text-align: center; padding-bottom: 5px;">
		유저 신고글 관리
	</h1>
</div>

<div class="text-end" style="padding-right: 50px; padding-top: 15px; margin-bottom:15px;">
<form action="./filter" method="post">
		<select name ="filter" id="filter">
		   <option value = "user_id" selected>아이디</option>
		   <option value = "user_name">이름</option>
		   <option value = "grade">등급</option>
		</select>
		
		검색 : <input type="text" name="content" id="content">
		<button id="searchBtn" type="submit" class="btn btn-secondary btn-sm">검색하기</button>
</form>
</div> 

<div id="result" class="admin1">
<table class="table table table-hover">
<tr class="table-secondary">
	<th>글번호</th>
	<th>신고자 아이디</th>
	<th>신고자 이름</th>
	<th>제목</th>
	<th>신고분류</th>
	<th>처리상태</th>
	<th>작성일</th>
</tr>
<c:forEach var="report" items="${reportU }">
<tr>
	<th>${report.REPORTNO }</th>
	<th>${report.USER_ID }</th>
	<th>${report.USER_NAME }</th>
	<th><a href="./userview?reportno=${report.REPORTNO }">${report.TITLE }</a></th>
	<th>${report.REPORT_OPTION }</th>
	<th><c:choose>
		<c:when test="${report.STATUS eq 'done'}"> 승인</c:when>
		<c:when test="${report.STATUS eq 'unprocessed'}">미승인</c:when>
	</c:choose>  </th>
	<th>${report.WRITE_DATE }</th>
</tr>
</c:forEach>
</table>
<br>
<div>
<c:import url="./paging.jsp" />
</div>
</div>
</div>
</div>
</body>
</html>



