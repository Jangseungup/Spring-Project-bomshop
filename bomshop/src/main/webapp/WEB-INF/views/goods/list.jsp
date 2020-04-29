<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/select.css">

<div id="best_goods" class="list_full">
	<!-- 베스트 상품 목록 들어갈곳 -->
	<div class="pagetitle">
		<h1>
			<span class="title">상품 리스트</span>
		</h1>
		
	</div>
	<c:choose>
		<c:when test="${!empty list}">
			<div class="best_goods_list goods_list">
				<c:forEach var="goods" items="${list}">
					<ul class="b_list">
						<li class="list_img">
							<!-- 대표이미지 -->
							<a href="detail?gno=${goods.gno}">
								<img src="${pageContext.request.contextPath}/upload/${goods.gno}/mainImg.jpg" width="270" height="280"/>
							</a>
						</li>
						<li class="list_seller">
							<!-- 판매자 -->
							<a href="${goods.shopurl}">
								${goods.shopname}
							</a>
						</li>
						<li class="list_gname">
							<!-- 상품명 -->
							<a href="">
								${goods.gname_ko}
							</a>
						</li>
						<li class="list_price">
							<!-- 판매가 -->
							<span class="price">
								<c:if test="${goods.cost != 0}">
									${goods.cost}
								</c:if>
								<c:if test="${goods.cost == 0}">
									${goods.cost_origin}
								</c:if>
							</span>
							<c:if test="${goods.cost != 0}">
								<span class="origin_price">
									${goods.cost_origin}
								</span>
							</c:if>
						</li>
						<li class="list_scount">
							<!-- 판매개수 -->
							<span>
								${goods.scount} 판매됨
							</span>
						</li>
					</ul>

				</c:forEach>
			</div>
			<div class="more_list">
				<!-- 더보기 버튼 -->
				<a href="#" class="moreBtn btn btn-default btn-lg btn-block">더보기</a>
			</div>
		</c:when>
		<c:otherwise>
			판매중인 상품 없음
		</c:otherwise>
	</c:choose>
</div>

<script>
	$(document).ready(function(){
		$(".b_list").slice(0,10).show();
		
		$(".moreBtn").on("click",function(event){
			event.preventDefault();
			$(".b_list:hidden").slice(0,10).show();
			
			if($(".b_list:hidden").length == 0){
				$(".more_list").attr("style","display:none");
			}
		});
	});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>