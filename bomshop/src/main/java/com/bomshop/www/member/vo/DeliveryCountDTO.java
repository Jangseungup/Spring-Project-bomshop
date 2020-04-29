package com.bomshop.www.member.vo;

import lombok.Data;

@Data
public class DeliveryCountDTO {
	private int deliveryWaitCnt;
	private int deliveryRunningCnt;
	private int deliveryCompleteCnt;
	private int refundRequestCnt;
	private int exchangeRequestCnt;
	private int cancellationCnt;
	
}
