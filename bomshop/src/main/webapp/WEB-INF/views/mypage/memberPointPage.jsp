<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.topText{
		font-size : 25px;
	}
	.pointText{
		color : red;
	}
	.mypagePoint_explain{
		display: inline-block;
		text-align: left;
		margin-top : 50px;
		margin-bottom : 50px;
	}
	.mypagePoint_explain span{
		font-size : 12px;
		text-align: left;
	}
</style>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<div class="mypagePoint_main">
	<div class="mypagePoint_topText">
		<span class="topText">회원님의 현재 보유 포인트는 <span class="pointText"><f:formatNumber  value="${memberInfo.mpoint}" pattern="#,###"/></span>점 입니다.</span>
	</div>
	<div class="mypagePoint_explain">
		<span style="font-weight:bold;font-size:15px;">포인트 상세</span><br/>
		<span class="explain">
			· 본 사이트의 포인트는 현금과 동일하게 사용됩니다. ex) 현금 10,000원 = Point 10,000원<br/>
			· 포인트는 상품 결제시에만 사용가능합니다.<br/>
			· 포인트는 상품 구매확정 시 적립되며, 포인트 적립(%)는 회원등급에서 혜택란에서 확인이 가능합니다.<br/>
			· 포인트는 사용 즉시 차감되며 복구되지 않으니 신중히 사용하시길 권장합니다.<br/>
			· 하단의 '사용하러 가기' 버튼은 상품 '베스트' 페이지로 이동합니다.
		</span>
	</div><br/>
	<button type="button" class="btn btn-dark" id="homeBtn">사용하러가기</button>
</div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$("#homeBtn").click(function(){
		location.href="${pageContext.request.contextPath}/";
	});
</script>
