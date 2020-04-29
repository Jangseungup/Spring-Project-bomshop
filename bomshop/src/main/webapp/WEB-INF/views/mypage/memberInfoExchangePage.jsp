<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%
	String zipNo; //우편번호
	String roadAddr; //도로명 주소
	String jibunAddr; //지번 주소
%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<style>
	.infoExchange_main{
		text-align: center;
	}
	.topTag_wrap{
		width : 750px;
		display : inline-block;
		text-align: left;
		padding-bottom : 20px;
		border-bottom: 1px solid lightgray;
	}
	.topTag_wrap div{
		display: inline-block;
		color : deepgray;
		width : 150px;
		text-align: center;
	}
	
	.topTag_wrap div:first-child{
		border-right: 1px solid black;
	}
	
	.topTag_wrap div:hover{
		color : black;
		font-weight : bold;
		cursor : pointer;
	}
	
	.context_main{
		text-align : center;
	}
	
	.content_wrap{
		width : 750px;
		display: inline-block;
		padding: 30px;
	}
	
	.infoExchange_content input{
		width : 250px;
		margin : 5px;
		text-align: center;
		
	}
	
	.deliveryInfo{
		padding : 5px;
		border-top : 2px solid black;
		margin-bottom : 30px;
	}
	
	.mainAddr_Div{
		margin-top : 5px;
		border-top : 2px solid black;
		border-bottom : 1px solid gray;
		height : 80px;
		margin-bottom : 30px;
	}
	
	.addrList_Div{
		margin-top : 5px;
		border-top : 2px solid black;
	}
	
	.addrList_Div table{
		width : 690px;
		text-align: center;
	}
	.addrList_Div table tr th{
		border-bottom : 1px solid gray;
	}
	.addrList_Div table tr td{
		padding : 3px;
		border-bottom : 1px solid lightgray;
		font-size : 13px;
	}
	
	.addrAddDiv{
		border : 1px solid gray;
		padding : 20px;
		margin-top:30px;
		margin-bottom:30px;	
		border-radius : 10px;
	}
	
	.addrAddDiv input{
		width:350px;
		border : 1px solid lightgray;
		height : 35px;
		border-radius: 8px;
	}
	
	 #address1,#address2{
		width:480px;
	}
</style>

<div class="infoExchange_main">
	<div class="topTag_wrap">
		<div>
			<span onclick="javacript:changeDiv('info');" id="infoTxt">개인정보 변경</span>
		</div>
		<div>
			<span onclick="javacript:changeDiv('addr');" id="addrTxt">배송지 편집</span>
		</div>
	</div>
</div>

