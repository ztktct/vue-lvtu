<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/framework/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/framework/common/header.jsp"%>
 <%@page import="com.alibaba.fastjson.JSON"%>  
<meta charset="UTF-8">
	<title>旅途点点店铺平台-商品管理-补票延长</title>
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
		.wrapTab-nav{border-bottom:0;}
		.nav-tabs>li{float:none;}
		.nav-tabs>li select{border-radius:0;}
		.fix-top{position:fixed;z-index:20;left:0;right:0;top:1.41333rem;background:#f2f2f2;}
		.order-manage-bd{margin-top:2.45rem}
		.order-manage-bd .order-record .telephone{width:auto;height:auto;border-radius:0;background:transparent;}
		.order-manage-bd .order-record .icon-telephone{margin-right:5px;}
		.order-manage-hd{margin-bottom:0;}
	</style>
</head>
<body>
 <%@ include file="/train/trainSide/sp/base/top.jsp"%>
<!-- 后台开单头部 -->
	<header class="billing-header backstage-header">
		<i class="icon-bill-01"></i>
		<h2>补票延长</h2>
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
	<s:hidden name="model.partnerId" id="partnerId"></s:hidden>
	<s:hidden name="shop" id="shop"></s:hidden>
	<s:hidden name="shopName" id="shopName"></s:hidden>
	
	
	<div class="fix-top">
	<nav class="order-manage-hd">
		<ul>
				
			<li class="on"><a href="javascript:;">待补票</a></li>
			<li><a href="javascript:;">已补票</a></li>
		</ul>
	</nav>
</div>
	<main class="order-manage-bd">
	
		<!-- 待补票 -->
		<div class="order-block on">
		<s:iterator id="shopProductList" value="#request.upTicketList" status="st" var="list">
					<input id="shop_idsn" name="shop_ids" type="hidden" value="${ticketShopId}">
			<!-- 一条订单 -->
			<s:if test="#list.ticketIs == 0">
							
			<div class="order-record">
				<div class="or-wrap">
					<div class="item">
						<span>联系人：</span>
						<strong>${ticketName}</strong>
					</div>
					<div class="item">
						<span>申请时间：</span>
						<strong>${ticketCreateDate}</strong>
					</div>
					<div class="item">
						<span>车　　次：</span>
						<strong>${ticketTrain}</strong>
					</div>
					<div class="item">
						<span>车厢座位：</span>
						<strong>${ticketCarriage}-${ticketSeat}</strong>
					</div>
					<div class="item">
						<span>手机号码：</span>
						<strong>${ticketPhone}</strong>
					</div>
				</div>
				<div class="or-cooperation">
					<%-- <span>补票起始-达站：<em>${ticketStart}-${ticketEnd}</em></span> --%>
					<a href="javascript:;" onclick="changeSellStatus(${ticketId});"><i  class="btn-orange" >补票</i> </a>
									
				</div>
				<a href="tel:${ticketPhone}" class="telephone"><i class="icon-telephone"></i><span>${ticketPhone}</span></a>
				</div>
				</s:if>
				</s:iterator>
			</div>

		<!-- 已补票 -->
		<div class="order-block">
		<s:iterator id="shopProductList" value="#request.upTicketList" status="st" var="list">
					<input id="shop_idsy" name="shop_ids" type="hidden" value="${ticketShopId}">
			<!-- 一条订单 -->
			<s:if test="#list.ticketIs == 1">
			<div class="order-record">
				<div class="or-wrap">
					<div class="item">
						<span>联系人：</span>
						<strong>${ticketName}</strong>
					</div>
					<div class="item">
						<span>申请时间：</span>
						<strong>${ticketCreateDate}</strong>
					</div>
					<div class="item">
						<span>车　　次：</span>
						<strong>${ticketTrain}</strong>
					</div>
					<div class="item">
						<span>车厢座位：</span>
						<strong>${ticketCarriage}-${ticketSeat}</strong>
					</div>
					<div class="item">
						<span>手机号码：</span>
						<strong>${ticketPhone}</strong>
					</div>
				</div>
				<%-- <div class="or-cooperation">
					<span>补票起始-到达站：<em>${ticketStart}-${ticketEnd}</em></span>
				</div> --%>
				<a href="tel:${ticketPhone}" class="telephone"><i class="icon-telephone"></i><span>${ticketPhone}</span></a>
				</div>
			</s:if>
			</s:iterator>
			</div>
			
		
	</main>

<script type="text/javascript">

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
</script>
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
				
				/*
				var ticketIs ;
				var shopId = $("#shop").val();
				if($(this).text()=='待补票'){
					 ticketIs = $("#shop_idsn").val();
				}else{
					 ticketIs = $("#shop_idsy").val();
				}
				location.href="upTicket.action?action=query&qform.ticketIs="+ticketIs+"&qform.ticketShopId="+shopId;
				*/
			});
		});
	</script>
	
<script type="text/javascript">

