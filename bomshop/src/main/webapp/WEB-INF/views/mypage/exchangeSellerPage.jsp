<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<style>
	.exchangeSeller_wrap{
		display : inline-block;
		width : 760px;
		
	}
	
	.topText_wrap{
		text-align: left;
		border-bottom : 2px solid black;
		padding-bottom : 5px;
	}
	
	.topText{
		font-size : 20px;
		font-weight: bold;
	}
	
	.exchangeWarningExplain_wrap{
		text-align: left;
		margin-bottom : 50px;
		border-bottom: 1px solid gray;
		padding-bottom: 20px;
	}
	
	.exchangeWarningExplain_Text{
		font-size : 13px;
		color : gray;
	}
	
	#shopname, #shopurl, #shopphone, #maccount, #spw {
		width:350px;
		border : 1px solid lightgray;
		height : 35px;
		border-radius: 8px;	
		margin-bottom : 12px;
	}
	#address1{
		margin-top : 8px;
	}
	#address1,#address2{
		width:470px;
		margin-bottom : 8px;
	}
	#zipNo{
		width : 200px;
		border : 1px solid lightgray;
		height : 40px;
		border-radius: 8px;
	}
	
	#bankname{
		width : 200px;
		border : 1px solid lightgray;
		height : 40px;
		border-radius: 8px;
	}
	
	/* 은행선택 modal */
	.modals {
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
    
        .modal-contents {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 40%; /* Could be more or less, depending on screen size */                          
        }
        .input_wraps{
        	margin-top : 50px;
        }
        .bankInputcloseBtn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .bankInputcloseBtn:hover,
        .bankInputcloseBtn:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        
        .bankBtn{
        	padding : 7px;
        	background-color: #343a40;
        	color : white;
        	border-radius: 5px;
        	width : 100px;
        	height : 42px;
        }
        
        .banktable tr td{
        	padding : 5px;
        }
        
        #ex_typeSelect{
        	width : 200px;
        	height : 35px;
        	border-radius: 5px;
        	margin-bottom: 12px;
        }
</style>
<div class="exchangeSeller_wrap">
	<div class="topText_wrap">
		<span class="topText">판매자 전환</span>
	</div><br/>
	<div class="exchangeWarningExplain_wrap">
		<span class="exchangeWarningExplain_Text">
			· 한번 판매자로 전환하면 다시 일반 회원으로 돌아올 수 없으니 신중히 결정해 주세요.<br/>
			· 판매자로 전환 하더라도 일반 회원처럼 사이트를 이용가능합니다. <br/>
			· 판매자 전환 시 최상단 메뉴에 판매자 페이지가 생성되며, 판매자 페이지로 이동하여 상품관련 기능을 수행하실 수 있습니다.
			
		</span>
	</div>
	<div style="text-align: left; display: inline-block;">
		<form action="exchangeSeller" id="exchangeSellerForm" method="POST">
			<input type="hidden" name="mno" value="${memberInfo.mno}"/>
			<input type="text" name="shopname" id="shopname" placeholder=" 쇼핑몰(샵) 이름을 입력해주세요"/>
			<div class="result" id="shopnameResult"></div>
			<br/>
			<input type="text" name="shopurl" id="shopurl" placeholder=" 쇼핑몰 URL 주소를 입력해주세요" />
			<div class="result" id="shopurlResult"></div>
			<br/>
			<input type="number" name="shopphone" id="shopphone" placeholder=" 전화번호를 입력해주세요(-제외 숫자만 입력)"/>
			<div class="result" id="shopphoneResult"></div>
			<br/>
			<div id="addrDiv">
				<input type="text" class="zipNo" id="zipNo" name="zipNo"
					placeholder="  우편번호" readonly />
				<button type="button" class="btn btn-dark" id="modalBtn"
					data-target="#layerpop" data-toggle="modal">우편번호찾기</button>
			    <input type="text" class="form-control" id="address1"  name="address1" style="background-color: white;" readonly /> 
					<input type="text" class="form-control" id="address2" name="address2" style="background-color: white;" placeholder=" 상세 주소" />
			</div>
			<div class="result" id="addressResult"></div>
			<br/>
			<input type="text" name="bankname" id="bankname" placeholder=" 은행을 선택해주세요"/>
			&nbsp;&nbsp;<button type="button" class="btn-dark" style="border-radius: 5px; height:40px; margin-bottom: 7px;" id="inputBankBtn">은행 선택</button>
			<div class="result" id="banknameResult"></div>
			<br/>
			<input type="number" name="maccount" id="maccount" placeholder=" 계좌번호를 입력해주세요(- 제외 숫자만 입력)"/>
			<div class="result" id="maccountResult"></div>
			<br/>
			<input type="hidden" name="ex_type" id="ex_type"/>
			<select id="ex_typeSelect" onchange="javascript:exTypeSelectOnchange();">
				<option disabled selected>환전 방법 선택</option>
				<option value="0">금고 쌓기</option>
				<option value="1">계좌 송금</option>
			</select>
			<div class="result" id="ex_typeResult"></div>
			<br/>
			<input type="password" name="spw" id="spw" placeholder=" 통장비밀번호를 입력해주세요"/>
			<div class="result" id="spwResult"></div>
		</form>
		<div style="text-align: center; margin-top:50px;">
			<button id="submitBtn" class="btn btn-dark" style=" width : 150px;">전환하기</button>
		</div>
	</div>
