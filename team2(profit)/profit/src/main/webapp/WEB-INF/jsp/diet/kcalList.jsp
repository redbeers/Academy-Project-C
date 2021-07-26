<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<style type="text/css">
.class-btn {
	width: 50px;
	padding: 0;
	height: 30px;
	background-color: #ffc107c2;
	font-size: 14px;
	font-weight: 700;
	color: #ffffff;
	display: inline-block;
	border: 1px solid rgba(155, 158, 163, 0.2);
	border-radius: 2px;
	-webkit-transition: all 0.4s;
	-moz-transition: all 0.4s;
	-ms-transition: all 0.4s;
	-o-transition: all 0.4s;
	transition: all 0.4s;
}

.class-btn:hover {
	background: #ffffff;
	border: 1px solid #ffc107c2;
	color: #ffc107c2;
}

-ms-overflow-style
:
 
none
;
 
}
::-webkit-scrollbar {
	display: none;
}

.box {
	-ms-overflow-style: none;
}

.box::-webkit-scrollbar {
	display: none;
}

.kcalList tr td {
	padding-top: 10px;
	padding-bottom: 10px;
	border-bottom: 1px solid #6c7ae05c;
}

.kcalList tr:hover {
	background-color: #f8f6ff;
}

.kcal_span{
font-weight: bold;
}
.kcal_img{
width: 15px; 
height: 15px;
}

</style>

<script>

var totalKcal = 0;
function fn_modalOpen(kcalNum){
	//ajax
	var formData = new FormData($('#frm'+ kcalNum)[0]);
	$.ajax({
		type:"POST",
		url:"kcalNumAjax.do",
		data:formData,
		processData : false,
		contentType : false,
		async:false,
		dataType:"text",
		success : function(data){
			var jsonInfo = JSON.parse(data);
			if(jsonInfo.msg=="ok"){
				$('#food_name').text(jsonInfo.descKor);
				$('#makerName').text(jsonInfo.makerName);
				$('#nutrCont1').text(jsonInfo.nutrCont1);
				$('#servingSize').text(jsonInfo.servingSize);
				$('#sp1').text("탄수화물( " + jsonInfo.nutrCont2 + " g )");
				$('#sp2').text("단백질( " + jsonInfo.nutrCont3 + " g )");
				$('#sp3').text("지방( " + jsonInfo.nutrCont4 + " g )");
				$('#sp4').text("당류( " + jsonInfo.nutrCont5 + " g )");
				$('#sp5').text("나트륨( " + jsonInfo.nutrCont6 + " g )");
				if(jsonInfo.cont2Rs>100){
					$("#carbo").css('width',"100%");
				}else{
					$("#carbo").css('width',jsonInfo.cont2Rs + "%");
				}
				if(jsonInfo.cont3Rs>100){
					$("#protein").css('width',"100%");
				}else{
					$("#protein").css('width',jsonInfo.cont3Rs + "%");
				}
				if(jsonInfo.cont4Rs>100){
					$("#fat").css('width',"100%");
				}else{
					$("#fat").css('width',jsonInfo.cont4Rs + "%");
				}
				if(jsonInfo.cont5Rs>100){
					$("#sugars").css('width',"100%");
				}else{
					$("#sugars").css('width',jsonInfo.cont5Rs + "%");
				}
				if(jsonInfo.cont6Rs>100){
					$("#salt").css('width',"100%");
				}else{
					$("#salt").css('width',jsonInfo.cont6Rs + "%");
				}
				
				//운동 칼로리 계산
				var walkKcal = Math.round(parseInt(jsonInfo.servingSize) / 4);
				var walkHour = Math.floor(walkKcal / 60);
				var walkMin = walkKcal % 60;
				
				if(walkHour != 0){
					$('#walkKcalHour').text(walkHour + "시간 ");
				}
				if(walkMin != 0){
					$('#walkKcalMin').text(walkMin + "분");
				}
				
				var swimKcal = Math.round(parseInt(jsonInfo.servingSize) / 10);
				var swimHour = Math.floor(swimKcal / 60);
				var swimMin = swimKcal % 60;
				
				if(swimHour != 0){
					$('#swimKcalHour').text(swimHour + "시간 ");
				}
				if(swimMin != 0){
					$('#swimKcalMin').text(swimMin + "분");
				}
				
				var bikeKcal = Math.round(parseInt(jsonInfo.servingSize) / 7);
				var bikeHour = Math.floor(bikeKcal / 60);
				var bikeMin = bikeKcal % 60;
				
				if(bikeHour != 0){
					$('#bikeKcalHour').text(bikeHour + "시간 ");
				}
				if(bikeMin != 0){
					$('#bikeKcalMin').text(bikeMin + "분");
				}
				
				console.log("walkKcal : " + walkKcal + "분");
				console.log("walkHour : " + walkHour);
				console.log("walkMin : " + walkMin);
				
				
				$("#myModal").modal('show');
			}else if(jsonInfo.msg=="ng"){
				alert("데이터를 불러오는 데 실패했습니다. 다시 시도해 주세요.");
			}else{
				alert("데이터를 불러오는 데 실패했습니다. 다시 시도해 주세요.");
			}
		},
		error : function(error){
			alert("데이터를 불러오는 데 실패했습니다. 다시 시도해 주세요.");
			console.log(error);
			console.log(error.status);
		}
	});
	
}

