<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.nonMemberOrder_wrap{
		text-align: center;
		min-height: 600px;
		padding-top : 100px;
	}
	
	.nonMemberOrder_content{
		display: inline-block;
	}
	
	.nonMember_inputDiv{
		padding : 20px;
	}
	
	.nonMember_input{
		height : 50px;
		border : 1px solid gray;
		border-radius: 5px;
		width : 550px;
	}
	
	.nonMemberSubmitBtn{
		height: 50px;
		width : 350px;
		font-size : 18px;
		background-color: #343a40;
		border : 1px solid #343a40;
		color : white;
		border-radius: 5px;
		margin-top : 70px;
	}

</style>


<%@include file="../common/header.jsp" %>
<section>	
	<div class="nonMemberOrder_wrap">
		<span style="display: block; font-size:40px; font-weight: bold; margin-bottom:50px;">비회원 주문조회</span>
		<div class="nonMemberOrder_content">
			<form action="nonMemberOrderCheck" method="post" id="nonMemberOrderCheckForm">
				<div class="nonMember_inputDiv">
					<input type="number" name="orderno" id="orderno" placeholder=" 주문번호를 입력해주세요." class="nonMember_input" />
					<div class="result"></div>
				</div>
				<div class="nonMember_inputDiv">
					<input type="text" name="order_email" id="order_email" placeholder=" 주문자 이메일을 입력해주세요." class="nonMember_input" />
					<div class="result"></div>
				</div> 
				<div class="nonMember_inputDiv">
					<input type="text" name="order_phone" id="order_phone" placeholder=" 주문자 전화번호를 입력해주세요." class="nonMember_input" />
					<div class="result"></div>
				</div>
				<div>
					<input type="button" id="nonMemberSubmitBtn" class="nonMemberSubmitBtn" value="주문확인"/> 
				</div>
			</form>
		</div>
	</div>
</section>
<script>

	var orderEmailBoolean = false;
	var orderPhoneBoolean = false;

	var regexEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;       // 이메일 정규식
	var regexMobile = /^[0-9]{2,3}?[0-9]{3,4}?[0-9]{4}$/;	//전화번호 정규식
	
	// 정규식 검사
	function checkRegex(elP,valP,regexP, messageP, ajaxP){
		if(regexP.test(valP) === false){
			showErrorMessage(elP,messageP,false);
			return false;
		}else if(regexP.test(valP) !== false && ajaxP === null){
			showErrorMessage(elP,"사용가능합니다.",true);
			return true;
		}else{
			if(ajaxP !== null){
				// ajax 실행
				ajaxP(elP);
			}
		}
	}
	
	// 메세지를 보여줄 요소, 메세지, 성공실패유무
	function showErrorMessage(elP, messageP,isChecked){
		var html = "<span style='margin-left:5px;font-size:16px; ";
		html += isChecked ? "color : green;" : "color : red;";
		html += "'>";
		html += messageP;
		html += "</span>";
		$(elP).html(html);
	}
	
	$("#order_email").on("input",function(){
		var tempVal = $(this).val();
		
		var elP = $(this).parent().find(".result");
		var message = "올바른 이메일 형식이 아닙니다.";
		
		orderEmailBoolean = checkRegex(elP,tempVal,regexEmail,message,null);
	});
	
	
	$("#order_phone").on("input",function(){
		var tempVal = $(this).val();
		
		var elP = $(this).parent().find(".result");
		var message = "번호는 -는 제외 숫자 형식으로 입력해주세요.";
		
		orderPhoneBoolean = checkRegex(elP,tempVal,regexMobile,message,null);
	});
	
	
	$("#nonMemberSubmitBtn").click(function(){
		if(orderPhoneBoolean && orderEmailBoolean){
			nonMemberOrderCheckForm.submit();
		}else{
			alert("형식에 맞는 정보가 필요합니다.");
		}
		
	});
</script>
<%@include file="../common/footer.jsp" %>
