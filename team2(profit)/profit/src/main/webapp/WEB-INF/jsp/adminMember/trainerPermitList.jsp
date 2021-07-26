<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/datepicker/jquery-ui.css">
<script src="./resources/datepicker/jquery-3.5.1.js"></script>
<script src="./resources/datepicker/jquery-ui.js"></script>

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
</style>
<script type="text/javascript">
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
	$("#mydate").datepicker({
		changeYear : true,
		changeMonth : true,
		dayNamesMin : [ '일', '월', '화', '수', '목','금', '토' ],
		monthNamesShort : [ '1월', '2월', '3월', '4월','5월', '6월', '7월', '8월', '9월','10월', '11월', '12월' ],
		yearRange : 'c-100:c+10',
		dateFormat : 'yymmdd'
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
			<h3 style="text-align: center; cursor: pointer;" onclick="location.href='trainerPermitList.do'" >트레이너 승인</h3>
			<br>
        	<div class="row" style="margin-bottom: 30px;margin-top: 30px;">
            <!-- counter -->
            <div class="col-md-3 col-sm-6 bottom-margin text-center counter-section wow fadeInUp sm-margin-bottom-ten animated" data-wow-duration="300ms" style="visibility: visible; animation-duration: 300ms; animation-name: fadeInUp;"> 
	            <i class="fa fa-user medium-icon"></i> 
	            <span id="anim-number-pizza" class="counter-number"></span> 
	            <span class="timer counter alt-font appear" data-to="980" data-speed="7000" 
	            	onclick="location.href='trainerPermitList.do?selStatus=A&selIdentity=&selDate=&searchKeyword=' " style="cursor: pointer">${todayNumberList.statusA }</span>
	            <p class="counter-title">승인요청</p>
            </div> 
            <!-- end counter -->
            
            <!-- counter -->
            <div class="col-md-3 col-sm-6 bottom-margin text-center counter-section wow fadeInUp sm-margin-bottom-ten animated" data-wow-duration="600ms" style="visibility: visible; animation-duration: 600ms; animation-name: fadeInUp;"> 
	            <i class="fa fa-user medium-icon"></i> 
	            <span class="timer counter alt-font appear" data-to="980" data-speed="7000"
	            	onclick="location.href='trainerPermitList.do?selStatus=B&selIdentity=&selDate=&searchKeyword=' "
	            	style="cursor: pointer">${todayNumberList.statusB }</span> 
	            <span class="counter-title">검토단계</span> 
	        </div> 
	        <!-- end counter -->
            
            <!-- counter -->
            <div class="col-md-3 col-sm-6 bottom-margin-small text-center counter-section wow fadeInUp xs-margin-bottom-ten animated" data-wow-duration="900ms" style="visibility: visible; animation-duration: 900ms; animation-name: fadeInUp;"> 
            	<i class="fa fa-user medium-icon"></i> 
            	<span class="timer counter alt-font appear" data-to="810" data-speed="7000" 
    	        	onclick="location.href='trainerPermitList.do?selStatus=C&selIdentity=&selDate=&searchKeyword=' " 
	            	style="cursor: pointer">${todayNumberList.statusC }</span> 
            	<span class="counter-title">보완단계</span> 
            </div> 
            <!-- end counter -->
            
            <!-- counter -->
            <div class="col-md-3 col-sm-6 text-center counter-section wow fadeInUp animated" data-wow-duration="1200ms" style="visibility: visible; animation-duration: 1200ms; animation-name: fadeInUp;"> 
            	<i class="fa fa-heart medium-icon"></i> 
            	<span class="timer counter alt-font appear" data-to="600" data-speed="7000" onclick="fn_today()" style="cursor: pointer">${todayNumberList.statusDate }</span> 
            	<span class="counter-title">오늘처리건수</span> 
            </div> 
            <!-- end counter -->
        </div>

						
			<!-- 2 -->
		    <div class="classes__filter" style="margin-bottom: 0px;">
			<br>
               <div class="row">
                   <div class="col-lg-12">
                   		<!-- 검색조건 form 시작 -->
                       <form action="trainerPermitList.do" method="get">
                           <div class="class__filter__select" style="width: 150px;">
                               <p>상태</p>
                               <select name="selStatus" id="selStatus">
                                   <option value="">전체</option>
                                   <option value="A" <c:if test="${selStatus eq 'A'}">selected</c:if>	>신청</option>
                                   <option value="B" <c:if test="${selStatus eq 'B'}">selected</c:if>	>검토</option>
                                   <option value="C" <c:if test="${selStatus eq 'C'}">selected</c:if>	>보완</option>
                                   <option value="D" <c:if test="${selStatus eq 'D'}">selected</c:if>	>반려</option>
                                   <option value="E" <c:if test="${selStatus eq 'E'}">selected</c:if>	>승인</option>
                               </select>
                           </div>
                           <div class="class__filter__select" style="width: 150px;">
                               <p>검색조건</p>
                               <select name="selIdentity">
                                   <option value="">전체</option>
                                   <option value="이름"  <c:if test="${selIdentity eq '이름'}">selected</c:if>		>이름</option>
                                   <option value="아이디"	<c:if test="${selIdentity eq '아이디'}">selected</c:if>	>아이디</option>
                               </select>
                           </div>
                           <div id="searchDiv" class="class__filter__input" style="margin-right: 28px;width: 150px;">
							<p>처리일자</p>
							<input type="text" placeholder="검색" id="mydate" style="width: 100%;" 
								<c:if test="${not empty selDate}">value=${selDate }</c:if>
								name="selDate" id="selDate">
						</div>
						
						<div id="searchDiv" class="class__filter__input"  style="margin-right: 20px;width: 350px;">
							<p>검색어</p>
							<input type="text" placeholder="검색" style="width: 100%;" 
								<c:if test="${not empty searchKeyword}">value=${searchKeyword }</c:if>
								name="searchKeyword" id="searchKeyword">
							<div class="class__filter__btn">
                               <button><i class="fa fa-search"></i></button>
                           </div>
						</div>
                       	</form>
                   	</div>
               	</div>
            </div>
			
		    <div class="classes__filter">
			<table class="table" style="text-align: center;">
			<thead>
				<tr style="background: #6d7ab0; color: white;font-size: 1.1em;">
						<th scope="col">번호</th>
						<th scope="col">아이디</th>
						<th scope="col">이름</th>
						<th scope="col">신청일자</th>
						<th scope="col">처리일자</th>
						<th scope="col">상태</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty processList}">
						<tr>
							<td colspan="8" style="text-align: center;">트레이너 신청내역이 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty processList}">
					<c:forEach var="list" items="${processList}" varStatus="status">
					<tr <c:if test="${list.processStatus eq 'A' }">onclick="fn_change(${list.processSeq })"</c:if>
						onclick="location.href='trainerPermitDetail.do?processSeq=${list.processSeq}' ">
						<td>${list.processSeq }</td>
						<td>${list.memberId }</td>
						<td>${list.memberName }</td>
						<td>${fn:substring(list.inDate,0,10)}</td>
						<c:if test="${empty list.upDate}">
							<td>-</td>
						</c:if>
						<c:if test="${not empty list.upDate}">
							<td>${fn:substring(list.upDate,0,10)}</td>
						</c:if>
						<td>
							<c:if test="${list.processStatus eq 'A'}"><span style="background-color: #FDA4C7;color: white;font-weight: bold;padding: 7px;">신청</span></c:if>
							<c:if test="${list.processStatus eq 'B'}"><span style="background-color: #81BDF5;color: white;font-weight: bold;padding: 7px;">검토</span></c:if>
							<c:if test="${list.processStatus eq 'C' && list.processFinishDate ne null}"><span style="background-color: #FAC056;color: darkslategray;font-weight: bold;padding: 7px;">보완</span></c:if>
							<c:if test="${list.processStatus eq 'C' && list.processFinishDate eq null}"><span style="background-color: #958BF2;color: white; font-weight: bold;padding: 7px;">만료</span></c:if>
							<c:if test="${list.processStatus eq 'D'}"><span style="background-color: #D16666;color: white; font-weight: bold;padding: 7px;">반려</span></c:if>
							<c:if test="${list.processStatus eq 'E'}"><span style="background-color: #6ABD66;color: white;font-weight: bold;padding: 7px;">승인</span></c:if>
						</td>
					</tr>
					</c:forEach>
					</c:if>
				</tbody>
			</table>
			
			
			
			
				<!-- 페이징처리 -->
            	<div class="col-lg-12">
					<div class="classes__pagination">
					<c:if test="${pageMaker.prev}">
						<a href="trainerPermitList.do${pageMaker.makeQueryAdminChat(pageMaker.startPage - 1)}">
							<span class="arrow_carrot-left"></span>
						</a>
					</c:if> 
					
					<c:set var="page" value="${pageMaker.cri.page}"/>
					<c:set var="idx" value="${idx}"/>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            			<a href="trainerPermitList.do${pageMaker.makeQueryAdminChat(idx)}" <c:if test="${page == idx }">style="background: #5768AD;color:#FFFFFF;"</c:if>>${idx}</a>
					</c:forEach>
					
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<a href="trainerPermitList.do${pageMaker.makeQueryAdminChat(pageMaker.endPage + 1)}"><span class="arrow_carrot-right"></span></a>
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