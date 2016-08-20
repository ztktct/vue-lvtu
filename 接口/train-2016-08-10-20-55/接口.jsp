<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	 //测试 订单详情查询
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
	<!-- ***************************以上为订单详情（出处：orderDetail.jsp)********************************************************************** -->
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
	
	
<!-- ***********************************************************************以上为订单管理***********（出处：omn.jsp）********************************************************************* -->
<!-- ***********************************************************************以下为商品管理*******(出处：productManages.jsp)************************************************************************* -->

//搜索
$('#query_btn').click(function(){
	var queryProductDateBeg = $("#queryProductDateBeg").val();
	var queryProductDateEnd = $("#queryProductDateEnd").val();
	var shop_goods_name = $("#shop_goods_name").val();
	var shopShelve = $("#shopShelve").val();
	console.log("queryProductDateBeg="+queryProductDateBeg);
	console.log("queryProductDateEnd="+queryProductDateEnd);
	console.log("shop_goods_name="+shop_goods_name);
	console.log("shopShelve="+shopShelve);
	var shopId = $("#shopId").val();
	var reqData={
			action:"queryProductListByData",
			"model.shop_partner_shop_id":shopId,
			"model.queryProductDateBeg":queryProductDateBeg,
			"model.queryProductDateEnd":queryProductDateEnd,
			"model.shop_goods_name":shop_goods_name,
			"model.shop_goods_is_shelve":shopShelve
		
	};
	queryProductListByData(reqData);

	slideFilter($(".manage-filter"));
});

//查询商品列表
function queryProductListOfAll(shopId,classId){
	var reqData={
			action:"queryProductListOfAll",
			"model.shop_partner_shop_id":shopId,
			"model.shop_goods_class_id":classId
		};
	queryProductListByData(reqData);
}

