<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/video.js/7.8.1/video-js.min.css" rel="stylesheet"> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/video.js/7.8.1/video.min.js"></script>

<script>

$(document).ready(function(){
// 	var myAudio = document.getElementById("videoplay");
// 	var time = myAudio.duration;
// 	console.log(time);

// var video = $('video')[0];
// var t = setInterval(function () {
//     if(video.readyState > 0) {
//         var duration = video.duration;
//         console.log(duration);
//         clearInterval(t);
//     }
// }, 500);

	var video = $('video')[0];
	var i = setInterval(function() {
	    if(video.readyState > 0) {
	        var minutes = parseInt(video.duration / 60, 10);
	        var seconds = Math.floor(video.duration % 60);
	        var time = minutes+":"+seconds;
// 	        if(minutes<10){
// 	        	minutes = 0minutes;
// 	        }
// 	        if(seconds<10){
// 	        	seconds = 0seconds;
// 	        }
// 	        return minutes+":"+seconds;
	        console.log("time "+time);
			console.log("몇분?? "+minutes);
			console.log("몇초?? " +seconds );
			console.log(minutes+":"+seconds);
			
	        // (Put the minutes and seconds in the display)

	        clearInterval(i);
			$("#videoTime").append(time);
			
// 			var param = "";
// 			param += "dummy=" + Math.random();
// 			param += "&time=" + time;
			
// 			$.ajax({
// 				url : "sendTimeAjax.do",
// 				data : param,
// 				dataType : "text",
// 				async : false
// 			});
			
	    }
	}, 200);
	
	
});


	//수강시작버튼 눌렀을때
	function start_play() {
		var msg = "ok";
		if (msg == "ok") {
			var start = confirm("수강시작 일주일 후부터는 환불이 불가능합니다. \n수강을 시작하시겠습니까?");
			if (start == true) {
				fn_updBuyLesson();
					
			}

		}
	}

	//수강시작누른 후 영상controls
	function vid_play_pause() {
		var videoplay = document.getElementById("videoplay");
		var txt = "";
		txt += "	<th scope='row' colspan='2'>";
		txt += "		<video id='videoplay' controls width='100%'>";
		txt += "		<source src='http://192.168.41.6:9999/upload/profit/${classResult.fileSaveName}'>";
		txt += "	</video>";
		txt += "	</th>";
		$("#newVideo").html(txt);
	}
	
	//상세강의 수강시작했을때 buy_lesson테이블 update
	function fn_updBuyLesson(){
		var lessonSeq = $('input:hidden[name=lessonSeq]').val();
		
		var param = "";
		param += "dummy=" + Math.random();
		param += "&lessonSeq=" + lessonSeq
		console.log(param);
		
		$.ajax({
			url : "updBuyLessonAjax.do",
			data : param,
			dataType : "text",
			async : false,
			success : function(data) {
				if (data == "ok") {
					alert("수강이 시작되었습니다.");
					document.getElementById("startBtn").style.display = "none";
					document.getElementById("pointer").style.display = "none";
					vid_play_pause();
				} else {
					alert("문제가 발생했습니다. 다시 한 번 시도해주세요");
				}
				console.log(data)
			},
		
		error : function(error){
			alert("문제가 있습니다. 다시 시도해 주세요.");
			console.log(error);
			console.log(error.status);
		}
		});
	}

	//상세강의 삭제
	function fn_delClass() {
		var params = location.search.substr(location.search.indexOf("?") + 1);
		var lessonDetailSeq = params.substr(params.indexOf("=") + 1);
		console.log(lessonDetailSeq);
		var flag_ok = confirm("강의를 삭제하시겠습니까?");
		if (flag_ok) {
			var param = "";
			param += "dummy=" + Math.random();
			param += "&lessonDetailSeq=" + lessonDetailSeq
			console.log(param)

			$.ajax({
				url : "class_delAjax.do",
				data : param,
				dataType : "text",
				async : false,
				success : function(data) {
					if (data == "ok") {
						alert("삭제가 정상적으로 완료되었습니다.");
						location.href = "lessonDetail.do?lessonSeq="
								+ $("input:hidden[name=lessonSeq]").val();
					} else {
						alert("삭제에 실패하였습니다. 다시 한 번 시도해주세요")
					}
					console.log(data)
				}
			});

		}
	}
