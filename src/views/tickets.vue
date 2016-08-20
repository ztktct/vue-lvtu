<template>
	<div class="page-header">
			<lt-header v-on:child-shopid="changeShop" :re-get-new-num="reGetNewNum"  page_title="补票管理"></lt-header>
			<nav class="order-manage-hd">
				<ul>
					<li :class="{on: type == 0}" @click="toggleType(0)"><a href="javascript:;">待补票</a></li>
					<li :class="{on: type == 1}" @click="toggleType(1)"><a href="javascript:;">已补票</a></li>
				</ul>
			</nav>
	</div>
	
	<main class="order-manage-bd page-main">
		<refresh></refresh>
		<!-- 待补票 -->
		<div class="order-block on">
			<!-- 一条订单 -->
			<div class="order-record" v-for="ticket in tickets" transition="slide-up" track-by="$index">
				<div class="or-wrap">
					<div class="item">
						<span>联系人：</span>
						<strong>{{ticket.ticketName}}</strong>
					</div>
					<div class="item">
						<span>申请时间：</span>
						<strong>{{ticket.ticketCreateDate}}</strong>
					</div>
					<div class="item">
						<span>车　　次：</span>
						<strong>{{ticket.ticketTrain}}</strong>
					</div>
					<div class="item">
						<span>车厢座位：</span>
						<strong>{{ticket.ticketCarriage + '-' + ticket.ticketSeat}}</strong>
					</div>
					<div class="item">
						<span>手机号码：</span>
						<strong>{{ticket.ticketPhone}}</strong>
					</div>
				</div>
				<div class="or-cooperation" v-if="ticket.ticketIs == 0">
					<!-- 未处理 -->
					<span></span>
					<input type="button" @click="changeSellStatus(ticket)" value="补票" class="btn-orange">
				</div>
				<a :href="'tel:'+ticket.ticketPhone" class="telephone"><i class="icon-telephone"></i>{{ticket.ticketPhone}}</a>
			</div>
			<!-- 一条订单 -->
			<infinite :loading="loading"></infinite>
		</div>
	</main>
	<lt-footer v-on:child-refresh="childRefresh"></lt-footer>
</template>


<script>

	import refresh from '../components/refresh';
	import infinite from '../components/infinite';
	import ltFooter from '../components/footer';
	import ltHeader from '../components/header'
    import {setNewMsg} from '../vuex/action';
	import Promise from 'bluebird';

	export default {
		data(){
			return{
				type:0, 		// 0:待补票，1:已补票
				tickets:[],		// 存放当前类别的补票信息
				page:1,			// 当前获取了的页数
				pageSize:10,	// 每次查询的数量
				reGetNewNum:0,  // 改变这个值将重新获取新数据的个数，头部和底部的数字
				loading:true	// 是否正在加载
			}
		},
		components:{
			refresh,
			infinite,
			ltFooter,
			ltHeader
		},
		vuex:{
			getters:{
				websit: state => state.websit,
				shopId: state => state.shopId,
                hasNewMsg: state => state.hasNewMsg
			},
            actions:{
                setNewMsg
            }
		},
		watch:{
            // 如果有新消息,则重新加载数据
            'hasNewMsg':function(){
                if(this.hasNewMsg == 1){
                    getTicketsList(this).then(() =>{
							this.setNewMsg(0);
                        });
                }
            }
        },
		methods:{
			// 切换店铺
			changeShop:function(){
				this.page=1;
				getTicketsList(this);
			},
			// 切换状态查看
			toggleType:function(type){
				this.page=1;
				this.type = type;
				this.tickets =[];
				getTicketsList(this);
			},
			// 补票处理
			changeSellStatus(ticket){
				this.$http.post(this.websit+'upTicket.action',{
					action:"changeSellStatus",
					ticketId:ticket.ticketId
				}).then( results =>{
					this.reGetNewNum++; // 仅仅是为了让header组件重新获取新数据
					let data = results.data;
					if(data.error == 0){
						 $.toast("补票成功！");
						 this.tickets.$remove(ticket)
					}
				})
			},
			// 刷新本页面数据
            childRefresh:function(){
                this.page = 1;
                this.tickets = [];
                getTicketsList(this);
            }
		},
		ready(){
            let _self = this;

            // 下拉刷新
            $('.order-manage-bd').pullToRefresh().on("pull-to-refresh", function () {
				_self.page=1;
                getTicketsList(_self,true,true).then(()=>{
                    $('.order-manage-bd').pullToRefreshDone();
				});
            });

            // 上拉加载
            let loading = false;
            $('.order-manage-bd').infinite().on("infinite", function() {
                if(loading) return;
                loading = true;
                // 数据加载
				getTicketsList(_self,false).then(()=>{
					_self.page++;
					loading = false;
				});
            });
		}
	}

	/**
	 * 获取补票列表
	 * @param  {object}  vm Vue实例
	 * @param  {bollean} load 加载的类型，整页加载或者上拉加载，默认整页加载
	 * @param  {bollean} refresh 是否是刷新
	 * @return {Promise} 返回Promise对象，处理数据加载完成之后的操作，不管有无补票信息
	 */
	function getTicketsList(vm,load=true,refresh=false){
		return new Promise((resolve,reject)=>{

			// 发送请求，开始加载,当不是刷新的时候显示加载，刷新自带加载
			if( !refresh ) vm.loading = true;

			vm.$http.post(vm.websit +'upTicket.action',{
				action:"queryUpTicketList",
				"qform.ticketShopId":vm.shopId,		// 店铺ID
				"qform.ticketIs":vm.type,			// 是否需要补票，0：待补票，1：已补票
				"qform.pageIndex": vm.page,			// 当前查询的页数
				"qform.pageSize": vm.pageSize		// 	每次查询的数量
			}).then( results =>{
				let data = results.data;
				// 如果查询成功
				if(data.result == 'SKsuccessMessages'){
					vm.reGetNewNum++; // 仅仅是为了让header组件重新获取新数据
					if(load){
						vm.tickets = data.data;
					}else{
						vm.tickets = vm.tickets.concat(data.data);
					}

					// 如果数量小于请求的数量，表示没有更多,无需下拉加载
					if(data.data.length < vm.pageSize){
						vm.loading=false;
					}else{
						vm.loading=true;
					}

				}else{
					$.toast("没有数据", "cancel");
					if(load){
						vm.tickets = [];
					}
					vm.loading = false;
				}
				
				resolve();
			})
		});
			
	}
</script>