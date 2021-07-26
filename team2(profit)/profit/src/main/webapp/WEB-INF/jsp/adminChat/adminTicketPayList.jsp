<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/datepicker/jquery-ui.css">
<script src="./resources/datepicker/jquery-3.5.1.js"></script>
<script src="./resources/datepicker/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$( "#mydate" ).datepicker({
		changeYear : true,
		changeMonth : true,
	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    yearRange: 'c-100:c+10',
	    dateFormat: 'yymmdd'
		
    });
	
	
	
	$('.minus').click(function () {
		var $input = $(this).parent().find('input');
		var count = parseInt($input.val()) - 1;
		count = count < 0 ? 0 : count;
		$input.val(count);
		$input.change();
		return false;
	});
	$('.plus').click(function () {
		var $input = $(this).parent().find('input');
		$input.val(parseInt($input.val()) + 1);
		$input.change();
		return false;
	});
	
	
});

function fn_updTicketCnt(ele){
	var msg = "ok";
	
	if(msg=="ok"){
		var save = confirm("해당강의의 상태를 바꾸시겠습니까?");
		if(save == true){
			
			vtr = $(ele).parents('tr');
			buyTicketSeq = $(vtr).find('.buyTicketSeq').val();
			ticketAvailFlag = $(vtr).find('.ticketAvailFlag').val();
			console.log("buyTicketSeq " + buyTicketSeq);
			console.log("ticketAvailFlag " + ticketAvailFlag);
			
			vtr2 = $(ele).parent('td');
			ticketCnt = $(vtr2).find('.ticketCnt').val();
			console.log("ticketCnt " + ticketCnt);
			
			var param = "";
				param += "dummy=" + Math.random();
				param += "&buyTicketSeq=" + buyTicketSeq;
				param += "&ticketCnt=" + ticketCnt;
				param += "&ticketAvailFlag=" + ticketAvailFlag;
				
			console.log("param " + param);
				
			$.ajax({
				type : 'get',
				url : 'updTicketCntAjax.do',
				data : param,
				async:false,
				dataType:"text",
				success : function(data){
					if(data=="ok"){
						alert("수정이 정상적으로 완료되었습니다.");
// 						location.reload();
					}else if(data=="no"){
						alert("수정에 실패하였습니다. 다시 시도해주세요");
// 						location.reload();
					}
			    },
				error : function(error){
					alert("수정에 실패하였습니다. 다시 시도해 주세요.");
// 					location.reload();
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


</script>
</head>
<style>
.classes__filter form .class__filter__btn_re {
	padding-right: 125px;
}

.table tr:hover {
	background-color: #f8f6ff;
}
.minus, .plus{
	width:20px;
	height:20px;
	background:#f2f2f2;
	border-radius:4px;
	padding:8px 5px 8px 5px;
	border:1px solid #ddd;
    display: inline-block;
    vertical-align: middle;
    text-align: center;
}


</style>
<body>

<!-- 	Breadcrumb Begin -->
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
			<h3 style="text-align: center;">이용권 구매내역</h3>
			<br>
			    <div class="classes__filter" style="margin-bottom: 0px;">
				<br>
                <div class="row">
                    <div class="col-lg-12">
                        <form action="adminTicketPayList.do">
                            <div class="class__filter__select" style="width: 150px;">
                                <p>종류</p>
                                <select name="selStatus">
                                    <option <c:if test="${pageMaker.cri.selStatus eq '전체'}">selected</c:if>>전체</option>
                                    <option <c:if test="${pageMaker.cri.selStatus eq '1회권'}">selected</c:if>>1회권</option>
                                    <option <c:if test="${pageMaker.cri.selStatus eq '3회권'}">selected</c:if>>3회권</option>
                                    <option <c:if test="${pageMaker.cri.selStatus eq '5회권'}">selected</c:if>>5회권</option>
                                </select>
                                
                            </div>
                            <div id="searchDiv" class="class__filter__input" style="margin-right: 28px;width: 150px;">
								<p>날짜</p>
								<input type="text" name="selDate" value="${pageMaker.cri.selDate}" placeholder="검색" id="mydate" style="width: 100%;">
							</div>
							<div class="class__filter__select" style="width: 150px;">
                                <p>검색조건</p>
                                <select name="selIdentity">
                                    <option <c:if test="${pageMaker.cri.selIdentity eq '전체'}">selected</c:if>>전체</option>
                                    <option <c:if test="${pageMaker.cri.selIdentity eq '이름'}">selected</c:if> >이름</option>
                                    <option <c:if test="${pageMaker.cri.selIdentity eq '아이디'}">selected</c:if>>아이디</option>
                                </select>
                            </div>
							<div id="searchDiv" class="class__filter__input"  style="margin-right: 20px;width: 350px;">
								<p>검색어</p>
								<input type="text" name="searchKeyword" placeholder="검색" style="width: 100%;" value="${pageMaker.cri.searchKeyword}">
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
						<th scope="col">종류</th>
						<th scope="col">남은개수</th>
						<th scope="col">결제일</th>
						<th scope="col">수정</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty adminTicketPayList}">
						<tr>
							<td colspan="7" style="text-align: center;">이용권 구매내역이 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty adminTicketPayList}">
					<c:forEach var="result" items="${adminTicketPayList}" varStatus="status">
					<tr>
						<td style="vertical-align: middle;">
							<input type="hidden" class="buyTicketSeq" name="buyTicketSeq${status.index}" value="${result.buyTicketSeq}">
							<input type="hidden" class="ticketCnt" name="ticketCnt${status.index}" value="${result.ticketCnt}">
							<input type="hidden" class="ticketAvailFlag" name="ticketAvailFlag${status.index}" value="${result.ticketAvailFlag}">
							${ (pageMaker.cri.page-1)*10 + (status.count)}
						</td>
						<td style="display: table-cell; vertical-align: middle">${result.inUserId}</td>
						<td style="display: table-cell; vertical-align: middle">${result.memberName}</td>
						<td style="display: table-cell; vertical-align: middle">${result.ticketName}</td>
						<td style="display: table-cell; vertical-align: middle">${result.ticketRemain} 회</td>
						<td style="display: table-cell; vertical-align: middle">${fn:substring(result.inDate,0,10)}</td>
						<td>
							<div class="number" style="width:120px;margin: 0px;display: inline-block;line-height: 14px">
								<span class="minus" style="cursor: pointer;height: 34px; width:26px;">-</span>
								<input class="ticketCnt" id="plmi${status.index}" type="text" value="${result.ticketRemain}" 
								style="width:50px;text-align: center;height:34px;font-size: 15px;border:1px solid #ddd;border-radius:4px;display: inline-block;vertical-align: middle;"/>
								<span class="plus" style="cursor: pointer; height: 34px; width:26px;">+</span>
							</div>
							<button type="button" id="updBtn${status.index}" class="btn btn-outline-dark" onclick="fn_updTicketCnt(this)" style="display: inline-block;font-size: 14px;">수정</button>
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
						<a href="adminTicketPayList.do${pageMaker.makeQueryAdminTicketPayList(pageMaker.startPage - 1)}">
							<span class="arrow_carrot-left"></span>
						</a>
					</c:if> 
					
					<c:set var="page" value="${pageMaker.cri.page}"/>
					<c:set var="idx" value="${idx}"/>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            			<a href="adminTicketPayList.do${pageMaker.makeQueryAdminTicketPayList(idx)}" <c:if test="${page == idx }">style="background: #5768AD;color:#FFFFFF;"</c:if>>${idx}</a>
					</c:forEach>
					
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<a href="adminTicketPayList.do${pageMaker.makeQueryAdminTicketPayList(pageMaker.endPage + 1)}"><span class="arrow_carrot-right"></span></a>
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
</html>