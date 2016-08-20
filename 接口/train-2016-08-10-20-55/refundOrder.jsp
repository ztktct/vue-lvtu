<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/framework/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/framework/common/header.jsp"%>
 <%@page import="com.alibaba.fastjson.JSON"%>  
<meta charset="UTF-8">
	<title>旅途点点店铺平台-商品管理-退款处理</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" >
	<meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/framework/css/style.css">
	<link href="<%=request.getContextPath()%>/framework/css/mobiscroll.css" rel="stylesheet" type="text/css">
	<script src="<%=request.getContextPath()%>/framework/js/autoFontSize.js"></script>
	<script src="<%=request.getContextPath()%>/framework/js/DateUtil.js"></script>
<script type="text/javascript" src="<c:url value='/framework/js/webuploader.min.js'/>"></script>
<script src="<%=request.getContextPath()%>/framework/js/zepto.min.js"></script>
	<style>
		.order-manage-hd,.order-manage-bd .order-record{margin-bottom:0;}
		.wrapTab-nav{border-bottom:0;}
		.nav-tabs>li{float:none;}
		.nav-tabs>li select{border-radius:0;}
		.fix-top{position:fixed;z-index:20;left:0;right:0;top:1.41333rem;background:#f2f2f2;}
		.order-manage-bd{margin-top:2.34rem}
		#refundc{display:none;position:fixed;z-index:100;top:0;bottom:0;right:0;left:0;background:rgba(0,0,0,.3);margin:0}
		#refundc .order-block{display:block;position:absolute;left:50%;top:50%;-webkit-transform:translate(-50%,-50%);transform:translate(-50%,-50%);background:#fff;padding:45px 25px;border-radius:10px;width:30%;}
		.order-manage-hd li{position:relative;}
		.order-manage-hd li .num{font-size:.375rem;position:absolute;min-width:1.25em;height:1.25em;background:#ef574a;color:#fff;text-align:center;line-height:1.375em;border-radius:.625em;top:6%;left: 50%;top: 6%; -webkit-transform: translate(100%); transform: translate(100%);}
		.order-manage-hd li .num:empty{display:none;}
		.order-manage-bd .order-record .or-cooperation{-webkit-box-pack:end;-webkit-justify-content:flex-end;-moz-box-pack:end;-ms-flex-pack:end;justify-content:flex-end;}
		.order-manage-bd .order-record .or-cooperation a{margin-left:10px;font-style:normal;color:#fff;}
		.order-manage-bd .order-record .telephone{width:auto;height:auto;border-radius:0;background:transparent;}
		.order-manage-bd .order-record .icon-telephone{margin-right:5px;}
		@media screen and (max-width:768px){
			#refundc .order-block{width:80%;}
		}
		#refundc .form-inline{display:-webkit-box;display:-webkit-flex;display:-moz-box;display:-ms-flexbox;display:flex;}
		#refundc .form-inline .form-control{margin-right:1em;}
	</style>
</head>
<body>
 <%@ include file="/train/trainSide/sp/base/top.jsp"%>
<!-- 后台开单头部 -->
	<header class="billing-header backstage-header">
		<i class="icon-bill-01"></i>
		<h2>退款处理</h2>
		<ul class="billing-header-ul">
					<li>车次：<s:property value="#request.userName"/></li>
					<li>
					<select class="form-control" name="shopId" id="shopId" style="display:none;">
					</select>
					</li>
		</ul>
	</header>
				<%@ include file="/train/trainSide/sp/base/leftMenu.jsp"%>
<form method="post" action="upTicket.action?action=query" id="searchFrom">
	<div class="fix-top">
	<nav class="order-manage-hd">
		<ul>
				
			<li class="on"><a class="refundNum" href="javascript:;" id="refundNoBtn">待处理<span class="num"></span></a></li>
			<li><a href="javascript:;" id="refundIsBtn">已处理</a></li>
		</ul>
	</nav>
</div>
	<main class="order-manage-bd">
	
		<!-- 待退款 -->
		<div class="order-block on" id="refundNo">
					
		</div>

		<!-- 已退款 -->
		<div class="order-block"  id="refundIs">
		
		</div>
			
		
	</main>
	<main class="order-manage-bd" id="refundc" >
			<!-- 处理框-->
			<div class="order-block on" id="refundNo">
				<input type="hidden" name="isHandle" id="isHandle">
				<div class="form-inline">
						<select id="isAuth" name="isAuth" class="form-control">
								<option selected="selected" value="">--请选择处理结果--</option>
								<option  value="1">同意</option>
								<option value="2">不同意</option>
						</select>
					<input type="button" onclick="changeRefundStatus();" value="提交" class="btn btn-primary">
				</div>
		</div>
		</main>

</form>
<%@ include file="/train/trainSide/spm/shopproduct/buttomOfList.jsp"%>
</body>
<script type="text/javascript">
		$(function(){
			var tab_tit=$('.order-manage-hd li');
			var tab_con=$('.order-block');

			tab_tit.on('click',function(){
				
				tab_tit.removeClass('on');
				$(this).addClass('on');
				tab_con.removeClass('on');
				tab_con.eq($(this).index()).addClass('on');
				
			
			});
		});
	</script>
	
<script type="text/javascript">
function changeToShow(isHandle){
	if(isHandle!=0){
			$.zui.messager.show("已经处理，不可重复！",{type:"danger"});
			return;
	}
	$("#refundc").show();
	$("#isHandle").val(isHandle);
}
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


$(function(){
	getShopList();
	
	$("#refundNoBtn").on("click",function(){
			var isHandle = 0;
			getRefundOrderList(isHandle);
	});
	$("#refundIsBtn").on("click",function(){
		var isHandle = 1;
		getRefundOrderList(isHandle);
});

	
	
	
	 
	 
	 
	 
	 
	
	
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
   						$("#shop").val(data[i].shop_id);
   					}else{
   						str += "<option value=\""+data[i].shop_id+"\">"+data[i].shop_name+"</option>"
   					}
   				});
   				$("#shopId").html(str);
   			}
   			getRefundOrderList(0);
   			//queryRefundNum();
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
	
	//店铺改变事件
	$("#shopId").change(function(){
		var shopId= $(this).val();
		
		if(shopId>0)
		{
			$("#shop").val(shopId);
				//dosubmit("queryOrderList");
				$.zui.messager.show("正在变更店铺……",{type:"warning"});
				dosubmit("queryOrderList");
		}
		getRefundOrderList(0);
	});
	
	
	
});
</script>
</html>