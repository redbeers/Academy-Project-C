<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.table tr:hover {
	background-color: #f8f6ff;
}
</style>
<script type="text/javascript">

</script>
</head>
<body>

	<!-- Breadcrumb Begi -->
	<section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg" style="background-image: url(&quot;./resources/img/breadcrumb.jpg&quot;);">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>공지사항 목록</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->
	<!-- Classes Section Begin -->
	<section class="classes spad">
		<div class="container">
			<div class="classes__filter">
				<h3>📢 공지사항</h3>
				<br>
				<table class="table" style="text-align: center;">
					<thead>
						<tr style="background: #6d7ab0; color: white; font-size: 1.1em;">
							<th scope="col">번호</th>
							<th scope="col" colspan="5">제목</th>
							<th scope="col">파일</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="data" items="${data}" varStatus="status">
							<tr style="cursor: pointer;" onclick="location.href='${path}noticeDetail.do?communitySeq=${data.communitySeq}'">
								<th scope="row">${data.rn}</th>
								<td colspan="5">
									<form id="frm" action="commonHit.do">
										${data.commonTitle}
									</form>
								</td>
								<c:if test="${data.fileCnt ne '0'}">
									<td><img src="./resources/img/common/logo.png" style="width: 20px; height: 10px; opacity: 0.5;"></td>
								</c:if>
								<c:if test="${data.fileCnt eq '0'}">
									<td></td>
								</c:if>
								<td>${data.inUserId}</td>
								<td>${data.inDate}</td>
								<td>${data.commonHit}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="classes__item__text" style="text-align: right;">
					<c:set var="inUser" value="${sessionScope.memberId}" />
					<c:if test="${inUser eq '1'}">
						<a href="noticeAdd.do" class="class-btn">등록</a>
					</c:if>
				</div>
			</div>
			<!-- 페이징처리 -->
			<div class="col-lg-12">
				<div class="classes__pagination">
					<c:if test="${pageMaker.prev}">
						<a href="boardList.do${pageMaker.makeQuery(pageMaker.startPage - 1)}">
							<span class="arrow_carrot-left"></span>
						</a>
					</c:if>

					<c:set var="page" value="${pageMaker.cri.page}" />
					<c:set var="idx" value="${idx}" />
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<a href="noticeList.do${pageMaker.makeQuery(idx)}" <c:if test="${page == idx }">style="background: #5768AD;color:#FFFFFF;"</c:if>>${idx}</a>
					</c:forEach>

					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<a href="noticeList.do${pageMaker.makeQuery(pageMaker.endPage + 1)}">
							<span class="arrow_carrot-right"></span>
						</a>
					</c:if>
				</div>
			</div>
		</div>
	</section>

	<!-- Classes Section End -->
</body>
</html>