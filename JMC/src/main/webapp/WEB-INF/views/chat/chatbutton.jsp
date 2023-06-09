<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript">
$(function(){
	
	$("#chatbutton").click(function(){
		
		$(".close").show()
		$(this).css("display","none")
	})
	$("#closeButton").click(function(){
		$(".close").css("display","none")
		$("#chatbutton").show()
	})
	$("#backButton").click(function(){
		$('#iframeChat').get(0).contentWindow.back()   		
	})
})

function backbuttonhide(){
	$("#backButton").hide()
}
function backbuttonshow(){
	$("#backButton").show()
}


</script>
<style type="text/css">
#buttonjsp{
	position:fixed;
	bottom : 10%;
	left : 90%;
}
.close{
	position : relative;
	display : none;
	right : 330px;
	width : 370px;
	height : 600px;
	background-color: white;
	border-radius: 30px;
    box-shadow: 0px 0px 5px 3px gray;
	
	
}
#iframeChat{
	width: 100%;
	height: 90%;
	border : none;
}
#closeChat{
	margin-left : 263px;
}


#buttonjsp{
	width : 0px;
}
#closeButton{
	width : 30px;
	height : 30px;
	cursor: pointer;
}
#headerButton{
	display : flex;
	align-items: center;
	padding-right : 15px;
	padding-left: 15px;
	height : 10%;
}
#back{
	display : flex;
	width: 100%;
}
#backButton{
	width:40px;
	height: 45px;
	cursor: pointer;
}
#chatbutton{
    border: 0px solid white;
    border-radius: 50px;
    background-color: white;
	width: 80px;
	cursor: pointer;
}
</style>
</head>
<body>
<div id="buttonjsp">
<img  src="../resources/image/chaticon.png" id="chatbutton">
<!-- <button id="chatbutton">채팅방</button> -->
<div class="close">
<div id="headerButton">
<div id="back">
<img src="../resources/image/back.png" id="backButton">
</div>
<div id="hideChat">
<img src="../resources/image/close.png" id="closeButton">
</div>
</div>
<iframe src="./chatroomlist" id="iframeChat">
</iframe>
</div>
</div>
</body>
</html>