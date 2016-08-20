<template>
	<div class="page-header">
			<lt-header v-on:child-shopid="changeShop" :re-get-new-num="reGetNewNum"  page_title="退款处理"></lt-header>
			<nav class="order-manage-hd">
				<ul>
					<li :class="{on: type == 0}" @click="toggleType(0)"><a href="javascript:;">待处理</a></li>
					<li :class="{on: type == 1}" @click="toggleType(1)"><a href="javascript:;">已处理</a></li>
				</ul>
			</nav>
	</div>
	
	<main class="order-manage-bd page-main">
		<refresh></refresh>
		
		<div class="order-block on">
			<!-- 一条退款信息 -->
			<div class="order-record" v-for="refund in refunds" transition="slide-up"  track-by="$index">
				<div class="or-wrap">
					<div class="item">
						<span>商品信息：</span>
						<strong>{{refund.orderDefGoodsName}}</strong>
					</div>
					<div class="item">
						<span>联系人姓名：</span>
						<strong>{{refund.orderMemberName}}</strong>
					</div>
					<div class="item">
						<span>联系人电话：</span>
						<strong>{{refund.orderMemberPhone}}</strong>
					</div>
					<div class="item">
						<span>订单商品数量：</span>
						<strong>{{refund.orderDefTotalNum}}</strong>
					</div>
					<div class="item">
						<span>申请时间：</span>
						<strong>{{refund.refCreateDate}}</strong>
					</div>
                    <div class="item">
						<span>退款类型：</span>
						<strong>{{refund.refType}}</strong>
					</div>
                    <div class="item">
						<span>备注：</span>
						<strong>{{refund.refDetail}}</strong>
					</div>
                    <div class="item">
						<span>是否已经处理：</span>
						<strong>{{refund.refIsAuth== 0 ? '待处理' : '已处理'}}</strong>
					</div>
                    <div class="item" v-if="type == 1">
						<span>是否同意：</span>
						<strong v-if="refund.refIsAuth == 1">已同意</strong>
						<strong v-if="refund.refIsAuth == 2">未同意</strong>
					</div>
                    <div class="item">
						<span>是否删除：</span>
						<strong>{{refund.refIsDel == 0 ? '未删除' : '已删除'}}</strong>
					</div>
				</div>
				<div class="or-cooperation" v-if="type==0">
					<!-- 未处理 -->
					<span></span>
                    <div>
                        <input type="button" @click="changeRefundStatus(refund,1)" value="同意" class="btn-primary" style="margin-right:10px;">
                        <input type="button" @click="changeRefundStatus(refund,2)" value="不同意" class="btn-orange">
                    </div>
					
				</div>
				<a :href="'tel:'+refund.orderMemberPhone" class="telephone"><i class="icon-telephone"></i>{{refund.orderMemberPhone}}</a>
			</div>
			<!-- 一条退款信息 end -->
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
				type:0, 		// 0:待退款，1:已退款
				page:1,		    // 当前的页数
				pageSize:10,		// 每次加载的个数
				refunds:[],		// 存放当前类别的退款信息
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
                    getRefundsList(this).then(() =>{
							this.setNewMsg(0);
                        });
                }
            }
        },
		methods:{
			// 切换店铺
			changeShop:function(){
				this.page=1;
				getRefundsList(this);
			},
			// 切换状态查看
			toggleType:function(type){
				this.page=1;
				this.type = type;
				this.refunds =[];
				getRefundsList(this);
			},
			// 退款处理
			changeRefundStatus(refund,state){
				this.$http.post(this.websit+'refundOrder.action',{
					action:"changeRefundStatus",
					"model.refId":refund.refId,
				    "model.refIsAuth":state,    // ???????
				}).then( results =>{
					this.reGetNewNum++; // 仅仅是为了让header组件重新获取新数据
					let data = results.data;
					if(data.error == 0){
						 $.toast(data.msg);
						 this.refunds.$remove(refund);
					}
				})
			},
			// 刷新本页面数据
            childRefresh:function(){
                this.page = 1;
                this.refunds = [];
                getRefundsList(this);
            }
		},
		ready(){
            let _self = this;
            // 下拉刷新
            $('.order-manage-bd').pullToRefresh().on("pull-to-refresh", function () {;
                _self.page=1;
				getRefundsList(_self,true,true).then(()=>{
                    $('.order-manage-bd').pullToRefreshDone();
				});
            });

			 // 上拉加载
            let loading = false;
            $('.order-manage-bd').infinite().on("infinite", function() {
                if(loading) return;
                loading = true;
                // 数据加载
				getRefundsList(_self,false).then(()=>{
					_self.page++;
					loading = false;
				});
            });
		}
	}

	/**
	 * 获取退款列表
	 * @param  {object}  vm Vue实例
	 * @param  {bollean} load 加载的类型，整页加载或者上拉加载，默认整页加载
	 * @param  {bollean} refresh 是否是刷新
	 * @return {Promise} 返回Promise对象，处理数据加载完成之后的操作，不管有无补票信息
	 */
	function getRefundsList(vm,load=true,refresh=false){
		return new Promise((resolve,reject)=>{
            
			// 发送请求，开始加载,当不是刷新的时候显示加载，刷新自带加载
			if( !refresh ) vm.loading = true;

			vm.$http.post(vm.websit +'refundOrder.action',{
                action:"queryRefundOrderList",
				"model.pageIndex":vm.page,		// 当前加载了的页数
				"model.pageSize":vm.pageSize,	// 每次加载的个数
				"model.refShopId":vm.shopId,    // 店铺ID
				"model.refIsAuth":vm.type       // 是否需要退款，0：待退款，1：已退款
			}).then( results =>{
				let data = results.data;
				
				// 如果查询成功
				if(data.result == 'SKsuccessMessages'){
					vm.reGetNewNum++; // 仅仅是为了让header组件重新获取新数据
					if(load){
						vm.refunds = data.data;
					}else{
						vm.refunds = vm.refunds.concat(data.data);
					}

					// 如果数量小于请求的数量，表示没有更多,无需下拉加载
					if(data.data.length < vm.pageSize){
						vm.loading=false;
					}else{
						vm.loading=true;
					}
				}else{
					$.toast(data.msg, "cancel");
					if(load){
						vm.refunds = [];
					}
					vm.loading = false;
				}
				resolve();
			})
		});
			
	}
</script>