function fn_calcAdd(foodName, kcalNum){
	var cnt = $('.ex').length+1;
	$(".box").append("<p id=cnt"+cnt+" class='ex'>🥨"+foodName+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class='kcal_span'><span class='kcal_span_num'>"+kcalNum+"</span> Kcal&nbsp;&nbsp;&nbsp;<img class='kcal_img' src='./resources/img/common/delete2.png' onclick='fn_del("+cnt+")'></span></p>");
	$(".ex").last().hide().fadeIn(600);
    totalKcal += parseInt(kcalNum);
    $(".choose-counter123").text(totalKcal);
}

function fn_del(cnt){
	var removeKcal = parseInt($("#cnt" + cnt + " .kcal_span_num").text());
	totalKcal -= removeKcal;
	$("#cnt" + cnt).show().fadeOut(600);
	$("#cnt" + cnt).remove();
    console.log($(".choose-counter123").text());
	$(".choose-counter123").text(totalKcal);
}

function fn_kcal_clac(url){
	
	var clacContent = $('.box').html();
	var clacTotal = $('.choose-counter123').text();
	sessionStorage.setItem("clacContent",clacContent);
	sessionStorage.setItem("clacTotal", clacTotal);
	location.href=url;
}

$(function(){
	totalKcal = 0;
	
	
	console.log("  dd : " + sessionStorage.getItem("clacContent"));
	$(".box").html(sessionStorage.getItem("clacContent"));
	var clacTotal = sessionStorage.getItem("clacTotal");
	console.log(clacTotal);
	
	if(clacTotal != null){
		totalKcal = parseInt(clacTotal);
		console.log("total : " + totalKcal);
		$(".choose-counter123").text(totalKcal);
	}
})

function fn_search(){
	var clacContent = $('.box').html();
	var clacTotal = $('.choose-counter123').text();
	sessionStorage.setItem("clacContent",clacContent);
	sessionStorage.setItem("clacTotal", clacTotal);
	
	location.href="kcalList.do#location123";
}



</script>
</head>
<body>


	<!-- Breadcrumb Begin -->
	<section class="breadcrumb-option set-bg"
		data-setbg="./resources/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>칼로리 계산기</h2>
						
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Blog Hero End -->

	<!-- Blog Details Section Begin -->
	<section class="blog-details spad">
		<input id="save" name="calcContent" type="hidden" value=""> 
		<div class="container">
			<div class="classes__item__text"
				style="text-align: center; padding-top: 0; padding-bottom: 0">
				<span class="blinking" style="font-weight: bold; font-size: 1.2em">
					내가 먹은 음식의 칼로리를 알아보고 영양소 구성 및 운동 상세를 확인할 수 있습니다</span>&nbsp;
			</div>
			<br>
			<div class="row" style="justify-content: center">
				<div
					style="display: left; margin-right: 20px; width: 30%; background-color: white; padding: 0px; border: 1px solid #ebecef; border-radius: 10px; height: 520px;">
					<div style="text-align: center;">
						<p style="font-size: 1.2em; font-weight: bold;margin-top: 20px;margin-bottom: 30px;">
							<span style="background-color: #fee9b8;">&nbsp;Kcal 계산기&nbsp;</span>
						</p>
					</div>
					<div>
					<form id="frmBox" enctype="multipart/form-data" action="frmBoxSave.do">
						<div class="box" style="overflow-y: scroll; height: 370px;padding-left: 30px;padding-right:15px;">
							
						</div>
					</form>
					
						<hr>
						<div style="text-align: right;margin-right: 20px;">
							<p style="font-weight: bold; font-size: 1.2em; color: #5768AD">
							총 칼로리 : <span class="choose-counter123">0</span>  Kcal</p>
						</div>
					</div><br>
					<div style="width: 351px;height: 355px;padding:0;border: 1px solid #ebecef;border-radius: 10px;background-color: white;">
					<div style="text-align: center;">
						<p style="font-size: 1.2em; font-weight: bold;margin-top: 20px;margin-bottom: 20px;">
							<span style="background-color: #fee9b8;">&nbsp;인기 검색어&nbsp;</span>
						</p>
						<p style="font-weight: bold;">🥇 1위&nbsp;&nbsp;&nbsp;${popularSearch[0]['descKor']}</p>
						<p style="font-weight: bold;">🥈2위&nbsp;&nbsp;&nbsp;${popularSearch[1]['descKor']}</p>
						<p style="font-weight: bold;">🥉3위&nbsp;&nbsp;&nbsp;${popularSearch[2]['descKor']}</p>
						<p style="font-weight: bold;">4위&nbsp;&nbsp;&nbsp;${popularSearch[3]['descKor']}</p>
						<p style="font-weight: bold;">5위&nbsp;&nbsp;&nbsp;${popularSearch[4]['descKor']}</p>
						<p style="font-weight: bold;">6위&nbsp;&nbsp;&nbsp;${popularSearch[5]['descKor']}</p>
						<p style="font-weight: bold;">7위&nbsp;&nbsp;&nbsp;${popularSearch[6]['descKor']}</p>
						
					</div>
					</div>
				</div>
				<div class="col-lg-8 order-lg-2 order-1"
					style="background-color: white; padding: 30px; border: 1px solid #ebecef; border-radius: 10px; display: left; height: 900px;">
					<div class="classes__filter">
						<div class="row">
							<div class="col-lg-12">
								<form id="searchForm">
									<div class="class__filter__input">
										<p>검색</p>
										<input type="text" style="width: 470px;" placeholder="검색"
											id="keyword" name="searchKeyword" value="${searchKeyword}">
									</div>
									<div class="class__filter__btn">
										<button style="cursor: pointer;" onclick="fn_search()" >
											<i class="fa fa-search"></i>
										</button>
									</div>
									<span id="location123"></span>
								</form>
								<p style="font-size: 0.8em;">
									음식의 칼로리 뿐만 아니라 영양소 구성을 조회할 수 있으므로 다이어트뿐 아니라 <br>
									<span style="color: #16a8e5">건강한 식습관 형성</span>에도 도움이 됩니다.
								</p>
							</div>
						</div>
					</div>
					<div class="modal" id="myModal" tabindex="-1" role="dialog">
					    <div class="modal-dialog" role="document">
					        <div class="modal-content" style="margin-top: 0px;margin-left:50px;width: 770px;height:900px;">
					            <div class="modal-header">
					                <h3 class="modal-title">🍤음식 정보 상세보기</h3>
					                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					                    <span aria-hidden="true">&times;</span>
					                </button>
					            </div>
					            <div class="modal-body">
					                <table style="border: 1px solid #d5d6d6;width: 600px;text-align: center;margin-left: auto;margin-right: auto;">
					                	<tr style="border: 1px solid #d5d6d6;">
						                	<th style="width: 30%;font-weight: bold;padding:10px;background-color: #fff1c6">식품이름</th>
					                		<td style="width: 60%;"><span id="food_name"></span></td>
					                	</tr>
					                	<tr style="border: 1px solid #d5d6d6;">
						                	<th style="font-weight: bold;padding:10px;background-color: #fff1c6">판매 기업</th>
					                		<td><span id="makerName"></span></td>
					                	</tr>
					                	<tr style="border: 1px solid #d5d6d6;">
						                	<th style="font-weight: bold;padding:10px;background-color: #fff1c6">총내용량</th>
					                		<td><span id="nutrCont1"></span> Kcal ( <span id="servingSize"></span> g )</td>
					                	</tr>
					                </table>
					                <div style="text-align: center">
						                <p style="font-size: 0.9em;"><span style="color: #fb4d00">[주의]</span>음식 칼로리는 사용되는 재료와 1인 분량 기준의 차이에 의해 다소 차이가 있을 수 있습니다.</p>
					                </div>
					                <br>
					                  <span id="sp1"></span>
					                <div class="progress" style="margin-bottom: 10px;">
									 <div id="carbo" class="progress-bar progress-bar-striped" role="progressbar" style="width: 100%;" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
							  		<span id="sp2"></span>
									<div class="progress" style="margin-bottom: 10px;">
									  <div id="protein" class="progress-bar progress-bar-striped bg-success" role="progressbar" style="width: 100%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
									<span id="sp3"></span>
									<div class="progress" style="margin-bottom: 10px;">
									  <div id="fat" class="progress-bar progress-bar-striped bg-info" role="progressbar" style="width: 100%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
									<span id="sp4"></span>
									<div class="progress" style="margin-bottom: 10px;">
									  <div id="sugars"  class="progress-bar progress-bar-striped bg-warning" role="progressbar" style="width: 100%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
									<span id="sp5"></span>
									<div class="progress" style="margin-bottom: 10px;">
									  <div id="salt"  class="progress-bar progress-bar-striped bg-danger" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
									</div><br>
							
							<div style="text-align: center;">🚴‍♂삶은 달걀 칼로리와 동일한 운동을 확인해 보세요🚴</div>‍
					        <div style="text-align: center;">
					        <div style="float: left;width: 30%;height: 200px;margin-left: 25px;">
					        <img src="./resources/img/common/run.png" style="height: 174px;"><br>
					        걷기 <span id="walkKcalHour"></span><span id="walkKcalMin"></span>
					        </div>
					        <div style="float: left;width: 30%;height: 200px;margin-left: 10px;">
					        <img src="./resources/img/common/bike.png" style="height: 174px;"><br>
					        자전거 <span id="bikeKcalHour"></span><span id="bikeKcalMin"></span>   
					        </div>
					        <div style="float: left;width: 30%;height: 200px;margin-left: 10px;margin-right: 15px;">
					        <img src="./resources/img/common/swim.png" style="height: 174px;"><br>
					        수영 <span id="swimKcalHour"></span><span id="swimKcalMin"></span>   
					        </div>
					        </div>
					        </div>
					            <div class="modal-footer">
					                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					            </div>
					        </div>
					    </div>
					</div>

					<div style="text-align: center;">
						<table class="kcalList"
							style="margin-right: 0; margin-left: auto; margin-right: auto;">
							<tr>
								<th
									style="background-color: #6c7ae0e3; padding: 20px; color: white; font-size: 1.1em; width: 45%;font-size: 1.2em;">음식명</th>
								<th
									style="background-color: #6c7ae0e3; padding: 20px; color: white; font-size: 1.1em; width: 20%;font-size: 1.2em;">총
									내용량(g)</th>
								<th
									style="background-color: #6c7ae0e3; padding: 20px; color: white; font-size: 1.1em; width: 20%;font-size: 1.2em;">열량(kcal)</th>
								<th
									style="background-color: #6c7ae0e3; padding: 20px; color: white; font-size: 1.1em; width: 10%;"></th>
							<tr>
							<c:forEach var="result" items="${kcalList}" varStatus="status">
							<form id="frm${result.num}">
								<input type="hidden" name="kcalNum" value="${result.num}">
							</form>
							<tr>
								<td onclick="fn_modalOpen(${result.num})">${result.descKor}</td>
								<td>${result.servingSize}</td>
								<td>${result.nutrCont1}</td>
								<td><input class="class-btn" type="button" value="담기" onclick="fn_calcAdd('${result.descKor}','${result.nutrCont1}')"></td>
							</tr>
							</c:forEach>
						</table>
						<br>
						<!-- 페이징처리 -->
            	<div class="col-lg-12">
					<div class="classes__pagination">
					<c:if test="${pageMaker.prev}">
						<a href="kcalList.do${pageMaker.makeQueryKal(pageMaker.startPage - 1)}">
							<span class="arrow_carrot-left"></span>
						</a>
					</c:if> 
					
					<c:set var="page" value="${pageMaker.cri.page}"/>
					<c:set var="idx" value="${idx}"/>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            			<a onclick="fn_kcal_clac('kcalList.do${pageMaker.makeQueryKal(idx)}')" <c:if test="${page == idx }">style="background: #5768AD;color:#FFFFFF;"</c:if>>${idx}</a>
					</c:forEach>
					
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<a onclick="fn_kcal_clac('kcalList.do${pageMaker.makeQueryKal(idx)}')"><span class="arrow_carrot-right"></span></a>
					</c:if>
					</div>
				</div>
					</div>
				</div>
				
				
				
			</div>
		</div>
	</section>
	<!-- Blog Details Section End -->

</body>
<!-- Js Plugins -->
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="./resources/js/jquery.nice-select.min.js"></script>
<script src="./resources/js/jquery.barfiller.js"></script>
<script src="./resources/js/jquery.slicknav.js"></script>
<script src="./resources/js/owl.carousel.min.js"></script>
<script src="./resources/js/main.js"></script>
</html>