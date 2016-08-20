<!--订单管理组件-->
<template>
    <div class="page-header">
        <lt-header v-on:child-shopid="getShop" :re-get-new-num="reGetNewNum" page_title="订单管理"></lt-header>
        <nav class="order-manage-hd">
            <ul>
                <li :class="{on:type==4}" @click="toggleType(4)">待接单<span class="num">{{newOrders[0] == 0 ? '' : newOrders[0]}}</span></li>
                <li :class="{on:type==5}" @click="toggleType(5)">待配送<span class="num">{{newOrders[1] == 0 ? '' : newOrders[1]}}</span></li>
                <li :class="{on:type==3}" @click="toggleType(3)">待完成<span class="num">{{newOrders[2] == 0 ? '' : newOrders[2]}}</span></li>
                <li :class="{on:type==6}" @click="toggleType(6)">已完成</li>
            </ul>
            <div class="filter" @click="toggleFilter">
                <i class="icon-filter"></i>筛选
            </div>
        </nav>
    </div>

    <main class="order-manage-bd page-main">
        <refresh></refresh>

        <div class="order-block on">
            <!-- 一条订单 -->
            <div class="order-record" 
                v-for="order in orders" 
                transition="slide-up" 
                track-by="$index">

                <div class="or-wrap">
                    <div class="item">
                        <span>订单编号：</span>
                        <strong>{{order.orderNo}}</strong>
                    </div>
                    <div class="item">
                        <span>下单时间：</span>
                        <strong>{{order.orderCreateDate}}</strong>
                    </div>
                    <div class="item">
                        <span>有无发票：</span>
                        <strong>{{order.orderIsInvoice == '0' ? '无' : '有'}}</strong>
                    </div>
                    <div class="item">
                        <span>商品信息：</span>
                        <strong>{{order.orderDefGoodsName + '*' + order.orderDefTotalNum}}</strong>
                    </div>
                    <div class="item">
                        <span>车厢座位：</span>
                        <strong>{{order.orderMemberCarriage +'车 '+ (order.orderMemberSeatNo ? order.orderMemberSeatNo+'座' : '')}}</strong>
                    </div>
                    <div class="item">
                        <span style="letter-spacing:1px;">总 金 额：</span>
                        <strong>{{'￥' + order.orderTotal / 100 }}</strong>
                    </div>
                    <div class="item">
                        <span>应付金额：</span>
                        <strong>{{'￥' + order.orderDuePay / 100}}</strong>
                    </div>
                    <div class="item">
                        <span>实付金额：</span>
                        <strong style="color:#ef574a;">{{'￥' + order.orderPay / 100}}</strong>
                    </div>
                    <div class="item">
                        <span>送餐时间：</span>
                        <strong style="color:#ef574a;" v-if="order.orderMemberIsSeat == 1">自取订单</strong>
                        <strong style="color:#ef574a;" v-else>{{order.orderSelectDate}}</strong>
                    </div>
                    <div class="item">
                        <span>联 系 人：</span>
                        <strong>{{order.orderMemberName}}</strong>
                    </div>
                </div>
                <div class="or-cooperation">
                    <a v-link="{name:'order',params:{id:order.orderId}}" >订单详情</a>
                    <input type="button" value="配送" @click="deliveryOrder(order)" class="btn-orange" v-if="order.orderStep == 5">
                    <input type="button" value="接单" @click="receiverOrder(order)" class="btn-orange" v-if="order.orderStep == 4">
                </div>
                <a href="tel:{{order.orderMemberPhone}}" class="telephone"><i class="icon-telephone"></i>{{order.orderMemberPhone}} </a>
            </div>

            <infinite :loading="loading"></infinite>
        </div>
    </main>
    <lt-footer v-on:child-refresh="childRefresh"></lt-footer>
    <!-- 筛选 -->
    <filters :showfilter.sync="showfilter" v-on:child-order-filter="filter"></filters>

</template>