</div>

<!-- 은행선택 모달 -->
<div id="bankInputModal" class="modals">
	<div class="modal-contents">
		<div>
			<span class="bankInputcloseBtn">&times;</span>
		</div>
		<div id="bankInputText">
			<span style="font-size:30px; font-weight: bold;">은행 선택</span>
		</div>
		<div class="input_wraps" id="input_wrap">
			<table style="display: inline-block;" class="banktable">
				<tr>
					<td><button class="bankBtn" onclick="javascript:bankInput('하나은행')">하나은행</button></td>
					<td><button class="bankBtn" onclick="javascript:bankInput('국민은행')">국민은행</button></td>
					<td><button class="bankBtn" onclick="javascript:bankInput('기업은행')">기업은행</button></td>
					<td><button class="bankBtn" onclick="javascript:bankInput('부산은행')">부산은행</button></td>
					<td><button class="bankBtn" onclick="javascript:bankInput('우리은행')">우리은행</button></td>
				</tr>
				<tr>
					<td><button class="bankBtn" onclick="javascript:bankInput('외환은행')">외환은행</button></td>
					<td><button class="bankBtn" onclick="javascript:bankInput('새마을금고')">새마을금고</button></td>
					<td><button class="bankBtn" onclick="javascript:bankInput('전북은행')">전북은행</button></td>
					<td><button class="bankBtn" onclick="javascript:bankInput('신한은행')">신한은행</button></td>
					<td><button class="bankBtn" onclick="javascript:bankInput('NH농협')">NH농협</button></td>
				</tr>
				<tr>
					<td><button class="bankBtn" onclick="javascript:bankInput('수협은행')">수협은행</button></td>
					<td><button class="bankBtn" onclick="javascript:bankInput('대구은행')">대구은행</button></td>
					<td><button class="bankBtn" onclick="javascript:bankInput('산업은행')">산업은행</button></td>
					<td><button class="bankBtn" onclick="javascript:bankInput('신협')">신협</button></td>
					<td><button class="bankBtn" onclick="javascript:bankInput('우체국')">우체국</button></td>
				</tr>
			</table>
		</div>
	</div>
</div>


<!-- 주소모달  -->
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

$("#inputBankBtn").click(function(){
	$("#bankInputModal").show();
});

$(".bankInputcloseBtn").click(function(){
	$("#bankInputModal").hide();
});

function bankInput(bankInputText){
	$("#bankname").val(bankInputText);
	$("#bankInputModal").hide();
}

function exTypeSelectOnchange(){
	var selectedVal = $("#ex_typeSelect option:selected").val();
	$("#ex_type").val(selectedVal);
}


