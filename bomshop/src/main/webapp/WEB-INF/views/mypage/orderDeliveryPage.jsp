<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.deliveryList_main{
	width : 760px;
		display: inline-block;
		text-align: left;
}
.deliveryTopExplain{
	border-top : 2px solid black;
		padding-top : 10px;
		margin-bottom : 50px;
		margin-top : 7px;
}
.deliveryExplainText{
	font-size : 13px;
		color : gray;
}
.searchDiv{
	border : 1px solid lightgray;
		padding : 20px;
		background-color: #F6F6F6;
		margin-bottom : 50px;
		border-radius: 10px;
}
.btn-s1{
	text-decoration: none;
		color : gray;
		font-size : 13px;
		font-weight: bold;
		border : 1px solid lightgray;
		padding : 6px;
		background-color: white;
		border-radius: 5px;
		display: inline-block;
}
.btn-s1:hover{
	cursor: pointer;
}
	
#search_all{
	background-color: gray;
	color : white;	
}

.deliveryTopText{
	font-size : 20px;
	font-weight: bold;
}
.deliveryListDiv{
	border-top : 2px solid black;
		margin-top : 7px;
		text-align: center;
}
.topShow_Div{
	display: inline-block;
	width : 700px;
	border : 2px solid gray;
	text-align: center;
	padding : 30px;
	margin-bottom : 50px;
	border-radius: 10px;
	font-weight: bold;
}
/* 주문/배송 리스트 테이블 */
.deliveryListTable{
	width : 760px;
}

.deliveryListTable tr th{
	border-bottom : 1px solid gray;
	height : 30px;
}

/* 테이블 내 버튼 (반품/교환/구매확정 버튼)*/
.tablebtn{
	border : 1px solid lightgray;
	colir : gray;
	font-size : 14px;
	padding : 5px;
}

.tablebtn:hover{
	cursor: pointer;
}

.tablebtn:active {
	background-color: lightgray;
}

.cntSpan{
	color : red;
	font-weight: bold;
}

/* 주문배송모달 */
.modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
    
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 40%; /* Could be more or less, depending on screen size */                          
        }
        .input_wrap{
        	margin-top : 50px;
        }
        .refundcloseBtn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .refundcloseBtn:hover,
        .refundcloseBtn:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        
        .exchangecloseBtn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .exchangecloseBtn:hover,
        .exchangecloseBtn:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        
         .purchaseCompletecloseBtn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .purchaseCompletecloseBtn:hover,
        .purchaseCompletecloseBtn:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        
         .cancelcloseBtn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .cancelcloseBtn:hover,
        .cancelcloseBtn:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        
         .confirmcloseBtn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .confirmcloseBtn:hover,
        .confirmcloseBtn:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

.submitBtn{
	width : 100px;
	height : 35px;
	font-size : 15px;
	background-color: #343a40;
	border-color: #343a40;
	border-radius: 5px;
	color : white;
}

#goReviewBtn, #goNoReviewBtn{
	width:150px;
}

#refund_reason, #exchange_reason{
	width : 250px;
	height : 40px;
	border-radius: 10px;
	font-size : 15px;
}

/* 리뷰 입력창 DIV */
.reviewInput{
	margin-top : 50px;
	margin-bottom : 50px;
}

#grade{
	width : 150px;
	height : 28px;
	border-radius: 5px;
	margin-bottom : 10px;
}

	.fileDrop{
		display:inline-block;
		width:150px;
		height:150px;
		border:1px solid lightgray;
		border-radius: 10px;
		margin-bottom : 10px;
		margin-top : 10px;
	}
	
	.fileDrop span:hover{
		cursor: default;
	}
	
	.uploadList span{
		font-size : 1.5em;
	}
	.uploadList span:hover{
		cursor : pointer;
	}
	.uploadList{
		margin-bottom : 10px;
	}

	#review_content{
		border-radius: 10px;
		border : 2px solid gray;
	}
	#review_content::placeholder{
		color : gray;
		text-align: center;
	}
	
	#load{
		text-decoration: none; 
		font-size:15px; 
		font-weight:bold;
		color:black; 
		padding:10px; 
		border:1px solid lightgray; 
		background-color: #F6F6F6; 
		border-radius: 10px; 
		display: inline-block;
	}
	
	#load:hover{
		cursor: pointer;
	}