function iFrameHeight() {   
	var ifm= document.getElementById("printFrame");   
	var subWeb = document.frames ? document.frames["printFrame"].document : ifm.contentDocument;   
	if(ifm != null && subWeb != null) {
	   ifm.height = subWeb.body.scrollHeight;
	   ifm.width = subWeb.body.scrollWidth;
	}   
}
function printO()
{
	
	
	preview(1);
	
	
	
}
function closeModal()
{
	$('#printDialog').modal('hide');
	//var modalTrigger = $('#printDialog').model();
	//modalTrigger.close();
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
	/*$("#testClose").on("click",function(){
	
		// $('#printDialog').modal("hide");
			//modalTrigger.close();
	})*/
	$(".btn.btn-primary").on("click",function(){
		 var jsonDataString = $(this).attr("q");
		
		 showPrintD(jsonDataString);
	})
	return false;
}
function changeSellStatuss(){
	$.zui.messager.show("不可重复补票！",{type:"warning"});
}

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
function assignPrint(data)
{
	if(data)
	{
		$("#main_pay_status").html(data.custPayStatus==1?"已付款":"未付款");
		$("#main_arrive_time").text(data.arriveTime);
		$("#main_addr").text(data.addr);
		$("#main_phone").text(data.cust_phone);
		$("#main_name").html(data.custName);
		$("#main_product_num").html(data.productNum);
		$("#main_create").html(data.createDate);
		$("#sp_total").html(data.total);
		$("#sp_orderNo").html(data.mainOrderNo);
		$("#sp_delivery").html(data.deliveryFee);
		$("#main_total").html(data.total);
		
	}
}
function assignSubOrder(order)
{
	var list =order||{};
	if(order)
	{
	
		var html="";
		$(order).each(function(i,d){
			html+="<tr><td>"+d.productName+"</td><td>"+d.productNum+"</td><td>"+d.price+"</td><td>"+d.total+"</td></tr>";
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
				$.post("orderManage.h8h",postData,function(retMsg){
					if(retMsg)
					{
						assignSubOrder(retMsg);
						preview(1);
					}
				},"json");
				/*$('#printDialog').modal({
					show: true,
					position:'200px'
				});*/
			}
		}catch(e)
		{
			//console.log(e);
			//$('#printDialog').modal('hide');
		}
}
$(function(){
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
   						$("#shop").val(data[i].shop_id);
   						console.log("shop="+$("#shop").val());
   					}else{
   						str += "<option value=\""+data[i].shop_id+"\">"+data[i].shop_name+"</option>"
   					}
   				});
   				$("#shopId").html(str);
   			}
   			
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
		upTicketsOrderNum();
	});
	$('.productList table').datatable({minFixedLeftWidth: 100});
	$("#btn-select-all").click(function(){
		$("input[name='chbForSelect']").each(function(){
			$(this).attr("checked",true);
		})
	});
	$("#btn-select-none").click(function(){
		$("input[name='chbForSelect']").each(function(){
			$(this).attr("checked",false);
		})
	});
	$("#btn-select-another").click(function(){
		$("input[name='chbForSelect']").each(function(){
			if($(this).attr("checked"))
			{
				$(this).attr("checked",false);
			}else{
				$(this).attr("checked",true);
			}
		})
	});
	$(".btn.btn-primary").click(function(){
		/* var jsonDataString = $(this).attr("q");
		 console.log(jsonDataString)
		 showPrintD(jsonDataString);
		$('#printDialog').modal({
			show: true,
			position:'200px'
		});*/
	})
	$("#print_btn").click(function(){
		//$("#printFrame").attr("src","http://weixin.bantubento.com/default.php/Home/Order/printOrder?mainOrderNo="+$(this).attr("t"));
		
	});
	$('#query_btn').click(function(){
		dosubmit("queryOrderList");
	});
	
	$('#clear_btn').click(function(){
		$('#search_div').find('input').val('');
		$('#querySellStatus').val("-1");
		$('#querySrcShopId').val("");
		$('#search_div').find('.search-choice-close').click();
		$('#timeRange_7').click();
	});
	
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
</script>
<script>
localData = {
        hname:location.hostname?location.hostname:'localStatus',
        isLocalStorage:window.localStorage?true:false,
        dataDom:null,

        initDom:function(){ //初始化userData
            if(!this.dataDom){
                try{
                    this.dataDom = document.createElement('input');//这里使用hidden的input元素
                    this.dataDom.type = 'hidden';
                    this.dataDom.style.display = "none";
                    this.dataDom.addBehavior('#default#userData');//这是userData的语法
                    document.body.appendChild(this.dataDom);
                    var exDate = new Date();
                    exDate = exDate.getDate()+30;
                    this.dataDom.expires = exDate.toUTCString();//设定过期时间
                }catch(ex){
                    return false;
                }
            }
            return true;
        },
        set:function(key,value){
            if(this.isLocalStorage){
                window.localStorage.setItem(key,value);
            }else{
                if(this.initDom()){
                    this.dataDom.load(this.hname);
                    this.dataDom.setAttribute(key,value);
                    this.dataDom.save(this.hname)
                }
            }
        },
        get:function(key){
            if(this.isLocalStorage){
                return window.localStorage.getItem(key);
            }else{
                if(this.initDom()){
                    this.dataDom.load(this.hname);
                    return this.dataDom.getAttribute(key);
                }
            }
        },
        remove:function(key){
            if(this.isLocalStorage){
                localStorage.removeItem(key);
            }else{
                if(this.initDom()){
                    this.dataDom.load(this.hname);
                    this.dataDom.removeAttribute(key);
                    this.dataDom.save(this.hname)
                }
            }
        }
    }
</script>
</html>