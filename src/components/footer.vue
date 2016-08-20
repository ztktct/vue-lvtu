<template>
	<footer class="manage-ft page-footer">
		<ul>
			<li>
				<a v-link="{name:'home',params:{page:1,type:4}}" @click="childRefresh">
					<i class="icon-layers"></i>订单管理
					<span class="num">{{ newOrder == 0 ? '' : newOrder}}</span>
				</a>
			</li>
			<li><a v-link="{name:'goods'}"><i class="icon-menu"></i>商品管理</a></li>
			<li>
				<a  v-link="{name:'refund'}" @click="childRefresh">
					<i class="icon-lost"></i>退款申请
					<span class="num">{{ newRefund == 0 ? '' : newRefund}}</span>
				</a>
			</li>
			<li>
				<a v-link="{name:'tickets'}" @click="childRefresh">
					<i class="icon-tickets"></i>补票延长
					<span class="num">{{ newTicket == 0 ? '' : newTicket}}</span>
				</a>
			</li>
		</ul>
	</footer>
</template>

<script>
	export default {
		vuex:{
			getters:{
				newOrder: state => state.newOrder,
				newTicket : state => state.newTicket,
				newRefund: state => state.newRefund
			}
		},
		methods:{
			// 通知父组件刷新
			childRefresh:function(){
				this.$dispatch('child-refresh');
			}
		}
	}
</script>

<style lang="scss" scoped>
	
</style>