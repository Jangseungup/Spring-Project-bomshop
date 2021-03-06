<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String zipNo; //우편번호
	String roadAddr; //도로명 주소
	String jibunAddr; //지번 주소
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>

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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/join.css">
<body>
<%@ include file="../common/header.jsp" %>
<section>
	<div class="join_wrap">
	<h1>회원가입</h1>
	<%@ include file="./join_subtag_regist.jsp" %>
	<form action="join" method="post" id="joinForm">
		<input type="hidden" name="zipNo" value="${zipNo}" />
		<table>
			<tr>
				<td><input type="text" name="mid" id="mid" placeholder="  아이디 입력" />
					<input type="button" name="idCheckBtn" id="idCheckBtn" class="btn btn-dark" value="중복확인" />
					<div class="result"></div>
				</td>
			</tr>
			<tr>
				<td><input type="email" id="memail" name="memail" placeholder="  이메일 입력" />
					<input type="button" name="emailCheckBtn" id="emailCheckBtn" class="btn btn-dark" value="중복확인" /><br />
					<div class="result"></div>
					<span style="font-size:13px;">&nbsp;&nbsp;&nbsp;이메일 정보는 비밀번호 찾기 시 사용됩니다.</span>
					
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" name="mpw" id="mpw" placeholder="  비밀번호 입력" />
					<div class="result"></div>
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" name="mpw_check" id="mpw_check" placeholder="  비밀번호 확인" />
					<div class="result"></div>
				</td>
			</tr>
			<tr>
				<td>
					<div id="addrDiv">
						<input type="text" class="zipNo" id="zipNo" name="zipNo"
							placeholder="  우편번호" readonly />
						<button type="button" class="btn btn-dark" id="modalBtn"
							data-target="#layerpop" data-toggle="modal">우편번호찾기</button>
						<br /> <br /> <input type="text" class="form-control" id="address1"  name="address1" style="background-color: white;" readonly /> 
							<input type="text" class="form-control" id="address2" name="address2" style="background-color: white;" placeholder="  상세 주소" />
					</div>
				</td>
			</tr>
		</table>
		<div style="text-align: center; margin-top:60px;">
			<input type="button" id="joinBtn" class="btn btn-dark" value="회원가입" />
		</div>

	</form>


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
		</div>
	</section>
	<%@ include file="../common/footer.jsp" %>
</body>
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
	
	// 유효성 체크
	$(function(){
		var boolID = false;
		var boolEmail = false;
		var boolPassword = false;
		var boolPasswordCheck = false;
		var boolAddress = false;
		// 중복확인 확인.
		var boolIdCheck = false;
		var boolEmailCheck = false;
		
		var regexEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;       // 이메일
		var regexPass = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;			// 영문,숫자를 혼합하여 6~20자 이내
		var regexID = /^.*(?=.{8,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;			// 영문,숫자를 혼합하여 8~20자 이내
		
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
		
		$("#mid").on("input",function(){
			var tempVal = $(this).val();
			
			var elP = $(this).parent().find(".result");
			var message = "아이디는 8~20자 이내로 작성이 가능합니다.";
			
			boolID = checkRegex(elP,tempVal,regexID,message,null);
		});
		
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
		
		$("#mpw_check").on("input",function(){
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
		
		$("#idCheckBtn").click(function(){
			var idVal = $("#mid").val();
			$.ajax({
				type : "GET",
				url : "member/idCheck",
				data : {
					mid : idVal
				},
				success : function(data){
					boolIdCheck = data;
					if(boolIdCheck){
						// true : 사용가능한 아이디
						alert("사용가능한 아이디입니다.");
					}else{
						alert("이미 중복된 아이디가 존재합니다.");
					}
				}
			});
		});
		
		$("#emailCheckBtn").click(function(){
			var emailVal = $("#memail").val();
			$.ajax({
				type : "GET",
				url : "member/emailCheck",
				data : {
					memail : emailVal
				},
				success : function(data){
					boolEmailCheck = data;
					if(boolEmailCheck){
						alert("사용가능한 이메일입니다.");
					}else{
						alert("이미 중복된 이메일이 존재합니다.");
					}
				}
			});
		});
		
		$("#joinBtn").click(function(){
			checkAddr();
			
			if(!boolID){
				alert("아이디를 확인해주세요.");
				$("#mid").focus();
			}else if(!boolEmail){
				alert("이메일을 확인해주세요.");
				$("#memail").focus();
			}
			else if(!boolPassword){
				alert("비밀번호를 확인해주세요");
				$("#mpw").focus();
			}
			else if(!boolPasswordCheck){
				alert("비밀번호를 확인해주세요");
				$("#mpw_check").focus();
			}
			else if(!boolAddress){
				alert("주소를 확인해주세요");
				$("#address2").focus();
			}
			else if(!boolIdCheck){
				alert("아이디 중복확인을 해주세요");
				$("#idCheckBtn").focus();
			}else if(!boolEmailCheck){
				alert("이메일 중복확인을 해주세요");
				$("#emailCheckBtn").focus();
			}else{
	
				$("#joinForm").submit();
			}
		});
	});
</script>
</html>