<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/framework/common/taglibs.jsp"%>
<head>
<%@ include file="/framework/common/header.jsp"%>
 <%@page import="com.alibaba.fastjson.JSON"%>  
<meta charset="UTF-8">
	<title>旅途点点店铺平台-商品管理-商品管理</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" >
	<meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/framework/css/style.css">
	<link href="<%=request.getContextPath()%>/framework/css/mobiscroll.css" rel="stylesheet" type="text/css">
	<script src="<%=request.getContextPath()%>/framework/js/autoFontSize.js"></script>
<script src="<%=request.getContextPath()%>/framework/js/DateUtil.js"></script>
<script src="<%=request.getContextPath()%>/framework/js/zepto.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/framework/js/mobiscroll_002.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/framework/js/mobiscroll.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/framework/js/mobiscroll_show.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/framework/js/queryTrain.js"></script>
	<style>
		.goods-manage-hd .add-goods{background:transparent;}
		.goods-manage-bd{;margin-top:2.4458rem;margin-bottom:0;}
		.manage-filter{padding-top:1.41333rem;}
		a:active:focus{color:#fff;}
		.goods-select{width:auto}
		.goods-manage-bd02 {margin-top:3.798515rem;margin-bottom:1.75rem;}
		.goods-manage-bd02 .goods-manage-tit{position:fixed;left:0;right:0;background:#f1f1f1;top:2.61333rem;}
		#tongji{font-size:16px;text-align:center;margin-top:1rem;}
		#tongji span{background:#ef574a;border-radius:5px;color:#fff;padding:6px 16px;margin:0 10px;}
	</style>
</head>

<script type="text/javascript">
$(function(){
	var ds=["1","7","30"];
	for(var i=0;i<ds.length;i++){
		$("#timeRange_"+ds[i]).click(function(){
	        var idIndex=(this.id).substring((this.id).indexOf('timeRange_')+10);
	        var endDate = DateUtil.dateAdd('n', 1, new Date());//加一分钟
	        var startDate = DateUtil.dateAdd('d', 1-idIndex, endDate);//向前几天
	      	$('#queryProductDateBeg').val(DateUtil.dateToStr('yyyy-MM-dd 00:00', startDate));
	      	$('#queryProductDateEnd').val(DateUtil.dateToStr('yyyy-MM-dd HH:mm', endDate));
      	});
	}

	var stepTab=["100", "3","4","5","6","7","close"];
	for(var i=0;i<stepTab.length;i++){
		$("#orderStep_"+stepTab[i]).click(function(){
			var idIndex=(this.id).substring((this.id).indexOf('orderStep_')+10);
	        $("#orderStep").val(idIndex);
	       // initdata();
      	});
	}
	
	$("#orderStep_"+$("#orderStep").val()).tab('show');
	

});

</script>
 
<body>
 <%@ include file="/train/trainSide/sp/base/top.jsp"%>
<%@ include file="/train/trainSide/sp/base/leftMenu.jsp"%>

<form method="post" action="shopproduct.action?action=query" id="searchFrom">
	<s:hidden name="model.partnerId" id="partnerId"></s:hidden>
	<s:hidden name="shop" id="shop"></s:hidden>
	<s:hidden name="classId" id="classId"></s:hidden>
	<header class="billing-header backstage-header">
		<i class="icon-bill-01"></i>
		
		<h2>商品管理</h2>
		<ul class="billing-header-ul">
					<li>车次：<s:property value="#request.userName"/></li>
					<li>
					<select class="form-control" name="shopId" id="shopId" style="display:none;">
					</select>
					</li>
				</ul>
	</header>
	<header class="goods-manage-hd">
		<h2>商品管理</h2>
		<div class="rarea">
			<span class="search"><i class="icon-search"></i> 商品搜索</span>
			<button type="button" class="add-goods" id="btn_add">&nbsp;&nbsp;+添加菜品&nbsp;&nbsp;</button>
		</div>
	</header>
		
	
	
	<main class="goods-manage-bd02">
		
		<section class="goods-manage-tit">
			<div class="goods-select-wrap">
				<select name="" id="class_id" class="goods-select form-control">
				
				</select>
				<ul class="goods-ul-select">
			
				</ul>
			</div>
			
			<div class="coo">
				<input type="button" class="btn btn-primary btn-change" value="批量修改">
				<input type="button" class="btn btn-danger btn-edit" value="保存修改">
			</div>
		</section>

			<table>
				<thead>
					<tr>
						<th>菜品名称</th>
						<th>库存</th>
						<th>排序</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
			<%-- 	<s:iterator id="shopProductList" value="#request.shopProductList" status="st" var="list">
			
					<tr class="goods-item" data-classId="${shop_goods_class_id}" data-shopIds="${shop_partner_shop_id}" data-shopGoodsIsShelve="${shop_goods_is_shelve}"  data-goodsId="${shop_goods_id}" data-goodsStock="${shop_goods_store}" data-goodsSort="${shop_goods_sort}">
						<td><span>${shop_goods_name}</span></td>
						<td><input type="text" name="" value="${shop_goods_store}" class="input-text input-stock" disabled></td>
						<td><input type="text" name="" value="${shop_goods_sort}" class="input-text input-sort" disabled></td>
						<td>
						<s:if test="#list.shop_goods_is_shelve==1">
							<input type="button" value="上架" class="btn-coo btn-dgrey  btn-shelve" style="display:none">
							<input type="button" value="下架" class="btn-coo btn-orange btn-shelf" >
							<input type="button" value="删除" class="btn-coo btn-lgrey btn-delete" style="display:none">
						</s:if>
						<s:else>
							<input type="button" value="上架" class="btn-coo btn-dgrey  btn-shelve">
							<input type="button" value="下架" class="btn-coo btn-orange btn-shelf" style="display:none">
							<input type="button" value="删除" class="btn-coo btn-lgrey btn-delete" >
						</s:else>
						</td>
					</tr>
				</s:iterator> --%>
				</tbody>
			</table>
			<div id="tongji">
				
			</div>
		
	</main>
	
	
	<!-- 搜索 -->
	<div class="manage-filter form-lists">
		<div class="wrap">
			<div class="form-item">
				<label>出售状态</label>
				<div class="input-wrap">
					<select name="shop_goods_is_shelve" id="shopShelve">
						<option value="">--请选择出售状态--</option>
						<option value="1">在售</option>
						<option value="0">下架</option>
					</select>
				</div>
			</div>
			<!-- <div class="form-item">
				<label>产品分类</label>
				<div class="input-wrap">
					<select  name="model.shop_goods_class_id" id="goodsplays">
					        	<option value="">--请选择分类--</option>
					        </select>
				</div>
			</div> -->
			<div class="form-item">
				<label>添加时间</label>
				<div class="input-wrap">
					<input type="text" id="queryProductDateBeg" name="queryProductDateBeg" class="beginTime" data-timetype="datetime-local" min="2016-01-01 00:00:00"
					 placeholder="请选择开始时间">
				</div>
				<i class="icon-arrow-down"></i>
			</div>
			<div class="form-item">
				<label>至</label>
				<div class="input-wrap">
					<input type="text" id="queryProductDateEnd" name="queryProductDateEnd" class="beginTime" data-timetype="datetime-local" min="2016-01-01 00:00:00"
					 placeholder="请选择终止时间">
				</div>
				<i class="icon-arrow-down"></i>
			</div>
			<div class="form-item">
				<label>菜名</label>
				<div class="input-wrap">
					<input type="text" id="shop_goods_name" name="shop_goods_name" placeholder="请输入菜名">
				</div>
			</div>
			
			<div class="form-item form-item-btns">
				<input type="reset" value="重置" class="btn-reset">
				<button type="button" class="btn-search btn-orange" id="query_btn">&nbsp;&nbsp;搜索&nbsp;&nbsp;</button>
			</div>
		</div>
	</div>

<!-- **产品编辑  refuseOrder 模态框** -->
<div class="modal fade" id="updateShopProduct" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><i class="icon icon-times"></i></button>
        <h4 class="modal-title">编辑</h4>
      </div>
      <div class="modal-body">
      	<div class="form-horizontal" role="form">
      		<div class="form-group">
      			<label class="col-sm-2 control-label">库存：</label>
      			<div class="col-sm-10">
					<input type="hidden" id="hide_shopProductId"/>
					<input type="text" class="form-control" placeholder="库存" value="0" id="txt_store">
					<input type="hidden" value="0" id="hide_store"/>
				</div>
      		</div>
      		<div class="form-group">
      			<label class="col-sm-2 control-label">排序：</label>
      			<div class="col-sm-10">
        			<input type="text" class="form-control" placeholder="排序" value="0" id="txt_orderBy">
					<input type="hidden" value="0" id="hide_orderBy"/>
        		</div>
        	</div>
        </div>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-primary" id="btn-update">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>
	
</form>
    
<%@ include file="/train/trainSide/spm/shopproduct/buttomOfList.jsp"%>
</body>

<script type="text/javascript">
var countShelveQuery =""; 
var countClassQuery = ""; 
$(function(){
getShopList();
goodsInit();
findClass();
queryProductListOfAll();
/*
var shopIds = $("#shopId").val();
var classIds = $("#classId").val();

 console.log("shopIds="+shopIds+"classIds="+classIds);
function addProductList(classId){
	var shopId = $("#shopId").val();
	location.href="shopproduct.action?action=query&shop="+shopId+"&model.shop_goods_class_id="+classId;
} */
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
		
		
		
		
		
		
		
		
		
		// 切换分类
		$('.goods-ul-select ').on('click','li',function(){
			$('.goods-ul-select li').removeClass('on');
			$(this).addClass('on');
			var classid = $(this).attr("data-classid");
			$("#classId").val(classid);
			//addProductList(classid);
			var shopIdss = $("#shopId").val();
			queryProductListOfAll(shopIdss,classid);
		});
		$("#class_id").on("change",function(){
			var classid = $(this).val();
			$("#classId").val(classid);
			//addProductList(classid);
			var shopIdss = $("#shopId").val();
			queryProductListOfAll(shopIdss,classid);

			
		});
		
	
	
		
		function goodsInit(){
			
			$('.goods-item').each(function(){
				var id=$(this).attr('data-goodsId');//ID
				var stockVal=$(this).attr('data-goodsStock');//库存
				var sortVal=$(this).attr('data-goodsSort');//排序
				
				var stocks = $(this).find('.input-stock');
				var sorts = $(this).find('.input-sort');
		
				var shelve = $(this).find('.btn-shelve');//上架
				var shelf = $(this).find('.btn-shelf');//下架
				var delbtn = $(this).find('.btn-delete');//删除
			
				var $that=$(this);
				
				var good={
					id:id,
					stocks:stockVal,
					sorts:sortVal
				};
		
				stocks.on('change',function(){
					var hasSame = false;
					good.stocks = $(this).val();
					//changeGoods["'"+id+"'"]=good;
					for(var i = 0 , j = changeGoods.length;i<j;i++){
						if( changeGoods[i].id == good.id ){
							hasSame=true;
							changeGoods[i] = good;
						}
					}
					if(!hasSame){
						changeGoods.push( good );
					}
					
				});
		
				sorts.on('change',function(){
					var hasSame = false;
					good.sorts = $(this).val();
					//changeGoods["'"+id+"'"]=good;
					
					for(var i = 0 , j = changeGoods.length;i<j;i++){
						if( changeGoods[i].id == good.id ){
							hasSame=true;
							changeGoods[i] = good;
						}
					}
					if(!hasSame){
						changeGoods.push( good );
					}
				});
				
				
				//删除操作
				delbtn.on('click',function(){

					deleteShopProductId(id);
				
				});
				// 上架操作
				shelve.on('click',function(){
					var shopGoodsIsShelve=$that.attr('data-shopGoodsIsShelve');//状态
					var classidss = $(this).attr("data-classid");
					var $shelve = $(this);
					
					changeSellStatus(id,shopGoodsIsShelve,stockVal,function(){
						
						 countShelveQuery++;
						 $("#tongji").html("");
							$("#tongji").html("<span>总数："+""+countClassQuery+"</span><span>上架数量："+""+countShelveQuery+"</span>");
						$that.attr('data-shopGoodsIsShelve','1');
						$shelve.css('display','none');
						shelf.css('display','inline-block');
						delbtn.css('display','none');
					});
					
					// AJAX。。。
					
				});
		
				// 下架操作
				shelf.on('click',function(){
					var shopGoodsIsShelve=$that.attr('data-shopGoodsIsShelve');//状态
					var $shel=$(this);
					
					changeSellStatus(id,shopGoodsIsShelve,stockVal,function(){
						 countShelveQuery--;
						 $("#tongji").html("");
							$("#tongji").html("<span>总数："+""+countClassQuery+"</span><span>上架数量："+""+countShelveQuery+"</span>");
						$that.attr('data-shopGoodsIsShelve','0');
						$shel.css('display','none');
						delbtn.css('display','inline-block');
						shelve.css('display','inline-block');
					});
					
					// AJAX。。。
					
				});
		
			});
			
			
			
			

		}
		
		
	
	
	
	
	
	//店铺列表
    function getShopList(){
    	var reqData={action:"getShopList"};
    	$.post("addOrder.action",reqData,function(retMsg){
    			var data = eval(retMsg.shopList);
    			if(data.length>1){
    				$('#shopId').show();
    			}
    			console.log("data="+JSON.stringify(data));
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
    				$("#shop").val($("#shopId").val());
    			}
    			
    	});
    }
	
    var bill_select=$('.billing-select');// 筛选
    var bill_nav=$('.billing-nav'); // 左侧导航

	var filter=$('.goods-manage-hd .search');
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
		if(shopId>0){
			
			$("#shop").val(shopId);
				$.zui.messager.show("正在变更店铺……",{type:"warning"});
				location.href="shopproduct.action?action=query&shop="+shopId;

		}
		
	});
	
	$("label").tooltip();
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
	
	/* 上下架 */
	$('.goods-manage-item').each(function(){
		var btnShelves=$(this).find('.btnShelves');
		var goods = $(this);
		
		btnShelves.on('click',function(){

			var shopGoodsId=goods.find('input[name="shopGoodsId"]').val();
			var shopGoodsIsShelve=goods.find('input[name="shopGoodsIsShelve"]').val();
			var shopGoodsStore=goods.find('input[name="shopGoodsStore"]').val();
			changeSellStatus(shopGoodsId,shopGoodsIsShelve,shopGoodsStore,goods);
		});
		
	});
})
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
function assignSingleForm(data)
{
	if(data)
	{
		$("#txt_store").val(data.shop_goods_store);
		$("#txt_orderBy").val(data.shop_goods_sort);
		$("#hide_store").val(data.shop_goods_store);
		$("#hide_orderBy").val(data.shop_goods_sort);
		$("#hide_shopProductId").val(data.shop_goods_id);
		$('#updateShopProduct').modal({
					show: true,
					position:'200px'
		});
	}
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
	$(".btn.btn-primary").on("click",function(){
		 var jsonDataString = $(this).attr("q");
		
		 showPrintD(jsonDataString);
	})
	return false;
}
function findClass(){
	var reqData={action:"getAllClassList"};
	$.post("shopproduct.action",reqData,function(retMsg){
		if(retMsg.error==0)
		{
		showClassList(retMsg.retData);
		showClassListOfIndex(retMsg.retData);
		
		}
	},"json")
}
function showClassListOfIndex(data){
	$(".goods-select").html("");
	$(".goods-ul-select").html("");

	
	if(data){
		$(data).each(function(i,d){
				
					if(i == 0){
						$(".goods-ul-select").append("<li class=\"on\" data-classid=\""+d.productClassId+"\">"+d.productClassName+"</li>");
						$(".goods-select").append("<option selected value=\""+d.productClassId+"\">"+d.productClassName+"</option>");
					}else{
						$(".goods-ul-select").append("<li data-classid=\""+d.productClassId+"\">"+d.productClassName+"</li>");
						$(".goods-select").append("<option value=\""+d.productClassId+"\">"+d.productClassName+"</option>");
					}
				
		});
		$("#classId").val($("#class_id").val());
	}
	
}

function GetQueryString(name) {  
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");  
    var r = window.location.search.substr(1).match(reg);  //获取url中"?"符后的字符串并正则匹配
    var context = "";  
    if (r != null)  
         context = r[2];  
    reg = null;  
    r = null;  
    return context == null || context == "" || context == "undefined" ? "" : context;  
}

function showClassList(data){
	$("#goodsplays").html("");
	$("#goodsplays").append("<option value=\"\">"+'请选择分类'+"</option>");
	if(data){
		$(data).each(function(i,d){
				$("#goodsplays").append("<option value=\""+d.productClassId+"\">"+d.productClassName+"</option>");
			
		});
	}
	
}

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
			}
		}catch(e)
		{
		}
}
 
</script>
<!--import footer-->
<%@include file="/framework/common/footer.jsp"%>