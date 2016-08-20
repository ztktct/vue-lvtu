
export default function(router){
    router.map({
        '/':{				//首页
            name:'home',
            component: function(resolve){
                require(['./views/orderManage.vue'],resolve);
            },
            auth: true     // 需要用户验证才可进入
        },
        /* 404路由 */
        '*': {
            component: function(resolve){
                require(['./views/orderManage.vue'],resolve);
            },
            auth: true     // 需要用户验证才可进入
        },
        '/order_manage':{   //首页
            name:'home',
            component: function(resolve){
                require(['./views/orderManage.vue'],resolve);
            },
            auth: true     // 需要用户验证才可进入
        },
        '/order_details/:id':{  //订单详情
            name:'order',
            component: function(resolve){
                require(['./views/orderDetails.vue'],resolve);
            },
           auth: true     // 需要用户验证才可进入
        },
        '/goods_manage':{   // 商品管理
            name:'goods',
            component:function(resolve){
                require(['./views/goodsManage.vue'],resolve);
            },
            auth: true     // 需要用户验证才可进入
        },
        '/tickets':{   // 补票延长
            name:'tickets',
            component:function(resolve){
                require(['./views/tickets.vue'],resolve);
            },
            auth: true     // 需要用户验证才可进入
        },
        '/add_goods':{  // 添加菜品
            name:'add_goods',
            component:function(resolve){
                require(['./views/addGoods.vue'],resolve);
            },
            auth: true     // 需要用户验证才可进入
        },
        '/refund':{ // 退款
            name:'refund',
            component:function(resolve){
                 require(['./views/refund.vue'],resolve);
            }
        },
        '/login':{      //登录
            name:'login',
            component: function(resolve){
                require(['./views/login.vue'],resolve);
            }
        }
    })
}