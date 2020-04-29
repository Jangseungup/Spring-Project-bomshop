<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.customer_service_nav{
		margin : 0;
		display : inline-block;
		width : 22%;
		float : left;
	}	
	
	.customer_service_main{
		margin : 0;
		display : inline-block;
		width : 65%;
		float : left;
	}
	.nav_menu{
		padding-left : 50px;
	}
	
	.nav_menu ul{
		text-decoration: none;
		list-style: none;
	}
	
	.nav_menu  ul  li{
		padding : 10px;
	}
	
	.nav_main_menu{
		font-size : 18px;
		font-weight: bold;
		color : black;
	}
	
	.nav_main_menu > li{
		padding : 20px;
	}
	
	.nav_main_menu a{
		text-decoration: none;
		color : black;
	}
	
	.nav_sub_menu{
		font-size : 15px;
		font-weight: normal;
	}
	
	#main_content{
		padding : 50px;
	}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	<section class="customer_service_section">

		<div class="customer_service_nav">
			<div class="nav_menu">
				<div style="display: inline-block; text-align: left;">
				<ul class="nav_main_menu">
					<li><a href="javascript:serviceMovePage('FAQpageall');">● FAQ / 자주묻는 질문</a>
						<ul class="nav_sub_menu">
							<li><a href="javascript:serviceMovePage('FAQpage1');">- 취소/환불/교환 관련</a></li>
							<li><a href="javascript:serviceMovePage('FAQpage2');">- 주문/결제/배송 관련</a></li>
							<li><a href="javascript:serviceMovePage('FAQpage3');">- 리뷰 관련</a></li>
						</ul>
					</li>
					<li><a href="javascript:serviceMovePage('mypage/qnaAdminRegistPage');">● 1:1 문의</a></li>
					<li><a href="javascript:serviceMovePage('mypage/myQuestionReviewPage');">● 나의 문의/리뷰내역</a></li>
				</ul>
				</div>
			</div>
		</div>
		<div class="customer_service_main">
			<div id="main_content">
			
			</div>
		</div>	

	</section>	
	<div style="clear:both;"></div>
	<jsp:include page="../common/footer.jsp"/>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	$(function(){
		serviceMovePage("mypage/FAQpageall");
	});
	function serviceMovePage(url){
	    $.ajax({
	    	type : "POST",
	    	url : url,
	    	dataType : "html",
	    	cache : false,
	    	async : true,
	    	success : function(data){
	    		 // Contents 영역 삭제
	            $('#main_content').children().remove();
	            // Contents 영역 교체
	            $('#main_content').html(data);
	    	}
	    });
	}
	</script>
</body>
</html>