<div class="content_main">
	<div class="content_wrap">
		<div class="infoExchange_content" id="infoExchange_content">
			<div>
				<form action="infoExchange" method="post">
					<div class="first_input" id="first_input">
						<div>
							<input type="email" name="memail" id="memail" value="${memberInfo.memail}"/>
							<div class="result"></div>
						</div>
						<div>
							<input type="password" id="mpw" name="mpw" placeholder="새 비밀번호를 입력해주세요."/>
							<div class="result"></div>
						</div>
						<div>
							<input type="password" id="re_mpw" placeholder="새 비밀번호 확인"/>
							<div class="result"></div>
						</div>
						<div>
							<input type="button" class="btn btn-dark" id="firstBtn" value="변경하기"/>
						</div>
					</div>
					<div class="second_input" id="second_input">
						<div>
							<span style="font-weight: bold;">${memberInfo.memail}</span><span> 에서 인증코드를 확인하여 입력해주세요.</span>
						</div>
						<div>
							<input type="text" name="email_code" id="email_code" placeholder="인증코드를 입력해주세요."/><br/>
							<input type="button" id="submitBtn" value="확인" class="btn btn-dark"/>
						</div>
					</div>
				</form>			
			</div>
		</div>
		<div class="addrExchange_content" id="addrExchange_content">
			<div style="text-align:left;">
				<span style="font-size:20px; font-weight:bold;">배송지 관리</span><br/>
				<div class="deliveryInfo">
					<span style="font-size:14px; color:gray;">
						· 기본 배송지는 고객님께서 마지막으로 선택하신 배송지입니다.<br/>
						· 배송 받을 주소를 선택하고 [기본 배송지로 선택] 버튼을 누르시면 배송지가 변경됩니다.<br/>
						· 등록된 배송지 수정, 삭제 및 신규 배송지 등록이 가능합니다.
					</span>
				</div>
				<span style="font-weight:bold;">기본 배송지</span><br/>
				<div class="mainAddr_Div">
					<div style = "display: inline-block; background-color: lightgray; height : 77px;">
						<span style="line-height: 80px; height : 100%; font-size : 13px; font-weight:bold; padding-left : 10px; padding-right : 10px;">기본 배송지</span>
					</div>
					<div style="display: inline-block;">
						<span style="font-size : 13px; line-height: 80px;" id="mainAddrSpan">
							<c:set var="doneloop" value="false"/>
							<c:forEach var="addr" items="${addrList}">
								<c:if test="${not doneloop}">
									<c:choose>
										<c:when test="${addr.memo eq '기본주소지'}">
											(${addr.post_code})${addr.addr1}&nbsp;${addr.addr2}
											<c:set var="doneloop" value="true"/>
										</c:when>	
									</c:choose>
								</c:if>
							</c:forEach>
							<c:if test="${doneloop eq false}">
										기본배송지가 설정되어있지 않습니다.
									</c:if>
						</span>
					</div>
				</div>
				
				<div class="addrAddDiv" id="addrAddDiv">
					<div>
						<input type="text" name="memo" id="addrMemo" placeholder="  배송지 명을 입력해주세요   ex)집" style="padding-left:8px;"/>
					</div>
					<div id="addrDiv">
						<input type="text" class="zipNo" id="zipNo" name="zipNo"
							placeholder="  우편번호" style="padding-left:8px;"readonly />
						<button type="button" class="btn btn-dark" id="modalBtn"
							data-target="#layerpop" data-toggle="modal">우편번호찾기</button>
						<br /> <br /> <input type="text" class="form-control" id="address1"  name="address1" style="background-color: white;" readonly /> 
							<input type="text" class="form-control" id="address2" name="address2" style="background-color: white;" placeholder="  상세 주소" />
					</div>
					<div style="text-align: center;margin-top:30px;">
						<input type="button" id="addrAddOkBtn" value="추가하기" class="btn btn-dark" style="width:150px;"/>
					</div>
				</div>
				
				<span>배송지 목록</span>
				<div class="addrList_Div" id="addrList_Div">
					<table>
						<tr>
							<th></th>
							<th>배송지 이름</th>
							<th>우편번호</th>
							<th>주소</th>
							<th>상세주소</th>
						</tr>
						<c:choose>
							<c:when test="${!empty addrList}">
								<c:forEach var="addr" items="${addrList}">
									<tr>
										<td>
											<input type="radio" name="addrSelect" value="${addr.memo}" <c:if test="${addr.memo eq '기본주소지'}"><c:out value="checked"/></c:if>/>
										</td>
										<td>${addr.memo}</td>
										<td>${addr.post_code}</td>
										<td>${addr.addr1}</td>
										<td>${addr.addr2}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6"><span style="font-weight: bold;">배송지 정보가 없습니다.</span></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
				<div class="addrBtn_wrap" style="text-align:center;margin-top : 30px;">
					<input type="button" id="addrAddBtn" class="btn btn-dark" value="새 배송지 추가"/>
					<input type="button" id="addrDelBtn" class="btn btn-dark" value="선택 배송지 삭제"/>
					<input type="button" id="setMainAddrBtn" class="btn btn-dark" value="기본주소지로 설정"/> 
				</div>
			</div>
		</div>
		<div class="shopExchange_content" id="shopExchange_content">
			<div style="text-align: left;">
				<h1>개인샵 편집</h1>
			</div>
			<div>
			
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="layerpop">
				<div class="modal-dialog">
					<div class="modal-content">
						<!-- header -->
						<div class="modal-header">
							<!-- header title -->
							<h4 class="modal-title">주소검색</h4>
							<!-- 닫기(x) 버튼 -->
							<button type="button" class="close" data-dismiss="modal">×</button>

						</div>
						<!-- body -->
						<div class="modal-body">

							<input type="hidden" id="currentPage" value="1" /> <input
								type="hidden" id="countPerPage" value="5" /> <input type="text"
								class="searchAddr" id="searchAddr" onkeydown="enterSearch();"
								width="50px" placeholder="도로명주소" />
							<button type="button" id="search" class="btn btn-dark">검색</button>
							<div
								style="margin-top: 10px; height: 300px; border: 1px solid red;">

								<table id="list">

								</table>
							</div>
							<div id="pagingList" style="text-align: center;"></div>
						</div>

						<!-- Footer -->
						<div class="modal-footer">
							<div style="margin-right: 45%;">
								<button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
				</div>
			</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var currentContent = "info";	// or addr or shop
	var infoDiv = $("#infoExchange_content");
	var addrDiv = $("#addrExchange_content");
	var shopDiv = $("#shopExchange_content");
	
	var regexEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;       // 이메일
	var regexPass = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;			// 영문,숫자를 혼합하여 6~20자 이내
	
	var boolEmailCheck = false;
	var boolPassword = false;
	var boolPasswordCheck = false;
	var boolEmail = false;
	
	
	$(function(){
		// 배송지 추가관련
		$("#addrAddDiv").hide();
		
		$("#addrAddBtn").click(function(){
			$("#addrAddDiv").show();	
		});
		
		$("#addrAddOkBtn").click(function(){
			var memoVal = $("#addrMemo").val();
			var post_codeVal = $("#zipNo").val();
			var addr1Val = $("#address1").val();
			var addr2Val = $("#address2").val();
			
			if(memoVal == '' || memoVal == null){
				alert("주소 메모를 작성해주세요.");
				$("#addrMemo").focus();
				return;
			}
			
			if(memoVal =='기본주소지'){
				alert("메모로 \'기본주소지\'를 작성할 수 없습니다. 하단의 버튼을 통해 설정해주시길 바랍니다.");
				$("#addrMemo").val("");
				return;
			}
			
			if($("#address1").val() == ''
				||
			$("#zipNo").val() == ''
				||
			$("#address2").val() == ''){
			alert("주소를 작성해주세요.");
			$("#address2").focus();
			return;
		}
			
			
			$.ajax({
				type : "POST",
				url : "member/addAddrInfo",
				data : {
					mno : '${memberInfo.mno}',
					memo : memoVal,
					post_code : post_codeVal,
					addr1 : addr1Val,
					addr2 : addr2Val 
				},
				success : function(data){
					var str = makeAddrHtml(data);
					$("#addrList_Div").html(str);
					$("#addrAddDiv").hide();
				}
			});
		});
		
		$("#addrDelBtn").click(function(){
			var memo = $("input:radio[name='addrSelect']:checked").val();
			$.ajax({
				type : "POST",
				url : "member/addrDelete",
				data : {
					mno : '${memberInfo.mno}',
					memo : memo
				},
				success : function(data){
					alert("주소가 삭제되었습니다.");
					var str = makeAddrHtml(data);
					$("#addrList_Div").html(str);
				}
			});
		});
		
		$("#setMainAddrBtn").click(function(){
			var memo = $("input:radio[name='addrSelect']:checked").val();
			$.ajax({
				type : "POST",
				url : "member/setMainAddr",
				data : {
					mno : '${memberInfo.mno}',
					memo : memo
				},
				success : function(data){
					alert("선택된 주소가 '기본주소지'가 되었습니다.");
					var str2 = makeAddrHtml(data);
					for(var i=0; i < data.length; i++){
						var memotmp = data[i].memo;
						if(memotmp == '기본주소지'){
							var str3 = "("+data[i].post_code+")"+data[i].addr1+" "+data[i].addr2;
							$("#mainAddrSpan").html(str3);
							break;
						}
					}
					$("#addrList_Div").html(str2);
				}
			});
		});
		
		function makeAddrHtml(data){
			var str = "";
			str += "<table>";
			str += "<tr>";
			str += "<th></th><th>배송지 이름</th><th>우편번호</th><th>주소</th><th>상세주소</th>";
			str += "</tr>";
			if(data.lenth <= 0){
				str += "<tr>";
				str += "<td colspan='6'><span style='font-weight: bold;'>배송지 정보가 없습니다.</span></td>";
				str += "</tr>";	
			}else{
				for(var i=0; i < data.length; i++){
					str += "<tr>";
					str += "<td>";
					str += "<input type='radio' name='addrSelect' value='"+data[i].memo+"' " ;
					if(data[i].memo == '기본주소지') str+= "checked";
					str += "/>";
					str += "</td>";
					str += "<td>"+data[i].memo+"</td>";
					str += "<td>"+data[i].post_code+"</td>";
					str += "<td>"+data[i].addr1+"</td>";
					str += "<td>"+data[i].addr2+"</td>";
					str += "</tr>";		
				}	
			}
			str += "</table>";
			return str;
		}
		//-----------
		changeDiv(currentContent);
		$("#second_input").hide();
		$("#first_input").show();
		
		$("#memail").on("input",function(){
			var tempVal = $(this).val();
			
			var elP = $(this).parent().find(".result");
			var message = "올바른 이메일 형식이 아닙니다.";
			
			boolEmail = checkRegex(elP,tempVal,regexEmail,message,null);
		});
		
		/* 비밀번호 유효성 검사 */
		$("#mpw").on("input",function(){
			var tempVal = $(this).val();
			var elP = $(this).parent().find(".result");
			var message = "영문/숫자 조합하여 6~20자 이내 작성";
			boolPassword = checkRegex(elP,tempVal,regexPass,message,null);
		});
		
		$("#re_mpw").on("input",function(){
			var tempVal = $(this).val();
			var elP = $(this).parent().find(".result");
			var originVal = $("#mpw").val();
			var message = "";
			
			if(boolPassword){
				if(tempVal == originVal){
					boolPasswordCheck = true;
					message = "비밀번호가 일치합니다.";
				}else{
					boolPasswordCheck = false;
					message = "비밀번호가 일치하지 않습니다.";
				}
			}else{
				boolPasswordCheck = false;
				message = "비밀번호를 확인하세요.";
			}

			showErrorMessage(elP,message,boolPasswordCheck);
		});
	});
	
	function changeDiv(currentContent){
		if(currentContent == "info"){
			infoDiv.show();
			addrDiv.hide();
			shopDiv.hide();
			$("#infoTxt").css("font-weight","bold");
			$("#addrTxt").css("font-weight","normal");
			$("#shopTxt").css("font-weight","normal");
		}else if(currentContent == "addr"){
			infoDiv.hide();
			addrDiv.show();
			shopDiv.hide();
			$("#addrTxt").css("font-weight","bold");
			$("#infoTxt").css("font-weight","normal");
			$("#shopTxt").css("font-weight","normal");
		}else{
			infoDiv.hide();
			addrDiv.hide();
			shopDiv.show();
			$("#shopTxt").css("font-weight","bold");
			$("#addrTxt").css("font-weight","normal");
			$("#infoTxt").css("font-weight","normal");
		}
	}
	$("#firstBtn").click(function(){
		$("#second_input").show();
		$("#first_input").hide();
		$.ajax({
			type : "GET",
			url : "mailSend",
			success : function(data){
				alert(data);
			}
		});
	});
	
	// 마지막 코드 확인 후 정보 갱신
	$("#submitBtn").click(function(){
		var tempCode = "";
		// DB임시코드 받아오기
		$.ajax({
			type : "GET",
			url : "mypage/getMailCode",
			data : {mno : '${memberInfo.mno}'},
			success : function(data){
				tempCode = data;
				console.log(tempCode);
				
				var inputCode = $("#email_code").val();
				
				if(tempCode == null || tempCode == ""){
					alert("임시코드가 제대로 생성되지 않았습니다.");	
				}
				
				if(tempCode == inputCode){
					var oldEmail = '${memberInfo.memail}';
					var newEmail = $("#memail").val();
					if(oldEmail != newEmail){
						// 이메일도 변경 - 이메일 중복체크 후 정보 갱신
						$.ajax({
							type : "GET",
							url : "member/emailCheck",
							data : {
								memail : newEmail
							},
							success : function(data){
								boolEmailCheck = data;
								if(boolEmailCheck){
									alert("사용가능한 이메일입니다.");
									// 이제 여기서 정보 갱신하라고 하면됨..!
									$.ajax({
										type : "POST",
										url : "member/updateAll",
										data : {
											mno : '${memberInfo.mno}',
											memail : newEmail,
											mpw : $("#mpw").val()
										},
										success : function(data){
											alert(data);
											location.href='mypage/main';
										}
									});
								}else{
									alert("이미 중복된 이메일이 존재합니다.");
									location.href="mypage/main";
									return;
								}
							}
						});	
					}else{
						// 이메일 변경 x 비밀번호 정보 갱신
						$.ajax({
							type : "POST",
							url : "member/updatePassword",
							data : {
								mno : '${memberInfo.mno}',
								mpw : $("#mpw").val()
							},
							success : function(data){
								alert(data);
								location.href='mypage/main';
							}
						});
					}
					/* 
					$.ajax({
						type : "POST",
						url : "mypage/infoExchangePost",
						data : {
							memail : $("#memail").val(),
							mpw : $("#mpw").val()
						},
						success : function(data){
							alert("data");
							location.href="mypage/main";
						}
					}); */
				}else{
					alert("임시코드를 다시 확인해주세요!");
					$("#email_code").val("");
					$("#email_code").focus();
				}
				
			}
		});
		
	
		
	});
	
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
		var html = "<span style='margin-left:5px;font-size:12px; ";
		html += isChecked ? "color : green;" : "color : red;";
		html += "'>";
		html += messageP;
		html += "</span>";
		$(elP).html(html);
	}

