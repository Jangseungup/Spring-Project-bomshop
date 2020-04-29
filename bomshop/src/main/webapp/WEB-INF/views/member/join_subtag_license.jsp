<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.join_tag_wrap{
		width:100%;
		height : 159px;
		text-align: center;
		border-top : 1px solid black;
		border-bottom : 1px solid black;
		padding : 20px;
		margin-top:50px;
		margin-bottom:20px;
	}
	
	.join_tag_wrap div{
		display : inline-block;
		width : 200px;
		height : 100px;
		text-align : center;
		vertical-align : middle;
		margin-top : 10px;
	}
	
	.license{
		color : black;
		font-weight: bold;
		border-left : 1px solid black;
	}
	
	.join_regist{
		color : gray;
		border-left : 1px solid black;
		border-right : 1px solid black;
	}
	.join_complete{
		color : gray;
		border-right : 1px solid black;
	}
	.join_tag_wrap div img{
		margin-bottom : 7px;
	}
</style>
<div class="join_tag_wrap">
	<div class="license">
		<img src="${pageContext.request.contextPath}/resources/img/license.png" width="50px;" height="50px;"><br/>
		정보수집동의
	</div>
	<div class="join_regist">
		<img src="${pageContext.request.contextPath}/resources/img/regist.png" width="50px;" height="50px;"><br/>
		정보입력
	</div>
	<div class="join_complete">
		<img src="${pageContext.request.contextPath}/resources/img/complete.png" width="50px;" height="50px;"><br/>
		가입완료
	</div>
</div>