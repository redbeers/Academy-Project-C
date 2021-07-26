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
}​
</style>

<script type="text/javascript">

function fn_switch(ele){
	
	var msg = "ok";
	
	if(msg=="ok"){
		var save = confirm("해당강의의 상태를 바꾸시겠습니까?");
		if(save == true){
			
			vtr = $(ele).parents('tr');
			lessonSeq = $(vtr).find('.lessonSeq').val();
			lessonPrivateFlag = $(vtr).find('.lessonPrivateFlag').val();
			upUserId = $(vtr).find('.upUserId').val();
			console.log(lessonSeq)
			console.log(lessonPrivateFlag)
			console.log(upUserId);
			
			var param = "";
				param += "dummy=" + Math.random();
				param += "&lessonSeq=" + lessonSeq;
				param += "&lessonPrivateFlag=" + lessonPrivateFlag;
				param += "&upUserId=" + upUserId;
				
			console.log("param " + param);
				
			$.ajax({
				type : 'post',
				url : 'updTrainerLessonAjax.do',
				data : param,
				async:false,
				dataType:"text",
				success : function(data){
					if(data=="ok"){
						alert("수정이 정상적으로 완료되었습니다.");
						location.reload();
					}else if(data=="ng"){
						alert("수정에 실패하였습니다. 다시 시도해주세요");
						location.reload();
					}else if(data=="A"){
						alert("관리자가 해당 강의를 비활성화 하였습니다. 관리자에게 문의하세요.");
						location.reload();
					}
			    },
				error : function(error){
					alert("수정에 실패하였습니다. 다시 시도해 주세요.");
					location.reload();
					console.log(error);
					console.log(error.status);
				}
				
				
			}); //ajax
			
		}//if save 
		else{
			alert("수정이 취소되었습니다.");
			location.reload();
		}
	}  //if msg
	
 }//function

function fn_change(processSeq){
	if (confirm("신청서를 검토하시겠습니까?") == true){
		$.ajax({
			type : "POST",
			data : "processSeq=" + processSeq,
			url : "updateStatusBAjax.do",
			dataType : "text", 
			success : function(result) {
				if (result == "ok") {
					location.href="trainerPermitDetail.do?processSeq="+processSeq+" "
				} else {
					alert("문제가 발생하였습니다. 잠시 후 다시 시도해주세요")
				}
			},
			error : function() {
				alert("오류발생");
			}
		})
	} else{  
	    return;
	}
}


