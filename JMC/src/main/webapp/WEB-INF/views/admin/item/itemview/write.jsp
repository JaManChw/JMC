<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<c:import url="../../main.jsp"/>

<!-- include libraries(jQuery, bootstrap) -->
<!-- CSS only -->
<!-- <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet"> -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<script>
$(function() {
	
	$("#btnOption").click(function() {
		console.log("Option Add Button Click Event Occured")
		
		var addOption = "<div class='OptionDiv'>";
		addOption += "<label>옵션설명:</label>";
		addOption += "<input type='text' class='option' name='optionContent' style='margin-top:5px;'>";
		addOption += "<label>추가 금액:</label>";
		addOption += "<input type='text' class='option mustNum' name='extraCharge' style='margin-top:5px;'>";
		addOption += "<label>옵션 상품 갯수:</label>";
		addOption += "<input type='text' class='option mustNum' name='optionCount' style='margin-top:5px;'>";
		addOption += "<img class='image' alt='delpic' src='/resources/image/optionDelete.png' style='width:20px;'>";
		addOption += "<br>";
		addOption += "</div>";
		
		$("#addedOption").append(addOption)
	})
	
	//생성된 옵션의 우측의 삭제 버튼 클릭시 옵션이 삭제되도록 하는 이벤트 리스너 
	$("#addedOption").on("click", ".image", function(){
		console.log(this);
		$(this).parent().remove();
		
	})


	//동적으로 생성되는 옵션에 가격, 수량에 숫자만 입력되도록 하는 이벤트 리스너
	//정규식, replace함수 사용
	$("#addedOption").on("change", ".mustNum", function() {
// 		console.log("이벤트는 걸렷나요?")
		this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
	})
	
	
	//가격과 전체 수량에 숫자만 입력되도록 하는 이벤트 리스너
	//정규식, replace함수 사용
	$(".mustNum").change(function() {		
		
		this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
		
	})
	
	
		//div#content에 에디터 적용하기
	$("#summernote").summernote({
				height: 400,
				width: 800,
				//resize: none;
				disableResizeEditor: true,
				//fileSave
				callbacks: {
					onImageUpload: function(files, editor, welEditable) {
						console.log("사용이 되나요1?");
						for(var i = files.length -1 ; i >= 0; i--){
							sendFile(files[i], this)
						}
					}
				}
			});
	
	function sendFile(file, el) {
		console.log("el {}", el);
		data = new FormData();
		data.append("file", file);	//** 파일전달파라미터의 name
		
		$.ajax({
			data: data
			,type: "POST"
			,url: "./writeFileupload"
			,cache: false
			,contentType: false
			,processData: false
			,success: function(res) {
				var image = $('<img>').prop('src', res.url)
				$(el).summernote('insertNode', image[0])
				console.log($(el))
				console.log(res)
				console.log(res.url)
			}
			,error: function() {
				console.log("error입니다스!")
			}
		})
	}
	
	$(".img-wrap").click(function() {
		$("#file").click()
	})

	$("#file").change(function() {
	
		var files = this.files;
	
		for(var i = 0; i<files.length; i++){
		
			if(!files[i].type.includes("image")){
				alert((i+1)+ "번째 파일("+files[i]+")은 이미지가 아닙니다")
				continue				
			}
		
			$(".uploadedPic").html('')
		
			var reader = new FileReader()
		
	        reader.onload = function(){
	           $("<img>")
	           .attr({
	              src:this.result
	              ,width:100
	              ,height:100
	           })
	           .appendTo($(".uploadedPic"))
	        }   

			
			
			reader.readAsDataURL(files[i])
		
		}
	})
})
</script>

<style type="text/css">
#itemWriteForm{
	width:1200px;
	margin: 0 auto;
}

#itemWriteInput{
	border:1px solid gray;
}
.img-wrap{
    cursor: pointer;
    width: 40%;
    height: 100px;
    background: gray;
    border: 2px solid white;
    border-radius: 20px 20px;
    position: relative;
    display: inline-block;
	
}
.picUpIcon{
	width: 50px;
    height: 50px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-50%);
}

.all-file-wrap{
	width: 300px;
    height: 100px;
    display: flex;
    flex-direction: row;
}

.uploadedPic{
 	display:inline-block; 
	width:92%;
	height: 100px;
}
.itemWrite{
	color:blue;
}
</style>

<div id="itemWriteForm">
<form action="./write" method="post" enctype="multipart/form-data">

<a><h1>판매 상품 신규 등록</h1></a>

<span>상품 기본 정보</span>
<div id="itemWriteInput">
<div>
<label>상품분류</label>
<select name="itemType">
	<option value="칵테일 재료">칵테일 재료</option>
	<option value="칵테일 도구">칵테일 도구</option>
	<option value="칵테일 잔">칵테일 잔</option>
	<option value="위스키 물품">위스키 물품</option>
	<option value="와인 물품">와인 물품</option>
</select>
<select name="itemStatus">
	<option value="sale">판매</option>
	<option value="sold_out">매진</option>
	<option value="stop_selling">판매 중지</option>
</select>
<br>
</div>
<div>
<label>상품명</label>
<input type="text" id="itemTitle" name="itemTitle"><br>
</div>
<div>
<label>가격 입력</label>
<input type="text" id="itemPrice" name="itemPrice" class="mustNum"><br>
</div>
<div>
<label>재고 설정</label>
<input type="text" id="allItemCount" name="allItemCount" class="mustNum"><br>
</div>
<div>
<label>상품 옵션 추가</label>
<img id="btnOption" alt="optionAddIcon" src="/resources/image/optionAddIcon.png" style="width:15px">
<div id="addedOption">
</div>
</div>
<div>
	<label>상품 메인 이미지</label>
</div>
<div class="all-file-wrap">
	<div class="img-wrap">	
		<img class="picUpIcon" alt="picUpIcon" src="/resources/image/fileuploadIcon.png" style="width:50px;height:50px;">
	</div>
	<div class="uploadedPic">
	</div>
	<input type="file" id="file" name="file" multiple="multiple" class="form-control rounded-bottom d-none">
</div>
<hr>
<label>상품 내용 입력</label>
<textarea id="summernote" name="itemContent"></textarea><br>
<hr>
<button>상품 등록</button>
</div>

</form>
</div>

<!-- <div class="아이콘 저작권"> -->
<!-- <a href="https://www.flaticon.com/kr/free-icons/-" title="...을 더한 아이콘">...을 더한 아이콘  제작자: kliwir art - Flaticon</a> -->
<!-- <a href="https://www.flaticon.com/kr/free-icons/" title="실패한 아이콘">실패한 아이콘  제작자: rizky maulidhani - Flaticon</a> -->
<!-- <a href="https://www.flaticon.com/kr/free-icons/" title="카메라 아이콘">카메라 아이콘  제작자: Freepik - Flaticon</a> -->
<!-- </div> -->

</div>
</div>
</body>
</html>