</style>
<!-- 주문/배송 조회 페이지 -->
<div class="deliveryList_main">
	<div class = "topShow_Div" id="topShow_Div">
		<span>배송대기</span><span class="cntSpan">&nbsp;${deliveryCntVO.deliveryWaitCnt }</span> &nbsp;/&nbsp; 
		<span>배송중</span><span class="cntSpan">&nbsp;${deliveryCntVO.deliveryRunningCnt}</span> &nbsp;/&nbsp; 
		<span>배송완료</span><span class="cntSpan">&nbsp;${deliveryCntVO.deliveryCompleteCnt}</span> &nbsp;/&nbsp;
		<span>환불요청</span><span class="cntSpan">&nbsp;${deliveryCntVO.refundRequestCnt}</span> &nbsp;/&nbsp;
		<span>교환요청</span><span class="cntSpan">&nbsp;${deliveryCntVO.exchangeRequestCnt}</span>	&nbsp;/&nbsp;
		<span>거래취소</span><span class="cntSpan">&nbsp;${deliveryCntVO.cancellationCnt}</span>
	</div>
	<span class="deliveryTopText">주문/배송 조회</span><br/>
	<div class="deliveryTopExplain">
		<span class="deliveryExplainText">
		· 최근 1개월 내의 주문/배송 내역을 확인하실 수 있습니다.<br/>
		· 기간별 조회는 전체/7일/15일/30일로 구성되어 있습니다.<br/>
		· 배송이 완료된 상품일 경우 반품/교환 신청 및 구매확정을 하실 수 있습니다.<br/>
		</span>
	</div>
	
	<div class="searchDiv">
		<span style="color:gray;font-weight: bold; font-size:15px;">기간별 조회</span><br/><br/>
		<div class="btn-s1" id="search_all"><span class="search_value">전체</span></div>
		<div class="btn-s1" id="search_7d"><span class="search_value">7일</span></div>
		<div class="btn-s1" id="search_15d"><span class="search_value">15일</span></div>
		<div class="btn-s1" id="search_30d"><span class="search_value">30일</span></div>
	</div>
	
	<span class="deliveryTopText">주문/배송 내역</span><br/>
	<div class="deliveryListDiv" id="deliveryListDiv">
		<!-- 주문/배송 리스트  -->
	</div>
</div>

<!-- 반품신청 모달 -->
<div id="refundModal" class="modal">
	<div class="modal-content">
		<div>
			<span class="refundcloseBtn">&times;</span>
		</div>
		<div id="modal_headText">
			<span style="font-size:30px; font-weight: bold;">반품신청</span>
		</div>
		<div class="input_wrap" id="input_wrap">
			<select id="refund_reason">
				<option disabled selected>사유를 선택해주세요</option>
				<option value="1">단순변심</option>
				<option value="2">상품불량</option>
				<option value="3">사이즈변경</option>
				<option value="4">기타</option>
			</select>
			<br/><br/><br/><br/><br/><br/>
			<input type="button" id="refundSubmitBtn" class="submitBtn" value="신청"/>
		</div>
		<div class="result" id="result">
		</div>
	</div>
</div>

<!-- 교환신청 모달 -->
<div id="exchangeModal" class="modal">
	<div class="modal-content">
		<div>
			<span class="exchangecloseBtn">&times;</span>
		</div>
		<div id="modal_headText">
			<span style="font-size:30px; font-weight: bold;">교환신청</span>
		</div>
		<div class="input_wrap" id="input_wrap">
			<select id="exchange_reason">
				<option disabled selected>사유를 선택해주세요</option>
				<option value="1">단순변심</option>
				<option value="2">상품불량</option>
				<option value="3">사이즈변경</option>
				<option value="4">기타</option>
			</select>
			<br/><br/><br/><br/><br/><br/>
			<input type="button" id="ExchangeSubmitBtn" class="submitBtn" value="신청"/>
		</div>
		<div class="result" id="result">
		</div>
	</div>
</div>

