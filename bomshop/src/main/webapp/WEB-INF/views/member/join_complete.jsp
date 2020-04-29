<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#completeMessage{
		font-size : 30px;
		font-weight: bold;
	}
	.goShopTag{
		text-decoration: none;
		cursor: pointer;
		width : 200px;
		color : white;	
	}
	.goShopTag span{
		width:200px;
	}
</style>
</head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<body>
	<%@include file="../common/header.jsp" %>
	<%@include file="join_subtag_complete.jsp" %>
	<div style="text-align:center;margin-top:100px; margin-bottom:100px;">
	<div>
		<img src="${pageContext.request.contextPath}/resources/img/completelogo.png" width="300px;" height="300px;"><br/><br/>
		<span id="completeMessage">가입을 축하합니다!</span><br/><br/>
		<a href="${pageContext.request.contextPath}/member/login" class="goShopTag"><span class="btn btn-dark">로그인 하러가기</span></a>
	</div>
</div>
	<%@include file="../common/footer.jsp" %>
</body>
</html>