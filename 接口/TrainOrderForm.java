package train.trainSide.ordermanage.model;

import java.util.List;

import com.h8h.framework.BaseObject;

/**
 * 订单
 * **/
public class TrainOrderForm  extends BaseObject{

	
	private static final long serialVersionUID = 1L;
	private long orderId;//  
	private String orderNo;//订单编号  
	private String orderTotal;//订单总金额  
	private String orderDefTotalNum;//订单商品数量  
	private String orderDefGoodsName;//默认一个商品名称  
	private String orderDefGoodsImg;//默认一个商品图片  
	private String orderDuePay;//应付  
	private String orderPay;//订单实际支付价格  
	private String orderBalance;//余额支付  
	private String orderPayStatus;//订单状态  
	private String orderPayDate;//支付日期  
	private String orderPayDateStamp;//  
	private String orderPayMethod;//支付方式  
	private String orderType;//订单类别(0-充值,1-商品)  
	private String orderSelectDate;//要求送达时间  
	private String orderSelectDateStamp;//  
	private String orderIsDiscount;//订单是否折扣  
	private String orderActId;//活动id  
	private String orderDiscount;//折扣金额(订单活动,满减)  
	private String orderIsCancel;//订单是否可以取消  
	private String orderIsClose;//是否关闭  
	private String orderIsRefound;//是否退款  
	private String orderIsDel;//是否删除  
	private String orderCreateDate;//  
	private String orderCreateDateStamp;//  
	private String orderIsInvoice;//是否小票  
	private long orderMemberId;//会员id  
	private String orderMemberPhone;//收货人电话  
	private String orderMemberName;//收货人姓名  
	private String orderMemberIsSeat;//0-配送,1-自取  
	private String orderMemberTrain;//  
	private String orderMemberCarriage;//车厢  
	private String orderMemberSeatNo;//收货人座位号  
	private String orderReceiveShopId;//门店id  
	private String orderReceiveShopName;//门店名称  
	private String orderReceiveIs;//是否接单  
	private String orderReceiveDate;//接单时间  
	private String orderReceiveDateStamp;//接单时间戳  
	private String orderDeliveryIs;//订单是否配送  
	private String orderDeliveryDate;//配送时间  
	private String orderDeliveryDateStamp;//配送时间戳  
	private String orderIsSendto;//是否送达  
	private String orderIsSendtoDate;//  
	private String orderIsSendtoDateStamp;//  
	private String orderIsComplete;//是否完成  
	private String orderIsCompleteDate;//订单完成时间  
	private String orderIsCompleteDateStamp;//订单完成时间戳  
	private String orderCouponId;//优惠券id(0-未使用)  
	private String orderCouponTotal;//优惠券金额  
	private int orderStep;//步骤
	private String stepName;
	private String stepValue;
	private String srcType;//来源类型
	private String srcQuery;
	private String startDate;
	private String endDate;
	private String bussiQuery;
	private String goodsClassName;
	private String goodsClassIds;
	private String keys;
	private String orderColumn;
	private long userId;//用户id
	private String priData;
	private String shopQuery;
	private String content;

	
	//
	private String queryOrderDateBeg;
	private String queryOrderDateEnd;
	private int pageIndex;
	private int pageSize;
	private List<TrainOrderGoodsForm> ogList;
	
	
	public String getSrcQuery() {
		return srcQuery;
	}