<!-- 구매확정 모달 -->
<div id="purchaseCompleteModal" class="modal">
	<div class="modal-content">
		<div>
			<span class="purchaseCompletecloseBtn">&times;</span>
		</div><br/>
		<div id="modal_headText">
			<span style="font-size:30px; font-weight: bold;">리뷰작성</span>
		</div>
		<div class="input_wrap" id="input_wrap">
			<span style="font-size:13px; color : gray;">
				리뷰를 작성하시면 회원등급에 따른 포인트 적립률로 
				<br/>계산된 포인트를 받으실 수 있습니다.<br/>
				리뷰 작성이 완료되면 해당 상품 내역은 '구매내역' 페이지로 이동됩니다.<br/>
				리뷰 작성 여부와 작성하신 글 확인은 '구매내역' 페이지에서 확인가능합니다.<br/>
			</span>
			<div class="reviewInput">
				<div style="text-align: left;display: inline-block;width:515px;margin-bottom:5px;font-size:18px;font-weight: bold;"><span>리뷰</span></div>
				<textarea id="review_content" rows=3 cols=70 style="resize:none;" placeholder="리뷰를 200자 이내로 작성해주세요."></textarea><br/>
				<div class="fileDrop">
					<span style="font-size:12px;color:lightgray; line-height: 150px;">이미지추가</span>
				</div>
				<div class="uploadList">
					
				</div>
				<select id="grade" onchange="javascript:gradeOnChange();">
					<option disabled selected>평점선택</option>
					<option value="1">1점</option>
					<option value="2">2점</option>
					<option value="3">3점</option>
					<option value="4">4점</option>
					<option value="5">5점</option>
				</select>
				<div id="grade_img"></div>
			</div>
			<input type="button" id="purchaseCompleteSubmitBtn" class="submitBtn" value="작성완료"/>
		</div>
		
	</div>
</div>

<!-- 거래취소 모달 -->
<div id="cancelModal" class="modal">
	<div class="modal-content">
		<div>
			<span class="cancelcloseBtn">&times;</span>
		</div>
		<div id="modal_headText">
			<span style="font-size:30px; font-weight: bold;">거래취소</span>
		</div>
		<div class="input_wrap" id="input_wrap">
			<span style= "font-size:13px; color : gray;">
				※주의※ <br/>
				아직 주문자가 확인하지 않은 주문건에 대해 거래취소를 요청합니다.<br/>
				하단의 '확인' 버튼을 누르시면 해당 주문이 '즉시' 취소되며 '거래취소'상태로 변경됩니다.
			</span><br/><br/><br/><br/>
			<input type="button" id="cancelSubmitBtn" class="submitBtn" value="확인"/>
		</div>
		<div class="result" id="result">
		</div>
	</div>
</div>

<!-- review 작성 확인 모달 -->
<div id="confirmModal" class="modal">
	<div class="modal-content">
		<div>
			<span class="confirmcloseBtn">&times;</span>
		</div>
		<div id="modal_headText">
			<span style="font-size:30px; font-weight: bold;">구매확정</span>
		</div>
		<div class="input_wrap" id="input_wrap">
			<span style= "font-size:13px; color : gray;">
				※알림※ <br/>
				리뷰를 작성하시면 회원등급에 따른 포인트가 적립됩니다.<br/>
				회원등급은 '회원등급' 메뉴에서 확인이 가능합니다.<br/>
			</span><br/><br/><br/><br/>
			<input type="button" id="goReviewBtn" class="submitBtn" value="리뷰작성 하러가기"/>
			<input type="button" id="goNoReviewBtn" class="submitBtn" value="리뷰없이 구매확정"/>
		</div>
		<div class="result" id="result">
		</div>
	</div>
</div>


<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
var orderNo;
var gno;

$(function(){
	getDeliveryList("all");
	$("#deliveryListDiv table tr").slice(0,1).show();
	$("#load").click(function(e){
		console.log('#load');
		if($("#deliveryListDiv table tr:hidden").length==0){
			alert('더 이상 보여드릴 상품이 없습니다.');
		}
		e.preventDefault();
		$("#deliveryListDiv table tr:hidden").slice(0,1).show();
	});
});


$("#search_all").click(function(){
	$(this).css("background-color","gray");
	$(this).css("color","white");
	$("#search_7d").css("background-color","#F6F6F6");
	$("#search_7d").css("color","gray");
	$("#search_15d").css("background-color","#F6F6F6");
	$("#search_15d").css("color","gray");
	$("#search_30d").css("background-color","#F6F6F6");
	$("#search_30d").css("color","gray");
	getDeliveryList("all");
});

$("#search_7d").click(function(){
	$(this).css("background-color","gray");
	$(this).css("color","white");
	$("#search_all").css("background-color","#F6F6F6");
	$("#search_all").css("color","gray");
	$("#search_15d").css("background-color","#F6F6F6");
	$("#search_15d").css("color","gray");
	$("#search_30d").css("background-color","#F6F6F6");
	$("#search_30d").css("color","gray");
	getDeliveryList("7d");
	
});