<script>
    // 引入刷新,加载组件
    import refresh from '../components/refresh';
    import infinite from '../components/infinite';
    import filters from '../components/filters';
    import ltFooter from '../components/footer';
    import ltHeader from '../components/header';
    import {setNewMsg} from '../vuex/action';

    import Promise from 'bluebird';

    export default{
        data(){
            return{
                page_title:'',
                pageNum:10,         // 每次查询的个数
                type:4, 		    // 3：配送中（待完成） 4：待接单 5：待配送 6：已完成
                orders:[],		    // 订单数据
                page:1, 		    // 当前数据分页
                showfilter:false, 	//筛选
                loadingData:false,   // 加载数据中
                reGetNewNum:0,       //  改变这个值将重新获取新数据的个数，头部和底部的数字
                loading:false       // 家在状态，是否正在加载
            }
        },
        components:{
            refresh,
            infinite,
            filters,
            ltFooter,
            ltHeader
        },
        vuex:{
            getters:{
                websit:state => state.websit,
                shopId: state => state.shopId,
                newOrders: state => state.newOrders,
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
                    loadData(this,this.page,this.type)
                        .then( data =>{
                            this.setNewMsg(0);
                            this.orders = data;
                        });
                }
            },
            
        },
		methods:{
			// 切换分类
			toggleType:function(type){
                let _self = this;
				_self.type = type;
				_self.orders = [];
				_self.page = 1;
                loadData(_self,_self.page,_self.type)
                    .then( data =>{
                        _self.orders = data;
                    });
			},
			// 切换筛选
			toggleFilter:function(){
				this.showfilter = !this.showfilter;
			},
            // 获得店铺订单数据
            getShop:function(shopid){
               
                // 获得的参数为更改的店铺id
                this.page = 1;
                this.orders = [];
                loadData(this,this.page,this.type).then( data =>{
                    this.orders = data;
                });
            },

            // 刷新本页面数据
            childRefresh:function(){
                this.page = 1;
                this.orders = [];
                loadData(this,this.page,this.type).then( data =>{
                    this.orders = data;
                });
            },

            // 筛选
            filter(params){
                this.page = 1;
                this.orders = [];
                this.loading = true;
                this.$http.post(this.websit+'orderManage.action',{
                     action:"queryOrderListForZhang",
                    "orderModel.pageIndex":this.page,   
                    "orderModel.pageSize":this.pageNum,                         // 每次查询的数量
                    "orderModel.orderReceiveShopId":this.shopId,                // 店铺ID
                    "orderModel.orderStep":this.type,
                    "orderModel.orderNo":params.orderNo,                        // 订单编号
                    "orderModel.queryOrderDateBeg": params.queryOrderDateBeg,   // 下单时间
					"orderModel.queryOrderDateEnd":params.queryOrderDateEnd,    // 终止时间
					"orderModel.orderMemberName":params.orderMemberName,        // 乘客姓名
					"orderModel.orderMemberPhone":params.orderMemberPhone,      // 乘客手机
                }).then( results =>{
                    let data = results.data;
                    
                    if(data.msg == "查询成功"){
                         this.orders = data.data;
                         // 禁用上拉加载
                        if(data.data.length < this.pageNum){
                             this.loading = false;
                        }else{
                            $('.weui-infinite-scroll').show();
	                        $('.order-manage-bd').infinite();
                        }
                    }
                   
                    if(data.msg == '没有数据'){
                       $.toast("未搜索到订单", "cancel");
                        this.loading = true;
                    }
                });
            },

            // 接单
            receiverOrder(order){
                this.$http.post(this.websit + 'orderManage.action',{
                    action:"receiveOrder",
                    'model.orderId': order.orderId, 
	       			'model.orderStep': 5
                }).then( results =>{
                    let data = results.data;
                    if(data.msg =="接单成功！"){
                         $.toast(data.msg);
                         this.orders.$remove(order);
                         this.reGetNewNum++;
                    }else{
                        $.toast(data.msg,"cancel");
                    }
                });
            },

            // 配送
            deliveryOrder(order){
                this.$http.post(this.websit + 'orderManage.action',{
                    action:"deliveryOrder",
                    'model.orderId': order.orderId, 
	       			'model.orderStep': 3
                }).then( results =>{
                    let data = results.data;
                    if(data.msg == "配送成功！"){
                         $.toast(data.msg);
                         this.orders.$remove(order);
                        this.reGetNewNum++;
                    }else{
                        $.toast(data.msg,"cancel");
                    }
                });
            }
		},
		ready(){
            let _self = this;
            
            // 下拉刷新
            $('.order-manage-bd').pullToRefresh().on("pull-to-refresh", function () {
                _self.orders = [];
                loadData(_self,_self.page,_self.type)
                    .then( data =>{
                        _self.orders = data;
                    });
                $('.order-manage-bd').pullToRefreshDone();
                $('.order-manage-bd').infinite();
            });

            // 上拉加载
            let loading = false;
            $('.order-manage-bd').infinite().on("infinite", function() {
                if(loading) return;
                loading = true;
                _self.page++;
                // 数据加载
                loadData(_self,_self.page,_self.type)
                    .then( data =>{
                        loading = false;
                        _self.orders = _self.orders.concat(data);
                    });
            });  
		}
    }


/** 获取订单列表
 *  @param {object} vm vue实例
 *  @param {number} page 查询的页数
 *  @param {number} step 查询什么状态下的订单，1：已支付 3：配送中（待完成） 4：待接单 5：待配送 6：已完成
 */
function loadData(vm,page,step){
    //  $('.weui-infinite-scroll').show();
	//   $('.order-manage-bd').infinite();
    return new Promise(function(resolve,reject){
        // 加载初始数据
        vm.loading = true;
        vm.$http.post(vm.websit+'orderManage.action',{
            action:"queryOrderListForZhang",
            "orderModel.pageIndex":page,   
            "orderModel.pageSize":vm.pageNum,           // 每次查询的数量
            "orderModel.orderReceiveShopId":vm.shopId,  // 店铺ID
            "orderModel.orderStep":step                 // 1：已支付 3：配送中（待完成） 4：待接单 5：待配送 6：已完成
        }).then(function(results) { 

            let data = results.data;
             vm.reGetNewNum++; // 仅仅是为了让header组件重新获取新数据
            if(data.msg == "查询成功" && data.data.length>0){
                $.toptip('查询成功', 1000, 'success');
                 // 如果查询到的数据小于查询的个数，则表示没有更多数据
                // 禁用上拉加载
                if(data.data.length < this.pageNum){
                    vm.loading = false;  
                }
                resolve(data.data);

            }else if(data.msg="没有数据"){
                $.toast("暂无更多数据！", "text");
                 vm.loading = false; 

            }else{
                $.toast(data.msg, "text");
                vm.loading = false; 
            }
        }).catch(()=>{

            $.toast('请重新登录', "text");
            localStorage.hasLogin = 0;
            vm.$router.go({name:'login'});

        });
    });
}

</script>

<style lang="scss">
    .order-manage-hd{
        li{
            position:relative;
        }
        .num{
            font-size: 13px;
            position: absolute;
            min-width: 1.25em;
            height: 1.25em;
            background: #ef574a;
            color: #fff;
            text-align: center;
            line-height: 1.25;
            border-radius: .625em;
            left: 78%;
            top: 10%;
            &:empty{
                display:none;
            }
        }
    }
</style>
