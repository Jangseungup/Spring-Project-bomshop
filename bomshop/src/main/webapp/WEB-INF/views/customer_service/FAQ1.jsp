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
	<span class="FAQ_topText">FAQ / 취소/환불/교환 관련</span>
</div>
<div class="FAQ_content_wrap">
	<div class="FAQ_contents">
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 주문을 취소하고싶어요</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				<span>주문은 마이페이지 메뉴에서 직접 취소가 가능합니다.<br/>
				<br/>
				- '마이페이지-주문/배송 조회'에서 상품의 상태가 '배송대기'이고 아직 판매자가 확인하지 않았을 경우 즉시 취소가 가능합니다.<br/>
				- '배송대기'가 아닌 상태일 경우와 판매자가 확인한 상태일 경우 반품/교환 신청이 가능합니다.</span>
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 환불/교환 하고 싶어요.</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				<span>환불 및 교환은 마이페이지 메뉴에서 '환불/교환'신청이 가능합니다.<br/>
				<br/>
				- '마이페이지-주문/배송 조회'에서 상품의 배송 완료되었을 경우 환불 및 교환신청을 하실 수 있습니다.<br/>
				- 만일 처리가 되지 않거나 늦어질 경우는 왼쪽 메뉴의 '1:1문의'로 문의주시길 바랍니다.</span>
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 환불은 어떻게 진행되나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				<span>사이트 특성 상 모든 결제가 캐쉬로 진행되며 환불 또한 캐쉬로 반환됩니다.</span>
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 주문 취소, 환불 시 사용한 포인트와 쿠폰은 복원되나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				<span>글쎄요...</span>
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