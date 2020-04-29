<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<style>
	.purchaseList_main{
		width : 760px;
		display: inline-block;
		text-align: left;
	}
	
	.purchaseTopText{
		font-size : 20px;
		font-weight: bold;
	}
	.purchaseTopExplain{
		border-top : 2px solid black;
		padding-top : 10px;
		margin-bottom : 50px;
		margin-top : 7px;
	}
	
	.puchaseExplainText{
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
	
	.purchaseListDiv{
		border-top : 2px solid black;
		margin-top : 7px;
		text-align: center;
	}
	
	.listWrap > div{
		display: inline-block;
		width:170px;
		height: 184px;
	}
	
	table tr th{
		border-bottom: 1px solid gray;
		padding-bottom: 10px;
	}
	
	table tr th:last-child{
		width:  100px;
	}
	
	table tr td:first-child {
		padding : 10px;
	}
	
	table tr{
		display: none;
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
<!-- 주문(구매) 내역 페이지 -->
<div class="purchaseList_main">
	<span class="purchaseTopText">최근 구매 상품</span><br/>
	<div class="purchaseTopExplain">
		<span class="puchaseExplainText">
		· 회원님께서 실제 구매하신 상품만 모아 놓은 페이지입니다.<br/>
		· 최근 1개월간 홈페이지를 통해 구매하신 내역을 확인하실 수 있습니다.<br/>
		· 반품/교환/구매확정 항목은 주문/배송 조회 페이지에서 신청이 가능합니다.<br/>
		</span>
	</div>
	
	<div class="searchDiv">
		<span style="color:gray;font-weight: bold; font-size:15px;">기간별 조회</span><br/><br/>
		<div class="btn-s1" id="search_all"><span class="search_value">전체</span></div>
		<div class="btn-s1" id="search_7d"><span class="search_value">7일</span></div>
		<div class="btn-s1" id="search_15d"><span class="search_value">15일</span></div>
		<div class="btn-s1" id="search_30d"><span class="search_value">30일</span></div>
	</div>
	
	<span class="purchaseTopText">최근 구매 내역</span><br/>
	<div class="purchaseListDiv" id="purchaseListDiv">
		<!-- 구매내역 리스트  -->
		<c:choose>
			<c:when test="${!empty purchaseList}">
				<table style="text-align: center; padding : 5px; width:760px;">
					<tr>
						<th>상품 이미지</th><th>상품</th><th>구매날짜</th><th>가격</th><th>구매확정일</th>
					</tr>
				<c:forEach var="p" items="${purchaseList}">
					<tr>
						<td>
							<img src="${pageContext.request.contextPath}/upload/${p.gno}/mainImg.jpg"
						  		width = "200px">
						</td>
						<td style="width:200px;">
							<span>${p.gname_ko}<br/>(색상:${p.color},<br/>사이즈:${p.size},<br/>수량:${p.count})</span>
						</td>
						<td>
							<span><f:formatDate value="${p.order_date}" pattern="yyyy-MM-dd"/></span>
						</td>
						<td>
							
							<span><f:formatNumber value="${p.price}" pattern="#,###"/>원</span>
						</td>
						<td>
							<span><f:formatDate value="${p.order_com_date}" pattern="yyyy-MM-dd"/></span>
						</td>
					</tr>
					</c:forEach>
				</table>
				<div id="load">더보기</div>
			</c:when>
			<c:otherwise>
				<div style="margin-top:20px;">
					<span style="font-size:15px; font-weight:bold;">구매내역이 없습니다.</span>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	
	$(function(){
		$("table tr").slice(0,5).show();
		$("#load").click(function(e){
			if($("table tr:hidden").length==0){
				alert('더 이상 보여드릴 상품이 없습니다.');
			}
			e.preventDefault();
			$("table tr:hidden").slice(0,5).show();
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
		// 여기 ajax 들..
		$.get("purchaseListAll",function(data){
			drawTable(data);
		});
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
		
		$.get("purchaseList7d",function(data){
			drawTable(data);
		});
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
		
		$.get("purchaseList15d",function(data){
			drawTable(data);
		});
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
		
		$.get("purchaseList30d",function(data){
			drawTable(data);
		});
	});
	
	function drawTable(data){
		var str = "";
		console.log(data.length == 0);
		if(data.length == 0){
			str += "<div>";
			str += "<span style='font-size:15px; font-weight:bold;''>구매내역이 없습니다.</span>";
			str += "</div>";
		}else{
			str += "<table style='text-align: center; padding : 5px; width:760px;''>";
			str += "<tr>";
			str += "<th>상품 이미지</th><th>상품</th><th>구매날짜</th><th>가격</th><th>구매확정일</th>";
			str += "</tr>";
			 for(var i=0; i<data.length; i++){
				var date = new Date(data[i].order_date).yyyymmdd();
				var comDate = new Date(data[i].order_com_date).yyyymmdd();
				str += "<tr>";
				
				str += "<td>";
				str += "<img src='${pageContext.request.contextPath}/upload/"+data[i].gno+"/mainImg.jpg' width = '200px;'>";
				str += "</td>";
				
				str += "<td style='width:200px;'>";
				str += "<span>"+data[i].gname_ko+"<br/>(색상:"+data[i].color+",<br/>사이즈:"+data[i].size+",<br/>수량:"+data[i].count+")</span>";
				str += "</td>";
				
				str += "<td>";
				str += date.toString();
				str += "</td>";
				
				str += "<td style='100px;'>";
				str += (data[i].price).toLocaleString();
				str += "원</td>";
				
				str += "<td>";
				str += comDate.toString();
				str += "</td>";
				
				str += "</tr>";
			}
			str += "</table>";
			str += "<div id='load'>더보기</div>";
		}	
		$("#purchaseListDiv").html(str);
		$("table tr").slice(0,5).show();
		$("#load").click(function(e){
			if($("table tr:hidden").length==0){
				alert('더 이상 보여드릴 상품이 없습니다.');
			}
			e.preventDefault();
			$("table tr:hidden").slice(0,5).show();
		});
	}
	
	Date.prototype.yyyymmdd = function()
	{
	    var yyyy = this.getFullYear().toString();
	    var mm = (this.getMonth() + 1).toString();
	    var dd = this.getDate().toString();
	 
	    return yyyy +"-"+ (mm[1] ? mm : '0'+mm[0]) +"-"+ (dd[1] ? dd : '0'+dd[0]);
	}
</script>
