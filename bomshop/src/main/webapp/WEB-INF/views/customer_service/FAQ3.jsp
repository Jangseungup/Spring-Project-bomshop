<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.FAQ_topText{
		font-size : 21px;
		font-weight: bold;
	}
	.FAQ_content_wrap{
		margin-top : 6px;
		border-top : 2px solid black;
	}
	.FAQ_content{
		padding : 20px;
	}
	#FAQ_content_head:hover{
		cursor : pointer;
	}	
	.FAQ_content{
		padding-bottom : 20px;
		border-bottom : 1px solid lightgray;
	}
	
	#FAQ_content_target{
		margin-top : 10px;
		padding : 10px;
		background-color : #f1f1f1;
	}
</style>
<div class="FAQ_topText_wrap">
	<span class="FAQ_topText">FAQ / 리뷰관련</span>
</div>
<div class="FAQ_content_wrap">
	<div class="FAQ_contents">
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 리뷰는 어디서 작성할 수 있나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				<span>
					리뷰는 '마이페이지 > 주문/배송조회'에서 상품이 '배송완료'일 경우 '구매확정'버튼을 통해 작성가능합니다.
				</span>
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 리뷰를 수정하거나 삭제할 수 있나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				BOMSHOP에서는 리뷰를 수정하거나 삭제하실 수 없습니다.<br/>
				이 점 유의하여 작성하여 주시길 바랍니다.
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 리뷰는 구입 후 언제까지 작성이 가능하나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				리뷰는 상품이 배송 완료 후 30일(한달)동안 작성 가능합니다. 
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 리뷰 작성 기준이 궁금해요.</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				BOMSHOP 리뷰는 상품 당 포토 리뷰에 대해서만 등록 및 포인트 적립이 가능합니다.<br/>
				포인트는 리뷰 작성 후 바로 적립됩니다.
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 리뷰 작성 시 포인트는 얼마나 적립되나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				포인트는 회원등급에 따라 최소 1%, 최대 10%까지 적립 가능합니다.<br/>
				회원등급은 '마이페이지 > 회원등급'에서 확인 가능합니다.
			</div>
		</div>
	</div>
</div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function(){
		$(".FAQ_content_target").hide();
	});
	
	function toggleContent(obj){
		var target = $(obj).parent().find('#FAQ_content_target');
		target.toggle();
	}
	
	
</script>