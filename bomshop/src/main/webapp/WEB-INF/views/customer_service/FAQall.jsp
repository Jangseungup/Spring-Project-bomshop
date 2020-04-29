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
</div><br/>
<div class="FAQ_topText_wrap">
	<span class="FAQ_topText">FAQ / 주문/결제/배송 관련</span>
</div>
<div class="FAQ_content_wrap">
	<div class="FAQ_contents">
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 주문내역을 확인하고 싶어요.</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				<span>
					BOMSHOP 회원일 경우 마이페이지 > 주문/배송내역에서 확인 가능합니다.<br/>
					비회원 구매일 경우 상단의 '비회원 주문조회'를 통해 확인 가능합니다.
				</span>
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 배송지 변경은 어디서 하나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				<span>
					배송지 변경은 '마이페이지 > 배송지 편집'에서 기본배송지 설정 및 추가가 가능합니다.
				</span>
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶  결제방식은 어떻게 되나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				사이트 특성상 모든 결제는 사전에 충전한 캐쉬를 사용합니다.
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 배송조회는 어디서 하나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				BOMSHOP 회원일 경우 마이페이지 > 주문/배송내역에서 확인 가능합니다.<br/>
				비회원 구매일 경우 상단의 '비회원 주문조회'를 통해 확인 가능합니다.
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 주문한 상품과 다른 상품이 배송되었어요.(오배송)</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				물품이 오배송된 경우, '고객센터 > 1:1문의'를 통해 문의 주시면 빠른 조치가 가능합니다.
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 포인트는 어떻게 사용하나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				포인트는 상품을 구매하실 때 결제 페이지에서 사용가능하며 현금처럼 사용가능합니다.
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 쿠폰은 어떻게 사용하나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				쿠폰은 상품을 구매하실 때 결제 페이지에서 사용가능하며 해당 쿠폰의 금액만큼 할인된 금액으로 상품을 구입하실 수 있습니다.
			</div>
		</div>
	</div>
</div><br/>
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