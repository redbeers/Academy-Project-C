<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/datepicker/jquery-ui.css">
<script src="./resources/datepicker/jquery-3.5.1.js"></script>
<script src="./resources/datepicker/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<style type="text/css">
.counter-section i {
    display: block;
    margin: 0 0 10px
}

.counter-section span.counter {
    font-size: 40px;
    color: #000;
    line-height: 60px;
    display: block;
    font-family: "Oswald", sans-serif;
    letter-spacing: 2px
}

.counter-title {
    font-size: 16px;
    letter-spacing: 2px;
    text-transform: uppercase
}

.counter-icon {
    top: 25px;
    position: relative
}

.counter-style2 .counter-title {
    letter-spacing: 0.55px;
    float: left
}

.counter-style2 span.counter {
    letter-spacing: 0.55px;
    float: left;
    margin-right: 10px
}

.counter-style2 i {
    float: right;
    line-height: 26px;
    margin: 0 10px 0 0
}

.counter-subheadline span {
    float: right
}

.medium-icon {
    font-size: 40px !important;
    margin-bottom: 15px !important
}
.classes__filter form .class__filter__btn_re {
	padding-right: 125px;
}
.table tr:hover {
	background-color: #f8f6ff;
}
.ui-datepicker-calendar {
    display: none;
}   
.table td, .table th {
	vertical-align: middle;
} 
a:hover, a:focus {
    text-decoration: none;
    outline: none;
    color: #6d7ab0;
}
.link{
	color: black;
}

textarea {
    width: 70%;
    height: 100px;
    font-size: 16px;
    color: #ffffff;
    padding-left: 28px;
    padding-top: 15px;
    border-radius: 2px;
    background: rgba(255, 255, 255, 0.2);
    border: none;
    margin-bottom: 34px;
}
#hover_btn:hover {
    background: white;
    border: 1px solid #5768AD;
    color: #5768AD;
}
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
#hover_btn2 {
    font-size: 14px;
    font-weight: 700;
    color: white;
    display: inline-block;
    border: 1px solid rgba(155, 158, 163, 0.2);
    padding: 10px 20px 7px;
    border-radius: 2px;
    background-color: #ffbf00;
}
</style>
<script type="text/javascript">
function fn_myInfoMod(){
	$("#modBtn1").hide();
	$("#modBtn2").show();
	$("textarea[name='trainerGym']").attr("readonly", false);
	$("textarea[name='trainerAward']").attr("readonly", false);
	$("textarea[name='trainerCareer']").attr("readonly", false);
}

function fn_myInfoModFinish(){
	var result = confirm("정보를 수정하시겠습니까?");
	if(result){
		
		var formData = new FormData($('#frm')[0]);
		
		$.ajax({
			type : 'post',
			url : 'trainerInfoModAjax.do',
			data : formData,
			processData : false,
			contentType : false,
			async:false,
			dataType:"text",
			success : function(data){
				if(data=="ok"){
					alert("정상적으로 수정되었습니다.");
					window.location.reload();
				}else if(data=="ng"){
					alert("수정 도중 문제가 발생하였습니다. 다시 시도해 주세요");
				}else{
					alert("수정 도중 문제가 발생하였습니다. 다시 시도해 주세요");
				}
			},
			error : function(error){
				alert("수정 도중 문제가 발생하였습니다. 다시 시도해 주세요");
				console.log(error);
				console.log(error.status);
			}
		})
		
	}else{
		return;
	}
	$("#modBtn2").hide();
	$("#modBtn1").show();
}

$(function(){
	$("#modBtn2").hide();
})

</script>


