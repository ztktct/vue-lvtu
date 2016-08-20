<template>
    <div  transition="slide-left">
        <header class="order-md-hd">
            <h2>基本信息</h2>
            <a v-link="{name:'home'}"><i class="icon-back"></i>返回上级</a>
        </header>
        <loading v-if="!dataLoaded"></loading>
        <section class="order-md-info" v-if="dataLoaded" >
            <div class="container">
                <div class="item">
                    <span>订单编号：</span>
                    <strong>{{orderInfo.orderNo}}</strong>
                </div>
                <div class="item">
                    <span>下单时间：</span>
                    <strong>{{orderInfo.orderCreateDate}}</strong>
                </div>
                <div class="item">
                    <span>车厢座位：</span>
                    <strong>{{orderInfo.orderMemberCarriage +'车 '}}</strong>
                </div>
                <div class="item">
                    <span>送餐时间：</span>
                    <strong v-if="orderInfo.orderMemberIsSeat == 1">自取订单</strong>
                    <strong v-else>{{orderInfo.orderSelectDate}}</strong>
                </div>
            </div>
            <div class="state">
                订单状态：
                <!--3：配送中（待完成） 4：待接单 5：待配送 6：已完成-->
                <span v-if="orderInfo.orderStep == 4">待接单</span>
                <span v-if="orderInfo.orderStep == 5">待配送</span>
                <span v-if="orderInfo.orderStep == 6">已完成</span>
                <span v-if="orderInfo.orderStep == 3">配送中</span>
            </div>
        </section>

        <section class="order-md-dishes normal-dishes" v-if="dataLoaded" >
            <div class="container">
                <div class="dishes-item" v-for="item in orderGoods">
                    <div class="imgwrap">
                        <img :src="item.ogComGoodsImg" :alt="item.ogComGoodsName">
                    </div>
                    <div class="rarea">
                        <div class="top">{{item.ogComGoodsName}}</div>
                        <div class="middle">数量：{{item.ogShopGoodsNum}}份</div>
                        <div class="bottom">金额：￥{{item.ogComGoodsPriceDiscount}}</div>
                    </div>
                </div>
                <div class="dishes-price">
                    <span>总金额：<strong>￥{{orderInfo.orderTotal}}</strong></span>
                    <span>应付金额：<strong>￥{{orderInfo.orderDuePay}}</strong></span>
                    <span>实付金额：<strong>￥{{orderInfo.orderPay}}</strong></span>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
    import loading from '../components/loading';
    export default{
        data(){
            return{
                id:0,
                dataLoaded:false,   // 数据是否已加载完毕
                orderInfo:{},       // 订单相关信息
                orderGoods:[]       // 订单菜品    
            }
        },
        components:{
            loading
        },
        route:{
            data(transition){
                this.id = transition.to.params.id;
            }
        },
        vuex:{
            getters:{
                websit:state => state.websit
            }
        },
        watch:{
            id:function(){
                let _self = this;
                
                // 加载详情数据
                _self.$http.post(_self.websit+'orderManage.action',{
                    action:"queryOrderDetail",
                    "model.orderId": _self.id
                }).then( result =>{
                    let data = result.data;
                    
                    if(data.msg == '查询成功'){
                        _self.orderInfo = data.mainOrder;
                        _self.orderGoods = data.orderGoodsList;
                        _self.dataLoaded = true;
                    }else{
                        $.toast(data.msg, "cancel");
                    }
                }).catch(()=>{
                    $.toast("获取失败", "forbidden");
                })
            }
        }
    }
</script>

<style lang="scss" scoped>
    .order-md-info{
        margin-top:0;
    }
    .slide-left-transition{
        overflow:auto;
        height:100%;
    }
    .dishes-price{
        margin-bottom:.3rem;
    }
    .order-md-dishes .dishes-price{
        margin-bottom:0
    }
    .order-md-dishes .dishes-price span{
        margin-left:5px;
    }
</style>