$(document).ready(function() {
	$("#maleChart").hide();
	$("#femaleChart").show();
	
	 var context = document
     .getElementById('myChart')
     .getContext('2d');
 var myChart = new Chart(context, {
     type: 'bar', // 차트의 형태
     data: { // 차트에 들어갈 데이터
         labels: [
             //x 축
            "${chartFemaleResult[0]['lessonTitle']}",
            "${chartFemaleResult[1]['lessonTitle']}",
            "${chartFemaleResult[2]['lessonTitle']}",
            "${chartFemaleResult[3]['lessonTitle']}",
            "${chartFemaleResult[4]['lessonTitle']}",
            "${chartFemaleResult[5]['lessonTitle']}"
         ],
         datasets: [
             { //데이터
                 label: '여자 회원', //차트 제목
                 fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                 data: [
                     ${chartFemaleResult[0]['cnt']},
                     ${chartFemaleResult[1]['cnt']},
                     ${chartFemaleResult[2]['cnt']},
                     ${chartFemaleResult[3]['cnt']},
                     ${chartFemaleResult[4]['cnt']},
                     ${chartFemaleResult[5]['cnt']}
                     //x축 label에 대응되는 데이터 값
                 ],
                 backgroundColor: [
                     //색상
                     'rgba(255, 99, 132, 0.2)',
                     'rgba(54, 162, 235, 0.2)',
                     'rgba(255, 206, 86, 0.2)',
                     'rgba(75, 192, 192, 0.2)',
                     'rgba(153, 102, 255, 0.2)',
                     'rgba(255, 159, 64, 0.2)'
                 ],
                 borderColor: [
                     //경계선 색상
                     'rgba(255, 99, 132, 1)',
                     'rgba(54, 162, 235, 1)',
                     'rgba(255, 206, 86, 1)',
                     'rgba(75, 192, 192, 1)',
                     'rgba(153, 102, 255, 1)',
                     'rgba(255, 159, 64, 1)'
                 ],
                 borderWidth: 1 //경계선 굵기
             }
            
         ]
     },
     options: {
         scales: {
             yAxes: [
                 {
                     ticks: {
                         beginAtZero: true
                     }
                 }
             ]
         }
     }
 });
 
 
 
 
 
 var context = document
 .getElementById('myChart2')
 .getContext('2d');
var myChart = new Chart(context, {
 type: 'bar', // 차트의 형태
 data: { // 차트에 들어갈 데이터
     labels: [
         //x 축
        "${chartMaleResult[0]['lessonTitle']}",
        "${chartMaleResult[1]['lessonTitle']}",
        "${chartMaleResult[2]['lessonTitle']}",
        "${chartMaleResult[3]['lessonTitle']}",
        "${chartMaleResult[4]['lessonTitle']}",
        "${chartMaleResult[5]['lessonTitle']}"
     ],
     datasets: [
         { //데이터
             label: '남자 회원', //차트 제목
             fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
             data: [
                 ${chartMaleResult[0]['cnt']},
                 ${chartMaleResult[1]['cnt']},
                 ${chartMaleResult[2]['cnt']},
                 ${chartMaleResult[3]['cnt']},
                 ${chartMaleResult[4]['cnt']},
                 ${chartMaleResult[5]['cnt']}
                 //x축 label에 대응되는 데이터 값
             ],
             backgroundColor: [
                 //색상
            	 'rgba(255, 99, 132, 0.2)',
                 'rgba(54, 162, 235, 0.2)',
                 'rgba(255, 206, 86, 0.2)',
                 'rgba(75, 192, 192, 0.2)',
                 'rgba(153, 102, 255, 0.2)',
                 'rgba(255, 159, 64, 0.2)'
             ],
             borderColor: [
                 //경계선 색상
            	 'rgba(255, 99, 132, 1)',
                 'rgba(54, 162, 235, 1)',
                 'rgba(255, 206, 86, 1)',
                 'rgba(75, 192, 192, 1)',
                 'rgba(153, 102, 255, 1)',
                 'rgba(255, 159, 64, 1)'
             ],
             borderWidth: 1 //경계선 굵기
         }
        
     ]
 },
 options: {
     scales: {
         yAxes: [
             {
                 ticks: {
                     beginAtZero: true
                 }
             }
         ]
     }
 }
});
});


function fn_show1(){
	$("#femaleChart").show();
	$("#maleChart").hide();
	
}

