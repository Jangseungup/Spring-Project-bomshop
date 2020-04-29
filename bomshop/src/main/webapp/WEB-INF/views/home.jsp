<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css">

<div id="Wrapper">
	<div id="banner">
		<!-- 베너 광고 들어갈곳 -->
		<div class="slideshow-container">
				<%-- <a href="detail?gno=${.gno}"><img src="${pageContext.request.contextPath}/resources/${.gno}/ad.png"/></a> --%>
			<%-- <div class="mySlides fade">
				<a href="#"><img src="${pageContext.request.contextPath}/resources/img/test1.jpg"/></a>
			</div>
			
			<div class="mySlides fade">
				<a href="#"><img src="${pageContext.request.contextPath}/resources/img/test2.jpg"/></a>
			</div>
			
			<div class="mySlides fade">
				<a href="#"><img src="${pageContext.request.contextPath}/resources/img/test3.jpg"/></a>
			</div>
			
			<div class="mySlides fade">
				<a href="#"><img src="${pageContext.request.contextPath}/resources/img/test4.jpg"/></a>
			</div>
			
			<div class="mySlides fade">
				<a href="#"><img src="${pageContext.request.contextPath}/resources/img/test5.jpg"/></a>
			</div> --%>
			
			<c:choose>
				<c:when test="${!empty gnoList}">
					<c:forEach var="advertise" items="${gnoList}">
						<div class="mySlides fade">
							<a href="${pageContext.request.contextPath}/goods/detail?gno=${advertise.gno}">
								<img src="${pageContext.request.contextPath}/upload/${advertise.gno}/AD.png"/>
							</a>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="mySlides fade">
						<a href="${pageContext.request.contextPath}/goods/main">
							<img src="${pageContext.request.contextPath}/resources/img/nonAD.png"/>
						</a>
					</div>
				</c:otherwise>
			</c:choose>
			
			<img src="${pageContext.request.contextPath}/resources/img/left.png" class="btn prev" role="button" />
			<img src="${pageContext.request.contextPath}/resources/img/right.png" class="btn next" role="button" />
		</div>
		<div style="text-align:center">
			<c:if test="${!empty gnoList}">
				<c:forEach var="advertise" items="${gnoList}">
					<span class="dot"></span>
				</c:forEach>
			</c:if>
		</div>
	</div>
	
	<div id="best_goods" class="list_full">
		<!-- 베스트 상품 목록 들어갈곳 -->
		<div class="pagetitle">
			<h1>
				<span class="title">베스트 상품</span>
				<a href="${pageContext.request.contextPath}/goods/list?searchType=best" class="more_btn">더보기 ></a>
			</h1>
			
		</div>
		<div class="best_goods_list goods_list">
			<c:choose>
				<c:when test="${!empty best_list}">
					<c:forEach var="best_list" items="${best_list}">
						<c:choose>
							<c:when test="${best_list.gstatus == 'Y'}">
								<ul>
									<li class="list_img">
										<!-- 대표이미지 -->
										<a href="${pageContext.request.contextPath}/goods/detail?gno=${best_list.gno}">
											<img src="${pageContext.request.contextPath}/upload${best_list.img1}" width="270" height="280"/>
										</a>
									</li>
									<li class="list_seller">
										<!-- 판매자 -->
										<a href="${best_list.shopurl}">
											${best_list.shopname}
										</a>
									</li>
									<li class="list_gname">
										<!-- 상품명 -->
										<a href="">
											${best_list.gname_ko}
										</a>
									</li>
									<li class="list_price">
										<!-- 판매가 -->
										<span class="price">
											<c:if test="${best_list.cost != 0}">
												${best_list.cost}
											</c:if>
											<c:if test="${best_list.cost == 0}">
												${best_list.cost_origin}
											</c:if>
										</span>
										<c:if test="${best_list.cost != 0}">
											<span class="origin_price">
												${best_list.cost_origin}
											</span>
										</c:if>
									</li>
									<li class="list_scount">
										<!-- 판매개수 -->
										<span>
											${best_list.scount} 판매됨
										</span>
									</li>
								</ul>
							</c:when>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					판매중인 상품 없음
				</c:otherwise>
			</c:choose>
		</div>
		<div class="divide"></div>
	</div>
	
	<div id="new_goods" class="list_full">
		<!-- 신상 들어갈 곳 -->
		<div class="pagetitle">
			<h1>
				<span class="title">신상품</span>
				<a href="${pageContext.request.contextPath}/goods/list?searchType=new" class="more_btn">더보기 ></a>
			</h1>
		</div>
		<div class="new_goods_list goods_list">
			<c:choose>
				<c:when test="${!empty list}">
					<c:forEach var="goods" items="${list}">
						<c:choose>
							<c:when test="${goods.gstatus == 'Y'}">
								<ul>
									<li class="list_img">
										<!-- 대표이미지 -->
										<a href="${pageContext.request.contextPath}/goods/detail?gno=${goods.gno}">
											<img src="${pageContext.request.contextPath}/upload${goods.img1}" width="255" height="260"/>
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
							</c:when>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					판매중인 상품 없음
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		var message = "${message}";
		if(message != ""){
			alert(message);
		}
		
		var slideIndex = 1;
		showSlides(slideIndex);
		var dots = $(".dot");
		
		$(".slideshow-container .prev").on("click",function(){
			console.log("prevbtn");
			showSlides(slideIndex -= 1);
		});
		
		$(".slideshow-container .next").on("click",function(){
			console.log("nextbtn");
			showSlides(slideIndex += 1);
		});
		
		$(".dot").on("click",function(){
			var i = $(this).index();
			console.log("dot : "+i);
			showSlides(slideIndex = i+1);
		});
		
		function showSlides(n){
			var i;
			var slides = $(".mySlides");
			var dots = $(".dot");
			
			if(n > slides.length){slideIndex = 1}
			if(n < 1){slideIndex = slides.length}

			for(i = 0; i < slides.length; i++){
				slides[i].style.display = "none";
			}
			
			for(i = 0; i < dots.length; i++){
				dots[i].className = dots[i].className.replace("active","");
			}
			
			slides[slideIndex-1].style.display = "block";
			dots[slideIndex-1].className += " active";
		}
		
		
	});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>















