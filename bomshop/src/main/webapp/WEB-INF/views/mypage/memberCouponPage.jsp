<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	#couponPage_main{
		text-align:center;
	}
	#couponCnt_div{
		text-align:left;
	}
	#couponCnt_div span{
		font-size : 26px;
	}
	#couponCntSpan{
		color : red;
	}
	#couponList_div{
		margin-top : 10px;
		border-top : 2px solid black;
	}
	#couponList_div table{
		width:750px;
		border-collapse: collapse;
	}
	#couponList_div table tr th{
		border-bottom : 1px solid gray;
		padding : 10px;
	}
	#couponList_div table tr td{
		border-bottom : 1px solid lightgray;
		padding : 10px;
	}
	
	#CouponPaging{
		height : 30px;
		text-align: center;
		display: inline-block;
	}
	.pagingUl{
		list-style: none;
		
	}
	.pagingUl li{
		float : left;
		border: 1px solid gray;
		width:30px;
		height:30px;
		margin : 1px;
	}
	.pagingUl li a{
		text-decoration: none;
		color : black;
		line-height: 30px;
	}
	
	.couponInput{
		display : inline-block;
		border: 1px solid lightgray;
		border-radius : 7px;
		width : 500px;
		padding : 30px;
		margin-bottom: 80px;
		background-color: #F6F6F6;
	}
	
	.couponInput span{
		font-weight: bold;
		margin-right: 50px;
	}
	
	.couponInput input[type="text"]{
		width : 300px;
		height: 30px;
		border-radius: 7px;
		border : 1px solid gray;
	}
	
	.couponInput input[type="button"]{
		padding : 8px;
		border-radius: 8px;
		border : 1px solid lightgray;
		color : white;
		background-color: #343a40;
	}
	
</style>
<div id="couponPage_main">
	<div style="display: inline-block; width:750px;">
	
		<!-- 쿠폰입력 -->
		<div id="couponInput" class="couponInput">
			<span>쿠폰입력</span><input type="text" id="couponCode" placeholder=" 쿠폰을 입력해주세요."/>
			<input type="button" id="couponInputBtn" value="확인" class="couponInputBtn"/>
		</div>
		
		<div id="couponCnt_div">
			<span>발급 받은 쿠폰</span><span id="couponCntSpan"> ${couponCnt}</span><span>장</span>
			<span style="font-size:15px; font-weight: normal; color:gray">* 유효기간이 지난 쿠폰은 목록에서 삭제됩니다.</span>
		</div>
		<div id="couponList_div">
			<table id="target">
				<tr>
					<th>쿠폰명</th>
					<th>할인 금액</th>
					<th>적용 기준</th>
					<th>유효 기간</th>
				</tr>
				<!-- coupon List -->
				<c:choose>
					<c:when test="${empty couponList}">
						<tr>
							<td colspan="5">보유하신 쿠폰이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="coupon" items="${couponList}">
							<tr>
								<td>${coupon.cname}</td>
								<td><f:formatNumber value="${coupon.sale}" pattern="#,###" /> 원</td>
								<td><span id="limitText"><f:formatNumber value="${coupon.climit}" pattern="#,###" /> 원 이상 구매시</span></td>
								<td>~<f:formatDate value="${coupon.cdate}" pattern="yyyy-MM-dd"/></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>				
			</table>
		</div>
		<div id = "CouponPaging">
			<ul class="pagingUl" id="pagingUl">
				<c:if test="${pageMaker.prev}">
					<li><a href="javascript:pageExchange('${pageMaker.startPage-1})"><</a></li>
				</c:if>
				<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<c:choose>
						<c:when test="${pageMaker.cri.page eq i}">
							<li><a href="#" style="color:red;font-weight:bold;">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="javascript:pageExchange('${i}')">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${pageMaker.next}">
					<li><a href="javascript:pageExchange('${pageMaker.endPage+1}')">></a></li>
				</c:if>
			</ul>
		</div>
	</div>
</div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function pageExchange(page){
		$.ajax({
			type : "GET",
			url : "mypage/getPageList",
			data : {
				page : page
			},
			success : function(data){
				var txt = "";
				txt += "<tr><th>쿠폰명</th><th>할인 금액</th><th>적용 기준</th><th>유효 기간</th></tr>";
				for(var i=0; i<data.length; i++){
					var date = new Date(data[i].cdate).yyyymmdd();
					txt += "<tr>";
					txt += "<td>"+data[i].cname+"</td>";
					txt += "<td>"+(data[i].sale).toLocaleString()+"원</td>";
					txt += "<td><span id='limitText'>"+(data[i].climit).toLocaleString()+"원 이상 구매시</span></td>";
					txt += "<td>~"+date.toString()+"</td>";
					txt += "</tr>";
				}
				$("#target").html(txt);
				pageMakerExchange(page);
			}
		});	
	}
	function pageMakerExchange(page){
		$.ajax({
			type : "GET",
			url : "mypage/getPageMaker",
			data : {
				page : page
			},
			success : function(data){
				var txt = "";
				
				if(data.prev){
					txt += "<li><a href='javascript:pageExchange("+(data.startPage-1)+")'><</a></li>";
				}
				
				for(var i=data.startPage; i <= data.endPage; i++){
					if(data.cri.page == i){
						txt += "<li><a href='#' style='color:red;font-weight:bold;'>"+i+"</a></li>";
					}else{
						txt += "<li><a href='javascript:pageExchange("+i+")'>"+i+"</a></li>";	
					}
				}
				
				if(data.next){
					txt += "<li><a href='javascript:pageExchange("+(data.endPage+1)+")'>></a></li>";
				}
				$("#pagingUl").html(txt);
			}
		});
	}
	
	Date.prototype.yyyymmdd = function()
	{
	    var yyyy = this.getFullYear().toString();
	    var mm = (this.getMonth() + 1).toString();
	    var dd = this.getDate().toString();
	 
	    return yyyy +"-"+ (mm[1] ? mm : '0'+mm[0]) +"-"+ (dd[1] ? dd : '0'+dd[0]);
	}
	
	// 쿠폰 입력
	$("#couponInputBtn").click(function(){
		var couponCode = $("#couponCode").val();
		if(couponCode == '' || couponCode == null){
			alert('코드를 입력해주세요.');
			return;
		}
		
		$.ajax({
			type : "POST",
			url : "mypage/couponCodeInput",
			data : {
				mno : '${memberInfo.mno}',
				coupon_code : couponCode
			},
			success : function(data){
				alert(data);
				if(data == "쿠폰 등록 성공"){
					pageExchange(1);
				}
			}
		});
		$("#couponCode").val('');
	});

</script>