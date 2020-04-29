<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<style>
.qnaAdmin_TopText{
		font-size : 21px;
		font-weight: bold;
	}
	
.qnaAdmin_content{
	margin-top : 10px;
	border-top : 2px solid black;
	padding : 20px;
}

.qna_title{
	width : 450px;
	height : 35px;
	border-radius: 4px;
	border : 1px solid gray;
}

.qna_textarea{
	border-radius: 4px;
}
</style>
<div class="qnaAdmin_main_wrap">
	<span class="qnaAdmin_TopText">1:1 문의</span>	
</div>

<div class="qnaAdmin_content">
	<form action="customerService/qnaAdminRegist" method="POST">
		<input type="hidden" name="mno" value="${memberInfo.mno}"/>
		<input type="text" class="qna_title" name="title" id="title" placeholder="제목을 입력해주세요."/><br/><br/>
		<textarea class="qna_textarea" name="content" cols="100" rows="20"></textarea>
		<div style="padding-left:320px;margin-top:40px;">
			<input type="submit" class="btn btn-dark" value="문의하기"/>
		</div>
	</form>
</div>