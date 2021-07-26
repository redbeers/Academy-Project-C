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
});

</script>
</head>
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
			<h3 style="text-align: center;">온라인클래스 결제 / 환불 내역</h3>
			<br>
			    <div class="classes__filter" style="margin-bottom: 0px;">
				<br>
                <div class="row">
                    <div class="col-lg-12">
                        <form action="adminLessonPayList.do">
                            <div class="class__filter__select" style="width: 150px;">
                                <p>상태</p>
                                <select name="selStatus">
                                    <option <c:if test="${pageMaker.cri.selStatus eq '전체'}">selected</c:if>>전체</option>
                                    <option <c:if test="${pageMaker.cri.selStatus eq '결제'}">selected</c:if>>결제</option>
                                    <option <c:if test="${pageMaker.cri.selStatus eq '환불'}">selected</c:if>>환불</option>
                                </select>
                                
                            </div>
                            <div id="searchDiv" class="class__filter__input" style="margin-right: 28px;width: 150px;">
								<p>날짜</p>
								<input type="text" name="selDate" value="${pageMaker.cri.selDate}" placeholder="검색" id="mydate" style="width: 100%;cursor: pointer;">
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
								<input type="text" name="searchKeyword" placeholder="검색" style="width: 100%;cursor: pointer;" value="${pageMaker.cri.searchKeyword}">
								<div class="class__filter__btn">
                                <button style="cursor: pointer;"><i class="fa fa-search"></i></button>
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
						<th scope="col" colspan="2">강의명</th>
						<th scope="col">결제일</th>
						<th scope="col">상태</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty adminLessonPayList}">
						<tr>
							<td colspan="7" style="text-align: center;">결제/환불내역이 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty adminLessonPayList}">
					<c:forEach var="result" items="${adminLessonPayList}" varStatus="status">
					<tr>
						<td>${ (pageMaker.cri.page-1)*10 + (status.count)}</td>
						<td>${result.memberId}</td>
						<td>${result.memberName}</td>
						<td colspan="2">
							<span>[${result.lessonCategoryName}]</span>&nbsp;
							${result.lessonTitle}
						</td>
						<td>${fn:substring(result.inDate,0,10)}</td>
						<td>
						<c:if test="${result.status eq '결제'}">
							<span style="background-color: #6ABD66;color: white;font-weight: bold;padding: 7px;">결제</span>
						</c:if>
						<c:if test="${result.status eq '환불'}">
							<span style="background-color: #D16666;color: white;font-weight: bold;padding: 7px;">환불</span>
						</c:if>
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
						<a href="adminLessonPayList.do${pageMaker.makeQueryAdminLessonPayList(pageMaker.startPage - 1)}">
							<span class="arrow_carrot-left"></span>
						</a>
					</c:if> 
					
					<c:set var="page" value="${pageMaker.cri.page}"/>
					<c:set var="idx" value="${idx}"/>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            			<a href="adminLessonPayList.do${pageMaker.makeQueryAdminLessonPayList(idx)}" <c:if test="${page == idx }">style="background: #5768AD;color:#FFFFFF;"</c:if>>${idx}</a>
					</c:forEach>
					
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<a href="adminLessonPayList.do${pageMaker.makeQueryAdminLessonPayList(pageMaker.endPage + 1)}"><span class="arrow_carrot-right"></span></a>
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