</script>

<script>
var currentPage = $("#currentPage").val();
var countPerPage = $("#countPerPage").val();
//키보드 enter키 입력
function enterSearch() {
	var evt_code = (window.netscape) ? event.which : event.keyCode;
	if (evt_code == 13) {

		event.keyCode = 0;

		getAddr(currentPage);

	}
}

$("#modalBtn").click(function() {
	$("#searchAddr").val("");
	$("#list").html("");
	$("#pagingList").html("");
});

$("#search").click(function() {
	getAddr(currentPage);
});

// 주소 open API에 요청해서 주소값 가져오기. 
function getAddr(page) {
	//(api 호출 전에 검색어 체크)
	var keyword = document.getElementById("searchAddr");
	//alert(keyword.value+","+keyword.value.length+","+currentPage+","+countPerPage);
	if (!checkSearchedWord(keyword)) {
		return;
	}
	$.ajax({
		url : "http://www.juso.go.kr/addrlink/addrLinkApiJsonp.do",
		type : "post",
		data : {
			confmKey : "devU01TX0FVVEgyMDIwMDIwOTIyMTk1ODEwOTQ1MjU=",
			currentPage : page,
			countPerPage : countPerPage,
			keyword : keyword.value,
			resultType : "json"
		},
		dataType : "jsonp",
		crossDomain : true,
		success : function(jsonStr) {

			$("#list").html("");
			var errCode = jsonStr.results.common.errorCode;
			var errDesc = jsonStr.results.common.errorMessage;

			if (errCode == "0") {
				if (jsonStr != null) {
					makeListJson(jsonStr);
				}
			} else {
				alert(errCode + "=" + errDesc);
			}
		},
		error : function(xhr, status, error) {
			alert("에러발생");
		}
	});
}

