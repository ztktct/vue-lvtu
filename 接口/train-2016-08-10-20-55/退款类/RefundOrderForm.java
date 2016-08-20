package train.trainSide.ordermanage.model;

import java.util.Date;

import train.trainSide.base.model.BupModel;


/*******************************************************************************
 * 
 * 
 * 新增订单
 * 
 * 
 */
public class RefundOrderForm extends BupModel {
		private int refId;
		private String refFrom;//0-派送前直接退，1-订单完成后退需确认
		private String refIsAuth;//ref_rom=1时用,0-未处理，1-同意，2-不同意
		private String refIsAuthName;
		private String refIsAuthNameOn;
		private String refType;//退款类型
		private String refundReason;//退款名称
		private String refDetail;//备注
		private String refOrderId;//订单ID
		private String refMemberId;//
		private String refState;//退款状态
		private String refPartnerId;//商家ID
		private String refMoney;//退款金额(分)
		private String refCreateDate;//申请时间
		private String refCreateDateStamp;//申请时间戳
		private String refShopId;//店铺
		private String refIsDel;//是否删除
		private String refIsDelName;
		
		private String orderIsInvoice;//是否小票
		private String orderMemberPhone;//联系人电话
		private String orderMemberName;//联系人姓名
		private String orderDefGoodsName;//订单商品名称
		private String orderDefTotalNum;//订单商品数量
		
		
		public String getOrderIsInvoice() {
			return orderIsInvoice;
		}
		public void setOrderIsInvoice(String orderIsInvoice) {
			this.orderIsInvoice = orderIsInvoice;
		}
		public String getOrderMemberPhone() {
			return orderMemberPhone;
		}
		public void setOrderMemberPhone(String orderMemberPhone) {
			this.orderMemberPhone = orderMemberPhone;
		}
		public String getOrderMemberName() {
			return orderMemberName;
		}
		public void setOrderMemberName(String orderMemberName) {
			this.orderMemberName = orderMemberName;
		}
		public String getOrderDefGoodsName() {
			return orderDefGoodsName;
		}
		public void setOrderDefGoodsName(String orderDefGoodsName) {
			this.orderDefGoodsName = orderDefGoodsName;
		}
		public String getOrderDefTotalNum() {
			return orderDefTotalNum;
		}
		public void setOrderDefTotalNum(String orderDefTotalNum) {
			this.orderDefTotalNum = orderDefTotalNum;
		}
		public int getRefId() {
			return refId;
		}
		public void setRefId(int refId) {
			this.refId = refId;
		}
		public String getRefFrom() {
			return refFrom;
		}
		public void setRefFrom(String refFrom) {
			this.refFrom = refFrom;
		}
		public String getRefIsAuth() {
			return refIsAuth;
		}
		public void setRefIsAuth(String refIsAuth) {
			this.refIsAuth = refIsAuth;
		}
		public String getRefType() {
			return refType;
		}
		public void setRefType(String refType) {
			this.refType = refType;
		}
		public String getRefundReason() {
			return refundReason;
		}
		public void setRefundReason(String refundReason) {
			this.refundReason = refundReason;
		}
		public String getRefDetail() {
			return refDetail;
		}
		public void setRefDetail(String refDetail) {
			this.refDetail = refDetail;
		}
		public String getRefOrderId() {
			return refOrderId;
		}
		public void setRefOrderId(String refOrderId) {
			this.refOrderId = refOrderId;
		}
		public String getRefMemberId() {
			return refMemberId;
		}
		public void setRefMemberId(String refMemberId) {
			this.refMemberId = refMemberId;
		}
		public String getRefState() {
			return refState;
		}
		public void setRefState(String refState) {
			this.refState = refState;
		}
		public String getRefPartnerId() {
			return refPartnerId;
		}
		public void setRefPartnerId(String refPartnerId) {
			this.refPartnerId = refPartnerId;
		}
		public String getRefMoney() {
			return refMoney;
		}
		public void setRefMoney(String refMoney) {
			this.refMoney = refMoney;
		}
		public String getRefCreateDate() {
			return refCreateDate;
		}
		public void setRefCreateDate(String refCreateDate) {
			this.refCreateDate = refCreateDate;
		}
		public String getRefCreateDateStamp() {
			return refCreateDateStamp;
		}
		public void setRefCreateDateStamp(String refCreateDateStamp) {
			this.refCreateDateStamp = refCreateDateStamp;
		}
		public String getRefShopId() {
			return refShopId;
		}
		public void setRefShopId(String refShopId) {
			this.refShopId = refShopId;
		}
		public String getRefIsDel() {
			return refIsDel;
		}
		public void setRefIsDel(String refIsDel) {
			this.refIsDel = refIsDel;
		}
		public String getRefIsAuthName() {
			return refIsAuthName;
		}
		public void setRefIsAuthName(String refIsAuthName) {
			this.refIsAuthName = refIsAuthName;
		}
		public String getRefIsDelName() {
			return refIsDelName;
		}
		public String getRefIsAuthNameOn() {
			return refIsAuthNameOn;
		}
		public void setRefIsAuthNameOn(String refIsAuthNameOn) {
			this.refIsAuthNameOn = refIsAuthNameOn;
		}
		public void setRefIsDelName(String refIsDelName) {
			this.refIsDelName = refIsDelName;
		}
		
	

}
