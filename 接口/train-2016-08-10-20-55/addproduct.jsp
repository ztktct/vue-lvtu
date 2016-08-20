<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/framework/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/framework/common/header.jsp"%>
 <%@page import="com.alibaba.fastjson.JSON"%>  
<meta charset="UTF-8">
	<title>旅途点点店铺平台-商品管理-菜品列表</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" >
	<meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/framework/css/style.css">
	<link href="<%=request.getContextPath()%>/framework/css/mobiscroll.css" rel="stylesheet" type="text/css">
	<script src="<%=request.getContextPath()%>/framework/js/autoFontSize.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/framework/js/mobiscroll.zepto.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/framework/js/mobiscroll_002.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/framework/js/mobiscroll.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/framework/js/mobiscroll_show.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/framework/js/queryTrain.js"></script>
	<script type="text/javascript">
	$(function(){
		//mobile 

		
		findClass();
		if($('.goods-ul-select').width() >= $('.goods-manage-bd02 .modal-header').width()- $('#add').width() ){
			$('.goods-manage-bd02').addClass('mobile');
		}
		$(window).resize(function(){
			if($('.goods-ul-select').width() >= $('.goods-manage-bd02 .modal-header').width()- $('#add').width() ){
				$('.goods-manage-bd02').addClass('mobile');
			}else{
				$('.goods-manage-bd02').removeClass('mobile');
			}
		});
		/* var goodsclass= $("#goodsplay").val();
			getAllProductList(goodsclass); */
		
			$("#btn-add-shopproduct").click(function(){
				var msg;
				var id=[];
				var shopId= <%=request.getParameter("shop")%>;
				
				$("input[name='chbForSelect']:checked").each(function(i,d){
					if($(this).val()>0)
					{
						
						id.push($(this).val());
					}
				});
				if(id.length>0&&shopId>0)
				{
					var reqData={productIds:id.join(","),shop:shopId,action:"spmAddShopProduct"};
					var msg = new $.zui.Messager("正在添加商品……",{type:"warning"});
					msg.show();
					$.post("shopproduct.action",reqData,function(retMsg){
						if(retMsg.error>0)
						{
							 msg= new $.zui.Messager(retMsg.desc, {type: 'danger', placement: 'top'});
							 msg.show();
						}else{
							 msg= new $.zui.Messager(retMsg.desc, {type: 'success', placement: 'top'});
							 msg.show();
							 var shopId = $("#shop").val();
							 
							 location.href='shopproduct.action?action=query&shopId='+shopId;
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
	$("#goodsplay").on("change",function(){
		var goodsclass= $("#goodsplay").val();
		$("#classId").val(goodsclass);
		if(goodsclass>0){
			getAllProductList(goodsclass);
		}
	});
	// 切换分类
	$('.goods-ul-select ').on('click','li',function(){
		$('.goods-ul-select li').removeClass('on');
		$(this).addClass('on');
		var classid = $(this).attr("data-classid");
		console.log("classid="+classid	);
		$("#classId").val(classid);
		if(classid>0){
			getAllProductList(classid);
		}
	});
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
	function assignProductList(data)
	{
		var htmlStr="";
		if(data)
		{
			$(data).each(function(i,d){
				htmlStr+="<li><div class='img'><img src=\"http://lvtudiandian.img-cn-hangzhou.aliyuncs.com/"+d.comGoodsImgOss+"\" height=\"100\" width=\"100\" /></div><div class='context'><p class='name'><label><input type=\"checkbox\" value=\""+d.comGoodsId+"\" name=\"chbForSelect\" />"+d.comGoodsName+"</label></p>";
				htmlStr+="<ul><li>价格:"+d.comGoodsPrice+" </li>"+
				"<li>折扣价:"+d.comGoodsPriceDiscount+"</li>"+
				"</ul></div></li>";
				//<li>购买量:"+d.buyCount+"</li><li>浏览量:"+d.scanCount+"</li>
			});
			if(htmlStr!="")
			{
				$("#productListForSelect").html("");
				$("#productListForSelect").html(htmlStr);
			}
		}else{
			$("#productListForSelect").html("<h1>抱歉，没有符合要求的产品，亲！</h1>");
		}
	}
	});
	</script>
	<style type="text/css">
	.modal-header {
		padding-bottom: 40px;
	}
		#play {
			float:left;
		}
		#add {
			float: right;
		}
		.goods-manage-item .goods-manage-body{display:block;margin-top:2.50625rem;}
		.goods-manage-body > .control-label{display:block;}
		#productListForSelect{overflow:hidden;}
		#productListForSelect>li{float:left;width:50%;-webkit-box-sizing:border-box;box-sizing:border-box;text-align:center;margin:0 auto 10px;}
		.order-md-hd{position:fixed;top:0;left:0;right:0;}
		.modal-header{top:1.046851rem;position:fixed;left:0;right:0;padding-bottom:10px;}
		.goods-manage-bd{margin-bottom:0;}
	</style>
</head>
<body>
 <%@ include file="/train/trainSide/sp/base/top.jsp"%>
	<header class="order-md-hd">
		<h2>菜品列表</h2>
		<a href="javascript:history.go(-1);"><i class="icon-back"></i>返回上级</a>
	</header>
<input type="hidden" name="shop" id="shop" value="<%=request.getParameter("shop")%>">
<input type="hidden" name="classId" id="classId" value="">
	<main class="goods-manage-bd goods-manage-bd02">
		<!-- 一个菜品 -->
		<div class="goods-manage-item">
			<div class="modal-header">
			<div id="play" class="goods-manage-tit" style="padding:0;">
				<select class="goods-select form-control" id="goodsplay" >
        		</select>
        		<ul class="goods-ul-select" style="padding:0;">
        		</ul>
			</div>
			<div id="add">
			 <button type="button" class="btn btn-primary" id="btn-add-shopproduct">添加</button>	
			</div>	
						
      </div>
			<div class="body goods-manage-body">
      			<label class=" control-label">产品列表：</label>
      			<div class="">
					<ul id="productListForSelect" class="form-control" style="height:auto"></ul>
        			
        		</div>
			</div>
		</div>
		
		
	</main>

	

</body>
</html>