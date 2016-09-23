<template>
	<div class="order-table" transition="slide-left">
		<header class="order-md-hd">
	        <h2>订单列表</h2>
	        <a v-link="{name:'query'}"><i class="icon-back"></i>返回上级</a>
	    </header>
	    <div class="table-wrap">
	    	<table class="table">
		    	<thead>
			    	<tr>
			    		<th>订单编号</th>
			    		<th>商品名称</th>
			    		<th>日期</th>
			    		<th>车次</th>
			    		<th>金额</th>
			    		<th>总计</th>
			    	</tr>
		    	</thead>
			    <tbody v-for="main in mainOrders">
			    	<tr>
			    		<td rowspan="{{ childOrders[main.orderId].length + 1 }}">{{main.orderNo}}</td>
			    		<td>{{main.ogComGoodsName}}</td>
			    		<td>{{main.orderCreateDate}}</td>
			    		<td>{{main.orderMemberTrain}}</td>
			    		<td></td>
			    		<td rowspan="{{ childOrders[main.orderId].length + 1 }}">{{main.orderTotal}}</td>
			    	</tr>
			    	<template v-for="child in childOrders[main.orderId]">
			    		<tr>
				    		<td>{{child.ogComGoodsName}}</td>
				    		<td>{{child.orderCreateDate}}</td>
				    		<td>{{child.orderMemberTrain}}</td>
				    		<td>{{child.ogComGoodsPriceDiscount}}</td>
				    	</tr>
			    	</template>
			    </tbody>
		    	<tfoot>
			    	<tr>
			    		<td colspan="6">总计：￥{{totalPrice}}</td>
			    	</tr>
		    	</tfoot>
		    </table>
	    </div>
	</div>
</template>

<script>
	export default{
		data(){
			return{
				mainOrders:[],
				childOrders:{},
				totalPrice:0
			}
		},
		vuex:{
			getters:{
				websit: state => state.websit,
				shopId: state => state.shopId,
				queryOrderBody : state => state.queryOrderBody
			}
		},
		computed:{
			totalPrice:function(){
				let _self = this;
				let total = 0;
				_self.mainOrders.forEach( order =>{
					total += parseFloat(order.orderTotal);
				});
				return total;
			}
		},
		ready(){
			let _self = this;
			this.$http.post(this.websit + 'orderManage.action',{
				action: "queryOrderListForExcel",
				"model.orderReceiveShopId": _self.queryOrderBody.shopId,
				"model.step": _self.queryOrderBody.step,
				"model.beginTime": _self.queryOrderBody.startTime,
				"model.endTime": _self.queryOrderBody.endTime
			}).then( results =>{
				let data =results.data;
				if(data.error == 0){
					_self.mainOrders = data.listall[0];
					_self.childOrders = data.listall[1];
				}else{
					$.toast(data.msg, "cancel");
				}
				
			})
		}
	}
</script>

<style lang="scss" scoped>
	.order-md-hd{
		margin-bottom:10px;
	}
	.order-table{
		position:absolute;
		top:0;
		left:0;
		right:0;
		bottom:0;
		display:flex;
		flex-direction:column;
	}
	.table-wrap{
		flex:1;
		padding-bottom:10px;
		overflow:auto;
	}
	.table{
		border:1px solid #ccc;
		width:100%;
		background:#fff;
		th,td{
			border:1px solid #ccc;
			padding: 7px;
			text-align:center;
		}
		th{
			border-bottom-width:2px;
		}
		tfoot{
			td{
				text-align:right;
			}
		}
	}
</style>