$("#search_15d").click(function(){
	$(this).css("background-color","gray");
	$(this).css("color","white");
	$("#search_all").css("background-color","#F6F6F6");
	$("#search_all").css("color","gray");
	$("#search_7d").css("background-color","#F6F6F6");
	$("#search_7d").css("color","gray");
	$("#search_30d").css("background-color","#F6F6F6");
	$("#search_30d").css("color","gray");
	getDeliveryList("15d");
});

$("#search_30d").click(function(){
	$(this).css("background-color","gray");
	$(this).css("color","white");
	$("#search_all").css("background-color","#F6F6F6");
	$("#search_all").css("color","gray");
	$("#search_15d").css("background-color","#F6F6F6");
	$("#search_15d").css("color","gray");
	$("#search_7d").css("background-color","#F6F6F6");
	$("#search_7d").css("color","gray");
	getDeliveryList("30d");
});

function getDeliveryList(type){
	$.ajax({
		type : "GET",
		url : "mypage/getDeliveryList",
		data : {type : type},
		success : function(data){
			console.log(data);
			drawHtmlList(data);
		}
	});
}

function drawHtmlList(data){
	var target = $("#deliveryListDiv");
	var str = "";
	if(data.length <= 0){
		str += "<div style='margin-top : 20px;'>";
		str += "<span style='font-size:15px; font-weight : bold;'>";
		str += "주문/배송 진행 건이 없습니다.";
		str += "</span>";
		str += "</div>";
	}else{
		str += "<table class='deliveryListTable' id='deliveryListTable'>";
		str += "<tr>";
		str += "<th>주문일자</th><th>이미지</th><th>상품</th><th>가격</th><th>상태</th><th>비고</th>";
		str += "</tr>";
		for(var i=0; i < data.length; i++){
			if(data[i].order_status == 10){
				continue;
			}
			var date = new Date(data[i].orderdate).yyyymmdd();
			str += "<tr>";
			
			str += "<td>";
			str += date;
			str += "</td>";
			
			str += "<td>";
			str += "<img src='${pageContext.request.contextPath}/upload/"+data[i].gno+"/mainImg.jpg' width='150px'><br/>";
			str += "</td>";
			
			str += "<td>";
			str += "<span style='font-weight:bold;'>"+data[i].gname_ko+"</span><br/>(";
			str += "<span>색상 : "+data[i].color+"</span><br/>";
			str += "<span>사이즈 : "+data[i].size+"</span><br/>";
			str += "<span>수량 : "+data[i].count+"</span>";
			str += ")</td>";
			
			str += "<td>";
			str += (data[i].price).toLocaleString();
			str += "원</td>";
			
			str += "<td>";
			var statusText = "";
			switch(data[i].order_status){
			case 0:
				statusText = "배송대기";
				break;
			case 1:
				statusText = "배송중";
				break;
			case 2: 
				statusText = "배송완료";
				break;
			case 3:
				statusText = "환불요청";
				break;
			case 4: 
				statusText = "교환요청";
				break;
			case 5:
				statusText = "거래취소";
				break;
			case 6:
				statusText = "반품처리";
				break;
			case 7:
				statusText = "교환중";
				break;
				
			}
			str += "<span style='font-weight : bold;'>";
			str += statusText;
			str += "</span>";
			str += "</td>";
			
			str += "<td>";
			if(data[i].order_check == 'N'){
				if(data[i].order_status!=5){
					str += "<div class='tablebtn' onclick='javascript:cancelModal("+data[i].orderno+");'><span>주문취소</span></div>";
				}
			}else{
				if(data[i].order_status == 0){
					str += "<div class='tablebtn' onclick='javascript:cancelModal("+data[i].orderno+");'><span>주문취소</span></div>";
				}
			}
			
			if(data[i].order_status == 0 || data[i].order_status == 1 || data[i].order_status == 2){
				str += "<div class='tablebtn' onclick='javascript:refundModal("+data[i].orderno+");'><span>반품신청</span></div>";
			}
			if(data[i].order_status == 0 || data[i].order_status == 1 || data[i].order_status == 2){
				str += "<div class='tablebtn' onclick='javascript:exchangeModal("+data[i].orderno+");'><span>교환신청</span></div>";
			}
			if(data[i].order_status == 1 || data[i].order_status == 2){
				str += "<div class='tablebtn' onclick='javascript:confirmModal("+data[i].orderno+","+data[i].gno+");'><span>구매확정</span></div>";
			}
		
			
			str += "</td>";
			
			str += "</tr>";
		}
		str += "</table>";
		str += "<div id='load'>더보기</div>";
	}
	target.html(str);
	var element = $(target).find("table").find("tr");
	//$("table tr").slice(0,1).show();
	console.log(element);
	
	$(element).slice(0,1).show();
	
	console.log($("#deliveryListDiv table tr:hidden").length);
	console.log(element.length);
	//$(element).css("display","block");
	$("#load").click(function(e){
		
		if($("#deliveryListDiv table tr:hidden").length==0){
			alert('더 이상 보여드릴 상품이 없습니다.');
		}
		
		e.preventDefault();
		//$("table tr:hidden").slice(0,1).show();
	});
}