function queryProductListByData(reqData){
	$.post("shopproduct.action",reqData,function(retMsg){
		console.log("sucess?="+"ssss")
		if(retMsg.error>0)
		{
			$("#updateShopProduct").modal('hide');
			$.zui.messager.show(retMsg.desc, {type: 'danger', placement: 'top'});
		}else{
			
		
		//	location.reload();
		var data = retMsg.datas;
		 countShelveQuery =retMsg.countShelveQuery; 
		 countClassQuery = retMsg.countClassQuery; 
		$("#tongji").html("");
		$("#tongji").html("<span>总数："+""+countClassQuery+"</span>"+"<span>上架数量："+""+countShelveQuery+"</span>");
		
		
		data=JSON.parse(data);
		console.log("data="+data);
		$("tbody").html("");
		if(data==""){
			$.zui.messager.show("没有数据！",{type:"danger"});
			return;
		}else{
			$.zui.messager.show(retMsg.desc, {type: 'success', placement: 'top'});
		}
		
	
		var src = "";
		$(data).each(function(i,d){
			console.log("d="+i);
				src+="<tr class=\"goods-item\" data-classId=\""+d.shop_goods_class_id+"\" data-shopIds=\""+d.shop_partner_shop_id+"\" data-shopGoodsIsShelve=\""+d.shop_goods_is_shelve+"\"  data-goodsId=\""+d.shop_goods_id+"\" data-goodsStock=\""+d.shop_goods_store+"\" data-goodsSort=\""+d.shop_goods_sort+"\">"+
				"<td><span>"+d.shop_goods_name+"</span></td>"+
				"<td><input type=\"text\" name=\"\" value=\""+d.shop_goods_store+"\" class=\"input-text input-stock\" disabled></td>"+
				"<td><input type=\"text\" name=\"\" value=\""+d.shop_goods_sort+"\" class=\"input-text input-sort\" disabled></td>"+
				"<td>";
		
				if(d.shop_goods_is_shelve==1){
					src+="<input type=\"button\" value=\"上架\" class=\"btn-coo btn-dgrey  btn-shelve\" style=\"display:none\">"+
					"<input type=\"button\" value=\"下架\" class=\"btn-coo btn-orange btn-shelf\" >"+
					"<input type=\"button\" value=\"删除\" class=\"btn-coo btn-lgrey btn-delete\" style=\"display:none\">";
				}else{
					src+="<input type=\"button\" value=\"上架\" class=\"btn-coo btn-dgrey  btn-shelve\">"+
					"<input type=\"button\" value=\"下架\" class=\"btn-coo btn-orange btn-shelf\" style=\"display:none\">"+
					"<input type=\"button\" value=\"删除\" class=\"btn-coo btn-lgrey btn-delete\" >";
				}
			src+="</td></tr>";
		});
		$("tbody").html(src);
		goodsInit();
		
		}
	},"json");
}
//保存编辑库存
//存放编辑的商品
var changeGoods=[];

		//mobile 
		if($('.goods-ul-select').width() >= $('.goods-manage-tit').width()- $('.goods-manage-tit .coo').width() ){
			$('.goods-manage-bd02').addClass('mobile');
		}
		
		// 编辑模式
		$('.goods-manage-tit .btn-change').on('click',function(){
			var shopId = $("#shopId").val();
			if(!shopId){
				$.zui.messager.show("请先选择店铺！",{type:"warning"});
				return;
			}
			$('.goods-manage-bd02').addClass('editable');
			$('.input-text').removeAttr('disabled');
			$('.btn-coo').attr('disabled','true');
		});
		// 保存编辑
		$('.goods-manage-tit .btn-edit').on('click',function(){
			$('.goods-manage-bd02').removeClass('editable');
			$('.input-text').attr('disabled','true');
			$('.btn-coo').removeAttr('disabled');
		console.log(changeGoods);
			// AJAX请求...
			if(changeGoods.length<=0){
				$.zui.messager.show("没有修改任何数据！",{type:"warning"});
				return;
			}
			sid = $("#shopId").val();
			if(sid>0)
			{
	
						var reqData={
							action:"updateShopProduct",
							"model.shop_partner_shop_id":sid,
							"model.goodsStr":JSON.stringify(changeGoods)
						};
						
						$.post("shopproduct.action",reqData,function(retMsg){
							console.log("sucess?="+"ssss")
							if(retMsg.error>0)
							{
								$("#updateShopProduct").modal('hide');
								$.zui.messager.show(retMsg.desc, {type: 'danger', placement: 'top'});
							}else{
								$.zui.messager.show(retMsg.desc, {type: 'success', placement: 'top'});
							//	location.reload();
							}
						},"json");
				
			}else{
				msg= new $.zui.Messager("请先选择店铺", {type: 'danger', placement: 'top'});
				msg.show();
				return ;
			}
		});
		//添加商品事件
	$("#btn_add").click(function(){
		var shopId = $("#shopId").val();
		if(!(shopId>0)){
			$.zui.messager.show("请先选择店铺!",{type:"warning"});
			return;
		}
		location.href="shopproduct.action?action=addProductList&shop="+shopId;
		
		
	});
	//添加商品保存事件
	$("#btn-add-shopproduct").click(function(){
		var msg;
		var id=[];
		var shopId= $("#shopId").val();
		$("input[name='chbForSelect']:checked").each(function(i,d){
			if($(this).val()>0)
			{
				
				id.push($(this).val());
			}
		});
		if(id.length>0&&shopId>0)
		{
			var reqData={productIds:id.join(","),shop:shopId,action:"spmAddShopProduct"};
			$.post("shopproduct.action",reqData,function(retMsg){
				if(retMsg.error>0)
				{
					 msg= new $.zui.Messager(retMsg.desc, {type: 'danger', placement: 'top'});
					 msg.show();
				}else{
					 msg= new $.zui.Messager(retMsg.desc, {type: 'success', placement: 'top'});
					 msg.show();
					 location.href="shopproduct.action?action=query&shopId="+shopId;
				}
			},"json")
		}else{
				 msg= new $.zui.Messager("请选择商品或者店铺后重试", {type: 'danger', placement: 'top'});
				 msg.show();
				 return;
		}
		
	});
	//删除店铺商品
function deleteShopProductId(shopProductId)
{
	var partnerId = $("#partnerId").val();
	var id=shopProductId;
	shopId = $("#shopId").val();
	if(shopId<=0){
		$.zui.messager.show("请先选择店铺！",{type:"warning"});
	}
	if(id>0)
	{
		var reqData={
			action:"deleteShopProductById",
			shopProductId:id,
			partnerId:partnerId,
			shop:shopId
		};
		$.post("shopproduct.action",reqData,function(retMsg){
			if(retMsg.error>0)
			{
				var msg = new $.zui.Messager(retMsg.desc, {type: 'danger', placement: 'top'});
				msg.show();
				//location.href="shopproduct.action?action=query&shopId="+shopId;
				//location.reload();
			}else{
				countClassQuery--;
				 $("#tongji").html("");
					$("#tongji").html("<span>总数："+""+countClassQuery+"</span><span>上架数量："+""+countShelveQuery+"</span>");
				$.zui.messager.show(retMsg.desc,{type:'success'});
				
				
				$("tr[data-goodsid='"+shopProductId+"']").remove();
			//	location.href="shopproduct.action?action=query&shopId="+shopId;
			}
		},"json");
	}else{
		var msg = new $.zui.Messager("参数错误", {type: 'danger', placement: 'top'});
		msg.show();
		return false;
	}
}
//库存修改
function updatInit(shopProductId)
{
	var id=shopProductId;
	var shopId = $("#shopId").val();
	if(id!=null)
	{
		var reqData={
			action:"getShopProduct",
			shop:shopId,
			shopProductId:id
		};
		$.post("shopproduct.action",reqData,function(retMsg){
			if(retMsg.error>0)
			{
				var msg = new $.zui.Messager(retMsg.desc, {type: 'danger', placement: 'top'});
				msg.show();
			}else{
				assignSingleForm(retMsg.retData);
			}
		},"json");
	}
}

