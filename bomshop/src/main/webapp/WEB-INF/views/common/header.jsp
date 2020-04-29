<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<div class="top_div">
	<div>
		<span id="title"><a href="${pageContext.request.contextPath}/">BOM SHOP</a></span>
	</div>
	<div>
		<form class= "main_search_form" action="list">
			<input type="text" name="keyword"><input type="submit" class="headerSearchBtn" value="검색"/>
		</form>
	</div>
	<!-- 여기 조건 추가, 멤버 타입으로 top_menu 달라짐 -->
	<div id="top_menu">
		<c:if test="${!empty memberInfo}">
			<span style="display: inline-block; width:300px;padding-left: 100px; font-weight:bold;">${memberInfo.mid}님 반갑습니다!</span><br/><br/>
		</c:if>
		<span>
			<a href="${pageContext.request.contextPath}/goods/cart">장바구니</a>	
		</span>
		<span>
			<c:choose>
				<c:when test="${!empty memberInfo}">
					<a href="${pageContext.request.contextPath}/mypage/main">마이페이지</a>
				</c:when>
				<c:otherwise>
					<a href="${pageContext.request.contextPath}/mypage/nonMemberOrderDeliveryPage">비회원 주문조회</a>
				</c:otherwise>
			</c:choose>
		</span>
		<span>
			<c:choose>
				<c:when test="${empty memberInfo}">
					<a href="${pageContext.request.contextPath}/member/login">로그인</a>	
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${!empty googleLogin}">
							<button onclick="javascript:signOut();">로그아웃</button>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
						</c:otherwise>
					</c:choose>
						
				</c:otherwise>
			</c:choose>
		</span>
		<span>
			<a href="${pageContext.request.contextPath}/customerService/main">고객센터</a>
		</span>
		 <c:if test="${!empty memberInfo}">
		 	<c:if test="${memberInfo.mtype eq 2}">
			<span>
				<a href="${pageContext.request.contextPath}/seller/">판매하기</a>
			</span>
			</c:if>
		</c:if>
	</div>
</div>
<br/>
<hr/>
<nav class="main_menu">
	<ul>
		<li><span><a href="${pageContext.request.contextPath}/goods/main">홈</a></span></li>
		<li><span><a href="${pageContext.request.contextPath}/goods/list?searchType=best">베스트</a></span></li>
		<li><span>의류</span>
			<ul class="clothUl" id="clothUl">
				<li><a href="${pageContext.request.contextPath}/goods/list?searchType=아우터" style="font-weight: bold; font-size:18px;">아우터</a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=패딩">패딩</a></li>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=코트">코트</a></li>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=자켓">자켓</a></li>
					</ul>
				</li>
				<li><a href="${pageContext.request.contextPath}/goods/list?searchType=상의" style="font-weight: bold;  font-size:18px; ">상의</a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=긴팔티셔츠">긴팔티셔츠</a></li>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=반팔티셔츠">반팔티셔츠</a></li>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=맨투맨">맨투맨</a></li>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=후드">후드</a></li>
					</ul>
				</li>
				<li><a href="${pageContext.request.contextPath}/goods/list?searchType=하의" style="font-weight: bold; font-size:18px;">하의</a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=청바지">청바지</a></li>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=반바지">반바지</a></li>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=캐주얼바지">캐주얼바지</a></li>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=트레이닝복">트레이닝복</a></li>
					</ul>
				</li>
				<li><a href="${pageContext.request.contextPath}/goods/list?searchType=기타" style="font-weight: bold; font-size:18px;">기타</a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=정장">정장</a></li>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=한복">한복</a></li>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=작업복">작업복</a></li>
						<li><a href="${pageContext.request.contextPath}/goods/list?searchType=수영복">수영복</a></li>
					</ul>
				</li>
			</ul>
		</li>
		<li><span><a href="${pageContext.request.contextPath}/goods/list?searchType=악세사리">액세서리</a></span>
			<ul class="accessaryUl">
				<li><a href="${pageContext.request.contextPath}/goods/list?searchType=가방">가방</a></li>
				<li><a href="${pageContext.request.contextPath}/goods/list?searchType=신발">신발</a></li>
				<li><a href="${pageContext.request.contextPath}/goods/list?searchType=벨트">벨트</a></li>
				<li><a href="${pageContext.request.contextPath}/goods/list?searchType=넥타이">넥타이</a></li>
			</ul>
		</li>
		<li><span>브랜드</span>
			<ul class="brandUl" id="brandUl">
				
			</ul>
		</li>
	</ul>
</nav>
<div style="clear:both;"></div>
<br/><hr/>
<script>
	$(function(){
		getHeaderData();
	});
	
	function getHeaderData(){

		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/getBrandList",
			success : function(data){
				console.log(data);
				var str = "";
				for(var i=0;i<data.length;i++){
					str += "<li><a href='${pageContext.request.contextPath}/goods/shopSearch?shopname="+data[i]+"'>" + data[i] + "</a></li>";
				}
				$("#brandUl").html(str);
			}
		});
	}
</script>
