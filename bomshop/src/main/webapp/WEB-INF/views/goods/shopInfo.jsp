<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
	.shopInfoWrap{
		min-height: 300px;
		text-align: center;
	}
	
	.shopInfoDiv{
		display: inline-block;
		margin-bottom : 30px;
	}
	
	.shopnameTxt{
		font-weight: bold;
		font-size : 3em;
	}
	
	.shopCategoriesMenu{
		list-style: none;
	}
	
	.shopCategoriesMenu > li{
		padding : 10px;
		font-size : 18px;
	}
	
	.shopCategoriesMenu > li > a{
		text-decoration: none;
		color : black;
	}
	
	.shopCategoriesMenu > li:hover{
		font-weight: bold;
	}
	
	.shopGoodsMenu{
		padding-left : 50px;
		width : 20%;
		float: left;
	}
	
	.shopGoodsList{
		width : 75%;
		float: left;
	}
	
.goods_list{
	box-sizing : border-box;
}

.goods_list ul{
	font-size : 1.2em;
}
.goods_list ul {
	float : left;
}
	
	.list_seller > a{
    color : black;
    text-decoration: none;
    font-size : 16px;
    font-weight: 500;

}

.b_list{
	list-style: none;
}

.list_gname > a{
	font-size: 16px;
    font-weight: 500;
    color: #000;
    text-decoration: none;
}

.price{
	font-size: 20px;
    font-weight: 600;
    padding-right: 6px;
}

.origin_price{
	text-decoration : line-through;
	color : #9e9e9e;
	font-size : 15px;
}

.list_scount{
	margin-top : 5px;
	font-size : 0.8em;
	color: #9e9e9e;
}
</style>
	<div class="shopInfoWrap">
		<div class="shopInfoDiv">
			<div><span class="shopnameTxt">${shopInfo.shopname}</span></div>
			<table style="margin-top:20px;">
				<tr>
					<th>
						URL : ${shopInfo.shopurl}
					</th>
				</tr>
				<tr>
					<th>
						위치 : (${shopInfo.shop_post_code})${shopInfo.shopaddr1} ${shopInfo.shopaddr2}
					</th>
				</tr>
			</table>
			<div style="margin-top:20px;"><img src="${pageContext.request.contextPath}/resources/img/heart.png" id="heart_icon" width="30px;"/><br/>현재  <span id="likecount" style="font-weight: bold;">${shopInfo.likecount}명</span>이 좋아요를 눌렀습니다!</div>
		</div>
		
	</div>
	<hr/>
		<nav class="shopGoodsMenu">
			<span style="font-weight: bold;font-size:20px;">CATEGORIES</span>
			<ul class="shopCategoriesMenu">
				<li><a href="javascript:changeGoodsListByCategory(0);">전체</a></li>
				<li><a href="javascript:changeGoodsListByCategory(1);">아우터</a></li>
				<li><a href="javascript:changeGoodsListByCategory(2);">상의</a></li>
				<li><a href="javascript:changeGoodsListByCategory(3);">하의</a></li>
				<li><a href="javascript:changeGoodsListByCategory(4);">기타</a></li>
				<li><a href="javascript:changeGoodsListByCategory(5);">악세사리</a></li>
			</ul>
		</nav>
		<section class="shopGoodsList" id="shopGoodsList">
			<c:choose>
				<c:when test="${empty shopGoodsList}">
					<div><span style='font-weight:bold;'>등록된 상품이 없습니다.</span></div>
				</c:when>
				<c:otherwise>
					<c:forEach var="g" items="${shopGoodsList}">
				<div class="best_goods_list goods_list">
				<ul class="b_list">
						<li class="list_img">
							<!-- 대표이미지 -->
							<a href="detail?gno=${g.gno}">
								<img src="${pageContext.request.contextPath}/upload/${g.gno}/mainImg.jpg" width="270" height="280"/>
							</a>
						</li>
						<li class="list_seller">
							<!-- 판매자 -->
							<a href="${g.shopurl}">
								${g.shopname}
							</a>
						</li>
						<li class="list_gname">
							<!-- 상품명 -->
							<a href="">
								${g.gname_ko}
							</a>
						</li>
						<li class="list_price">
							<!-- 판매가 -->
							<span class="price">
								<c:if test="${g.cost != 0}">
									${g.cost}
								</c:if>
								<c:if test="${g.cost == 0}">
									${g.cost_origin}
								</c:if>
							</span>
							<c:if test="${g.cost != 0}">
								<span class="origin_price">
									${g.cost_origin}
								</span>
							</c:if>
						</li>
						<li class="list_scount">
							<!-- 판매개수 -->
							<span>
								${g.scount} 판매됨
							</span>
						</li>
					</ul>
					</div>
			</c:forEach>
				</c:otherwise>
			</c:choose>
			
		</section>
	