// 주소 정보 -> table에 넣기 
function makeListJson(jsonStr) {
	var htmlStr = "<thead><tr><th style='width:70px;'>우편번호</th><th>주소</th></tr></thead><tbody>";
	if (jsonStr.results.common.totalCount > 0) {
		$("#totalCnt").show();
		$("#totalCnt").html(jsonStr.results.common.totalCount);
		$(jsonStr.results.juso)
				.each(
						function() {
							zipNo = this.zipNo; //우편번호
							roadAddr = this.roadAddr; //도로명 주소
							jibunAddr = this.jibunAddr //지번 주소
							htmlStr += "<tr>";
							htmlStr += "<td id='zipNum'>";
							htmlStr += "<a href='javascript:; onClick='inputTextAddress(\""
									+ zipNo
									+ "\", \""
									+ roadAddr
									+ "\");'>";
							htmlStr += zipNo;
							htmlStr += "</a>";
							htmlStr += "</td>";
							htmlStr += "<td>";
							htmlStr += "<a href='javascript:;' id='roadAddr' data-dismiss='modal' onClick='inputTextAddress(\""
									+ zipNo
									+ "\", \""
									+ roadAddr
									+ "\");'>";
							htmlStr += roadAddr;
							htmlStr += "</a>";
							htmlStr += "</td>";
							htmlStr += "</tr>";
						});
		pageMake(jsonStr);
	} else {
		htmlStr += "<tr><td colspan='2'>조회된 데이터가 않습니다.<br/>다시 검색하여 주시기 바랍니다.</td></tr>";
	}
	htmlStr += "</tbody>";

	$("#list").html(htmlStr);
}

