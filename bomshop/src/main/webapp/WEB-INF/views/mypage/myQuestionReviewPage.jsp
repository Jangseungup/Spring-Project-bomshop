<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.myQuestionReview_main{
		width : 760px;
		display: inline-block;
		text-align: left;
	}
	
	#Question_Div, #Review_Div, #QuestionAdmin_Div{
		display: inline-block;
		border-radius: 5px;
		padding : 10px;
		border-bottom: none;
		font-size : 20px;
	}	
	
	#Question_Div:hover, #Review_Div:hover, #QuestionAdmin_Div:hover{
		cursor: pointer;
	}
	
	.QR_contentDiv{
		width : 760px;
		border : 1px solid lightgray;
		border-radius: 5px;
		border-top : 2px solid black;
		text-align: center;
	}
	
	.Q_table{
		width : 760px;
		text-align: center;
		padding : 10px;
	}
	
	.R_table{
		width : 760px;
		text-align: center;
		padding : 10px;
	}
	
	.Q_table tr th{
		border-bottom : 1px solid gray;
		padding-bottom : 10px;
		height : 35px;
	}
	
	.Q_table tr td{
		border-bottom : 1px solid lightgray;
		padding : 10px;
	}
	
	.Q_table tr:last-child td{
		border-bottom: none;
	}
	
	.R_table tr{
		
	}
	.R_table tr th{
		border-bottom : 1px solid gray;
		padding-bottom : 10px;
		height : 35px;
	}
	
	.R_table tr td{
		border-bottom : 1px solid lightgray;
		padding : 10px;
	}
	
	.R_table tr:last-child td{
		border-bottom: none;
	}
	
	.A_table {
		width : 760px;
		text-align: center;
		padding : 10px;
	}
	.A_table tr{
		
	}
	.A_table tr th{
		border-bottom : 1px solid gray;
		padding-bottom : 10px;
		height : 35px;
	}
	
	.A_table tr td{
		border-bottom : 1px solid lightgray;
		padding : 10px;
	}
	
	.A_table tr:last-child td{
		border-bottom: none;
	}
	
	/* 페이징 */
	
	.QR_pagingDiv{
		text-align: center;
	}
	.reviewPaging{
		height : 30px;
		display : inline-block;
		text-align: center;
		
	}
	.reviewPagingUl{
		list-style: none;
		
	}
	.reviewPagingUl li{
		float : left;
		border: 1px solid gray;
		width:30px;
		height:30px;
		margin : 1px;
	}
	.reviewPagingUl li a{
		text-decoration: none;
		color : black;
		line-height: 30px;
	}
</style>
<div class="myQuestionReview_main">
	<div class="QR_TopMenu">
		<div id="Question_Div">
			<span id="Question_MunuText">나의 상품문의</span>	
		</div>
		<div id="Review_Div">
			<span id="Review_MunuText">나의 리뷰</span>
		</div>
		<div id="QuestionAdmin_Div">
			<span id="QuestionAdmin_MunuText">나의 관리자문의</span>	
		</div>
	</div>
	<div class="QR_contentDiv" id="QR_contentDiv">
		
	</div>
	<div class="QR_pagingDiv" id="QR_paginDiv">
	
	</div>
