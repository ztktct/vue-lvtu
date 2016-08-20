<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/framework/common/taglibs.jsp"%>
<head>
<%@ include file="/framework/common/header.jsp"%>
 <%@page import="com.alibaba.fastjson.JSON"%>       
<meta charset="UTF-8">
	<title>订单管理</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" >
	<meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/framework/css/style.css">
	<link href="<%=request.getContextPath()%>/framework/css/mobiscroll.css" rel="stylesheet" type="text/css">
	<script src="<%=request.getContextPath()%>/framework/js/autoFontSize.js"></script>
	<script src="<%=request.getContextPath()%>/framework/js/zepto.min.js"></script>
	<style type="text/css">
.manage-filter{padding-top:1.41333rem}
.nav-tabs>li{float:none;}
.nav-tabs>li select{border-radius:0;}
.order-manage-bd{margin-top:2.5537rem;margin-bottom:1.25rem;}
.order-manage-hd{margin-bottom:0;}
.fix-top{position:fixed;z-index:20;left:0;right:0;margin-top:1.41333rem;top:0;background:#f2f2f2;}
.btnquery{background:transparent;color:#ef574a;}

.order-manage-bd .order-record .telephone{font-size:12px;display:block;width:auto;height:auto;border-radius:0;background:transparent;}
.order-manage-bd .order-record .telephone span{vertical-align:middle;margin-left:5px;}
.order-manage-bd .order-record .item{display:-webkit-box;display:-webkit-flex;display:-moz-box;display:-ms-flexbox;display:flex;}
@media screen and (min-width:768px){
	.order-manage-bd .order-record .item{display: -webkit-inline-box;
  display: -webkit-inline-flex;
  display: -moz-inline-box;
  display: -ms-inline-flexbox;
  display: inline-flex;
width:49.5%;}
}
.order-manage-bd .order-record .item span{width:5em;}
.order-manage-bd .order-record .item strong{-webkit-box-flex:1;-webkit-flex:1;-moz-box-flex:1;-ms-flex:1;flex:1}

.order-manage-hd li a{position:relative;}
.order-manage-hd li .num{font-size:.375rem;position:absolute;min-width:1.25em;height:1.25em;background:#ef574a;color:#fff;text-align:center;line-height:1.375em;border-radius:.625em;left:78%;top:10%}
.order-manage-hd li .num:empty{display:none;}

@media print{
.lvtudiandian{width:2in;margin:0 auto}
.lvtudiandian .ticket-item{background:#fff;font-family: 'Arial';padding:0;margin-bottom:3rem;font-size:10pt;}
.lvtudiandian .ticket-item .borbt{padding-bottom:10px;margin-bottom:10px;border-bottom:1px dashed #333;}
.lvtudiandian .ticket-item .ticket-hd{text-align:center;font-size:14pt;}
.lvtudiandian .ticket-item .ticket-info{font-size:10pt;}
.lvtudiandian .ticket-item .ticket-info li{margin-bottom:8px;line-height: 1.3}
.lvtudiandian .ticket-item .ticket-info li:last-child{margin-bottom:0;}
.lvtudiandian .ticket-item .ticket-info li:after{content:'';display: table;clear:both;width:0;}
.lvtudiandian .ticket-item .ticket-info li span{float:left;}
.lvtudiandian .ticket-item .ticket-info li p{float:left;width:77%;}
.lvtudiandian .ticket-item .ticker-order table{width:100%;}
.lvtudiandian .ticket-item .ticker-order th,.ticket-item .ticker-order td{padding:4px 0;}
.lvtudiandian .ticket-item .ticker-order th{border-bottom:1px dashed #333;padding-bottom:10px;}
.lvtudiandian .ticket-item .ticker-order th:first-child{text-align:left;}
.lvtudiandian .ticket-item .ticker-order td:not(:first-child){text-align:center;}
.lvtudiandian .ticket-item .ticker-order tbody tr:first-child td{padding-top:10px;}
.lvtudiandian .ticket-item .ticker-order tbody tr:last-child td{border-bottom:1px dashed #333;padding-bottom:13px;}
.lvtudiandian .ticket-item .ticker-order tfoot td{padding:10px 0 0;}
.lvtudiandian .ticket-item .ticket-all{font-size:10pt;}
.lvtudiandian .ticket-item .ticket-bottom{font-size:15pt;font-family:'kaiti';text-align: center;padding:0 0 10px;}

}

	</style>
<title>旅途点点店铺平台-订单管理-订单管理</title>
<script type="text/javascript">
	$(document).ready(function(){
			$.post("orderManage.action",{
				action:"queryOrderListForZhang",
				"orderModel.pageIndex":1,
				"orderModel.pageSize":10,
				"orderModel.orderReceiveShopId":1,
				"orderModel.orderStep":4
			},function(data){
					if(data.result=='SKerrorMessages'){
						$.zui.messager.show(data.msg,{type:"warning"});
						return;
					}else{
						$.zui.messager.show(data.msg,{type:"success"});
						console.log("data="+JSON.stringify(data.data));
					}
			});
	});
</script>
</head>

<script type="text/javascript">
$(function(){
	$(".btnquery").click(function(){
		
		/* var orderId = $(this).attr("data-order");
		console.log(orderId);
		location.href="orderManage.action?action=initDetail&model.orderId="+orderId; */
		var p=$(this).parent().parent().prev("input").val();
			location.href="orderManage.action?action=initDetail&model.orderId="+p;

		
		
	});
	//if(<%=request.getAttribute("step")%>-4 >=0 ){
		//$('.order-manage-hd li').removeClass('on');
		//$('.order-manage-hd li').eq(<%=request.getAttribute("step")%>-4).addClass('on');
	//}
	$('#orderStep_'+<%=request.getAttribute("step")%>).parent().addClass('on');
	
	var shopIds = $("#shopIds").val();
	if(shopIds!=""&&shopIds!=null){
		$("#shopId").val(shopIds);
		$("#shop").val($("#shopId").val());
	}
	var ds=["1","7","30"];
	for(var i=0;i<ds.length;i++){
		$("#timeRange_"+ds[i]).click(function(){
	        var idIndex=(this.id).substring((this.id).indexOf('timeRange_')+10);
	        var endDate = DateUtil.dateAdd('n', 1, new Date());//加一分钟
	        var startDate = DateUtil.dateAdd('d', 1-idIndex, endDate);//向前几天
	      	//$('#queryOrderDateBeg').val(DateUtil.dateToStr('yyyy-MM-dd 00:00', startDate));
	      	//$('#queryOrderDateEnd').val(DateUtil.dateToStr('yyyy-MM-dd HH:mm', endDate));
      	});
	}

	var stepTab=["100", "3","4","5","6","7","close"];
	for(var i=0;i<stepTab.length;i++){
		$("#orderStep_"+stepTab[i]).click(function(){
			var idIndex=(this.id).substring((this.id).indexOf('orderStep_')+10);
			if(idIndex==100){
				$("#step").val("");
			}else{
				$("#step").val(idIndex);
				console.log($(this));
			}
	        
	        initdata();
      	});
	}
	
	$("#orderStep_"+$("#orderStep").val()).tab('show');

	
	
	
});

</script>
 
<body>

   <%@ include file="/train/trainSide/sp/base/top.jsp"%>
<%-- <header class="wrapHeader"><%@ include file="/train/trainSide/sp/base/top.jsp"%></header> --%>

	<%@ include file="/train/trainSide/sp/base/leftMenu.jsp"%>

<form method="post" action="orderManage.action?action=queryOrderList" id="searchFrom">
	<s:hidden name="model.partnerId" id="partnerId"></s:hidden>
	<s:hidden name="model.orderId" id="orderId"></s:hidden>
	<s:hidden name="model.ogId" id="ogId"></s:hidden>
	<s:hidden name="model.orderStep" id="orderStep"></s:hidden>
	<s:hidden name="model.step" id="step"></s:hidden>
	<input type="hidden" name="model.orderReceiveShopId" id="shop" >
	
	<header class="billing-header backstage-header">
		<i class="icon-bill-01"></i>
		<h2>订单管理</h2>
		<ul class="billing-header-ul">
					<li>车次：<s:property value="#request.userName"/></li>
					<li>
					<select class="form-control" name="shopId" id="shopId" style="display:none;">
					</select>
					</li>
		</ul>
		
	</header>
<div class="fix-top">

		<nav class="order-manage-hd">
			<ul>
				<li><a id="orderStep_4" data-toggle="tab" href="#step_tab">待接单<span class="num"></span></a></li>
				<li><a id="orderStep_5" data-toggle="tab" href="#step_tab">待配送<span class="num"></span></a></li>
				<li><a id="orderStep_3" data-toggle="tab" href="#step_tab">待完成<span class="num"></span></a></li>
				<li><a id="orderStep_6" data-toggle="tab" href="#step_tab">已完成</a></li>
			</ul>
			<div class="filter">
				<i class="icon-filter"></i>筛选
			</div>
		</nav>
</div>

	
	<main class="order-manage-bd">
		<!-- 待接单 -->
		<div class="order-block on">
			<!-- 一条订单 -->
			
			<s:iterator id="mainOrder" value="#request.mainOrderList" var="mainOrder">
			<input id="shopIds" type="hidden" name="shopIds" value="${orderReceiveShopId}">
			<input id="orderIds" type="hidden" name="orderIds" value="${orderId}">
			
			
			<div class="order-record">
			
				<div class="or-wrap">
					<div class="item">
						<span>订单编号：</span>
						<strong>${orderNo}</strong>
					</div>
					<div class="item">
						<span>下单时间：</span>
						<strong>${orderCreateDate}</strong>
					</div>
					<div class="item">
						<span>有无发票：</span>
						<s:if test="#mainOrder.orderIsInvoice==1">
									<strong>有</strong>
							</s:if>
   							 <s:else>
								<strong>无</strong>
							</s:else>
					</div>
					
					<div class="item">
						<span>商品信息：</span>
						<strong>
						<s:iterator id="order" value="#mainOrder.subOrder" var="order" status="st">
						${ogComGoodsName} × ${ogShopGoodsNum} &nbsp;
						</s:iterator>
						</strong>
					</div>
					
					
					<%-- <div class="item">
						<span>车　　次：</span>
						<strong>${orderMemberCarriage}</strong>
					</div> --%>
					<div class="item">
						<span>车厢座位：</span>
							<s:if test="#mainOrder.orderMemberSeatNo==''">
									<strong>${orderMemberCarriage}车</strong>
							</s:if>
   							 <s:else>
								<strong>${orderMemberCarriage}车${orderMemberSeatNo}</strong>
							</s:else>
					</div>
					<div class="item">
						<span>总金额：</span>
						<strong>￥${orderTotal}</strong>
					</div>
					<div class="item">
						<span>应付金额：</span>
						<strong>￥${orderDuePay}</strong>
					</div>
					<div class="item">
						<span>实付金额：</span>
						<strong>￥${orderPay}</strong>
					</div>
					<div class="item">
						<span>送餐时间：</span>
						<strong>	<s:if test="#mainOrder.orderMemberIsSeat== 1"><span style="color:red">自取订单</span></s:if><s:else>${orderSelectDate}</s:else></strong>
					</div>
					<div class="item">
						<span>联 系 人：</span>
						<strong>${orderMemberName}</strong>
					</div>
				</div>
				
				<div class="or-cooperation">
				<s:if test="#mainOrder.orderStep == 4">
										<button type="button" class="btn-orange" id="receive_btn" onclick="receiveOrder(${orderId},'5')">&nbsp;&nbsp;接单&nbsp;&nbsp;</button>
									</s:if>
									<s:if test="#mainOrder.orderStep == 5">
										<button type="button" class="btn-orange" id="delivery_btn" onclick="deliveryOrder(${orderId},'3')">&nbsp;&nbsp;配送&nbsp;&nbsp;</button>
									</s:if>
									<input type="hidden" a="%{mainOrder}" id="hidden_%{orderNo}" />
									<s:if test="#mainOrder.orderStep >=4">
					<%--  <button type="button" class="printbtn btn-orange" 
					q='{"custPayStatus":"${orderPayStatus}","mainOrderId":"${orderId}","mainOrderNo":"${orderNo}",
					"createDate":"${orderCreateDate}","orderMemberCarriage":"${orderMemberCarriage}","orderMemberSeatNo":"${orderMemberSeatNo}",
					"cust_phone":"${orderMemberPhone}",
					"custName":"${orderMemberName}","total":	"${orderTotal}","productNum":"${orderDefTotalNum}"}' t="${orderNo} " 
					id="print_btn">&nbsp;&nbsp;打印&nbsp;&nbsp;</button> --%>
									</s:if>
								</td>
								<td colspan="2" class="text-right">
									<button type="button" class="btnquery" data-order="${orderId}"  id="btn_query">&nbsp;&nbsp;查看详情&nbsp;&nbsp;</button>
								</td>
				</div>
				<a href="tel:${orderMemberPhone}" class="telephone" title="${orderMemberPhone}"><i class="icon-telephone"></i><span>${orderMemberPhone}</span></a>
			</div>
			
			
			</s:iterator>
		</div>
			<s:include value="/framework/common/page.jsp" />
	</main>
	<%-- <footer class="manage-ft">
		<ul>
			<li>
				<a href="<%=request.getContextPath()%>/orderManage.action?action=init">
					<i class="icon-layers"></i>订单管理
					<span class="num"></span>
				</a>
			</li>
			<li><a href="<%=request.getContextPath()%>/shopproduct.action?action=init"><i class="icon-menu"></i>商品管理</a></li>
			<li><a href="<%=request.getContextPath()%>/upTicket.action?action=init"><i class="icon-tickets"></i>补票延长</a></li>
			<li><a href="javascript:;"><i class="icon-lost"></i>旅客帮助</a></li>
		</ul>
	</footer> --%>
	<div class="manage-filter form-lists">
		<form action="orderManage.action?action=queryOrderList">
			<div class="wrap">
				<div class="form-item">
					<label>订单号</label>
					<div class="input-wrap">
							<s:textfield name="model.orderNo" cssClass="form-control"></s:textfield>
					</div>
				</div>
				<div class="form-item">
					<label>下单时间</label>
					<div class="input-wrap">
					<s:textfield name="model.queryOrderDateBeg" data-timetype="datetime-local" min="2016-01-01 00:00:00"
					 id="queryOrderDateBeg" cssClass="beginTime" data-timeType="datetime-local
					" maxlength="16" value="" readonly="true"></s:textfield>
					</div>
					<i class="icon-arrow-down"></i>
				</div>
				<div class="form-item">
					<label>至</label>
					<div class="input-wrap">
						<s:textfield value="" name="model.queryOrderDateEnd" id="queryOrderDateEnd" data-timetype="datetime-local" min="2016-01-01 00:00:00" cssClass="beginTime" maxlength="16" readonly="true"></s:textfield>
					</div>
					<i class="icon-arrow-down"></i>
				</div>
				<div class="form-item">
					<label>乘客姓名</label>
					<div class="input-wrap">
						<s:textfield name="model.orderMemberName" cssClass="form-control"></s:textfield>
					</div>
				</div>
				<div class="form-item">
					<label>乘客手机</label>
					<div class="input-wrap">
						<s:textfield name="model.orderMemberPhone" maxlength="11" cssClass="form-control"></s:textfield>
					</div>
				</div>
				<div class="form-item form-item-btns">
					<input type="reset" value="重置" class="btn-reset">
					<input type="submit" value="搜索" class="btn-search btn-orange">
				</div>
			</div>
		</form>
	</div>



	
</form>



<!-- *page content end* -->
</div>

<div class="modal fade" id="printDialog" aria-hidden="true">
  <div class="modal-dialog">
  	  <div class="modal-content">
  	  	 <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><i class="icon icon-times"></i></button>
        <h4 class="modal-title"> <i id="printO" onclick="printO()"><img src="<%=request.getContextPath()%>/framework/image/print.png" width="60" height="60"/></i></h4>
					<div class="form-horizontal" role="form" id="loadHtml">
					<!--startprint1-->
	
	<section class="main lvtudiandian">
		<!-- 一张订单 -->
		<div class="ticket-item">
			<div class="ticket-hd borbt">
				<div class="ticket-id">旅途点点便当</div>
				<div class="ticked-state" id="main_pay_status">用户未付款</div>
			</div>
			<div class="ticket-info borbt">
				<ul>
					<li>
						<span>送达：</span><p id="main_arrive_time"></p>
					</li>
					<li>
						<span>下单：</span><p id="main_create"></p>
					</li>
					<li>
						<span>位置：</span><p id="main_addr"></p>
					</li>
					<li>
						<span>电话：</span><p id="main_phone"></p>
					</li>
				</ul>
			</div>
			<div class="ticket-buyer borbt">买家：<span id="main_name"></span></div>
			<div class="ticker-order borbt">
				<table>
					<thead>
						<tr>
							<th>菜品</th>
							<th>数量</th>
							<th>单价</th>
							<th>金额</th>
						</tr>
					</thead>
					<tbody id="subOrders">
					
					</tbody>					
					<tfoot>
						<tr>
							<td>小计：</td>
							<td id="main_product_num">￥ 1</td>
							<td>--</td>
							<td id="main_total">30.00</td>
						</tr>
					</tfoot>
				</table>
			</div>
			<div class="ticket-all borbt" id="">共计：￥<span id="sp_total">30.00</span></div>
			<div class="ticket-number borbt" > 订单号：<span id="sp_orderNo">1105010103707</span></div>
			<div class="ticket-bottom">旅途点点餐饮</div>
		</div>
	
	</section>
	
	<!--endprint1-->
	 <div class="modal-footer">
		<button type="button" class="btn btn-primary" id="testClose" onclick="closeModal()">关闭</button>
	 </div>
					</div>
				</div>
  	  </div>
  </div>
</div>
</form>
<%@ include file="/train/trainSide/spm/shopproduct/buttomOfList.jsp"%>
</body>
	<script type="text/javascript" src="<%=request.getContextPath()%>/framework/js/mobiscroll.zepto.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/framework/js/mobiscroll_002.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/framework/js/mobiscroll.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/framework/js/mobiscroll_show.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/framework/js/queryTrain.js"></script>
	<script type="text/javascript">
		$(function(){
			
			
			
			
			
			var filter=$('.order-manage-hd .filter');
			var filter_con=$('.manage-filter');
			var filter_wrap=$('.manage-filter .wrap');

			filter.on('click',function(){
				slideFilter(filter_con);
			});
			filter_wrap.on('click',function(e){
				e.stopPropagation();
			});
			filter_con.on('click',function(e){
				slideFilter(filter_con);
			});

			// 显示/隐藏筛选
			function slideFilter(filter){
				if(filter.hasClass('show')){
					filter.removeClass('show');
					setTimeout(function(){
						filter.css('display','none');
					},300);
				}else{
					filter.css('display','block');
					setTimeout(function(){
						filter.addClass('show');
					},16);
				}
			}
//店铺改变事件
$("#shopId").change(function(){
	var shopId= $(this).val();
	
	if(shopId>0)
	{
		$("#shop").val(shopId);
			//dosubmit("queryOrderList");
			$.zui.messager.show("正在变更店铺……",{type:"warning",time:"2000"});
			location.href="orderManage.action?action=queryOrderList&shopId="+shopId;
	}
	receiveOrderNum();
	deciveOrderNum();
	completeOrderNum();
});
function printO()
{
	preview(1);
}
function closeModal()
{
	$('#printDialog').modal('hide');
}
function preview(oper)       
{
	if (oper < 10)
	{
	bdhtml=window.document.body.innerHTML;//获取当前页的html代码
	sprnstr="<!--startprint"+oper+"-->";//设置打印开始区域
	eprnstr="<!--endprint"+oper+"-->";//设置打印结束区域
	prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //从开始代码向后取html
	prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html
	window.document.body.innerHTML=prnhtml;
	window.print();
	window.document.body.innerHTML=bdhtml;
	} else {
	window.print();
	}
	$.getScript("<%=request.getContextPath()%>/framework/js/jquery.min.js");
	$.getScript("<%=request.getContextPath()%>/framework/js/z.min.js");
	$(".printbtn.btn-orange").on("click",function(){
		 var jsonDataString = $(this).attr("q");
		
		 showPrintD(jsonDataString);
	})
	return false;
}
function assignPrint(data)
{
	if(data)
	{
		$("#main_pay_status").html(data.custPayStatus==1?"已付款":"未付款");
		$("#main_arrive_time").text(data.arriveTime);
		$("#main_addr").text(data.orderMemberCarriage+data.orderMemberSeatNo);
		$("#main_phone").text(data.cust_phone);
		$("#main_name").html(data.custName);
		$("#main_product_num").html(data.productNum);
		$("#main_create").html(data.createDate);
		$("#sp_total").html(data.total);
		$("#sp_orderNo").html(data.mainOrderNo);
		$("#sp_delivery").html(data.deliveryFee);
		$("#main_total").html("￥"+data.total);
		
		
	}
}
function assignSubOrder(order)
{
	var list =order||{};
	if(order)
	{
	
		var html="";
		$(order).each(function(i,d){
			html+="<tr><td>"+d.ogComGoodsName+"</td><td>"+d.ogShopGoodsNum+"</td><td>￥"+d.ogComGoodsPriceDiscount+"</td><td>￥"+d.ogShopGoodsTotal+"</td></tr>";
		});
		if(html.length>0)
		{
				$("#subOrders").html("");
				$("#subOrders").html(html);
		}
	}
}
function showPrintD(jsonDATA)
{
	
	try{
			
			
			 //console.log(typeof jsonDataString)
			 if(typeof jsonDATA=="undefined")
			 {
				 return false;
			 }
			var mainOrderData = JSON.parse(jsonDATA);
			if(mainOrderData)
			{
				assignPrint(mainOrderData);
				var mainOrderId = mainOrderData.mainOrderId;
				var postData={
					action:"getSubOrder",
					mainOrderId:mainOrderId
				};
				$.post("orderManage.action",postData,function(retMsg){
					if(retMsg)
					{
						assignSubOrder(retMsg);
						preview(1);
					}
				},"json");
			}
		}catch(e)
		{
		}
}


	$("label").tooltip();
	$(".printbtn.btn-orange").click(function(){
		 var jsonDataString = $(this).attr("q");
		 console.log(jsonDataString);
		 showPrintD(jsonDataString);
	})
	$('#query_btn').click(function(){
		dosubmit("queryOrderList");
	});
	
	$('#clear_btn').click(function(){
		$('#search_div').find('input').val('');
		$('#querySrcType').val("");
		$('#querySrcShopId').val("");
		$('#search_div').find('.search-choice-close').click();
		$('#timeRange_7').click();
	});
	
	//查询待配送数量
	function deciveOrderNum(){
		var shopId= $("#shopId").val();
		var step = '5';
		if(shopId==null||shopId==""){
			$.zui.messager.show("请选择店铺！",{type:"warning"}	);
			return;
		}
		var postData={
				action:"queryReceiveOrderNum",
				"model.orderReceiveShopId":shopId,
				"model.step":step
			};
			$.post("orderManage.action",postData,function(retMsg){
				console.log("retMsg="+retMsg);
				if(retMsg&&retMsg.num!=0)
				{
					console.log("retMsg="+retMsg);
					$("#orderStep_5 .num").html(retMsg.num);
				}
			},"json");
		
	}
	//查询待完成数量
	function completeOrderNum(){
		var shopId= $("#shopId").val();
		var step = '3';
		if(shopId==null||shopId==""){
			$.zui.messager.show("请选择店铺！",{type:"warning"}	);
			return;
		}
		var postData={
				action:"queryReceiveOrderNum",
				"model.orderReceiveShopId":shopId,
				"model.step":step
			};
			$.post("orderManage.action",postData,function(retMsg){
				console.log("retMsg="+retMsg);
				if(retMsg&&retMsg.num!=0)
				{
					console.log("retMsg="+retMsg);
					$("#orderStep_3 .num").html(retMsg.num);
				}
			},"json");
		
	}
	//查询待接单数量
 	function receiveOrderNum(){
		var shopId= $("#shopId").val();
		var step = '4';
		if(shopId==null||shopId==""){
			$.zui.messager.show("请选择店铺！",{type:"warning"}	);
			return;
		}
		var postData={
				action:"queryReceiveOrderNum",
				"model.orderReceiveShopId":shopId,
				"model.step":step
			};
			$.post("orderManage.action",postData,function(retMsg){
				console.log("retMsg="+retMsg);
				if(retMsg)
				{
							console.log("retMsg="+retMsg);
							if(retMsg&&retMsg.num!=0)
							{
								$("#orderStep_4 .num").html(retMsg.num);
							}	
				}
			},"json");
		
	}
	
	
	getShopList();
	//店铺列表
    function getShopList(){
    	var reqData={action:"getShopList"};
    	$.post("addOrder.action",reqData,function(retMsg){
    		
    		
    			var data = eval(retMsg.shopList);
    			if(data.length>1){
    				$('#shopId').show();
    			}
    			if(data!=null)
    			{
    				var str = "";
    				str  += "<option value=\"\">--请选择店铺--</option>";
    				$(data).each(function(i,d){
    					if(i==0){
    						str += "<option selected=\"selected\" value=\""+data[i].shop_id+"\">"+data[i].shop_name+"</option>"
    					}else{
    						str += "<option value=\""+data[i].shop_id+"\">"+data[i].shop_name+"</option>"
    					}
    				});
    				$("#shopId").html(str);
    			}
    			receiveOrderNum();
    			deciveOrderNum();
    			completeOrderNum();
    	});
    }

    var bill_select=$('.billing-select');// 筛选
    var bill_nav=$('.billing-nav'); // 左侧导航


    // 左侧导航显示 
    $('.billing-header .icon-bill-01').on('click',function(e){
    	e.stopPropagation();
    	hideModule(bill_select);
    	slideModule(bill_nav);
    });
	
    function slideModule(o){
    	if(o.hasClass('show')){
    		o.removeClass('show');
    	}else{
    		o.addClass('show');
    	}
    }
    function showModule(o){
    	o.addClass('show');
    }

    function hideModule(o){
    	o.removeClass('show');
    }
	
	
	// 仅选择日期
	$("#queryDeliveryDate").datetimepicker(
	{
		language:  "zh-CN",
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0,
		format: "yyyy-mm-dd"
	});
	
	
});

//初始加载数据
function initdata(){
	dosubmit("queryOrderList");
}

//接单
function receiveOrder(mainOrderId,step){
	if(step-1==4){
		$.ajax({
	        type: "POST",
	        url: "orderManage.action?action=receiveOrder",
	        data: { 'model.orderId': mainOrderId, 
	       			'model.orderStep': step 
	       			},
	        dataType: "json",
	        success: function(data, textStatus) {
	        	if(data.result=='SKsuccessMessages'){
	            	msg = new $.zui.Messager(data.msg, {type: 'success', placement: 'top'});
	        		msg.show();
	        		dosubmit("queryOrderList");
	            }
	            if(data.result=='SKerrorMessages'){
	            	msg = new $.zui.Messager(data.msg, {type: 'danger', placement: 'top'});
	        		msg.show();
	        		//location.reload();
	            }
	        },
	        beforeSend: function(formData, jqForm, options) {
	            
	        },
	        async: false
	    });
	}else{
		$.zui.messager.show("步骤不对!",{type:"warning"});
		return;
	}
	
}
//配送
function deliveryOrder(mainOrderId,step){
	if(step==3){
		$.ajax({
	        type: "POST",
	        url: "orderManage.action?action=deliveryOrder",
	        data: { 'model.orderId': mainOrderId, 
	       			'model.orderStep': step 
	       			},
	        dataType: "json",
	        success: function(data, textStatus) {
	        	if(data.result=='SKsuccessMessages'){
	            	msg = new $.zui.Messager(data.msg, {type: 'success', placement: 'top'});
	        		msg.show();
	        		dosubmit("queryOrderList");
	            }
	            if(data.result=='SKerrorMessages'){
	            	msg = new $.zui.Messager(data.msg, {type: 'danger', placement: 'top'});
	        		msg.show();
	        		//location.reload();
	            }
	        },
	        beforeSend: function(formData, jqForm, options) {
	            
	        },
	        async: false
	    });
	}
	else{
		$.zui.messager.show("步骤不对!",{type:"warning"});
		return;
	}
	
}
</script>
<!--import footer-->
<%@include file="/framework/common/footer.jsp"%>