// 클릭된 주소 정보 가져와 text에 넣기
function inputTextAddress(zipcode, address) {
	$("#zipNo").val(zipcode);
	$("#address1").val(address);
	//getAddr(currentPage);
	$("#pagingList").html("");
}
// 주소검색창 - 특수문자 제거
function checkSearchedWord(obj) {

	if (obj.value.length > 0) {
		// 특수문자 제거
		var expText = /[%=><]/;
		if (expText.test(obj.value) == true) {
			alert("특수문자를 입력 할수 없습니다.");
			obj.value = obj.value.split(expText).join("");
			return false;

		}

		// 특정문자열(sql예약어의 앞뒤공백포함) 제거

		var sqlArray = new Array(
		"OR", "SELECT", "INSERT", "DELETE", "UPDATE", "CREATE"
		, "DROP", "EXEC", "UNION", "FETCH", "DECLARE", "TRUNCATE"
		);

		// sql 예약어

		var regex = "";
		for (var num = 0; num < sqlArray.length; num++) {
			regex = new RegExp(sqlArray[num], "gi");
			if (regex.test(obj.value)) {
				alert("\"" + sqlArray[num] + "\"와(과) 같은 특정문자로 검색할 수 없습니다.");
				obj.value = obj.value.replace(regex, "");
				return false;
			}
		}
	}
	return true;
}

