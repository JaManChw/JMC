<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="../header.jsp"/>
<style type="text/css">

table{
	border-collapse: collapse;
	width: 1000px;
	margin: 0 auto;
}

tr, th, td{
	border-bottom: 1px solid gray;
	text-align: center;
}

.qnADetailTable{
	padding-bottom: 100px;
}

div.main {
    padding-bottom: 90px;
      margin: 0 auto;
    width: 1800px;
    height: 750px;
}

div.left {   
   padding: 30px;
   float:left;
   width: 15%;
    display: inline-block;
   box-sizing: border-box;
   border: 1px solid #000;
   background-color: #efeeee;
   height: 800px;
}
 
div.right {
float:right;
    width: 80%;
        display: inline-block;
    box-sizing: border-box;    
     border-top-style: solid;
   border-bottom-style: solid;
      border-right-style: solid;
      border-left-style: solid;
     border-width: 1px;
     height: 800px;
}
div.title{
    font-size: 50px;
/*     float:left; */
   height: 120px;
}
</style>

<div class="main">
	<div class="left">
		<div class="title">
			<a href="<%=request.getContextPath()%>/cs/notice/list">공지사항</a>
		</div>
		<div class="title">
			<a href="<%=request.getContextPath()%>/cs/event/list">이벤트</a>
		</div>
		<div class="title">
			<a href="<%=request.getContextPath()%>/cs/qna/list">Q / A</a>
		</div>
		<!-- <span>공지사항</span> -->
		<!-- <span>이벤트</span> -->
		<!-- <span>Q / A</span> -->
	</div>
	<div class="right">		
		<div id="qnADetailContent">
			<c:if test="${empty qnAADetail}">
				<div class="qnADetailTable">
					<table>
						<tr>
							<th>번호</th>
							<td>${qnADetail.QUESTIONNO}</td>
							<th>작성자</th>
							<td>${qnADetail.USERNO}</td>
							<td>작성시간</td>
							<td><fmt:formatDate value="${qnADetail.WRITE_DATE}" pattern="yyyy.MM.dd HH:mm"/></td>
						</tr>
						<tr>
							<th>제목</th>
							<td colspan="5">${qnADetail.Q_TITLE}</td>
						</tr>
						<tr>
							<td colspan="6">${qnADetail.Q_CONTENT}</td>
						</tr>
					</table>
					<c:if test="${qnADetail.Q_STATUS eq 'unprocessed'}">
						<c:if test="${qnADetail.USERNO eq userno}">
							<button onclick="location.href='./revise?questionno=${qnADetail.QUESTIONNO}&curPage=${curPage}'">수정</button>
							<button onclick="location.href='./delete?questionno=${qnADetail.QUESTIONNO}&curPage=${curPage}'">삭제</button>
							<button onclick="location.href='./list?curPage=${curPage}'">목록</button>					
						</c:if>
						<button onclick="location.href='./list?curPage=${curPage}'">목록</button>
					</c:if>
					<c:if test="${qnADetail.Q_STATUS eq 'done'}">
						<button onclick="location.href='./list?curPage=${curPage}'">목록</button>
					</c:if>
				</div>
			</c:if>
			
			<c:if test="${not empty qnAADetail}">
				<div class="qnADetailTable">
					<table>
						<tr>
							<th>번호</th>
							<td>${qnADetail.QUESTIONNO}</td>
							<th>작성자</th>
							<td>${qnADetail.USERNO}</td>
							<td>작성시간</td>
							<td><fmt:formatDate value="${qnADetail.WRITE_DATE}" pattern="yyyy.MM.dd HH:mm"/></td>
						</tr>
						<tr>
							<th>제목</th>
							<td colspan="5">${qnADetail.Q_TITLE}</td>
						</tr>
						<tr>
							<td colspan="6">${qnADetail.Q_CONTENT}</td>
						</tr>
					</table>
					<br>
					<hr>
					<br>
					<table>
						<tr>
							<th>번호</th>
							<td>${qnAADetail.ANSWERNO}</td>
							<th>작성자</th>
							<td>${qnAADetail.USERNO}</td>
							<td>작성시간</td>
							<td><fmt:formatDate value="${qnAADetail.WRITE_DATE}" pattern="yyyy.MM.dd HH:mm"/></td>
						</tr>
						<tr>
							<td colspan="6">${qnAADetail.A_CONTENT}</td>
						</tr>
					</table>
					<button onclick="location.href='./list?curPage=${curPage}'">목록</button>
				</div>
			</c:if>
		</div>
	</div>
</div>

<c:import url="../../layout/footer.jsp"/>