Date.prototype.yyyymmdd = function()
{
    var yyyy = this.getFullYear().toString();
    var mm = (this.getMonth() + 1).toString();
    var dd = this.getDate().toString();
 
    return yyyy +"-"+ (mm[1] ? mm : '0'+mm[0]) +"-"+ (dd[1] ? dd : '0'+dd[0]);
}

function refundModal(orderno){
	$("#refundModal").show();
	orderNo = orderno;
}

function exchangeModal(orderno){
	$("#exchangeModal").show();
	orderNo = orderno;
}

function purchaseCompleteModal(orderno,gNo){
	orderNo = orderno;
	gno = gNo;
}

function confirmModal(orderno,gNo){
	orderNo = orderno;
	gno = gNo;
	$("#confirmModal").show();
}

$("#goReviewBtn").click(function(){
	$("#purchaseCompleteModal").show();
	$("#confirmModal").hide();
});

$("#goNoReviewBtn").click(function(){
	// 이제 여기 리뷰 작성 x ajax 하면됨.
	$.ajax({
		type : "POST",
		url : "mypage/noReviewPurchaseComplete",
		data : {
			mno : '${memberInfo.mno}',
			orderno : orderNo
		},
		success : function(data){
			alert(data);
			$("#confirmModal").hide();
			location.href="mypage/main";
		}
	});
});

function cancelModal(orderno){
	$("#cancelModal").show();
	orderNo = orderno;
}

$(".confirmcloseBtn").click(function(){
	$("#confirmModal").hide();
});

$(".refundcloseBtn").click(function(){
	$("#refundModal").hide();
});

$(".exchangecloseBtn").click(function(){
	$("#exchangeModal").hide();
});

$(".purchaseCompletecloseBtn").click(function(){
	$("#purchaseCompleteModal").hide();
});

$(".cancelcloseBtn").click(function(){
	$("#cancelModal").hide();
});

/* 모달 안 신청완료 버튼(ajax) */
$("#refundSubmitBtn").click(function(){
	var refund_reason = $("#refund_reason option:selected").val();
	$.ajax({
		type : "POST",
		url : "mypage/refundSetReason",
		data : {
			status_reason : refund_reason,
			orderno : orderNo
			},
		success : function(data){
			alert(data);
			$("#refundModal").hide();
			getDeliveryList("all");
			$.ajax({
				type : "GET",
				url : "mypage/orderDeliveryCnt",
				success : function(data){
					printStatusCnt(data);	
				}
			});
		}
	});
});

$("#ExchangeSubmitBtn").click(function(){
	var exchange_reason = $("#exchange_reason option:selected").val();
	$.ajax({
		type : "POST",
		url : "mypage/exchangeSetReason",
		data : {
			status_reason : exchange_reason,
			orderno : orderNo
			},
		success : function(data){
			alert(data);
			$("#exchangeModal").hide();
			getDeliveryList("all");
			$.ajax({
				type : "GET",
				url : "mypage/orderDeliveryCnt",
				success : function(data){
					printStatusCnt(data);	
				}
			});
		}
	});
});

$("#cancelSubmitBtn").click(function(){
	$.ajax({
		type : "POST",
		url : "mypage/cancelTransaction",
		data : {orderno : orderNo},
		success : function(data){
			alert(data);
			$("#cancelModal").hide();
			getDeliveryList("all");
			$.ajax({
				type : "GET",
				url : "mypage/orderDeliveryCnt",
				success : function(data){
					printStatusCnt(data);	
				}
			});
		}
	});
});