</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var page = 1;
	$(function(){
		$("#Question_MunuText").css("font-weight","bold");
		$("#Question_Div").css("border","1px solid lightgray");
		$("#Question_Div").css("border-bottom","none");
		
		questionAjaxGetList(page);
	});
	
	$("#Question_Div").on("click",function(){
		$("#Question_MunuText").css("font-weight","bold");
		$("#Review_MunuText").css("font-weight","normal");
		$("#QuestionAdmin_MunuText").css("font-weight","normal");
		
		$("#Question_Div").css("border","1px solid gray");
		$("#Question_Div").css("border-bottom","none");
		
		$("#Review_Div").css("border","none");
		$("#QuestionAdmin_Div").css("border","none");
		questionAjaxGetList(page);
	});
	
	$("#Review_Div").on("click",function(){
		$("#Question_MunuText").css("font-weight","normal");
		$("#Review_MunuText").css("font-weight","bold");
		$("#QuestionAdmin_MunuText").css("font-weight","normal");
		
		$("#Review_Div").css("border","1px solid gray");
		$("#Review_Div").css("border-bottom","none");
		
		$("#Question_Div").css("border","none");
		$("#QuestionAdmin_Div").css("border","none");
		reviewAjaxGetList(page);
	});
	
	$("#QuestionAdmin_Div").on("click",function(){
		$("#QuestionAdmin_MunuText").css("font-weight","bold");
		$("#Review_MunuText").css("font-weight","normal");
		$("#Question_MunuText").css("font-weight","normal");
		
		$("#QuestionAdmin_Div").css("border","1px solid gray");
		$("#QuestionAdmin_Div").css("border-bottom","none");
		
		$("#Review_Div").css("border","none");
		$("#Question_Div").css("border","none");
		questionAdminAjaxGetList(page);
	});
	function questionAjaxGetList(page){
		$.ajax({
			type : "GET",
			url : "myquestionList",
			data : {
				page : page,
				mno : '${memberInfo.mno}'
			},
			success : function(data){
				printQuestionListHtml(data);
			}
		});
	}
	
	function reviewAjaxGetList(page){
		$.ajax({
			type : "GET",
			url : "myreviewList",
			data : {
				page : page,
				mno : '${memberInfo.mno}'
			},
			success : function(data){
				printReviewListHtml(data);
			}
		});
	}
	
	function questionAdminAjaxGetList(page){
		$.ajax({
			type : "GET",
			url : "myquestionAdminList",
			data : {
				page : page,
				mno : '${memberInfo.mno}'
			},
			success : function(data){
				printQuestionAdminListHtml(data);
			}
		});
	}
	
	function printQuestionListHtml(data){
		target = $("#QR_contentDiv");
		pagingTarget = $("#QR_paginDiv");
		var str = "";
		str += "<table class='Q_table'>";
		str += "<tr>";
		str += "<th>번호</th><th>상품번호</th><th>제목</th><th>등록일</th><th>답변유무</th>";
		str += "</tr>";
		var list = data.qList;
		if(list.length > 0){
			for(var i=0; i < list.length; i++){
				var date = new Date(list[i].regdate).yyyymmdd();
				str += "<tr>";
				str += "<td>";
				str += list[i].qno;
				str += "</td>";
				str += "<td>";
				str += list[i].gno;
				str += "</td>";
				str += "<td>";
				str += list[i].title;
				str += "</td>";
				str += "<td>";
				str += date.toString();
				str += "</td>";
				str += "<td>";
				str += list[i].re_check;
				str += "</td>";
				str += "</tr>";
			}
		}else{
			str += "<tr>";
			str += "<td colspan='5' style='padding:10px; padding-top:20px; font-weight : bold;'>";
			str += "등록된 문의가 없습니다.";
			str += "</td>";
			str += "</tr>";
		}
		str += "</table>";
		
		// 페이징 처리 부분
		var str2 = "";
		str2 += "<div class='reviewPaging'>";
		str2 += "<ul class='reviewPagingUl' id='reviewPagingUl'> ";
		var pm = data.pageMaker;
		if(pm.prev == true){
			str2 += "<li><a href='javascript:reviewAjaxGetList("+pm.startPage-1+");'></a><</li>"
		}
		
		for(var k=pm.startPage; k <= pm.endPage; k++){
			if(k == pm.cri.page){
				str2 += "<li><a href='#' style='color:red;font-weight:bold;'>"+k+"</a></li>";
			}else{
				str2 += "<li><a href='javascript:reviewAjaxGetList("+k+")'>"+k+"</a></li>";
			}
		}
		
		if(pm.next == true){
			str2 += "<li><a href='javascript:reviewAjaxGetList("+pm.endPage+1+")'></a>></li>"
		}
		str2 += "</ul>";
		str2 += "</div>";
		
		target.html(str);
		pagingTarget.html(str2);
	}
	
	function printReviewListHtml(data){
		console.log(data);
		console.log(data.rList);
		target = $("#QR_contentDiv");
		pagingTarget = $("#QR_paginDiv");
		var str = "";
		str += "<table class='R_table'>";
		str += "<tr>";
		str += "<th>번호</th><th>상품번호</th><th>이미지</th><th>내용</th><th>등록일</th><th>평점</th>";
		str += "</tr>";
		var list = data.rList;
		if(list.length > 0){
			for(var i=0; i < list.length; i++){
				var date = new Date(list[i].regdate).yyyymmdd();
				str += "<tr>";
				str += "<td>";
				str += list[i].rno;
				str += "</td>";
				str += "<td>";
				str += list[i].gno;
				str += "</td>";
				str += "<td>";
				str += "<img src='${pageContext.request.contextPath}/upload"+list[i].img+"' width='150px;'>";
				str += "</td>";
				str += "<td>";
				str += list[i].content;
				str += "</td>";
				str += "<td>";
				str += date.toString();
				str += "</td>";
				str += "<td>";
				 for(var j=0; j < Number(list[i].grade); j++){
					str += "<img src='${pageContext.request.contextPath}/resources/img/gradestar.png' width='25px;'>";
				} 
				str += "</td>";
				str += "</tr>";
			}
		}else{
			str += "<tr>";
			str += "<td colspan='6' style='font-weight:bold;padding:10px;padding-top:20px;'>";
			str += "등록된 리뷰가 없습니다.";
			str += "</td>";
			str += "</tr>";
		}
		str += "</table>";
		// 페이징 처리 부분
		var str2 = "";
		str2 += "<div class='reviewPaging'>";
		str2 += "<ul class='reviewPagingUl' id='reviewPagingUl'> ";
		var pm = data.pageMaker;
		if(pm.prev == true){
			str2 += "<li><a href='javascript:reviewAjaxGetList("+pm.startPage-1+");'></a><</li>"
		}
		
		for(var k=pm.startPage; k <= pm.endPage; k++){
			if(k == pm.cri.page){
				str2 += "<li><a href='#' style='color:red;font-weight:bold;'>"+k+"</a></li>";
			}else{
				str2 += "<li><a href='javascript:reviewAjaxGetList("+k+")'>"+k+"</a></li>";
			}
		}
		
		if(pm.next == true){
			str2 += "<li><a href='javascript:reviewAjaxGetList("+pm.endPage+1+")'></a>></li>"
		}
		str2 += "</ul>";
		str2 += "</div>";
		
		target.html(str);
		pagingTarget.html(str2);
		
	}
	
	function printQuestionAdminListHtml(data){
		target = $("#QR_contentDiv");
		pagingTarget = $("#QR_paginDiv");
		var str = "";
		str += "<table class='A_table'>";
		str += "<tr>";
		str += "<th>번호</th><th>제목</th><th>등록일</th><th>답변유무</th>";
		str += "</tr>";
		var list = data.aList;
		if(list.length > 0){
			for(var i=0; i < list.length; i++){
				var date = new Date(list[i].regdate).yyyymmdd();
				str += "<tr>";
					str += "<td>";
						str += list[i].qano;
					str += "</td>";
					str += "<td>";
						str += list[i].title;
					str += "</td>";
					str += "<td>";
						str += date.toString();
					str += "</td>";
					str += "<td>";
						str += list[i].re_check;
					str += "</td>";
				str += "</tr>";
			}
		}else{
			str += "<tr>";
			str += "<td colspan='4' style='font-weight:bold;padding:10px;padding-top:20px;'>";
			str += "등록된 문의가 없습니다.";
			str += "</td>";
			str += "</tr>";
		}
		str += "</table>"
		
			// 페이징 처리 부분
			var str2 = "";
			str2 += "<div class='reviewPaging'>";
			str2 += "<ul class='reviewPagingUl' id='reviewPagingUl'> ";
			var pm = data.pageMaker;
			if(pm.prev == true){
				str2 += "<li><a href='javascript:questionAdminAjaxGetList("+pm.startPage-1+");'></a><</li>"
			}
			
			for(var k=pm.startPage; k <= pm.endPage; k++){
				if(k == pm.cri.page){
					str2 += "<li><a href='#' style='color:red;font-weight:bold;'>"+k+"</a></li>";
				}else{
					str2 += "<li><a href='javascript:questionAdminAjaxGetList("+k+")'>"+k+"</a></li>";
				}
			}
			
			if(pm.next == true){
				str2 += "<li><a href='javascript:questionAdminAjaxGetList("+pm.endPage+1+")'></a>></li>"
			}
			str2 += "</ul>";
			str2 += "</div>";
			
			target.html(str);
			pagingTarget.html(str2);
	}
	
	Date.prototype.yyyymmdd = function()
	{
	    var yyyy = this.getFullYear().toString();
	    var mm = (this.getMonth() + 1).toString();
	    var dd = this.getDate().toString();
	 
	    return yyyy +"-"+ (mm[1] ? mm : '0'+mm[0]) +"-"+ (dd[1] ? dd : '0'+dd[0]);
	}
</script>