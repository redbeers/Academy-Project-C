<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="./resources/datepicker/jquery-ui.css">
<script src="./resources/datepicker/jquery-3.5.1.js"></script>
<script src="./resources/datepicker/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(function(){
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
});

function fn_calculate(){
	var msg = "ok";
	
	if(msg=="ok"){
		var save = confirm("일괄정산 처리를 실행하시겠습니까?");
		if(save == true){
			fn_insSales();
		}
		else{
			alert("일괄정산이 취소되었습니다.");
		}
	}
}

function fn_insSales(){
	var gubun = $("input:hidden[name=gubun]").val();
	var yyyymm = $("input:hidden[name=yyyymm]").val();
	var totalfee = $("#totalfee").text();
	console.log("gubun " + gubun);
	console.log("yyyymm " + yyyymm);
	console.log("totalfee " + totalfee);
	
	var param = "";
	param += "dummy=" + Math.random();
	param += "&gubun="+ gubun;
	param += "&yyyymm=" + yyyymm;
	param += "&totalfee=" + totalfee;
	console.log("param "+ param);
	
	$.ajax({
			url : "insSalesAjax.do",
			data : param,
			dataType : "text",
			async:false,
			success : function(data) {
				if(data == "ok"){
					alert("일괄정산처리가 완료되었습니다.");	
					location.href="adminSalesList.do"
				} else{
					alert("일괄정산에 실패하였습니다. 다시 한 번 시도해주세요")
				}
				console.log(data)
			}
		});
	
	
}

</script>
<style>
.classes__filter form .class__filter__btn_re {
	padding-right: 125px;
}

.table tr:hover {
	background-color: #f8f6ff;
}

</style>
<body>

	<!-- Breadcrumb Begin -->
	<section class="breadcrumb-option set-bg"
		data-setbg="./resources/img/hero/hero-11.jpg" style="padding-bottom: 0px; padding-top: 70px;">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<!-- <h2>트레이너 승인</h2> -->

					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->
				
	<section class="classes spad">
		<div class="container">
			<h3 style="text-align: center;">[${adminSalesDetailList[0]['yyyymm']}] 상세</h3>
			<br>
<!-- 			검색form -->
<!-- 			<div class="classes__filter" style="margin-bottom: 0px;padding-bottom: 0px;"> -->
<!--                 <div class="row"> -->
<!--                     <div class="col-lg-12" > -->
<%--                         <form action="adminSalesDetail.do"> --%>
<!-- 							<div id="searchDiv" class="class__filter__input"  style="margin-right: 20px;width: 350px;"> -->
<!-- 								<p>검색어</p> -->
<%-- 								<input type="text" name="searchKeyword" placeholder="아이디검색" style="width: 100%;" value="${searchKeyword}"> --%>
<!-- 								<div class="class__filter__btn" style="padding-right: 525px;"> -->
<!--                                		<button ><i class="fa fa-search"></i></button> -->
<!--                             	</div> -->
<!-- 							</div> -->
<%--                         </form> --%>
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
			<div class="classes__filter" style="padding-top: 0px;">
			<br/><br/>
			 <button type="button" class="btn btn-outline-primary" style="float:right;" onclick="fn_calculate()">일괄 정산</button>
			 <br/><br/><br/>
			<table class="table" style="text-align: center;">
				<thead>
					<tr style="background: #6d7ab0; color: white;font-size: 1.1em;">
						<th scope="col">번호</th>
						<th scope="col">아이디</th>
						<th scope="col">건수</th>
						<th scope="col" >총금액</th>
						<th scope="col" >수수료</th>
						<th scope="col" >실수령액</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${adminSalesDetailList}" varStatus="status">
					<input type="hidden" name="gubun" value="${result.gubun}">
					<input type="hidden" name="yyyymm" value="${result.yyyymm}">
					<tr>
						<td>${status.count}</td>
						<td>${result.trainerId}</td>
						<td>${result.cnt} 건</td>
						<td><fmt:formatNumber type="number" maxFractionDigits="0"  value="${result.sum}" /> 원</td>
						<td><fmt:formatNumber type="number" maxFractionDigits="0"  value="${result.fee}" /> 원</td>
						<td ><fmt:formatNumber type="number" maxFractionDigits="0"  value="${result.realamount}" /> 원</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<br>
			<div style="width: 100%;text-align: right;padding-right: 20px;font-weight: bold;">
			
			<div>총 수수료합계&nbsp;:&nbsp;<span id="totalfee" style="background-color:#FFD2D7;"><fmt:formatNumber type="number" maxFractionDigits="0"  value="${totalPrice[0]['totalfee']}" /> </span>원</div>
			<div>총 실수령액합계&nbsp;:&nbsp;<span id="totalrealamount" style="background-color:#FFD2D7;"><fmt:formatNumber type="number" maxFractionDigits="0"  value="${totalPrice[0]['totalrealamount']}" /> </span>원</div>
			<div>총 금액합계&nbsp;:&nbsp;<span style="background-color:#FFD2D7;"><fmt:formatNumber type="number" maxFractionDigits="0"  value="${totalPrice[0]['total']}" /></span>원</div>
					
					
					
			</div>
			<!-- 페이징처리 -->
            	<div class="col-lg-12">
					<div class="classes__pagination">
					<c:if test="${pageMaker.prev}">
						<a href="adminSalesDetail.do${pageMaker.makeQueryAdminSalesDetailList(pageMaker.startPage - 1)}">
							<span class="arrow_carrot-left"></span>
						</a>
					</c:if> 
					
					<c:set var="page" value="${pageMaker.cri.page}"/>
					<c:set var="idx" value="${idx}"/>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            			<a href="adminSalesDetail.do${pageMaker.makeQueryAdminSalesDetailList(idx)}" <c:if test="${page == idx }">style="background: #5768AD;color:#FFFFFF;"</c:if>>${idx}</a>
					</c:forEach>
					
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<a href="adminSalesDetail.do${pageMaker.makeQueryAdminSalesDetailList(pageMaker.endPage + 1)}"><span class="arrow_carrot-right"></span></a>
					</c:if>
					</div>
				</div>
			
			</div>
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
