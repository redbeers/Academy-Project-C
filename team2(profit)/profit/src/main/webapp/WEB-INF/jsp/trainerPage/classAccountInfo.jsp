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
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
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
  .toggle.ios, .toggle-on.ios, .toggle-off.ios { border-radius: 20px; }
  .toggle.ios .toggle-handle { border-radius: 20px; }

  .toggle.android { border-radius: 0px;}
  .toggle.android .toggle-handle { border-radius: 0px; }
</style>
<script type="text/javascript">

$(document).ready(function() {
	var now = new Date();
    var month = now.getMonth() + 1; 
//     var month = 1; 
    var month1 = month - 1;
    if(month1 == 0){
    	month1 = 12;
    }
    var month2 = month1 -1;
    if(month2 == 0){
    	month2 = 12;
    }
    var month3 = month2 -1;
    if(month3 == 0){
    	month3 = 12;
    }
    var month4 = month3 -1;
    if(month4 == 0){
    	month4 = 12;
    }
    var month5 = month4 -1;
    if(month5 == 0){
    	month5 = 12;
    }
	
    console.log(month);
    console.log(month1);
    console.log(month2);
	 $('#mydate').datepicker( {
	        changeMonth: true,
	        changeYear: true,
	        showButtonPanel: true,
	        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        dateFormat: 'yymm',
	        onClose: function(dateText, inst) { 
	            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	            $(this).datepicker('setDate', new Date(year, month, 1));
	        }
	    });
	 
	 var context = document
     .getElementById('myChart')
     .getContext('2d');
 var myChart = new Chart(context, {
     type: 'line', // 차트의 형태
     data: { // 차트에 들어갈 데이터
         labels: [
             //x 축
            month5 + "월", month4 + "월", month3 + "월", month2 + "월", month1 + "월", month + "월"
         ],
         datasets: [
             { //데이터
                 label: '여자 회원', //차트 제목
                 fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                 data: [
                     ${chartResult['prevcount5f']},
                     ${chartResult['prevcount4f']},
                     ${chartResult['prevcount3f']},
                     ${chartResult['prevcount2f']},
                     ${chartResult['prevcount1f']},
                     ${chartResult['nowcountf']}
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
             } ,
             { //데이터
                 label: '남자 회원', //차트 제목
                 fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                 data: [
                     ${chartResult['prevcount5m']},
                     ${chartResult['prevcount4m']},
                     ${chartResult['prevcount3m']},
                     ${chartResult['prevcount2m']},
                     ${chartResult['prevcount1m']},
                     ${chartResult['nowcountm']}
                	 //x축 label에 대응되는 데이터 값
                 ],
                 backgroundColor: [
                     //색상
                     'rgba(102, 204, 255, 0.2)',
                     'rgba(54, 162, 235, 0.2)',
                     'rgba(255, 206, 86, 0.2)',
                     'rgba(75, 192, 192, 0.2)',
                     'rgba(153, 102, 255, 0.2)',
                     'rgba(255, 159, 64, 0.2)'
                 ],
                 borderColor: [
                     //경계선 색상
                     'rgba(102, 204, 255, 1)',
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

function fn_today(){
	var today = getCurrentDate();
	location.href="trainerPermitList.do?selStatus=&selIdentity=&selDate="+today+"&searchKeyword=";
}

function getCurrentDate(){
    var date = new Date();
    var year = date.getFullYear().toString();
    var month = date.getMonth() + 1;
    month = month < 10 ? '0' + month.toString() : month.toString();
    var day = date.getDate();
    day = day < 10 ? '0' + day.toString() : day.toString();
    return year + month + day ;
}

function fn_pdf(){
	var yearmonth = $("#mydate").val();
	if(yearmonth == null || yearmonth == ''){
		alert("날짜로 먼저 검색해주세요.");
		return;
	}
	var payResult = $("#payResult").text();
	if(payResult == '미정산'){
		alert("해당 월은 아직 정산되지 않았습니다.");
		return;
	}
	
	$("#pdfInfo").submit();
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
               	<span style="font-weight: bold; font-size: 1.1em;padding-left: 30px;">최근 6개월 간 구매 현황</span>
                   <div class="col-lg-12">
                   		<div style="width: 900px; height: 550px;">
							<!--차트가 그려질 부분-->
						<canvas id="myChart"></canvas>
						</div>
		
                   		
                   		<!-- 검색조건 form 시작 -->
                   		
                       <form action="classAccountInfo.do#location123" method="get">
                           <div id="searchDiv" class="class__filter__input" style="width: 300px;text-align: left;">
							<p style="margin-right: 140px;">날짜 검색</p>
							<input type="text" placeholder="검색" id="mydate" style="width: 200px;display: left;margin-right: 10px;" 
								<c:if test="${not empty selDate}">value=${selDate}</c:if>
								name="selDate" id="selDate">
							<div class="class__filter__btn" style="display: left;width: 50px;margin-right: 680px;">
                               <button><i class="fa fa-search"></i></button>
                           </div>
                           <span id="location123"></span>
						</div>
						
                       	</form>
                   	</div>
               	</div>
            </div>
		    <div class="classes__filter">
			<span style="font-weight: bold; font-size: 1.1em;">총 ${totalCount}건</span>
			
			
			<!-- 테스트 --> 
<!-- 			<input type="checkbox" checked data-toggle="toggle" data-style="ios">			 -->
			
			
			
			<table class="table" style="text-align: center;">
			<thead>
				<tr style="background: #6d7ab0; color: white;font-size: 1.1em;">
						<th scope="col">번호</th>
						<th scope="col">고객아이디</th>
						<th scope="col">강의명</th>
						<th scope="col">가격</th>
						<th scope="col">구매일</th>
						<th scope="col">정산여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${classAccountList}" varStatus="status">
					<tr>
						<td>${result.rn}</td>
						<td>${result.inUserId}</td>
						<td>${result.lessonTitle}</td>
						<td>${result.lessonPrice}</td>
						<td>${result.inDate}</td>
						<td>
						<c:if test="${result.classAccountFlag eq 'N'}"><span id="payResult" style="background-color: #D16666;color: white;font-weight: bold;padding: 7px;">미정산</span></c:if>
						<c:if test="${result.classAccountFlag eq 'Y'}"><span id="payResult" style="background-color: #6ABD66;color: white;font-weight: bold;padding: 7px;padding-left:8px;">&nbsp;&nbsp;정산&nbsp;&nbsp;</span></c:if>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<br>
			<div style="width: 100%;text-align: right;padding-right: 20px;font-weight: bold;">
			
			<c:set var="total" value="${totalCount * 3200}" />
			<fmt:formatNumber value="${totalCount}" type="number" var="numberType" />
			
			<div class="classes__item__text" style="text-align: right;padding-top: 0;">
                 <a class="class-btn_w" onclick="fn_pdf()">정산내역 보기</a>
   		 	</div>
   		 	
   		 	<form id="pdfInfo" method="post" action="classAccountPdf.do">
	   		 	<input type="hidden" name="selDate" value="${selDate}">
   		 	</form>
   		 	
   		 	
   		 	
			</div>
			
				<!-- 페이징처리 -->
            	<div class="col-lg-12">
					<div class="classes__pagination">
					<c:if test="${pageMaker.prev}">
						<a href="classAccountInfo.do${pageMaker.makeQueryChatList(pageMaker.startPage - 1)}">
							<span class="arrow_carrot-left"></span>
						</a>
					</c:if> 
					
					<c:set var="page" value="${pageMaker.cri.page}"/>
					<c:set var="idx" value="${idx}"/>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            			<a href="classAccountInfo.do${pageMaker.makeQueryChatList(idx)}" <c:if test="${page == idx }">style="background: #5768AD;color:#FFFFFF;"</c:if>>${idx}</a>
					</c:forEach>
					
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<a href="classAccountInfo.do${pageMaker.makeQueryChatList(pageMaker.endPage + 1)}"><span class="arrow_carrot-right"></span></a>
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