//商品下架上架状态修改
function changeSellStatus(shopProductId,sellStatus,store,fn)
{		
		/* var state = goods.find('.state');
		var shopGoodsIsShelve =goods.find('input[name="shopGoodsIsShelve"]');
		var btnShelves=goods.find('.btnShelves'); */
		
		//下架
		if( sellStatus == 1 ){
			if( !confirm("下架会删除所有购物车里包含此商品的项目") ){
				return;
			}
		}
		
		var shopId = $("#shopId").val();
		if(shopId==null||shopId==""){
			$.zui.messager.show("请先选择店铺！",{type:"warning"});
			return;
		}
		if(sellStatus==0)
		{
			if(store<=0)
			{
				var msg = new $.zui.Messager("库存为0时不允许上架", {type: 'danger', placement: 'top'});
			
		        msg.show();
				return false;
			}
		}
		var id=shopProductId||0;
		var reqData={action:"changeSellStatus",
				"model.shop_goods_id":id,
				"model.shop_partner_shop_id":shopId
				};
		var msg = new $.zui.Messager("变更信息中……",{type:"warning",time:"1000"});
		msg.show();
		$.post("shopproduct.action",reqData,function(retMsg){
			if(retMsg.error>0)
			{
				var msg = new $.zui.Messager(retMsg.desc, {type: 'danger', placement: 'top'});
		        msg.show();
			}else{
				console.log("sellStatus="+sellStatus);
				fn();
				/* if( sellStatus == 1 ){
					shopGoodsIsShelve.val(0);
					state.html("状态：下架");
					btnShelves.html("上架");
				}else{
					shopGoodsIsShelve.val(1);
					state.html("状态：在售");
					btnShelves.html("下架");
				} */
			}
		},"json")
}

<!-- 888888888888888888888888888888888888888888888以下为菜品添加列表页面 出处：addproduct.jsp88888888888888888888888888888888888888888888888888888888 -->
//查找类别列表
	function findClass(){
				var reqData={action:"getAllClassList"};
				$.post("shopproduct.action",reqData,function(retMsg){
					if(retMsg.error==0)
					{
					showClassList(retMsg.retData);
					}
				},"json")
			}
	function showClassList(data){
		$("#goodsplay").html("");
		$(".goods-ul-select").html("");
		$("#goodsplay").append("<option value=\"-1\">"+"--请选择分类--"+"</option>");
		if(data){
			$(data).each(function(i,d){
				if(i==0){
					$("#goodsplay").append("<option selected=\"selected\"  value=\""+d.productClassId+"\">"+d.productClassName+"</option>");
					$(".goods-ul-select").append("<li class=\"on\" data-classid=\""+d.productClassId+"\">"+d.productClassName+"</li>");
					$("#classId").val(d.productClassId);
				}else{
					$("#goodsplay").append("<option  value=\""+d.productClassId+"\">"+d.productClassName+"</option>");
					$(".goods-ul-select").append("<li data-classid=\""+d.productClassId+"\">"+d.productClassName+"</li>");
				}
					
					var goodsclass= $("#classId").val();
					getAllProductList(goodsclass);
			});
		}
		
	}
	
	
	//获取产品列表
	function getAllProductList(classId)
	{
			var shopId = <%=request.getParameter("shop")%>
			if(classId==null||classId==""){
				classId = $("#classId").val();
			}
				var reqData={action:"getAllProductList",classId:classId,shop:shopId};
				console.log(JSON.stringify(reqData));
		var msg = new $.zui.Messager('正在获取产品列表……', {type:"warning",time:"5000"});
		msg.show();
		$.post("shopproduct.action",reqData,function(retMsg){
			assignProductList(retMsg.retData);
			msg.hide();
		},"json")
	}
	<!-- ********************************************************************以下为补票延长 （出处：uptickets.jsp）****************************************************************************** -->
	
