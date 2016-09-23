<template>
    <lt-nav :show-nav.sync="showNav"></lt-nav>
    <header class="billing-header backstage-header">
        <div class="menu-btn" @click="toggleNav">
            <i class="icon-bill-01"></i>
        </div>
        <h2>{{page_title}}</h2>
        <div class="right">
            <select name="" id="" class="form-control" v-model="dataShopId">
                <option 
                    v-for="shop in shopList" 
                    value="{{shop.shop_id}}" 
                    track-by="$index"
                    >{{shop.shop_name}}</option>
            </select>
            <span>车次:{{train}}</span>
        </div>
    </header>
</template>

<script>

    import ltNav from '../components/nav';
    import {setShopId,setNewOrder,setNewOrders,setNewTicket,setNewRefund} from '../vuex/action';
    import Promise from 'bluebird';

    export default{
        data(){
            return{
                shopList:[],        // 店铺列表
                dataShopId:1,       // 当前选择的店铺ID，与shopId保持一致
                showNav:false,       // 切换导航
            }
        },
        components:{
            ltNav
        },
        props:['page_title','reGetNewNum'],
        vuex:{
            getters:{
                websit: state => state.websit,
                shopId: state => state.shopId,
                train: state => state.train,
			    hasLogin : state => state.hasLogin,	
                newOrder: state => state.newOrder,		// 新订单总数
                newOrders: state => state.newOrders,    // 各个新订单数量            
                newTicket: state => state.newTicket,    // 新补票信息
                newRefund: state => state.newRefund,    // 新退款信息
                partnerId: state => state.partnerId
            },
            actions:{
                setShopId,
                setNewOrder,
                setNewOrders,
                setNewTicket,
                setNewRefund
            }
        },
        watch:{
            // 当dataShopId变化时，表示用户选择了别的店铺，切换店铺
            // 发送给父组件店铺ID数据！！！！！
            'dataShopId':function(){

                this.setShopId(this.dataShopId);

                this.$dispatch('child-shopid',this.dataShopId);
            },
            'reGetNewNum':function(){
                // debugger
                queryNewData(this);
            }
        },
        methods:{
            toggleNav(){
                this.showNav = !this.showNav
            }
        },
        ready(){

            // 获取店铺列表
            let _self = this;
            
            _self.$http.post(this.websit + 'addOrder.action',{
                action:"getShopList",
                "shopModel.partnerId": _self.partnerId
            }).then( results =>{
                
                // 设置店铺列表    
                _self.shopList = JSON.parse(results.data.shopList).sort(function(a,b){
                  return a.shop_id - b.shop_id;
                });
                // 设置初始店铺ID
                // 如果开始ID没有设置，就取第一个店铺
                if(!_self.shopId){
                     _self.dataShopId = _self.shopList[0].shop_id;
                    _self.setShopId(_self.dataShopId);
                }else{
                    _self.dataShopId = _self.shopId;
                }
                queryNewData(_self);
               
            }).catch(()=>{
                console.log('获取店铺数据失败，请重新登录');
                $.toast("获取店铺失败", "cancel", function(toast) {
                    _self.$router.go('/login')
                });
            });
        },
    }

    // 当店铺列表已经获取之后查询数量
    function queryNewData(vm){
        if(vm.hasLogin){
            let newOrders=[0,0,0];
            let newOrderNum = 0;
            let newTicketNum = 0;
            let newRefundNum = 0;

           // 查询各个状态的订单
           queryOrderBystate(4).then( num =>{
               newOrders[0] = parseInt(num);
               return queryOrderBystate(5);
           }).then( num =>{
               newOrders[1] = parseInt(num);
               return queryOrderBystate(3);
           }).then( num =>{
               newOrders[2] = parseInt(num);
           }).then(()=>{
               
               vm.setNewOrders(newOrders);
           });
        
           // 底部查询
           // 查询总订单
           vm.$http.post(vm.websit+'orderManage.action',{
               action:"queryOrderNum",
               "model.orderReceiveShopId":vm.shopId,
               "model.step":''
           }).then( results =>{
               newOrderNum = results.data.num;
               vm.setNewOrder(newOrderNum);
           });
    
           // 查询退款
           vm.$http.post(vm.websit+'refundOrder.action',{
               action:"queryRefundNum",
               "model.refShopId":vm.shopId,
			   "model.refIsAuth":0
           }).then( results =>{
               newRefundNum = results.data.num;
               vm.setNewRefund(newRefundNum);
           });

           // 查询补票
           vm.$http.post(vm.websit+'upTicket.action',{
               action:"upTicketsOrderNum",
               "qform.ticketShopId":vm.shopId
           }).then( results =>{
               newTicketNum = results.data.num;
               vm.setNewTicket(newTicketNum);
           });
    
            //  查询指定状态的订单
            function queryOrderBystate(state){
                return new Promise((resolve,reject)=>{
                    vm.$http.post(vm.websit+'orderManage.action',{
                        action:"queryReceiveOrderNum",
                        "model.orderReceiveShopId":vm.shopId,
                        "model.step":state
                    }).then(results=>{
                        resolve(results.data.num);
                    });
                });
            }
        }
    }

</script>

<style lang="scss">
    .billing-header {
        color: #fff;
        height: 1.325rem;
        line-height: normal;
        h2 {
            font-size: 14px;
        }
        .right {
            display: inline-flex;
            align-items: center;
            flex:1;
            justify-content:flex-end;
            span {
                white-space: nowrap;
            }
        }
    }
    
    select.form-control {
        display: inline-block;
        width: auto;
        height: 28px;
        padding: 5px 8px;
        font-size: 13px;
        margin-right: 10px;
        color: #222;
        vertical-align: middle;
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 4px;
        -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
        box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
        -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
        -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
        transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    }
</style>