<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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


function fn_detail(ele){
	vtr = $(ele).parents('tr');
	yyyymm = $(vtr).find('.yyyymm').val();
	gubun = $(vtr).find('.gubun').val();
	console.log("yyyymm " + yyyymm);
	console.log("gubun " + gubun);
	
	location.href="adminSalesDetail.do?yyyymm="+yyyymm + "&gubun=" + gubun;
}

function fn_pdf(cnt){
// 	vtr = $(cnt).parents('tr');
// 	payResult = $(vtr).find('.payResult').text();
// 	yyyymm = $(vtr).find('.yyyymm').val();
// 	gubun = $(vtr).find('.gubun').val();
// 	console.log("payResult " + payResult)
// 	console.log("yyyymm " + yyyymm);
// 	console.log("gubun " + gubun);

	var accountFlag = $("#accountFlag" + cnt).val();
	console.log("accountFlag "+accountFlag);
	
	if(accountFlag == '미정산'){
		alert("해당 월은 아직 정산되지 않았습니다.");
		return;
	}
	$("#frm" + cnt).submit();

	
}


</script>
<style>
.classes__filter form .class__filter__btn_re {
	padding-right: 125px;
}

.table tr:hover {
	background-color: #f8f6ff;
}
.ui-datepicker-calendar {
    display: none;
}  
#openPdf{
	color:#17a2b8;
}
#openPdf:hover{
	color: #52E4DC;
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
			<h3 style="text-align: center;">정산하기</h3>
			<br>
			    <div class="classes__filter" style="margin-bottom: 0px;">
				<br>
                <div class="row">
                    <div class="col-lg-12">
                        <form action="adminSalesList.do">
                           <div id="searchDiv" class="class__filter__input" style="margin-right: 28px;width: 150px;">
								<p>날짜 검색</p>
								<input type="text" placeholder="검색" id="mydate" style="width: 100%;cursor: pointer;" 
									value="${pageMaker.cri.selDate}" name="selDate" id="selDate">
							</div>
							<div class="class__filter__select" style="width: 150px;">
                                <p>카테고리</p>
                                <select name="selGubun">
                                    <option <c:if test="${pageMaker.cri.selGubun eq '전체'}">selected</c:if>>전체</option>
                                    <option <c:if test="${pageMaker.cri.selGubun eq '온라인클래스'}">selected</c:if>>온라인클래스</option>
                                    <option <c:if test="${pageMaker.cri.selGubun eq '채팅'}">selected</c:if>>채팅</option>
                                </select>
                            </div>
                            <div class="class__filter__select" style="width: 150px;">
                                <p>상태</p>
                                <select name="selStatus">
                                    <option <c:if test="${pageMaker.cri.selStatus eq '전체'}">selected</c:if>>전체</option>
                                    <option <c:if test="${pageMaker.cri.selStatus eq '정산'}">selected</c:if>>정산</option>
                                    <option <c:if test="${pageMaker.cri.selStatus eq '미정산'}">selected</c:if>>미정산</option>
                                </select>
                                
                            </div>
								<div class="class__filter__btn" style="padding-right: 370px;">
                                <button style=" cursor:pointer;"><i class="fa fa-search"></i></button>
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
						<th scope="col">[월]&nbsp;카테고리</th>
						<th scope="col">정산여부</th>
						<th scope="col" >상세조회</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty adminSalesList}">
						<tr>
							<td colspan="4" style="text-align: center;">이용권 결제/환불내역이 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty adminSalesList}">
					<c:forEach var="result" items="${adminSalesList}" varStatus="status">
						<form id="frm${status.count}" action="salesAccountPdf.do" method="post">
					<tr>
						<td style="vertical-align: middle;">
							<input type="hidden" class="yyyymm" name="yyyymm" value="${fn:substring(result.yyyymm,0,7)}"/>
							<input type="hidden" class="gubun" name="gubun" value="${result.gubun}" />
							${ (pageMaker.cri.page-1)*10 + (status.count)}
						
						</td>
						<td style="vertical-align: middle;">
							<a onclick="fn_pdf(${status.count})" style="cursor: pointer;" id="openPdf"><span>[${fn:substring(result.yyyymm,0,7)}]</span>&nbsp;${result.gubun}</a>
						</td>
						<td style="vertical-align: middle;">
							<c:if test="${result.accountflag eq '미정산'}"><span class="payResult" id="payResult${status.index}" style="background-color: #D16666;color: white;font-weight: bold;padding: 7px;">미정산</span></c:if>
							<c:if test="${result.accountflag eq '정산'}"><span class="payResult" id="payResult${status.index}" style="background-color: #6ABD66;color: white;font-weight: bold;padding: 7px;padding-left:8px;">&nbsp;&nbsp;정산&nbsp;&nbsp;</span></c:if>	
						<input type="hidden" id="accountFlag${status.count}" name="accountFlag" value="${result.accountflag}">
						</td>
						
						<td style="vertical-align: middle;">
							<button type="button" id="detailBtn${status.index}" class="btn btn-outline-info" onclick="fn_detail(this)">상세</button>
						</td>
					</tr>
						</form>
					</c:forEach>
					</c:if>
				</tbody>
			</table>
			
   		 	
			<!-- 페이징처리 -->
            	<div class="col-lg-12">
					<div class="classes__pagination">
					<c:if test="${pageMaker.prev}">
						<a href="adminSalesList.do${pageMaker.makeQueryAdminSalesList(pageMaker.startPage - 1)}">
							<span class="arrow_carrot-left"></span>
						</a>
					</c:if> 
					
					<c:set var="page" value="${pageMaker.cri.page}"/>
					<c:set var="idx" value="${idx}"/>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            			<a href="adminSalesList.do${pageMaker.makeQueryAdminSalesList(idx)}" <c:if test="${page == idx }">style="background: #5768AD;color:#FFFFFF;"</c:if>>${idx}</a>
					</c:forEach>
					
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<a href="adminSalesList.do${pageMaker.makeQueryAdminSalesList(pageMaker.endPage + 1)}"><span class="arrow_carrot-right"></span></a>
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