//补票延长列表查询
$(document).ready(function(){
	queryUpTicketList();
	function queryUpTicketList(){
		
		$.post("upTicket.action",
				{
				action:"queryUpTicketList",
				"qform.ticketShopId":1,
				"qform.ticketIs":0,
				"qform.pageIndex": 1,
				"qform.pageSize":10
				},function(data){
					
				if(data.result=='SKerrorMessages'){
					$.zui.messager.show(data.msg,{type:"warning"});
				}else{
					$.zui.messager.show(data.msg,{typpe:"warning"});
					console.log("data="+JSON.stringify(data.data));
				}
		});
	}
});

//补票事件
function changeSellStatus(ticketId)
{		
		
		var id=ticketId;
		var reqData={action:"changeSellStatus",
				ticketId:id
				};
		$.zui.messager.show("变更信息中……",{type:"warning"});
		$.post("upTicket.action",reqData,function(retMsg){
			if(retMsg.error>0)
			{
				var msg = new $.zui.Messager(retMsg.desc, {type: 'danger', placement: 'top'});
		        msg.show();
			}else{
				$.zui.messager.show("补票成功！",{type:"success"});
				location.reload();
				
			}
		},"json")
}
	
	<!-- **************************************************************退款(出处：refundOrder.jsp)***************************************************************************************** -->
	//退款处理
