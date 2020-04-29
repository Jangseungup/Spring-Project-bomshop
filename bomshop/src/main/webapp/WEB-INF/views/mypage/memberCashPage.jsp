<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<style>
	.topText{
		font-size : 25px;
	}
	.cashText{
		color : red;
	}
	.mypageCash_explain{
		display: inline-block;
		text-align: left;
		margin-top : 50px;
		margin-bottom : 50px;
	}
	.mypageCash_explain span{
		font-size : 12px;
		text-align: left;
	}
	
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
            width: 50%; /* Could be more or less, depending on screen size */                          
        }
        .closeBtn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .closeBtn:hover,
        .closeBtn:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        
        .input_wrap input{
        	width : 400px;
        	margin-top : 30px;
        }
        
        .input_wrap input[type='button']{
        	margin-top : 150px;
        	width : 220px;
        }
        
        .input_wrap input[type='number'], input[type='password']{
        	border : 1px solid lightgray;
			height : 35px;
			border-radius: 8px;
        }
        
		input::placeholder{
			font-size : 13px;
			text-align: center;
		}
</style>
<div class="mypageCash_main">
	<div class="mypageCash_topText">
		<span class="topText">회원님의 현재 보유 캐쉬 금액은 <span class="cashText"><f:formatNumber  value="${memberInfo.cash}" pattern="#,###"/></span>원 입니다.</span>
	</div>
	<div class="mypageCash_explain">
		<span style="font-weight:bold;font-size:15px;">캐쉬 상세</span><br/>
		<span class="explain">
			· 본 사이트의 캐쉬는 현금과 동일하게 사용됩니다. ex) 현금 10,000원 = cash 10,000원<br/>
			· 사이트 특성상 모든 상품은 보유 캐쉬로만 결제가 가능합니다.<br/>
			· 한번 충전된 캐쉬는 환전이 불가능하니 신중하게 충전해 주시기 바랍니다.<br/>
			· 하단의 '충전하기' 버튼을 통해 충전이 가능합니다.<br/>
		</span>
	</div><br/>
	<button type="button" class="btn btn-dark" data-dismiss="modal" id="modalBtn">충전하기</button>
</div>

<div id="cashModal" class="modal">
	<div class="modal-content">
		<div>
			<span class="closeBtn">&times;</span>
		</div>
		<div id="modal_headText">
			<span style="font-size:30px; font-weight: bold;">충전하기</span>
		</div>
		<div class="input_wrap" id="input_wrap">
			<input type="number" name="cash" id="cashInput" placeholder="충전할 금액을 입력해주세요"/><br/>
			<input type="password" id="mpw" placeholder="비밀번호를 입력해주세요"/><br/>
			<input type="button" id="submitBtn" class="btn btn-dark" value="충전하기"/>
		</div>
		<div class="result" id="result">
		</div>
	</div>
</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$("#modalBtn").click(function(){
		$("#input_wrap").show();
		$("#modal_headText").show();
		$("#result").hide();
		$("#cashInput").val("");
		$("#mpw").val("");
		$("#cashModal").show();
		$("#cashInput").focus();
	});
	
	$(".closeBtn").click(function(){
		$("#cashModal").hide();
	});
	
	$("#submitBtn").click(function(){
		var cash = $("#cashInput").val();
		var mpw = $("#mpw").val();
		
		$.ajax({
			type : "POST",
			url : "mypage/cashCharge",
			dataType : "text",
			data : {
				cash : cash,
				mpw : mpw
			},
			success : function(data){
				var msg = data;
				var txt = "";
				txt += "<span style='font-size:20px;font-weight:bold;'>"+msg+"</span><br/>";
				txt += "<button class='btn btn-dark' onclick='javascript:okBtn();' style='margin-top : 30px;'>확인</button>";
				$("#input_wrap").hide();
				$("#modal_headText").hide();
				$("#result").html(txt);
				$("#result").show();
			}
		});
	});
	
	function okBtn(){
		location.href="main";
	};
</script>