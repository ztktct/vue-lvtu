<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<footer class="manage-ft">
		<ul>
			<li>
				<a id="orderManager" href="<%=request.getContextPath()%>/orderManage.action?action=init"><i class="icon-layers"></i>订单管理
					<span class="num"></span>
				</a></li>
				
			<li><a href="<%=request.getContextPath()%>/shopproduct.action?action=init"><i class="icon-menu"></i>商品管理</a></li>
			<li><a class="refundNum" href="<%=request.getContextPath()%>/refundOrder.action?action=init"><i class="icon-tickets"></i>退款申请<span class="num"></span></a></li>
			<li><a id="upticketnum" href="<%=request.getContextPath()%>/upTicket.action?action=init"><i class="icon-tickets"></i>补票管理<span class="num"></span></a></li>
			<!-- <li><a href="javascript:;"><i class="icon-lost"></i>旅客帮助</a></li> -->
		</ul>
	</footer>
<script type="text/javascript">
$(function(){
	receiveOrderNum();
	upTicketsOrderNum();
	queryRefundNum();
	//查询订单数量
 	function receiveOrderNum(){
		var shopId= $("#shopId").val();
		console.log("shopId="+shopId);
		var step = '';
	
		var postData={
				action:"queryOrderNum",
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
								$("#orderManager .num").html(retMsg.num);
							}	
				}
			},"json");
		
	}
 	//查询退款申请数量
 	function queryRefundNum(){
		var shopId= $("#shopId").val();
		console.log("shopId="+shopId);
			
		var postData={
				action:"queryRefundNum",
				"model.refShopId":shopId,
				"model.refIsAuth":0
			};
			$.post("refundOrder.action",postData,function(retMsg){
				console.log("retMsg="+retMsg);
				if(retMsg)
				{
							console.log("retMsg="+retMsg);
							if(retMsg&&retMsg.num!=0)
							{
								$(".refundNum .num").html(retMsg.num);
							}	
				}
			},"json");
		
	}
	//查询为补票数量
 	function upTicketsOrderNum(){
		var shopId= $("#shopId").val();
		console.log("shopId="+shopId);
	
		var postData={
				action:"upTicketsOrderNum",
				"qform.ticketShopId":shopId
			};
			$.post("upTicket.action",postData,function(retMsg){
				console.log("retMsg="+retMsg);
				if(retMsg)
				{
							console.log("retMsg="+retMsg);
							if(retMsg&&retMsg.num!=0)
							{
								$("#upticketnum .num").html(retMsg.num);
							}	
				}
			},"json");
		
	}
	
	
});

</script>