//유효성 체크
$(function(){
	var boolShopname = false;
	var boolUrl = false;
	var boolShopPhone = false;
	var boolAddress = false;
	var boolBankCheck = false;
	var boolAccount = false;
	var boolExtype = false;
	var boolPassword = false;
	
	var regexPass = /^[0-9]{4,8}$/;	// 숫자 4~8자 이내
	var regexMobile = /^[0-9]{2,3}?[0-9]{3,4}?[0-9]{4}$/;			// mobile -표시 없이 숫자만
	var regexAccount = /^[0-9]{11,15}$/;
	var regexUrl = /(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;

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
	
	function checkAddr(){
		if($("#address1").val() !== ''
				&&
			$("#zipNo").val() !== ''
				&&
			$("#address2").val() !== ''){
			boolAddress = true;
		}else{
			boolAddress = false;
		}
	}
	
	function checkEx_type(){
		if($("#ex_type").val() !== ''){
			boolExtype = true;
		}else{
			boolExtype = false;
		}
	}
	
	$("#shopname").on("input",function(){
		var tempVal = $(this).val();
		var elP = $("#shopnameResult");
		var message = '';
		if(tempVal !== ''){
			message = "사용가능합니다.";
			showErrorMessage(elP,message,true);
			boolShopname = true;
		}else{
			message = "쇼핑몰(숍) 이름을 입력해주세요."
			showErrorMessage(elP,message,false);
			boolShopname = false;
		}
	});
	
	$("#shopurl").on("input",function(){
		var tempVal = $(this).val();
		var elP = $("#shopurlResult");
		var message = "URL 형식에 맞게 작성해주세요.";
		
		boolUrl = checkRegex(elP,tempVal,regexUrl,message,null);
	});
	
	$("#shopphone").on("input",function(){
		var tempVal = $(this).val();
		var elP = $("#shopphoneResult");
		var message = "-를 제외한 전화번호를 입력해주세요.";
		
		boolShopPhone = checkRegex(elP,tempVal,regexMobile,message,null);
	});
	
	$("#bankname").on("input",function(){
		var tempVal = $(this).val();
		var elP = $("#banknameResult");
		var message = '';
		if(tempVal == "하나은행" || tempVal == "국민은행" || tempVal == "기업은행" || tempVal == "부산은행" || tempVal == "우리은행" ||
				tempVal == "외환은행" || tempVal == "새마을금고" || tempVal == "전북은행" || tempVal == "신한은행" || tempVal == "NH농협" ||
				tempVal == "수협은행" || tempVal == "대구은행" || tempVal == "산업은행" || tempVal == "신협" || tempVal == "우체국"){
			message = "사용가능합니다.";
			showErrorMessage(elP,message,true);
			boolBankCheck = true;
		}else{
			message = "지원하는 은행이 아닙니다. 오른쪽 버튼을 눌러 은행을 선택해주세요.";
			showErrorMessage(elP,message,false);
			boolBankCheck = false;
		}
	});
	
	$("#maccount").on("input",function(){
		var tempVal = $(this).val();
		var elP = $("#maccountResult");
		var message = "-를 제외한 숫자형식으로 입력바랍니다.(11~15자리)";
		
		boolAccount = checkRegex(elP,tempVal,regexAccount,message,null);
	});
	
	
	$("#spw").on("input",function(){
		var tempVal = $(this).val();
		var elP = $("#spwResult");
		var message = "비밀번호는 숫자로 4~8자리를 입력해주세요.";
		
		boolPassword = checkRegex(elP,tempVal,regexPass,message,null);
	});
	
	$("#submitBtn").click(function(){
		checkAddr();
		checkEx_type();

		if(!boolShopname){
			alert("샵이름을 확인해주세요.");
			$("#shopname").focus();
		}else if(!boolUrl){
			alert("URL 형식을 확인해주세요.");
			$("#shopurl").focus();
		}else if(!boolShopPhone){
			alert("전화번호를 확인해주세요.");
			$("#shopphone").focus();
		}else if(!boolAddress){
			alert("주소를 확인해주세요.");
			$("#address2").focus();
		}else if(!boolAccount){
			alert("계좌번호를 확인해주세요.");
			$("#maccount").focus();
		}else if(!boolExtype){
			alert("환전방법을 확인해주세요.");
			$("#ex_type").focus();
		}else if(!boolPassword){
			alert("통장 비밀번호를 확인해주세요.");
			$("#spw").focus();
		}else{
			$("#exchangeSellerForm").submit();
		}
		
	});
	
});
</script>