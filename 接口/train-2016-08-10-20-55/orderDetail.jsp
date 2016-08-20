<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/framework/common/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="<c:url value='/framework/plugins/boxer/css/jquery.fs.boxer.css'/>" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/framework/css/style.css">
<script src="<%=request.getContextPath()%>/framework/js/autoFontSize.js"></script>
<head>
	<%@ include file="/framework/common/header.jsp"%>
	<title>旅途点点商家平台-订单管理-订单详情</title>
	<style>
	.orderSteps li{width:33%;}
	.order-md-hd h2{margin:0;}
	.order-md-hd{position:fixed;top:0;left:0;right:0;}
	.wrapRight{margin-top:1.05rem;}
	.manage-ft ul{margin-bottom:0;}
	.manage-ft a{color:#333;}
	@media screen and (max-width:1000px){
		.orderDetail .status,.orderDetail .info{width:100%;padding:0;float:none;border:0;}
		
		.wrapFooter{font-size:12px;}
		.orderDaily ul{font-size:14px;}
		.orderDetail .status .nav li a{font-size:16px;}
		.wrapRight{float:none;margin-bottom:0;padding-bottom:0;}
	}
	</style>
	<script type="text/javascript">
	 $(document).ready(function(){
		 aa();
		 console.log("dddddd");
		 function aa(){
			 $.post("orderManage.action",{
				 	action:"queryOrderDetail",
				 	"model.orderId": '771'
				 
			 },function(data){
				 if(data.result=='SKerrorMessages'){
					 $.zui.messager.show(data.msg,{type:"warning"});
					 return;
				 }
				 console.log("aaaaaaaaaaaaaaa="+JSON.stringify(data.mainOrder));
				 console.log("bbbbbbbbbbbb="+JSON.stringify(data.orderGoodsList));
				 console.log("ccccccccccccc="+JSON.stringify(data.orderLogList));
			 });
		 }
		 //测试
	
	 });
	</script>
</head>
<script src="<%=request.getContextPath()%>/framework/plugins/boxer/js/jquery.fs.boxer.js"></script>
<script>
$(document).ready(function() {
  $(".boxer").not(".retina, .boxer_fixed").boxer({top:80,fixed:false});
});
</script>

<body>
 <%@ include file="/train/trainSide/sp/base/top.jsp"%>
<header class="order-md-hd">
		<h2>订单详情</h2>
		<a href="javascript:history.go(-1);"><i class="icon-back"></i>返回上级</a>
	</header>

<form method="post" action="orderManage.action">
<s:hidden name="model.partnerId" id="partnerId"></s:hidden>
	<s:hidden name="model.orderId" id="orderId"></s:hidden>
	<s:hidden name="model.ogId" id="ogId"></s:hidden>
	<s:hidden name="model.orderStep" id="orderStep"></s:hidden>
	<s:hidden name="model.step" id="step"></s:hidden>

<div class="wrapRight">
<div class="wrapTab">	
	<div class="wrapTab-cont tab-content">
		<!-- **订单详情** -->
		<div class="tab-pane active" id="tab01">
			<ol class="orderSteps">
				<li class="step-first">
					<div id="step_4">
						<div class="name">接单</div>
						<div class="check"></div>
						<div class="time" id="time_3">${model.orderReceiveDate }</div>
					</div>
				</li>
				<li>
					<div id="step_5">
						<div class="name">配送</div>
						<div class="check"></div>
						<div class="time" id="time_4">${model.orderDeliveryDate }</div>
					</div>
				</li>
				<li class="step-last">
					<div id="step_6">
						<div class="name">完成</div>
						<div class="check"></div>
						<div class="time" id="time_5">${model.orderIsCompleteDate }</div>
					</div>
				</li>
			</ol>
			
			<h4 class="header-dividing">基本信息</h4>
			<div class="orderDetail">
			<div class="info">
			<section class="order-md-info">
				<div class="container">
					<div class="item">
						<span>订单编号：</span>
						<strong>${model.orderNo }</strong>
					</div>
					<div class="item">
						<span>下单时间：</span>
						<strong>${model.orderCreateDate}</strong>
					</div>
					<%-- <div class="item">
						<span>车　　次：</span>
						<strong>${model.orderReceiveShopName}</strong>
					</div> --%>
					<div class="item">
						<span>车厢座位：</span>
						<strong>${model.orderMemberCarriage}车${model.orderMemberSeatNo}</strong>
					</div>
					<div class="item">
						<span>送餐时间：</span>
						<strong>${model.orderDeliveryDate}</strong>
					</div>
				</div>
				
			</section>
		
			
			
			
			<!-- 
				<div class="info">
					<dl>
						<dt>主订单编号：</dt>
						<dd>${model.orderNo }</dd>
					</dl>
					<dl>
						<dt>客户姓名：</dt>
						<dd>${model.orderMemberName }(${model.orderMemberPhone })</dd>
					</dl>
					<dl>
						<dt>位置：</dt>
						<dd><span>${model.orderMemberCarriage}${model.orderMemberSeatNo}</span></dd>
					</dl>
					<s:if test="#request.orderList.size()>0">
						<dl>
							<dt>图：</dt>
							<dd>
								<div class="orderAddGoods">
									<div class="basic">
										<div class="add-img-box">
											<s:iterator id="insPic" value="#request.orderList">
												<a href="${ogComGoodsImg }" class="boxer boxer-image" rel="gallery"><img src="${ogComGoodsImg }"/></a>
											</s:iterator>
										</div>
									</div>
								</div>
							</dd>
						</dl>
					</s:if>
					
					-->
				</div>
				<div class="status">
					<h3>订单状态：
						<s:if test="%{model.orderIsDel == 1}">
							<span>已关闭</span>
						</s:if>
						<s:else>
							${model.stepName }
						</s:else>
					</h3>
					<ul class="nav nav-pills">
					  <li role="presentation" class="active"><a href='javascript:void(0)' onclick='mainOrderLog()'>订单日志</a></li>
					</ul>
					<div class="orderDaily" id="orderDaily" style="display:none">
						<ul>
							<li class="first">
								<div class="time">${model.orderCreateDate }</div>
								<div class="point"></div>
								<div class="txt">新增订单</div>
							</li>
							
							<s:iterator id="orderMap" value="#request.orderLogList" var="orderMap" status="st">
									
									<s:if test="#st.last">
										<li class="last">
									</s:if>
									<s:else>
										<li>
									</s:else>
											<div class="time"><s:property value="operDate" /></div>
											<div class="point"></div>
											<div class="txt"><s:property value="content" /></div>
										</li>
								
							</s:iterator>
						</ul>
					</div>
				</div>
			</div>
			
			<h4 class="header-dividing">产品</h4>
			<section class="order-md-dishes normal-dishes">
		<s:iterator id="orderMap" value="#request.orderList" var="order">
			<div class="dishes-item">
				<div class="imgwrap">
					<img src="${ogComGoodsImg}" alt="">
				</div>
				<div class="rarea">
					<div class="top">${ogComGoodsName}</div>
					<div class="middle">数量：${ogShopGoodsNum}份</div>
					<div class="bottom">金额：￥${ogComGoodsPriceDiscount}</div>
				</div>
			</div>
			</s:iterator>
			
			<div class="dishes-price">
				总金额：<strong><span id="acc_${model.orderId}" class="f16 red fb">￥${model.orderTotal}</span></strong>
				应付金额：<strong><span id="acc_${model.orderId}" class="f16 red fb">￥${model.orderDuePay}</span></strong>
				实付金额：<strong><span id="acc_${model.orderId}" class="f16 red fb">￥${model.orderPay}</span></strong>
			</div>
	</section>
	
	 <!-- 
			<div class="orderList">
				<table width="100%">
					<thead>
						<tr class="order-hd text-center">
							<td>名称</td>
							<td>单价</td>
							<td>数量</td>
						</tr>
					</thead>
					<tbody>
						<s:iterator id="orderMap" value="#request.orderList" var="order">
							<tr class="order-bd">
								<td class="goods">
									<div class="img"><img src="${ogComGoodsImg}" ></div>
									<div class="name">${ogComGoodsName}</div>
								</td>
								<td class="number">
									<span>￥${ogComGoodsPriceDiscount}</span>
								</td>
								<td class="number">
									<span>${ogShopGoodsNum}</span>
								</td>
							</tr>
						</s:iterator>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="9">应付金额：<span id="acc_${model.orderId}" class="f16 red fb">￥${model.orderTotal}</span></td>
						</tr>
					</tfoot>
				</table>
			</div>
			
			-->
		</div>
	</div>
</div>
</div>

<!-- *page content end* -->
</div>
</form>
<%@ include file="/train/trainSide/spm/shopproduct/buttomOfList.jsp"%>

</body>
<script type="text/javascript">

$(function(){
	
	var ds=["1","2","3","4","5","6"];
	for(var i=0;i<ds.length;i++){
		if(ds[i].indexOf($('#orderStep').val()) >= 0){
			if(i==2){
				$('#step_'+ds[3]).addClass("step-done");
				$('#step_'+ds[4]).addClass("step-cur");
				break;
			}else{
				$('#step_'+ds[i]).addClass("step-cur");
				break;
			}
			
			
		} else {
			$('#step_'+ds[i]).addClass("step-done");
		}
	}
	
	$('#main_order_desc_ok').click(function(){
		var mainOrderId = $('#mainOrderId').val();
		var descContent = $('#descContent').val();
		if(descContent === ''){
			msg = new $.zui.Messager('备注内容不能为空！', {type: 'danger', placement: 'top'});
			$('#descContent').focus();
	        msg.show();
	        return;
		}
		$.ajax({
	        type: "POST",
	        url: "orderManage.action?action=mainOrderDesc",
	        data: { 'model.mainOrderId': mainOrderId, 
	       			'model.descContent': descContent },
	        dataType: "json",
	        success: function(data, textStatus) {
	        	if(data.result=='SKsuccessMessages'){
	            	msg = new $.zui.Messager(data.msg, {type: 'success', placement: 'top'});
	        		msg.show();
	        		$('#mainOrderDesc').modal('hide');
	            }
	            if(data.result=='SKerrorMessages'){
	            	msg = new $.zui.Messager(data.msg, {type: 'danger', placement: 'top'});
	        		msg.show();
	            }
	        },
	        beforeSend: function(formData, jqForm, options) {
	            
	        },
	        async: false
	    });
	});

	$('#close_order_ok').click(function(){
		var deleteReason = $('#deleteReason').val();
		var deleteReasonName = $("#deleteReason").find("option:selected").text();
		var mainOrderId = $('#mainOrderId').val();
		var orderId = $('#orderId').val();
		if(deleteReason === ''){
			msg = new $.zui.Messager('关闭理由不能为空！', {type: 'danger', placement: 'top'});
			$('#deleteReason').focus();
	        msg.show();
	        return;
		}
		$.ajax({
	        type: "POST",
	        url: "orderManage.action?action=closeOrder",
	        data: { 'model.deleteReason': deleteReason, 
	        		'model.deleteReasonName': deleteReasonName,
	       			'model.mainOrderId': mainOrderId, 
	       			'model.orderId': orderId },
	        dataType: "json",
	        success: function(data, textStatus) {
	        	if(data.result=='SKsuccessMessages'){
	        		$('#close_' + orderId).html("<span>已关闭</span>");
	        		$('#acc_' + mainOrderId).text("￥" + data.acc);
	        		$('#changePrice_' + mainOrderId).text("");
	            	msg = new $.zui.Messager(data.msg, {type: 'success', placement: 'top'});
	        		msg.show();
	        		$('#closeOrder').modal('hide');
	            }
	            if(data.result=='SKerrorMessages'){
	            	msg = new $.zui.Messager(data.msg, {type: 'danger', placement: 'top'});
	        		msg.show();
	            }
	        },
	        beforeSend: function(formData, jqForm, options) {
	            
	        },
	        async: false
	    });
	});
	
	$('#submit_exception_ok').click(function(){
		var expTye = $('#expTye').val();
		var expTypName = $("#expTye").find("option:selected").text();
		var expReason = $('#expReason').val();
		var mainOrderId = $('#mainOrderId').val();
		var orderId = $('#orderId').val();
		if(expTye === ''){
			msg = new $.zui.Messager('异常类型不能为空！', {type: 'danger', placement: 'top'});
			$('#expTye').focus();
	        msg.show();
	        return;
		}
		$.ajax({
	        type: "POST",
	        url: "orderManage.action?action=submitException",
	        data: { 'model.expTye': expTye, 
	        		'model.expTypName': expTypName,
	       			'model.expReason': expReason,
	       			'model.mainOrderId': mainOrderId, 
	       			'model.orderId': orderId },
	        dataType: "json",
	        success: function(data, textStatus) {
	        	if(data.result=='SKsuccessMessages'){
	            	$('#expTye_' + orderId).text(expTypName);
	            	$('#expReason_' + orderId).text(expReason);
	            	$('#exception_' + orderId).html("");
	            	msg = new $.zui.Messager(data.msg, {type: 'success', placement: 'top'});
	        		msg.show();
	        		$('#submitException').modal('hide');
	            }
	            if(data.result=='SKerrorMessages'){
	            	msg = new $.zui.Messager(data.msg, {type: 'danger', placement: 'top'});
	        		msg.show();
	            }
	        },
	        beforeSend: function(formData, jqForm, options) {
	            
	        },
	        async: false
	    });
	});
	
});

function mainOrderLog(){
	if($('#orderDaily')[0].style.display == "none"){
       	$('#orderDaily')[0].style.display = "block";
   	}else{
      	$('#orderDaily')[0].style.display = "none";
 	}
}

function mainOrderDesc(mainOrderId){
	$('#mainOrderId').val(mainOrderId);
	$.ajax({
		type: "POST",
	    url: "orderManage.action?action=queryDescContent",
	    data: { 'model.mainOrderId': mainOrderId},
	    dataType: "json",
	    success: function(data, textStatus) {
	        $('#descContent').val(data.descContent);
	    },
	    beforeSend: function(formData, jqForm, options) {
	            
	    },
	    async: false
	});
	$('#mainOrderDesc').modal({
		show: true,
		position:'200px'
	});
}



function closeOrder(mainOrderId, orderId){
	$('#mainOrderId').val(mainOrderId);
	$('#orderId').val(orderId);
	$('#closeOrder').modal({
		show: true,
		position:'200px'
	});
}

function submitException(mainOrderId, orderId){
	$('#mainOrderId').val(mainOrderId);
	$('#orderId').val(orderId);
	$('#submitException').modal({
		show: true,
		position:'200px'
	});
}

function changePrice(orderId){
	$('#orderId').val(orderId);
	var url = "orderManage.action?action=initChangePrice&callbackMethod=callbackMethod&closeMethod=closeMethod&orderId=" + orderId;
	$('#changePrice_iframe').attr("src", url);
	$('#changePrice').modal({
		show: true,
		position:'200px'
	});
}

function closeMethod(){
	$('#changePrice').modal('hide');
}
 
function callbackMethod(data){
	closeMethod();
} 

</script>
<!--import footer-->
<%@include file="/framework/common/footer.jsp"%>
