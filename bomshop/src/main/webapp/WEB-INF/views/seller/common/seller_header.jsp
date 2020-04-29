<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="session"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BomShop Sales Management</title>
<style>
	body{
		width: 100%;
		height: 100%;
		min-width: 1000px;
		min-height: 800px;
	}

	header{
		background-color: black;
		height : 100px;
		padding-top: 20px;
		padding-left: 30px;
		min-width: 500px;
	}
	
	header div#title{
		float:left;
	}
	
	header div#title a{
		color:white;
		text-decoration: none;
	}
	
	header div#titleBar{
		padding : 20px;
		min-width: 500px;
	}
	
	header div#titleBar .menu{
		float : right;
		margin : 20px;
	}

	header div#titleBar .menu a{
		color : white;
		text-decoration: none;
	}
	
	header div#titleBar .menu a:hover{
		color : lime;
	}
	
	div#content{
		display: flex;
	}
	
	div#menuBar{
		background-color: #444444;
		width : 10%;
		padding : 0;
		float:left;
		min-width: 100px;
		min-height: 680px;
	}
	
	div#menuBar .menu{
		padding : 10px;
		text-align: center;
		color : white;
	}
	
	div#menuBar .menu:hover{
		background-color: #666666;
		cursor: pointer;
	}	
</style>
<link rel="stylesheet" href="${path}/resources/css/seller_common.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<%-- <c:if test="${!empty loginMember}"> --%>
	<header>
		<div id="title">
			<h1><a href="${pageContext.request.contextPath}/seller/">BomShop 판매관리</a></h1>
		</div>
		<div id="titleBar">
			<div class="menu">
				<a href="${path}/seller/service_center">고객센터</a>
			</div>
			<div class="menu">
				<a href="${path}/">BomShop 메인</a>
			</div>
			<div class="menu">
				<a href="${path}/member/logout">로그아웃</a>
			</div>
			<div class="menu">
				<a href="${path}/seller/privacy">${memberInfo.shopname}</a>
			</div>
		</div>
	</header>
	
	<div id="content">
		<div id="menuBar">
			<div class="menu" id="menu_gr" onclick="location.href='${path}/seller/register'">상품등록</div>
			<div class="menu" id="menu_gm" onclick="location.href='${path}/seller/goods_manage'">상품관리</div>
			<div class="menu" id="menu_om" onclick="location.href='${path}/seller/order_manage'">주문관리</div>
			<div class="menu" id="menu_clm" onclick="location.href='${path}/seller/claim_manage'">클레임관리</div>
			<div class="menu" id="menu_sm" onclick="location.href='${path}/seller/settlement_manage'">정산관리</div>
			<div class="menu" id="menu_ar" onclick="location.href='${path}/seller/advertising_request'">광고관리</div>
			<div class="menu" id="menu_cum" onclick="location.href='${path}/seller/customer_manage'">고객관리</div>
		</div>
<%-- </c:if> --%>