</script>
<style>
.class-btn_c{
	font-size: 14px;
    font-weight: 700;
    color: #ffffff;
    background:#5768AD;
    display: inline-block;
    border: 1px solid rgba(155, 158, 163, 0.2);
    padding: 10px 15px 7px;
    border-radius: 2px;
    -webkit-transition: all 0.4s;
    -moz-transition: all 0.4s;
    -ms-transition: all 0.4s;
    -o-transition: all 0.4s;
    transition: all 0.4s;
    cursor:pointer;
    float : left;
}
.class_btn_c:hover{
    background: #ffffff;
    border: 1px solid #5768AD;
    color: #5768AD;
}
</style>
</head>
<body>
	<!-- Breadcrumb Begin -->
	<section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>강의 보기</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->
	<!-- Blog Section Begin -->
	<section class="blog spad">
		<div class="container">
				<!-- 여기부터 달라짐 -->
				<section class="classes spad">
					<div class="container">
						<h3>📽 강의시청</h3>
						<br>
						<input type = "hidden" name="lessonDetailSeq" value="${classResult.lessonDetailSeq}">
						<input type="hidden" name="lessonSeq" value="${classResult.lessonSeq}">
						<table class="table table" style="text-align: center;">
							<tbody>
								<tr>
									<th scope="row" style="background-color: #E6E6E6;width:30%;">강의명</th>
									<td>${classResult.lessonDetailTitle}</td>
								</tr>
								<tr>
									<th scope="row" style="background-color: #E6E6E6;">상세 설명</th>
									<td><div style="width:60%;height: auto; text-align: left;margin:0 auto;">${classResult.lessonDetailContent}</div></td>
								</tr>
								<tr>
									<th scope="row" style="background-color: #E6E6E6;">강의 정보</th>
									<td>
										<div style="display: inline-block;"><span style="color: #666">수강가능일</span>&nbsp;&nbsp;<span>바로수강가능</span></div>&nbsp;&nbsp; | &nbsp;&nbsp;
										<div style="display: inline-block;"><span style="color: #666">재생시간</span>&nbsp;&nbsp;<span id="videoTime"></span></div>&nbsp;&nbsp; | &nbsp;&nbsp;
										<div style="display: inline-block;"><span style="color: #666">등록일</span>&nbsp;&nbsp;<span>${classResult.inDate}</span></div>
									</td>
									
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<th scope="row" style="background-color: #E6E6E6;">재생시간</th> -->
<!-- 									<td>20:30</td> -->
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<th scope="row" style="background-color: #E6E6E6;">등록일</th> -->
<%-- 									<td>${classResult.inDate}</td> --%>
<!-- 								</tr> -->
								
								<tr id="newVideo">
									<th scope="row" colspan="2">
										<video id="videoplay" width="100%" >
											<source src="http://192.168.41.6:9999/upload/profit/${classResult.fileSaveName}">										
										</video>
										<br/><br/>
										<button type="button" id="startBtn" class="class-btn_c" onclick="start_play()">수강시작</button>
										<span class="blinking"  id="pointer" style="color:#ED2348;float:left;">← 수강시작을 눌러 강의를 바로 들어보세요  </span>&nbsp;
<!-- 										<button type="button" id="playBtn" class="class-btn_c" onclick="vid_play_pause()" style="display:none;">Play/Pause</button> -->
									</th>
								</tr>
							</tbody>
						</table>
						<div class="classes__item__text" style="text-align: right;">
							<a href="javascript:history.back();" class="class-btn" style="width:120px;text-align: center;background-color: white;border:1px solid #5768AD;">목록</a>
							<c:choose>
								<c:when test="${rightTrainer eq '1'}">
									<input type="button" onclick="fn_delClass()" class="class-btn" style="cursor:pointer;width:120px;background-color: white;border:1px solid #5768AD;" value="삭제" >
								</c:when>
								<c:when test="${rightTrainer eq '0'}">
								
								</c:when>							
							</c:choose>
						</div>
					</div>
				</section>
		</div>
	</section>
	<!-- Blog Section End -->
	<!-- Js Plugins -->
	<script src="./resources/js/jquery-3.3.1.min.js"></script>
	<script src="./resources/js/bootstrap.min.js"></script>
	<script src="./resources/js/jquery.nice-select.min.js"></script>
	<script src="./resources/js/jquery.barfiller.js"></script>
	<script src="./resources/js/jquery.slicknav.js"></script>
	<script src="./resources/js/owl.carousel.min.js"></script>
	<script src="./resources/js/main.js"></script>
</body>
</html>