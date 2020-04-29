<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#memberGradePage_main table{
		text-align: center;
		display: inline-block;
		font-size : 15px;
		border-spacing: 0;
	}
	
	#memberGradePage_main table tr th{
		background-color: lightgray;
	}
	
	#memberGradePage_main table tr td,th{
		padding : 10px;
	}
	
	#memberGradePage_main{
		text-align: center;
	}
</style>
<div id="memberGradePage_main">
	<div>
		<span style="font-weight:bold;font-size:20px;">< 회원등급 ></span>
	</div>
	<br/>
	<div style="margin-bottom : 30px;">
	<!-- 
						0 			-> mgrade : 1 (default)아이언
		member gpoint : 10,000 이상	->	mgrade : 2 (브론즈) 
						100,000 이상	->	mgrade : 3 (실버)
						500,000 이상	->	mgrade : 4 (골드)
						1,000,000 이상	-> mgrade : 5 (플래티넘)
						5,000,000 이상	-> mgrade : 6 (다이아)
						10,000,000 이상	-> mgrade : 7 (VIP)
	 -->
		<table border=1>
			<tr>
				<th>회원ID</th>
				<th>현재등급 / 포인트적립(%)</th>
				<th>다음등급 / 포인트적립(%)</th>
				<th>등급 포인트</th>
				<th>다음 등급까지 남은 포인트</th>
				<th>남은 등급 유지기간</th>
			</tr>
			<tr>
				<td>${memberInfo.mid}</td>
				<td id="mgrade_TD"></td>
				<td id="nextgrade_TD"></td>
				<td>${memberInfo.gpoint}점</td>
				<td id="pointremain"></td>
				<td id="enddate"></td>
			</tr>
		</table>	
	</div>
	<div>
		<span style="font-weight: bold;">등급표/혜택</span><br/>
		<img src="${pageContext.request.contextPath}/resources/img/membergradeInfo.png">
	</div>
	<div style="text-align: left; width : 1200px; display: inline-block; margin-top:30px; padding-left:150px;">
		<span style="font-weight:bold;font-size:15px;">※회원등급 산정방식</span>
		<p style="font-size:12px;">
			· 등급 포인트는 구매하신 상품의 금액을 포인트로 전환됩니다. ex) 30,000원 상당의 상품 -> 30,000점<br/>
			· 등급별 필요 포인트 <br/>
			&nbsp;&nbsp;&nbsp; - 브론즈:<c:forEach var="i" begin="1" end="17" step="1">&nbsp;</c:forEach>0점<br/>
			&nbsp;&nbsp;&nbsp; - 아이언   : <c:forEach begin="1" end="8">&nbsp;</c:forEach>10,000점<br/>
			&nbsp;&nbsp;&nbsp; - 실버: <c:forEach begin="1" end="10">&nbsp;</c:forEach>100,000점<br/>
			&nbsp;&nbsp;&nbsp; - 골드: <c:forEach begin="1" end="10">&nbsp;</c:forEach>500,000점<br/>
			&nbsp;&nbsp;&nbsp; - 플래티넘 : &nbsp;1,000,000점<br/>
			&nbsp;&nbsp;&nbsp; - 다이아   :<c:forEach begin="1" end="4">&nbsp;</c:forEach> 5,000,000점<br/>
			&nbsp;&nbsp;&nbsp; - VIP   :<c:forEach begin="1" end="7">&nbsp;</c:forEach> 10,000,000점<br/><br/>
			 주의 )<br/>
			· 해당 포인트는 등급 산정에 필요한 포인트로 상품구입에 사용되는 마일리지 개념의 포인트와는 다름을 알려드립니다.<br/>
			· 해당 등급은 1년 기준으로 초기화되며, 기준은 매해 매년 말 (12월 31일)입니다.<br/>
			· 등급별 혜택은 위의 등급표/혜택표를 참고하여 주십시오.
			 
		</p>
	</div>
</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var currentgrade = "";	// 현재등급
	var nextgrade = "";	// 다음등급
	var gpoint = "";	// 다음등급까지 남은 포인트
	var enddate;
	$(function(){
		enddate = calDate();
		$("#enddate").text(enddate+"일");
		
		var mgradeText = '${memberInfo.mgrade}';
		currentgrade = cal_grade(Number(mgradeText),'${memberInfo.gpoint}');
		$("#mgrade_TD").text(currentgrade);
		$("#pointremain").text(gpoint+"점");
		
		if(Number(mgradeText) < 7){
			nextgrade = cal_grade(Number(mgradeText)+1,'${memberInfo.gpoint}');	
		}
		$("#nextgrade_TD").text(nextgrade);
		
		
	});
	function cal_grade(mgrade,gp){
		var mgradeTxt = "";
		switch(mgrade){
			case 1:
				mgradeTxt = "아이언";
				mgradeTxt += " / ";
				mgradeTxt += "0%";
				gpoint = 10000 - Number(gp);
				break;
			case 2:
				mgradeTxt = "브론즈";
				mgradeTxt += " / ";
				mgradeTxt += "1%";
				gpoint = 100000 - Number(gp);
				break;
			case 3:
				mgradeTxt = "실버";
				mgradeTxt += " / ";
				mgradeTxt += "2%";
				gpoint = 500000 - Number(gp);
				break;
			case 4:
				mgradeTxt = "골드";
				mgradeTxt += " / ";
				mgradeTxt += "3%";
				gpoint = 1000000 - Number(gp);
				break;
			case 5:
				mgradeTxt = "플래티넘";
				mgradeTxt += " / ";
				mgradeTxt += "5%";
				gpoint = 5000000 - Number(gp);
				break;
			case 6:
				mgradeTxt = "다이아";
				mgradeTxt += " / ";
				mgradeTxt += "7%";
				gpoint = 10000000 - Number(gp);
				break;
			case 7:
				mgradeTxt = "VIP";
				mgradeTxt += " / ";
				mgradeTxt += "10%";
				gpoint = 0;
				break;
		}
		return mgradeTxt;
	}
	function calDate(){
		var t = new Date();
		var nowYear = t.getFullYear();
		var theDay = new Date(nowYear,11,31);
		var diffDate = theDay - t;
		var result = Math.ceil(diffDate / (60*1000*60*24));
		return result;
	}

</script>