function fn_show2(){
	
	$("#maleChart").show();
	$("#femaleChart").hide();
}


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
		    <div class="classes__filter" style="margin-bottom: 0px;padding-bottom:0px">
			<br>
               <div class="row">
               	<span style="font-weight: bold; font-size: 1.1em;padding-left: 30px;">* 누적 판매 순위 </span><br><br>
                 <div class="r_gender">
                    
                   <div class="col-lg-12" style="margin-left: 25px">
                   <input type="radio" name="gendType" id="male" value="M" autocomplete="off" style="opacity: 0;" checked onclick="fn_show1()">
                    <label for="male" style="border:1px solid;float:left;">남자</label>
					<input type="radio" name="gendType" id="female" value="F" autocomplete="off" style="opacity: 0;" onclick="fn_show2()">
                    <label for="female" style="border:1px solid;" >여자</label>
                 </div>
                   		<div style="width: 900px; height: 550px;">
							<!--차트가 그려질 부분-->
						<div id="maleChart"><canvas id="myChart"></canvas></div>
						<div id="femaleChart"><canvas id="myChart2"></canvas></div>
						</div>
		
                   		
                   		<!-- 검색조건 form 시작 -->
                   		
                       <form method="get" id="frm" action="myClassInfo.do#location123">
							<div class="class__filter__select">
								<p>Categories:</p>
								<select name="selCate" id="selCate">
									<option value="">카테고리</option>
									<option value="헬스" 
										<c:if test="${selCate eq '헬스'}">selected</c:if>>헬스</option>
									<option value="필라테스"
										<c:if test="${selCate eq '필라테스'}">selected</c:if>>필라테스</option>
									<option value="요가"
										<c:if test="${selCate eq '요가'}">selected</c:if>>요가</option>
									<option value="맨몸운동"
										<c:if test="${selCate eq '맨몸운동'}">selected</c:if>>맨몸운동</option>
								</select>
							</div>
							<div class="class__filter__select">
								<p>Level:</p>
								<select name="selLev" id="selLev"> 
									<option value="">전체</option>
									<option value="조회순"
										<c:if test="${selLev eq '조회순'}">selected</c:if>>조회순</option>
									<option value="좋아요순"
										<c:if test="${selLev eq '좋아요순'}">selected</c:if>>좋아요순</option>
									<option value="댓글순"
										<c:if test="${selLev eq '댓글순'}">selected</c:if>>댓글순</option>
								</select>
							</div>
							<div class="class__filter__input">
								<p>Search:</p>
								<input type="text" placeholder="검색" id="keyword" name="keyword" value="${option.keyword}">
							</div>
							<div class="class__filter__btn">
								<button type="submit" style="cursor:pointer;">
									<i class="fa fa-search"></i>
								</button>
							</div>
							<span id="location123"></span>
						</form>
                   	</div>
               	</div>
            </div>
		    <div class="classes__filter">
			<span style="font-weight: bold; font-size: 1.1em;">총 ${totalCount}건</span>
			<table class="table" style="text-align: center;">
			<thead>
				<tr style="background: #6d7ab0; color: white;font-size: 1.1em;">
						<th scope="col">번호</th>
						<th scope="col">강의사진</th>
						<th scope="col">강의명</th>
						<th scope="col">가격</th>
						<th scope="col">등록일</th>
						<th scope="col">활성화여부</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty classList}">
						<tr>
							<td colspan="6" style="text-align: center;font-size: 18px;">등록된 강의가 존재하지 않습니다. </td>
						</tr>
					</c:if>
					<c:if test="${!empty classList}">
					<c:forEach var="result" items="${classList}" varStatus="status">
					     
					<tr>
						<td>${result.rn}
						<input type="hidden" class="lessonSeq" name="lessonSeq${status.index}" value="${result.lessonSeq}">
					    <input type="hidden" name="chkTog${status.index}" value="chkTog${status.index}">
					     <input type="hidden" class="lessonPrivateFlag" name="lessonPrivateFlag${status.index}" value="${result.lessonPrivateFlag}">
					     <input type="hidden" class="upUserId" name="upUserId${status.index}" value="${result.upUserId}">
						</td>
						<td><img src="${result.filePath}" style="width: 50px; height: 50px"></td>
						<td><a class="link" href="lessonDetail.do?lessonSeq=${result.lessonSeq}">${result.lessonTitle}</a></td>
						<td>${result.lessonPrice}원</td>
						<td>${result.inDate}</td>
						<td>
						<c:if test="${result.lessonPrivateFlag eq 'Y'}">
							<div class="toggle-switch">
						    	<input type="checkbox" name="chk" id="chkTog${status.index}" value="chkTog${status.index}" onclick="fn_switch(this)">
						    		<label id="chkTog" for="chkTog${status.index}">
						     			<span class="toggle-track"></span>
						    		</label>
						  	</div>
						</c:if>
						<c:if test="${result.lessonPrivateFlag eq 'N'}">
								<div class="toggle-switch">
							    	<input type="checkbox" name="chk" id="chkTog${status.index}" value="chkTog${status.index}" checked onclick="fn_switch(this)">
							    		<label id="chkTog" for="chkTog${status.index}">
							     			<span class="toggle-track"></span>
							    		</label>
							  	</div>
							</c:if>
						</td>
					</tr>
					</c:forEach>
					</c:if>
				</tbody>
			</table>
			<br>
			<div style="width: 100%;text-align: right;padding-right: 20px;font-weight: bold;">
			
			<c:set var="total" value="${totalCount * 3200}" />
			<fmt:formatNumber value="${totalCount}" type="number" var="numberType" />
			</div>
			
				<!-- 페이징처리 -->
            	<div class="col-lg-12">
					<div class="classes__pagination">
					<c:if test="${pageMaker.prev}">
						<a href="myClassInfo.do${pageMaker.makeQuery(pageMaker.startPage - 1)}">
							<span class="arrow_carrot-left"></span>
						</a>
					</c:if> 
					
					<c:set var="page" value="${pageMaker.cri.page}"/>
					<c:set var="idx" value="${idx}"/>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            			<a href="myClassInfo.do${pageMaker.makeQuery(idx)}" <c:if test="${page == idx }">style="background: #5768AD;color:#FFFFFF;"</c:if>>${idx}</a>
					</c:forEach>
					
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<a href="myClassInfo.do${pageMaker.makeQuery(pageMaker.endPage + 1)}"><span class="arrow_carrot-right"></span></a>
					</c:if>
					</div>
				</div>
			
			
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