<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="session"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BomShop Sales Management</title>
<style>
	body {
		padding:0;
		margin:0;
	}
	header{
		background-color: black;
		height : 100px;
		padding-top: 20px;
		padding-left: 30px;
		color : white;
	}
	
	header div#title{
		float:left;
		
	}
	
	header div#title a{
		text-decoration: none;
		color:white;
	}
	
	header div#titleBar{
		padding : 20px;
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
	
	div#menuBar{
		background-color: #444444;
		min-width : 10%;
		height: 733px;
		padding : 0;
		float:left;
	}
	
	div#menuBar .menu{
		padding : 10px;
		text-align: center;
		cursor: pointer;
		color: white;
	}
	
	div#menuBar .menu:hover{
		background-color: #666666;
	}
	
	div#menuBar .menu a{
		color : white;
		text-decoration: none;
	}
	.menu-background-color{
		background-color: lightgray;
	}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${path}/resources/admin/css/common.css"/>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<header>
		<div id="title">
			<h1><a href="adminMain">BomShop 관리자</a></h1>
		</div>
		<div id="titleBar">
			<div class="menu">
				<a href="${path}/" target="_blank">쇼핑몰가기</a>
			</div>
			<div class="menu">
				<a href="${path}/member/logout">로그아웃</a>
			</div>
			<div class="menu">
				${memberInfo.mid}
			</div>
		</div>
	</header>
	<div class="allWrap">
	<div id="menuBar">
		<div id="memberManagementMenu" class="menu" onclick="location.href='${path}/admin/memberManagement'">
			신고관리
		</div>
		<div id="couponMenu" class="menu" onclick="location.href='${path}/admin/coupon'">
			쿠폰관리
		</div>
		<div id="reportGoodsMenu" class="menu" onclick="location.href='${path}/admin/reportGoods'">
			상품관리
		</div>
		<div id="advertiseMenu" class="menu" onclick="location.href='${path}/admin/advertise'">
			광고관리
		</div>
		<div id="serviceCenterMenu" class="menu" onclick="location.href='${path}/admin/serviceCenter'">
			고객센터
		</div>
	</div>

