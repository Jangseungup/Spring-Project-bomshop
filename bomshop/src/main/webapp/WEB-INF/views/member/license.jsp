<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#licenseCheck{
		position : relative;
		width:20px;
		height:27px;
		cursor: pointer;
		border : 2px solid gray;
		top : 2.5px;
	}
	label{
		position : relative;
		top:-2.5px;
	}
	#license1{
		overflow: scroll;
		width:700px;
		height : 300px;
		background-color: lightgray;
		border : 1px solid gray;
	}
	#license_wrap{
		text-align: center;
	}
	
	#licenseBtn{
		width : 300px;
	}
	
	
</style>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
</head>
<body>
<%@ include file="../common/header.jsp" %>
<%@ include file="./join_subtag_license.jsp" %>
<div id="license_wrap">
	<div>
		<div style="display:inline-block; margin-left:400px;">
		<input type="checkbox" id="licenseCheck"/>
		<label style="font-weight: bold; font-size:20px;" for="licenseCheck">BOMSHOP 약관 동의(필수)</label>
		</div>
	</div>
	<br/>
	<div style="display:inline-block;"><pre id="license1"></pre></div>
</div>
<div style="text-align: center; margin : 100px;">
	<input type="button" id="licenseBtn" class= "btn btn-dark" value="다음" />
</div>
<%@ include file="../common/footer.jsp" %>
</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$("#licenseBtn").click(function(){
		var check = $("#licenseCheck");
		if(check.is(":checked")==true){
			location.href="member/join";
		}else{
			alert("약관 동의가 필요합니다.");
		}
	});
	$(function(){
		$("#license1").load("${pageContext.request.contextPath}/resources/license/license1.txt");
	});

</script>
</html>