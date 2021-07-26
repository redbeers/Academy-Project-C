<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html lang="en">
<head>
<title>bulletin_write</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.js"></script>
<script src="https://github.com/summernote/summernote/tree/master/lang/summernote-ko-KR.js"></script>

<!-- 서머노트를 위해 추가해야할 부분 -->
  <script src="./resources/summernote/summernote-lite.js"></script>
  <script src="./resources/summernote/lang/summernote-ko-KR.js"></script>
  <link rel="stylesheet" href="./resources/summernote/summernote-lite.css">
  
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script>

$(function(){
	$('#loading').hide();
	
	$('.summernote').summernote({
		height: 600,
		fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
		fontNamesIgnoreCheck : [ '맑은고딕' ],
		focus: true,

		callbacks: {
		onImageUpload: function(files, editor, welEditable) {
	            for (var i = files.length - 1; i >= 0; i--) {
	             sendFile(files[i], this);
	            }
	        }
		}

	});

	
})

function sendFile(file, el) {
var form_data = new FormData();
       form_data.append('file', file);
       $.ajax({
         data: form_data,
         type: "POST",
         url: 'profileImage.do',
         cache: false,
         contentType: false,
         enctype: 'multipart/form-data',
         processData: false,
         beforeSend: function() {
        	 $('#loading').show(); 
	     },
         success: function(img_name) {
            console.log(img_name);
            setTimeout(function() {
            	alert("파일이 첨부되었습니다.");
            	$('#loading').hide(); 
				$(el).summernote('editor.insertImage', img_name);
			}, 4000);
         }
       });
}


function fn_boardMod(){
	var category = $("input[name='cate_type']:checked").val();
	var title = $("input[name='title']").val();
	var editordata= $("textarea[name='editordata']").val();
	
	if(!category){
		alert("카테고리를 선택해주세요");
		return;
	}
	if(!title){
		alert("제목을 입력해주세요");
		return;
	}
	if(!editordata){
		alert("내용을 입력해주세요");
		return;
	}
	
	var tumnail = $("form img").first().attr("src");
	$('#hidden').val(tumnail);
	
	var formData = new FormData($('#frm')[0]);
	$.ajax({
		type : 'post',
		url : 'boardModAjax.do',
		data : formData,
		processData : false,
		contentType : false,
		async:false,
		dataType:"text",
		success : function(data){
			var jsonInfo = JSON.parse(data);
			if(jsonInfo.msg=="ok"){
				alert("글이 정상적으로 수정되었습니다.");
				location.href="boardDetail.do?communitySeq=" + jsonInfo.communitySeq;
			}else if(data=="ng"){
				alert("수정이 실패하였습니다. 다시 시도해주세요");
			}else{
				alert("수정이 실패하였습니다. 다시 시도해주세요");
			}
		},
		error : function(error){
			alert("수정이 실패하였습니다. 다시 시도해 주세요.");
			console.log(error);
			console.log(error.status);
		}
		
		
	})
}

</script>


<style type="text/css">
#hover_btn {
	font-size: 14px;
	font-weight: 700;
	color: white;
	display: inline-block;
	border: 1px solid rgba(155, 158, 163, 0.2);
	padding: 10px 20px 7px;
	border-radius: 2px;
	background-color: #5768AD;
}

#hover_btn:hover {
	background: white;
	border: 1px solid #5768AD;
	color: #5768AD;
}
</style>
</head>
<body>

	<!-- Breadcrumb Begi -->
	<section class="breadcrumb-option set-bg"
		data-setbg="./resources/img/breadcrumb.jpg"
		style="background-image: url(&quot;./resources/img/breadcrumb.jpg&quot;);">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>게시판 수정</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->
	
	<div class="container">
	<section class="classes spad">
	<div style="text-align: center;">
		<h3 style="padding-left: 15px;color: #263246;font-family:DM Sans,sans-serif;font-weight: 400;">🔎 회원들과 공유할 꿀Tip을 작성해주세요</h3>
	</div>
	<br/><br/>
		<main role="main" class="container">
			<form name="form" id="frm">
			<input type="hidden" name="communitySeq" value="${BoardDetail['communitySeq']}">
			<input type="hidden" id="hidden" name="tumnail_img" value="none"/>
				<div class="write-title" style="margin-bottom: 5px;">
					<label>
						<p style="font-weight:bold;">카테고리<span style="color:red;"> *</span></p>
					</label>
					<div class="c_radio">
						<div style="display: inline-block;">
							<input type="radio" name="cate_type" id="exercise" value="1" autocomplete="off" style="opacity: 0;" <c:if test="${BoardDetail['communityCategoryName'] eq '운동'}">checked</c:if>>
							<label for="exercise">운동</label>
							<input type="radio" name="cate_type" id="food" value="2" autocomplete="off" style="opacity: 0"<c:if test="${BoardDetail['communityCategoryName'] eq '식단'}">checked</c:if>>
							<label for="food">식단</label>
						</div>
						<div style="display: inline-block;">
							<input type="radio" name="cate_type" id="motive" value="3" autocomplete="off" style="opacity: 0"<c:if test="${BoardDetail['communityCategoryName'] eq '동기부여'}">checked</c:if>>
							<label for="motive">동기부여</label>
							<input type="radio" name="cate_type" id="habit" value="4" autocomplete="off" style="opacity: 0"<c:if test="${BoardDetail['communityCategoryName'] eq '생활습관'}">checked</c:if>>
							<label for="habit">생활습관</label>
							<input type="radio" name="cate_type" id="etc" value="5" autocomplete="off" style="opacity: 0"<c:if test="${BoardDetail['communityCategoryName'] eq '기타'}">checked</c:if>>
							<label for="etc">기타</label>
						</div>
					</div>
				</div>
				<br><br>
				<label>
						<p style="font-weight:bold;margin-bottom:0">제목<span style="color:red;"> *</span></p>
				</label>
				<div style="text-align: center;">
				<input type="text" name="title" placeholder="제목을 입력하세요" value="${BoardDetail['commonTitle']}"
					style="width: 99%;border: none;border-bottom: 1px solid #D5D4D4;height: 54px;font-size: 15px;">
				<br/>
				</div>
				<br><br>
				<label>
					<p style="font-weight:bold;margin-bottom:0">내용<span style="color:red;"> *</span></p>
				</label>
				<div class="container" style="margin-top:10px;margin-bottom:20px;padding:0;position: relative;">
				  <textarea class="summernote" name="editordata">
				  ${BoardDetail['commonContent']}
				  </textarea>   
				  <div id="loading" style="position: absolute;top: 50%;left: 50%;margin:-150px 0 0 -150px">
				  	<img id="loading-image" src="./resources/img/common/loading.gif" alt="Loading..." />
				  </div> 
				</div>
				
				<div class="class__filter__input" style="text-align: right;">
					<button id="hover_btn" type="button" style="width: 150px;height:45px; padding: 5px;font-size:1.0em;" onclick="fn_boardMod()">수정</button>
					<button id="hover_btn" type="button" style="width: 150px;height:45px; padding: 5px;font-size:1.0em;" onclick="location.href='boardList.do'">목록</button>
				</div>
				
			</form>
		</main>
	</section>
	</div>
</body>
</html>

