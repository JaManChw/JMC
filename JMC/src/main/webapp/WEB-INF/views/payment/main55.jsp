<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
	  <script src="https://js.tosspayments.com/v1/payment-widget"></script>
<script type="text/javascript">
$(function() {
	$("#toss").click(function() {
			
		$.ajax({
			type: "get"
			, url: "./tossstart"
			, data:  {}
			, dataType: "html" 
			, success: function( res ) {
				console.log("AJAX 성공")
				$("#tossstart").html(res)
				filter = $("#filter").val();
			
			}
			, error: function() {
				console.log("AJAX 실패")
			}
		})
	})
}) 
</script>
</head>
<body>

<button id="toss">결제하기
</button>


<div id ="tossstart">
</div>

</body>
</html>