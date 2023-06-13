<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../layout/header.jsp" />
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">



#btn_group button {
	border: 1px solid skyblue;
	background-color: rgba(0, 0, 0, 0);
	color: skyblue;
	padding: 5px;
	font-size: 25px;
}

#btn_group button:hover {
	color: white;
	background-color: skyblue;
}

#goodswhole {
	border-top-left-radius: 5px;
	border-bottom-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-right-radius: 5px;
	margin-right: 20px;
}

#goodsglass {
	border-top-left-radius: 5px;
	border-bottom-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-right-radius: 5px;
}

#goodsshaker {
	border-top-left-radius: 5px;
	border-bottom-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-right-radius: 5px;
}

#goodsoffset {
	border-top-left-radius: 5px;
	border-bottom-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-right-radius: 5px;
}
#goods{
	font-size: 30px;
}

#searchWrite{
	width: 250px;
	height: 30px;
 	position: relative;
	left : 1000px;

}

.container { 
  display : grid ; 
  grid-template-columns: repeat(4, 400px);
  grid-template-rows: repeat(2,400px);
  place-items: center;
  margin-bottom: 50px
  

} 

.item{
text-align: center;
}

#btn_Search{
    position: relative;
    left: 952px;
    top: 8px;
}
</style>

<script type="text/javascript">
//엔터로 해도 작동 시키기
$("#searchWrite").keydown(function(e) {
	if(e.keyCode == 13){
		$("#btn_Search").click();
	}
})

//마우스로 클릭시 작동 시키기
 $("#btn_Search").click(function() {
	 console.log("돋보기 버튼 클릭 됨")
	 var searchData = $('#searchWrite').val()
	
	 if(searchData == ""){
		 return;
	 }
	 console.log(boardOptionno)
	
	 if(boardOptionno == undefined){
		 boardOptionno=0
	 }
	console.log("검색 값 :", searchData)
	console.log(boardOptionno)
	 
	 $.ajax({
	         type: "get"
	         , url: "/board/search"
		     , dataType: "json"
	         , data: {searchData : searchData, boardOptionno: boardOptionno}
			 ,contentType: "application/x-www-form-urlencoded; charset=UTF-8"
	         , success: function(res){
	            console.log("AJAX 성공")
	            console.log("res!!!!! :", res)
	    		var putHtml = "" 
	    			for(var i = 0; i <res.length; i ++){

	    			putHtml += "<a data-boardno='"+res[i].BOARDNO+"'><img src='/boardFileUpload/"+res[i].STORED_NAME+"/' class='boardPic'></a>";
	    			}
	            
	            $("#merchantList").html(putHtml);
	    		$.ajax({
	    			type: "get"
	    			, url: "/board/firstPage"
	    			,dataType : "json"
	    			, data : {boardno: res[0].BOARDNO}
	    			,contentType: "application/x-www-form-urlencoded; charset=UTF-8"
	    			,success: function(res1){
	    				console.log("AJAX 성공")
	    				console.log("값 잘 가지고 옴????", res[0].BOARDNO);
	    				$("#article > img").attr("src", "/boardFileUpload/"+res1.STORED_NAME)
	    				//★여기서 추가로 글 값들까지 가지고 오게 해야 함.........
	    				$("#article > #content22").html(res1.CONTENT)
	    				$("#article[id='cocountSpan']").html(res1.COCOUNT)
	    				$("#article[id='like']").html(res1.LIKECOUNT)
	    				
	    			
	    			}
	    			
	    			 , error: function(){
	    		            console.log("AJAX 실패")   
	    		    }
	    		})
	    			           
	            
	            
	         }//SUCCESS종료
	         , error: function(){
	            console.log("AJAX 실패")   
	         }//ERROR종료
	      })//AJAX 종료 		 



 })//function 종료




</script>

<body>
<div id="goods">
칵테일 용품
<span class="search"><!-- 검색어 관련 -->
 	<input type="text" id="searchWrite" name="searchWrite" placeholder="검색어를 입력하세요">
 	<img id="btn_Search" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" width="25px" height="25px">
</span>
</div>
<hr>
<div id="btn_group">
<a href="/store/goodsAll?type=goods"><button id="goodswhole">전체보기</button></a>
<c:if test="${list.get(0).ITEM_TYPE eq '칵테일 재료' 
				or list.get(0).ITEM_TYPE eq '칵테일 도구' 
				or list.get(0).ITEM_TYPE eq '칵테일 잔'}">
<a href="/store/itemDetailSection?type=goodsglass"><button id="goodsglass">칵테일 재료</button></a>
<a href="/store/itemDetailSection?type=goodsshaker"><button id="goodsshaker">칵테일 도구</button></a>
<a href="/store/itemDetailSection?type=goodsoffset"><button id="goodsoffset">칵테일 잔</button></a>
</c:if>



<c:if test="${list.get(0) eq '위스키 물품' 
				or list.get(0) eq '와인 물품'}">
</c:if>
</div>


<div class="container">
<c:forEach var="list" items="${list}">
	<div class="item">
	<img id="material" src='/itemfile/${list.I_STORED_NAME}/' width="250px" height="250px" >
	      <div>${list.ITEM_TYPE }</div>
	      <div>${list.ITEM_TITLE }</div>
	      <div>${list.ITEM_PRICE }</div>
	</div>
</c:forEach>
</div>
<c:import url="paging.jsp" />

<c:import url="../layout/footer.jsp" />