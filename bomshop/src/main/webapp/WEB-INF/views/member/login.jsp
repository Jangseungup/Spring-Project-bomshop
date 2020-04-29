<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login.css">
<style>
/* 아이디 / 비밀번호 찾기 modal */
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
    	#modal_headText{
    		text-align: center;
    		margin-bottom : 15px;
    	}
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 40%; /* Could be more or less, depending on screen size */                          
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
        
        .login_find_wrap span:hover{
        	cursor : pointer;
        }
        
        input[type="email"]{
        	width : 400px;
        	height : 35px;
        	border-radius: 5px;
        	border : 1px solid gray;
        	margin-bottom : 15px;
        }
        
        #email_code{
        	width : 400px;
        	height : 35px;
        	border-radius: 5px;
        	border : 1px solid gray;
        	margin-bottom : 15px;
        }
        
        #mpw, #re_mpw{
        	width : 400px;
        	height : 35px;
        	border-radius: 5px;
        	border : 1px solid gray;
        	margin-bottom : 15px;
        }
        .first_input, .second_input, .third_input{
        	text-align: center;
        }
        
        
      #emailSubmitBtn, #emailcodeSubmitBtn, #passSubmitBtn {
        	background-color: #343a40;
			border-color: #343a40;
			border-radius: 5px;
			color : white;
			padding : 5px;
        }
</style>
</head>
<body>
<%-- <c:out value="<script>signOut();</script>" escapeXml="false"/> --%>
	<%@ include file="../common/header.jsp" %>
	<section>
		<div id="login_wrap">
			<div class="login_top_text">
				<span>오늘 사면 내일 도착!</span><br/>
				<span>값싼 배송으로 내일 받는 BOMSHOP LOGIN</span>
			</div>
			<div class="login_form_wrap">
				<form class="login_form" action="loginPost" method="POST">
					<table>
						<tr>
							<td>
								<input type="text" name="mid" placeholder="아이디 입력" required="required"/>
							</td>
						</tr>
						<tr>
							<td>
								<input type="password" name="mpw" placeholder="비밀번호 이력" required="required"/>
							</td>
							</tr>
							<tr>
							<td>
								<input type="submit" id="loginOKBtn" value="로그인"/><br/>
								<input type="button" id="joinGetBtn" onclick="javascript:location.href='member/license';" value="회원가입" />
							</td>
							</tr>
					</table>
				</form>
			</div>
			<div class="login_find_wrap">
				<span onclick="javascript:showfindModal();">아이디 | 비밀번호 찾기</span>
			</div>
			<br/>
			<hr/>
			<div class="login_social_wrap">
				<div>
					<span>간편로그인 / 가입</span>
				</div>
				<div class="login_social_button">
					<div id="naver_id_login" style="display:inline-block;"><a href="${url}">
						<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/></a>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<div id="confirmModal" class="modal">
		<div class="modal-content">
			<div>
				<span class="confirmcloseBtn">&times;</span>
			</div><br/>
			<div id="modal_headText">
				<span style="font-size:30px; font-weight: bold;">아이디 / 비밀번호 찾기</span>
			</div>
			<div class="first_input" id="first_input">
				<div style="text-align: center;margin-bottom:20px;">
					<span>인증코드를 받으실 Email을 입력해주세요.</span><br/>
				</div>
				<input type="email" name="email" id="email" placeholder=" Email을 입력해주세요." /><br/>
				<div>
					<button id="emailSubmitBtn">인증코드 발송</button>
				</div>
			</div>
			<div class="second_input" id="second_input">
				<div style="text-align: center;margin-bottom:20px;">
					<span>인증코드 확인</span>
				</div>
				<div>
					<input type="text" name="email_code" id="email_code" placeholder=" 인증코드를 입력해주세요."/><br/>
					<button id="emailcodeSubmitBtn">확인</button>
				</div>
			</div>
			<div class="third_input" id="third_input">
				<div style="text-align:center;margin-bottom:20px;">
					<span>비밀번호 재설정</span><br/>
					<span>찾으시는 아이디는 : </span><span id="idTarget"></span>
				</div>
				<input type="password" name = "mpw" id="mpw" placeholder=" 새 비밀번호를 입력해주세요."/><br/>
				<input type="password" name="re_mpw" id="re_mpw" placeholder=" 새 비밀번호를 다시한번 입력해주세요."/><br/>
				<button id="passSubmitBtn">확인</button>
			</div>
		</div>
	</div>
	
	<%@ include file="../common/footer.jsp" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		var member_id = '';
		var myEmail = '';
		$(function(){
			$("#second_input").hide();
			$("#third_input").hide();
		});
		
		function showfindModal(){
			$("#confirmModal").show();
			$("#first_input").show();
			$("#second_input").hide();
			$("#third_input").hide();
		}
		
		$(".confirmcloseBtn").click(function(){
			$("#confirmModal").hide();
		});
		
		$("#emailSubmitBtn").click(function(){
			myEmail = $("#email").val();
			// 인증코드 발송
			$.ajax({
				type : "GET",
				url : "customerService/mailFindSend",
				data : {
					email : myEmail
				},
				success : function(data){
					alert(data);
					$("#first_input").hide();
					$("#second_input").show();
					$("#third_input").hide();
				}
			});
		});
		
		$("#emailcodeSubmitBtn").click(function(){
			// 인증코드 입력
			var tempCode = "";
			// DB임시코드 받아오기
			$.ajax({
				type : "GET",
				url : "customerService/getMailFindCode",
				data : {email : myEmail},
				success : function(data){
					tempCode = data.code;
					console.log(tempCode);
					
					var inputCode = $("#email_code").val();
					
					if(tempCode == null || tempCode == ""){
						alert("임시코드가 제대로 생성되지 않았습니다.");	
					}
					if(tempCode == inputCode){
						$("#idTarget").html(data.memberID);
						member_id = data.memberID;
						$("#first_input").hide();
						$("#second_input").hide();
						$("#third_input").show();
					}else{
						alert("임시코드를 다시 확인해주세요!");
						$("#email_code").val("");
						$("#email_code").focus();
					}
					
				}
			});
		});
		
		$("#passSubmitBtn").click(function(){
			
			
			var mpw = $("#mpw").val();
			var re_mpw = $("#re_mpw").val();
			if(mpw != re_mpw){
				alert("비밀번호가 일치하지않습니다.");
				mpw.val('');
				re_mpw.val('');
				mpw.focus();
				return;
			}
			// 비밀번호 재설정
			$.ajax({
				type : "POST",
				url : "member/updatePasswordUsingID",
				data : {
					mid : member_id,
					mpw : $("#mpw").val()
				},
				success : function(data){
					alert(data);
					$("#first_input").hide();
					$("#second_input").hide();
					$("#third_input").hide();
					$("#confirmModal").hide();
				}
			});
		});
	</script>
</body>
</html>