	public void setSrcQuery(String srcQuery) {
		this.srcQuery = srcQuery;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getBussiQuery() {
		return bussiQuery;
	}

	public void setBussiQuery(String bussiQuery) {
		this.bussiQuery = bussiQuery;
	}

	public String getGoodsClassName() {
		return goodsClassName;
	}

	public void setGoodsClassName(String goodsClassName) {
		this.goodsClassName = goodsClassName;
	}

	public String getGoodsClasIds() {
		return goodsClassIds;
	}

	public void setGoodsClasIds(String goodsClassIds) {
		this.goodsClassIds = goodsClassIds;
	}

	public void setOrderId(long orderId){
		this.orderId=orderId;
	}

	public long getOrderId(){
		return orderId;
	}

	public void setOrderNo(String orderNo){
		this.orderNo=orderNo;
	}

	public String getOrderNo(){
		return orderNo;
	}

	public void setOrderTotal(String orderTotal){
		this.orderTotal=orderTotal;
	}

	public String getOrderTotal(){
		return orderTotal;
	}

	public void setOrderDefTotalNum(String orderDefTotalNum){
		this.orderDefTotalNum=orderDefTotalNum;
	}

	public String getOrderDefTotalNum(){
		return orderDefTotalNum;
	}

	public void setOrderDefGoodsName(String orderDefGoodsName){
		this.orderDefGoodsName=orderDefGoodsName;
	}

	public String getOrderDefGoodsName(){
		return orderDefGoodsName;
	}

	public void setOrderDefGoodsImg(String orderDefGoodsImg){
		this.orderDefGoodsImg=orderDefGoodsImg;
	}

	public String getOrderDefGoodsImg(){
		return orderDefGoodsImg;
	}

	public void setOrderDuePay(String orderDuePay){
		this.orderDuePay=orderDuePay;
	}

	public String getOrderDuePay(){
		return orderDuePay;
	}

	public void setOrderPay(String orderPay){
		this.orderPay=orderPay;
	}

	public String getOrderPay(){
		return orderPay;
	}

	public void setOrderBalance(String orderBalance){
		this.orderBalance=orderBalance;
	}

	public String getOrderBalance(){
		return orderBalance;
	}

	public void setOrderPayStatus(String orderPayStatus){
		this.orderPayStatus=orderPayStatus;
	}

	public String getOrderPayStatus(){
		return orderPayStatus;
	}

	public void setOrderPayDate(String orderPayDate){
		this.orderPayDate=orderPayDate;
	}

	public String getOrderPayDate(){
		return orderPayDate;
	}

	public void setOrderPayDateStamp(String orderPayDateStamp){
		this.orderPayDateStamp=orderPayDateStamp;
	}

	public String getOrderPayDateStamp(){
		return orderPayDateStamp;
	}

	public void setOrderPayMethod(String orderPayMethod){
		this.orderPayMethod=orderPayMethod;
	}

	public String getOrderPayMethod(){
		return orderPayMethod;
	}

	public void setOrderType(String orderType){
		this.orderType=orderType;
	}

	public String getOrderType(){
		return orderType;
	}

	public void setOrderSelectDate(String orderSelectDate){
		this.orderSelectDate=orderSelectDate;
	}

	public String getOrderSelectDate(){
		return orderSelectDate;
	}

	public void setOrderSelectDateStamp(String orderSelectDateStamp){
		this.orderSelectDateStamp=orderSelectDateStamp;
	}

	public String getOrderSelectDateStamp(){
		return orderSelectDateStamp;
	}

	public void setOrderIsDiscount(String orderIsDiscount){
		this.orderIsDiscount=orderIsDiscount;
	}

	public String getOrderIsDiscount(){
		return orderIsDiscount;
	}

	public void setOrderActId(String orderActId){
		this.orderActId=orderActId;
	}

	public String getOrderActId(){
		return orderActId;
	}

	public void setOrderDiscount(String orderDiscount){
		this.orderDiscount=orderDiscount;
	}

	public String getOrderDiscount(){
		return orderDiscount;
	}

	public void setOrderIsCancel(String orderIsCancel){
		this.orderIsCancel=orderIsCancel;
	}

	public String getOrderIsCancel(){
		return orderIsCancel;
	}

	public void setOrderIsClose(String orderIsClose){
		this.orderIsClose=orderIsClose;
	}

	public String getOrderIsClose(){
		return orderIsClose;
	}

	public void setOrderIsRefound(String orderIsRefound){
		this.orderIsRefound=orderIsRefound;
	}

	public String getOrderIsRefound(){
		return orderIsRefound;
	}

	public void setOrderIsDel(String orderIsDel){
		this.orderIsDel=orderIsDel;
	}

	public String getOrderIsDel(){
		return orderIsDel;
	}

	public void setOrderCreateDate(String orderCreateDate){
		this.orderCreateDate=orderCreateDate;
	}

	public String getOrderCreateDate(){
		return orderCreateDate;
	}

	public void setOrderCreateDateStamp(String orderCreateDateStamp){
		this.orderCreateDateStamp=orderCreateDateStamp;
	}

	public String getOrderCreateDateStamp(){
		return orderCreateDateStamp;
	}

	public String getStepName() {
		return stepName;
	}

	public void setStepName(String stepName) {
		this.stepName = stepName;
	}

	public void setOrderIsInvoice(String orderIsInvoice){
		this.orderIsInvoice=orderIsInvoice;
	}

	public String getOrderIsInvoice(){
		return orderIsInvoice;
	}

	public void setOrderMemberId(long orderMemberId){
		this.orderMemberId=orderMemberId;
	}

	public long getOrderMemberId(){
		return orderMemberId;
	}

	public void setOrderMemberPhone(String orderMemberPhone){
		this.orderMemberPhone=orderMemberPhone;
	}

	public String getOrderMemberPhone(){
		return orderMemberPhone;
	}

	public void setOrderMemberName(String orderMemberName){
		this.orderMemberName=orderMemberName;
	}

	public String getOrderMemberName(){
		return orderMemberName;
	}

	public void setOrderMemberIsSeat(String orderMemberIsSeat){
		this.orderMemberIsSeat=orderMemberIsSeat;
	}

	public String getOrderMemberIsSeat(){
		return orderMemberIsSeat;
	}

	public void setOrderMemberTrain(String orderMemberTrain){
		this.orderMemberTrain=orderMemberTrain;
	}

	public String getOrderMemberTrain(){
		return orderMemberTrain;
	}

	public void setOrderMemberCarriage(String orderMemberCarriage){
		this.orderMemberCarriage=orderMemberCarriage;
	}

	public String getOrderMemberCarriage(){
		return orderMemberCarriage;
	}

	public void setOrderMemberSeatNo(String orderMemberSeatNo){
		this.orderMemberSeatNo=orderMemberSeatNo;
	}

	public String getOrderMemberSeatNo(){
		return orderMemberSeatNo;
	}

	public void setOrderReceiveShopId(String orderReceiveShopId){
		this.orderReceiveShopId=orderReceiveShopId;
	}

	public List<TrainOrderGoodsForm> getOgList() {
		return ogList;
	}

	public void setOgList(List<TrainOrderGoodsForm> ogList) {
		this.ogList = ogList;
	}

	public String getOrderReceiveShopId(){
		return orderReceiveShopId;
	}

	public void setOrderReceiveShopName(String orderReceiveShopName){
		this.orderReceiveShopName=orderReceiveShopName;
	}

	public String getOrderReceiveShopName(){
		return orderReceiveShopName;
	}

	public void setOrderReceiveIs(String orderReceiveIs){
		this.orderReceiveIs=orderReceiveIs;
	}

	public String getOrderReceiveIs(){
		return orderReceiveIs;
	}

	public void setOrderReceiveDate(String orderReceiveDate){
		this.orderReceiveDate=orderReceiveDate;
	}

	public String getOrderReceiveDate(){
		return orderReceiveDate;
	}

	public void setOrderReceiveDateStamp(String orderReceiveDateStamp){
		this.orderReceiveDateStamp=orderReceiveDateStamp;
	}

	public String getOrderReceiveDateStamp(){
		return orderReceiveDateStamp;
	}

	public void setOrderDeliveryIs(String orderDeliveryIs){
		this.orderDeliveryIs=orderDeliveryIs;
	}

	public String getGoodsClassIds() {
		return goodsClassIds;
	}

	public void setGoodsClassIds(String goodsClassIds) {
		this.goodsClassIds = goodsClassIds;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getOrderDeliveryIs(){
		return orderDeliveryIs;
	}

	public void setOrderDeliveryDate(String orderDeliveryDate){
		this.orderDeliveryDate=orderDeliveryDate;
	}

	public String getOrderDeliveryDate(){
		return orderDeliveryDate;
	}

	public void setOrderDeliveryDateStamp(String orderDeliveryDateStamp){
		this.orderDeliveryDateStamp=orderDeliveryDateStamp;
	}

	public String getOrderDeliveryDateStamp(){
		return orderDeliveryDateStamp;
	}

	public void setOrderIsSendto(String orderIsSendto){
		this.orderIsSendto=orderIsSendto;
	}

	public String getOrderIsSendto(){
		return orderIsSendto;
	}

	public void setOrderIsSendtoDate(String orderIsSendtoDate){
		this.orderIsSendtoDate=orderIsSendtoDate;
	}

	public String getOrderIsSendtoDate(){
		return orderIsSendtoDate;
	}

	public void setOrderIsSendtoDateStamp(String orderIsSendtoDateStamp){
		this.orderIsSendtoDateStamp=orderIsSendtoDateStamp;
	}

	public String getOrderIsSendtoDateStamp(){
		return orderIsSendtoDateStamp;
	}

	public void setOrderIsComplete(String orderIsComplete){
		this.orderIsComplete=orderIsComplete;
	}

	public String getOrderIsComplete(){
		return orderIsComplete;
	}

	public void setOrderIsCompleteDate(String orderIsCompleteDate){
		this.orderIsCompleteDate=orderIsCompleteDate;
	}

	public String getOrderIsCompleteDate(){
		return orderIsCompleteDate;
	}

	public void setOrderIsCompleteDateStamp(String orderIsCompleteDateStamp){
		this.orderIsCompleteDateStamp=orderIsCompleteDateStamp;
	}

	public String getQueryOrderDateBeg() {
		return queryOrderDateBeg;
	}

	public void setQueryOrderDateBeg(String queryOrderDateBeg) {
		this.queryOrderDateBeg = queryOrderDateBeg;
	}

	public String getQueryOrderDateEnd() {
		return queryOrderDateEnd;
	}

	public void setQueryOrderDateEnd(String queryOrderDateEnd) {
		this.queryOrderDateEnd = queryOrderDateEnd;
	}

	public String getOrderIsCompleteDateStamp(){
		return orderIsCompleteDateStamp;
	}

	public void setOrderCouponId(String orderCouponId){
		this.orderCouponId=orderCouponId;
	}

	public String getOrderCouponId(){
		return orderCouponId;
	}

	public void setOrderCouponTotal(String orderCouponTotal){
		this.orderCouponTotal=orderCouponTotal;
	}

	public String getOrderCouponTotal(){
		return orderCouponTotal;
	}

	public void setOrderStep(int orderStep){
		this.orderStep=orderStep;
	}

	public int getOrderStep(){
		return orderStep;
	}

	public String getStepValue() {
		return stepValue;
	}

	public void setStepValue(String stepValue) {
		this.stepValue = stepValue;
	}

	public String getSrcType() {
		return srcType;
	}

	public void setSrcType(String srcType) {
		this.srcType = srcType;
	}

	public String getKeys() {
		return keys;
	}

	public void setKeys(String keys) {
		this.keys = keys;
	}

	public String getOrderColumn() {
		return orderColumn;
	}

	public void setOrderColumn(String orderColumn) {
		this.orderColumn = orderColumn;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getPriData() {
		return priData;
	}

	public void setPriData(String priData) {
		this.priData = priData;
	}

	public String getShopQuery() {
		return shopQuery;
	}

	public void setShopQuery(String shopQuery) {
		this.shopQuery = shopQuery;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}


}