function pageMake(jsonStr) {

	var total = jsonStr.results.common.totalCount; // 총건수

	var pageNum = document.getElementById("currentPage").value; // 현재페이지

	var pageBlock = Number(document.getElementById("countPerPage").value); // 페이지당 출력 개수
	console.log("total : " + total + " pageBlock : " + pageBlock
			+ " pageNum : " + pageNum);
	var paggingStr = "";

	// 검색 갯수가 페이지당 출력갯수보다 작으면 페이징을 나타내지 않는다.

	if (total > pageBlock) {
		console.log("크면 들어옴");
		var totalPages = Math.floor((total - 1) / pageNum) + 1;
		console.log("totalPages : " + totalPages);
		var firstPage = Math.floor((pageNum - 1) / pageBlock) * pageBlock + 1;

		console.log("firstPage : " + firstPage);

		if (firstPage <= 0) {
			firstPage = 1;
		}

		var lastPage = (firstPage - 1) + pageBlock;
		console.log("lastPage : " + lastPage);

		if (lastPage >= totalPages) {
			lastPage = totalPages;
		}

		var nextPage = lastPage + 1;

		var prePage = firstPage - pageBlock;

		if (firstPage > pageBlock) {
			console.log(prePage);
			paggingStr += "<a href='javascript:;' onClick='goPage(" + prePage + ");'>◀</a>";
			paggingStr += "&nbsp;";
		}

		for (var num = firstPage; lastPage >= num; num++) {
			if (pageNum == num) {
				paggingStr += "<a style='font-weight:bold;color:#0000FF;' href='javascript:;'>"
						+ num + "</a>";
				paggingStr += "&nbsp;";

			} else {
				paggingStr += "<a href='javascript:;' onClick='goPage("
						+ num + ");'>" + num + "</a>";
				paggingStr += "&nbsp;";
			}
		}

		if (lastPage < totalPages) {
			paggingStr += "<a href='javascript:;' onClick='goPage("
					+ nextPage + ");'>▶</a>";
		}
	}
	$("#pagingList").html(paggingStr);

}

// 페이징 이동
function goPage(pageNum) {
	document.getElementById("currentPage").value = pageNum;
	getAddr(pageNum);
}
</script>