</head>
<body>
	<!-- Breadcrumb Begin -->
	<section class="breadcrumb-option set-bg" data-setbg="./resources/img/hero/hero-11.jpg" style="padding-bottom: 0px; padding-top: 70px;">
	</section>
	<!-- Breadcrumb End -->
	
	
	<!-- 본문 시작 -->
	<section class="classes spad" style="visibility: visible; animation-name: fadeIn;">
		
		<div class="container">
			<h3 style="text-align: center; cursor: pointer;" onclick="location.href='trainerInfo.do'" >내 정보</h3>
			<br>
        	<div class="row" style="margin-bottom: 30px;margin-top: 30px;">
            <!-- counter -->
            <div class="col-md-3 col-sm-6 bottom-margin text-center counter-section wow fadeInUp sm-margin-bottom-ten animated" data-wow-duration="300ms" style="visibility: visible; animation-duration: 300ms; animation-name: fadeInUp;"> 
				<img src="./resources/img/common/onlineclass.png" style="width: 40px;height: 40px;" onclick="location.href='myClassInfo.do'">
	            <span id="anim-number-pizza" class="counter-number"></span> 
	            <span class="timer counter alt-font appear" data-to="980" data-speed="7000" 
	            	onclick="location.href='trainerPermitList.do?selStatus=A&selIdentity=&selDate=&searchKeyword=' " style="cursor: pointer">${todayNumberList.statusA }</span>
	            <p class="counter-title" style="margin-top: 10px;">온라인 클래스</p>
            </div> 
            <!-- end counter -->
            
            <!-- counter -->
            <div class="col-md-3 col-sm-6 bottom-margin text-center counter-section wow fadeInUp sm-margin-bottom-ten animated" data-wow-duration="600ms" style="visibility: visible; animation-duration: 600ms; animation-name: fadeInUp;"> 
	            <img src="./resources/img/common/chatting.png" style="width: 40px;height: 40px;">
	            <span class="timer counter alt-font appear" data-to="980" data-speed="7000"
	            	onclick="location.href='trainerPermitList.do?selStatus=B&selIdentity=&selDate=&searchKeyword=' "
	            	style="cursor: pointer">${todayNumberList.statusB }</span> 
	            <p class="counter-title" style="margin-top: 10px;">1:1 상담</p>
	        </div> 
	        <!-- end counter -->
            
            <!-- counter -->
            <div class="col-md-3 col-sm-6 bottom-margin-small text-center counter-section wow fadeInUp xs-margin-bottom-ten animated" data-wow-duration="900ms" style="visibility: visible; animation-duration: 900ms; animation-name: fadeInUp;"> 
            	<img src="./resources/img/common/money1.png" style="width: 40px;height: 40px;" onclick="location.href='classAccountInfo.do'">
            	<span class="timer counter alt-font appear" data-to="810" data-speed="7000" 
    	        	onclick="location.href='trainerPermitList.do?selStatus=C&selIdentity=&selDate=&searchKeyword=' " 
	            	style="cursor: pointer">${todayNumberList.statusC }</span> 
            	<p class="counter-title" style="margin-top: 10px;">강좌 정산 내역</p>
            </div> 
            <!-- end counter -->
            
            <!-- counter -->
            <div class="col-md-3 col-sm-6 text-center counter-section wow fadeInUp animated" data-wow-duration="1200ms" style="visibility: visible; animation-duration: 1200ms; animation-name: fadeInUp;"> 
            	<img src="./resources/img/common/money2.png" style="width: 40px;height: 40px;" onclick="location.href='chatAccountInfo.do'">
            	<span class="timer counter alt-font appear" data-to="600" data-speed="7000" onclick="fn_today()" style="cursor: pointer">${todayNumberList.statusDate }</span> 
            	<p class="counter-title" style="margin-top: 10px;">상담 정산 내역</p>
            </div> 
            <!-- end counter -->
        </div>


						
			<!-- 2 -->
			
		    <div class="classes__filter" style="margin-bottom: 50px;padding-bottom:50px;text-align: center;">
		    
			<br>
              <span style="font-size: 1.5em;font-weight: bold;color:#5768AD;">트레이너정보</span>
               <form id="frm"> 
               <div style="margin-top: 30px;">
               <label>
					<p style="font-weight:bold;margin-bottom:0">소속헬스장<span style="color:red;"> *</span></p>
				</label>
				<div style="text-align: center;">
				<textarea name="trainerGym" rows="10" cols="80" style="background-color: #3f51b50d;color: black;margin-bottom: 20px;resize: none;" readonly="readonly">${myInfo['trainerGym']}</textarea>
				<br/>
				</div><br><br>
               	</div>
               	
               	<div >
               <label>
					<p style="font-weight:bold;margin-bottom:0">수상이력<span style="color:red;"> *</span></p>
				</label>
				<div style="text-align: center;">
				<textarea name="trainerAward" rows="10" cols="80" style="background-color: #3f51b50d;color: black;margin-bottom: 20px;resize: none;height: 200px;" readonly="readonly">${myInfo['trainerAward']}</textarea>
				<br/>
				</div><br><br>
               	</div>
               	
               	<div >
               <label>
					<p style="font-weight:bold;margin-bottom:0">경력<span style="color:red;"> *</span></p>
				</label>
				<div style="text-align: center;">
				<textarea name="trainerCareer" rows="10" cols="80" style="background-color: #3f51b50d;color: black;margin-bottom: 20px;resize: none;height: 200px;" readonly="readonly">${myInfo['trainerCareer']}</textarea>
				<br/>
				</div><br>
				<div id="modBtn1" class="class__filter__input" style="text-align: center;width: 100%;">
					<button id="hover_btn" type="button" style="width: 300px;height:45px; padding: 5px;font-size:1.2em;" onclick="fn_myInfoMod()" >수정하기</button>
				</div>
				<div id="modBtn2" class="class__filter__input" style="text-align: center;width: 100%;">
					<button id="hover_btn2" type="button" style="width: 300px;height:45px; padding: 5px;font-size:1.2em;background-color: #ffbf00" onclick="fn_myInfoModFinish()" >수정완료</button>
				</div>
               	</div>
               	</form>
            </div>
		<!-- container div 끝 -->	
		</div>
	</section>


	<!-- Js Plugins -->
	<script src="./resources/js/bootstrap.min.js"></script>
	<script src="./resources/js/jquery.nice-select.min.js"></script>
	<script src="./resources/js/jquery.barfiller.js"></script>
	<script src="./resources/js/jquery.slicknav.js"></script>
	<script src="./resources/js/owl.carousel.min.js"></script>
	<script src="./resources/js/main.js"></script>
</body>
</html>