function changeRefundStatus(refId,refIsAuth)
{		
		//var isHandle = $("#isHandle").val();
		
		//var refIsAuth = $("#isAuth").val();
		//var refId = $("#refundDo").attr("data-id");
		console.log("refId="+refId);
		var reqData={action:"changeRefundStatus",
				"model.refId":refId,
				"model.refIsAuth":refIsAuth,
				};
		console.log("refIsAuth="+refIsAuth);
		$.zui.messager.show("变更信息中……",{type:"warning"});
		$.post("refundOrder.action",reqData,function(retMsg){
			//$('#refundc').hide();
			if(retMsg.error>0)
			{
				var msg = new $.zui.Messager(retMsg.msg, {type: 'danger', placement: 'top'});
		        msg.show();
			}else{
				var nums= parseInt($('.refundNum .num').eq(0).text());
				
				$.zui.messager.show("处理完成！",{type:"success"});
				console.log("nums="+nums);
				if(nums>0){
					nums--;
				}
				if(nums!=0){
					$('.refundNum .num').text(nums);
				}else{
					$('.refundNum .num').text('');
				}
				
				var refundNoBtn=$('#refundNoBtn').parent();
				var refundIsBtn=$('#refundIsBtn').parent();
				refundNoBtn.removeClass('on');
				refundIsBtn.addClass('on');
				$('#refundNo').removeClass('on');
				$('#refundIs').addClass('on');
				getRefundOrderList("1"	);
			}
		},"json")
}
//退款列表
function getRefundOrderList(isHandle){
	 console.log("isHandle="+isHandle);
	var shopId = $("#shopId").val();
	console.log("shopId="+shopId);
	var reqData={action:"getRefundOrderList",
							  "model.refShopId":shopId,
							  "model.refIsAuth":isHandle
	};
	$.post("refundOrder.action",reqData,function(retMsg){
			if(retMsg.error>0){
				$.zui.messager.show("没有数据！",{type:"danger"});
				 $("#refundIs").html("");
				 $("#refundNo").html("");
				return;
			}else{
				var data = JSON.parse(retMsg.data);
				console.log("data="+JSON.stringify(data));
				if(null == isHandle||""==isHandle||0==isHandle){
					refundNoInit(data);
				}else{
					refundIsInit(data);
				}
				
			}
	});
}
//已经处理
function refundIsInit(data){
	 $("#refundIs").html("");
		var src = "";
		$(data).each(function(i,d){
			console.log("d="+d);
				src+="	<div class=\"order-record\">"+
					"<div class=\"or-wrap\">"+
					"<div class=\"item\">"+
					"<span>商品信息：</span>"+
					"<strong>"+d.orderDefGoodsName+"..等</strong>"+
				"</div>"+
				"<div class=\"item\">"+
				"<span>联系人姓名：</span>"+
				"<strong>"+d.orderMemberName+"</strong>"+
			"</div>"+
			"<div class=\"item\">"+
			"<span>联系人电话：</span>"+
			"<strong>"+d.orderMemberPhone+"</strong>"+
		"</div>"+
		"<div class=\"item\">"+
		"<span>订单商品数量：</span>"+
		"<strong>"+d.orderDefTotalNum+"</strong>"+
	"</div>"+
	
	
				"<div class=\"item\">"+
					"<span>申请时间：</span>"+
					"<strong>"+d.refCreateDate+"</strong>"+
				"</div>"+
				"<div class=\"item\">"+
					"<span>退款类型：</span>"+
					"<strong>"+d.refType+"</strong>"+
			"	</div>"+
				"<div class=\"item\">"+
					"<span>备注：</span>"+
					"<strong>"+d.refDetail+"</strong>"+
				"</div>"+
				"<div class=\"item\">"+
					"<span>是否已经处理：</span>"+
					"<strong>"+d.refIsAuthName+"</strong>"+
				"</div>"+
						"<div class=\"item\">"+
						"<span>是否同意：</span>"+
						"<strong>"+d.refIsAuthNameOn+"</strong>"+
						"</div>"+
						"<div class=\"item\">"+
						"<span>是否删除：</span>"+
						"<strong>"+d.refIsDelName+"</strong>"+
						"</div>"+
					"</div>"+
					"<a href=\"tel:"+d.orderMemberPhone+"}\" class=\"telephone\" title=\""+d.orderMemberPhone+"\"><i class=\"icon-telephone\"></i><span>"+d.orderMemberPhone+"</span></a>"+
					"</div>";
		});
		$("#refundIs").html(src);
		
}
//未处理
function refundNoInit(data){
		$("#refundNo").html("");
		var src = "";
		$(data).each(function(i,d){
			console.log("d="+d);
				src+="	<div class=\"order-record\">"+
					"<div class=\"or-wrap\">"+
					"<div class=\"item\">"+
					"<span>商品信息：</span>"+
					"<strong>"+d.orderDefGoodsName+"..等</strong>"+
				"</div>"+
				"<div class=\"item\">"+
				"<span>联系人姓名：</span>"+
				"<strong>"+d.orderMemberName+"</strong>"+
			"</div>"+
			"<div class=\"item\">"+
			"<span>联系人电话：</span>"+
			"<strong>"+d.orderMemberPhone+"</strong>"+
		"</div>"+
		"<div class=\"item\">"+
		"<span>订单商品数量：</span>"+
		"<strong>"+d.orderDefTotalNum+"</strong>"+
	"</div>"+
	
						"<div class=\"item\">"+
							"<span>申请时间：</span>"+
							"<strong>"+d.refCreateDate+"</strong>"+
						"</div>"+
						"<div class=\"item\">"+
							"<span>退款类型：</span>"+
							"<strong>"+d.refType+"</strong>"+
					"	</div>"+
						"<div class=\"item\">"+
							"<span>备注：</span>"+
							"<strong>"+d.refDetail+"</strong>"+
						"</div>"+
						"<div class=\"item\">"+
							"<span>是否已经处理：</span>"+
							"<strong>"+d.refIsAuthName+"</strong>"+
						"</div>"+
						"<div class=\"item\">"+
						"<span>是否删除：</span>"+
						"<strong>"+d.refIsDelName+"</strong>"+
						"</div>"+
					"</div>"+
					"<div class=\"or-cooperation\">"+
					"<a href=\"javascript:;\" id=\"refundDo\" class='btn-orange' data-id=\""+d.refId+"\"  onclick=\"changeRefundStatus("+d.refId+",'1');\">同意</a>"+
					"<a href=\"javascript:;\" id=\"refundNoDo\" class='btn-orange'  data-id=\""+d.refId+"\"  onclick=\"changeRefundStatus("+d.refId+",'2');\">不同意</a>"+
					"</div>"+
					"<a href=\"tel:"+d.orderMemberPhone+"}\" class=\"telephone\" title=\""+d.orderMemberPhone+"\"><i class=\"icon-telephone\"></i><span>"+d.orderMemberPhone+"</span></a>"+
					
					"</div>";
		});
		$("#refundNo").html(src);
}
	
	<!-- 提醒页面***（出处：top.jsp)********************************************************************************** -->
	
function  searchFlag()
{
	
	//window.write("<audio id=\"aaa\" src=\"123.mp3\" autoplay controls></audio>")
	var rData={
		action:"scanOrderFromLast"
	};
	$.post("orderManage.action",rData,function(retMsg){
		if(parseInt(retMsg.newOrder)==1||parseInt(retMsg.newTicket)==2||parseInt(retMsg.newRefund)==3)
		{
			msg = new $.zui.Messager("您有新的消息请查看！", {type: 'warning', placement: 'top',time:0,close:true});
			msg.show();
			playOrPaused();
		}
	
	},"json");
}
<!-- 底部数字提醒*****（出处：bottom.jsp)******************************************************************************************** -->
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