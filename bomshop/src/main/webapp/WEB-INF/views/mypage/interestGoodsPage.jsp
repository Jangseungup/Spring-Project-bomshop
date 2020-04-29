<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.head_wrap{
		width : 740px;
		display : inline-block;
		text-align : left;
	}
	
	.goodsList_wrap{
		display : inline-block;
		border-top : 2px solid black;
		width : 760px;
		margin-top : 10px;
		padding : 20px;
		text-align: left;
	}
.goodsDiv{
	display: inline-block;
	width : 244px;
}
	
</style>
<div class="interestGoods_main">
	<div class="head_wrap">
		<div>
			<span style="font-size:20px;font-weight: bold;">나의 관심상품</span>&nbsp;&nbsp;<span style="font-size:20px;font-weight:bold;color:red;">${likegoodsCnt}</span>
		</div>
	</div>
	<br/>
	<div class="goodsList_wrap">
		<c:choose>
			<c:when test="${empty likegoodsList}">
				<div>
					<span style="font-size:17px;font-weight: bold;">관심 상품으로 등록된 상품이 없습니다.</span>
				</div>
			</c:when>
			<c:otherwise>
				여기에 상품 클릭 시 상품상세 가기 링크.
				<br/>
				<c:set var="i" value="0"/>
				<c:forEach var="goods" items="${likegoodsList}">
					<c:if test="${i%3 == 0 && i ne 0}">
						<br/><br/>
					</c:if>
					<div class="goodsDiv">
						<img src="${pageContext.request.contextPath}/upload/${goods.gno}/mainImg.jpg" width="244px"><br/>
						<span>${memberInfo.shopname}</span><br/>
						<span>${goods.gname_ko}</span><br/>
						<span style="font-size:20px;font-weight: bold;"><f:formatNumber  value="${goods.cost}" pattern="#,###"/>원</span>
					</div>
					<c:set var="i" value="${i+1}"/>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
	

</div>