<div style="clear: both;"></div>
<script>
	function changeGoodsListByCategory(type){
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/goods/getListByCategory",
			data : {
				mno : '${shopInfo.mno}',
				type : type
			},
			success : function(data){
				printHtmlToGoodsListSection(data);
			}
		});
	}
	
	function printHtmlToGoodsListSection(data){
		console.log(data);
		var target = $("#shopGoodsList");
		var str = "";
		if(data.length == 0){
			str += "<div style='padding-left:480px;padding-top:100px;font-size:25px;'><span style='font-weight:bold;'>등록된 상품이 없습니다.</span></div>"
		}
		for(var i=0; i < data.length; i++){
			str += "<div class='best_goods_list goods_list'>";
			str += "<ul class='b_list'>";
			str += "<li class='list_img'>";
			str += "<a href='detail?gno='"+data[i].gno+"'>";
			str += "<img src='${pageContext.request.contextPath}/upload/"+data[i].gno+"/mainImg.jpg' width='270' height='280'/>";
			str += "</a>";
			str += "</li>";
			str += "<li class='list_seller'>";
			str += "<a href='"+'${shopInfo.shopurl}'+"'>";
			str += '${shopInfo.shopname}';
			str += "</a>";
			str += "</li>";
			str += "<li class='list_gname'>";
			str += "<a href=''>";
			str += data[i].gname_ko;
			str += "</a>";
			str += "</li>";
			str += "<li class='list_price'>";
			str += "<span class='price'>";
			if(data[i].cost != 0){
				str += data[i].cost;
			}else{
				str += data[i].cost_origin;
			}
			str += "</span>";
			if(data[i].cost !=0){
				str += "<span class='origin_price'>";
				str += data[i].cost_origin;
				str += "</span>";
			}
			str += "</li>";
			str += "<li class='list_scount'>";
			str += "<span>";
			str += data[i].scount + " 판매됨";
			str += "</span>";
			str += "</li>";
			str += "</ul>";
			str += "</div>";
		}
		target.html(str);
	}
	
	if("${memberInfo}" != ""){
		checkLike();
	}

	function checkLike(){
		$.get("like",{mno:"${memberInfo.mno}",shopmno:"${like.mno}"},function(data){
			if(data){
				$("#heart_icon").attr("src","${pageContext.request.contextPath}/resources/img/likeicon.png");
			}else{
				$("#heart_icon").attr("src","${pageContext.request.contextPath}/resources/img/heart.png");
			}
		});
	}
	
	$("#heart_icon").on("click",function(){
		var session = '${memberInfo}';
		var like = Number('${like.likecount}');
		if(session != "") {
			$.ajax({
	            type : "POST",
	            url : "like",
	            data : {
	               mno : "${memberInfo.mno}",
	               shopmno : "${like.mno}"
	            },
	            success : function(data){
	            	if(data){
	    				$("#heart_icon").attr("src","${pageContext.request.contextPath}/resources/img/likeicon.png");
	    				var likecount = like + 1;
	    				$("#likecount").html(likecount+"명");
	    				
	    			}else{
	    				
	    				$("#heart_icon").attr("src","${pageContext.request.contextPath}/resources/img/heart.png");
	    				var likecount = $("#likecount").text();
	    				var likeReplace = likecount.replace("명","");
	    				var likeInt = Number(likeReplace);
	    				likeInt -= 1;
	    				$("#likecount").html(likeInt+"명");
	    				
	    			}
	            }
	         });
		}else{
			alert("로그인 후 이용가능");
		}
	 });
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>