<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.spMainTopText{
		font-size : 30px;
		font-weight: bold;
	}
	
	.spMainaTagDiv{
		margin-bottom : 50px;
	}
	.spMainaTagDiv a{
		text-decoration: none;
		color : white;
		border : 1px solid #343a40;
		background-color: #343a40;
		padding : 10px;
		border-radius: 5px;
	}
	.spMainaTagDiv a:hover{
		cursor : pointer;
	}
</style>
</head>
<body>
	<%@include file="../common/header.jsp" %>
	<section id="mypage_section">
	
	<div style="text-align : center; margin-top:100px;">
		<span class="spMainTopText">판매자 전환 완료!</span>
	</div>
	<div style="text-align: center; margin-top:20px;">
		<img src="${pageContext.request.contextPath}/resources/img/completelogo.png" width="300px">
	</div>
	<div style="text-align: center; margin-top:50px;" class="spMainaTagDiv">
	<a href="${pageContext.request.contextPath}/">홈으로 가기</a>
	<a href="#">판매자 페이지로 가기</a>
	</div>
	
	</section>
	<%@include file="../common/footer.jsp" %>
</body>
</html>