$("#purchaseCompleteSubmitBtn").click(function(){
	// 1. 리뷰 쓰는거 여기 모달로 넣어서 보내주어 review 테이블에 넣기.
	// 2. 그 후 리뷰완료? 상태로 바꿔주기.
	$.ajax({
		type : "POST",
		url : "mypage/purchaseComplete",
		data : {
			mno : '${memberInfo.mno}',
			gno : gno,
			content : $("#review_content").val(),
			img : $(".uploadList span").attr("data-src"),
			grade : $("#grade option:selected").val(),
			orderno : orderNo
		},
		success : function(data){
			alert(data);
			$("#purchaseCompleteModal").hide();
			location.href='mypage/main';
		}
	});
});


function printStatusCnt(data){
	var target = $("#topShow_Div");
	var txt = "";
	txt += "<span>배송대기</span>";
	txt += "<span class='cntSpan'>&nbsp;"+data.deliveryWaitCnt+"</span>&nbsp;/&nbsp;";
	txt += "<span>배송중</span>";
	txt += "<span class='cntSpan'>&nbsp;"+data.deliveryRunningCnt+"</span>&nbsp;/&nbsp;";
	txt += "<span>배송완료</span>";
	txt += "<span class='cntSpan'>&nbsp;"+data.deliveryCompleteCnt+"</span>&nbsp;/&nbsp;";
	txt += "<span>환불요청</span>";
	txt += "<span class='cntSpan'>&nbsp;"+data.refundRequestCnt+"</span>&nbsp;/&nbsp;";
	txt += "<span>교환요청</span>";
	txt += "<span class='cntSpan'>&nbsp;"+data.exchangeRequestCnt+"</span>&nbsp;/&nbsp;";
	txt += "<span>거래취소</span>";
	txt += "<span class='cntSpan'>&nbsp;"+data.cancellationCnt+"</span>&nbsp;/&nbsp;";
	target.html(txt);
}

function gradeOnChange(){
	var selectedVal = $("#grade option:selected").val();
	var str = "";
	for(var i=0; i < selectedVal; i++){
		str += "<img src='${pageContext.request.contextPath}/resources/img/gradestar.png' width='50px;'>";
	}
	
	$("#grade_img").html(str);
}

/* image upload 관련 */
$(".fileDrop").on("dragenter dragover", function(event){
			event.preventDefault();
		});
		
		$(".fileDrop").on("drop",function(event){
			event.preventDefault();
			// DOM 객체에 브라우저를 통해 이벤트가 발생된 데이터의 실체 파일 정보를 가지고 옴
			var files = event.originalEvent.dataTransfer.files;
			var file = files[0];
			console.log(file);
			
			var maxSize = 10485760;	// 10MB
			
			if(maxSize < file.size){
				return;
			}
			
			var formData = new FormData();	// form으로 보낸것 처럼
			formData.append("file",file);
			formData.append("gno",gno);
			
			$.ajax({
				type : "POST",
				url : "mypage/reviewImageUpload",
				dataType : "text",
				contentType : false,
				processData : false,
				data : formData,
				success : function(data){
					console.log(data);
					var str = "";
					if(checkImageType(data)){
						str += "<div style='inline-block;'>";
						str += "<img src='displayFile?fileName="+data+"' target='_blank' width='150px'/>";
						str += "<span data-src='"+data+"'>&times;</span>";
						str += "</div>";
					}else{
						
					}
					$(".uploadList").append(str);
				},
				error : function(err){
					console.log(err);	
				}
			});
		});
		
		$(".uploadList").on("click","span",function(){
			var target = $(this);
			
			$.ajax({
				type : "POST",
				url : "mypage/deleteReviewImage",
				dataType : "text",
				data : {
					fileName : target.attr("data-src")
				},
				success : function(data){
					if(data == "DELETED") alert("삭제완료");
					
					target.parent("div").remove();
				}
			});
		});
		
		function getImageName(fileName){
			if(!checkImageType(fileName)){
				return;
			}
			
			console.log(fileName);
			
			// /2020/01/21/ 
			var front = fileName.substr(0,12);
			// /2020/01/21/** -> / 끝까지
			var end = fileName.substr(14);
			console.log(front + end);
			
			// or return fileName.replace("s_","");
			return front+end;
		}
		
		function getOriginalName(data){
			var idx = data.indexOf("_")+1;
			return data.substr(idx);
		}
		
		function checkImageType(fileName){
			var pattern = /jpg|gif|png|jpeg/i;
			return fileName.match(pattern);
		}
</script>