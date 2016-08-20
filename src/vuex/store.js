import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

// state: 包含所有应用级别状态的对象
// Getters: 在组件内部获取 store 中状态的函数
// Mutations: 修改状态的事件回调函数
// Actions: 组件内部用来分发 mutations 事件的函数

// 应用级别的状态对象
const state = {
    // http://lvtudiandian.com:8080/train/
    // http://127.0.0.1:7000/train/
    websit:"http://lvtudiandian.com:8080/train/",  // 设置接口的域名
    partnerId:0,            // 商家ID,默认为0        (用户登录信息返回或本地读取)
    train:'',               // 车次                  (用户登录信息返回或本地读取)
    shopId:'',              // 店铺ID,默认为空        (登录后查询店铺ID)
    hasLogin:0,             // 用户登陆状态           (登陆后设置为1,退出登录后为0)
    newOrder:0,             // 新订单总数
    newOrders:[],           // 各个新订单数量
    newTicket:0,            // 新补票的数量
    newRefund:0,            // 新的退款信息
    hasNewMsg:0             // 是否提示有新消息，0:无，1:有，用于自动刷新订单等列表
};

let _info = localStorage.getItem('LVTUDIANDIAN_USERINFO');
const USER_INFO = !!_info ? JSON.parse(_info) : null;

// 从localStorage中获取初始值，如果用户没有退出登录，localStorage将保存信息等待下次调用
state.hasLogin = localStorage.getItem('LVTUDIANDIAN_USERINFO_HASLOGIN') || 0;
state.train = USER_INFO ? USER_INFO.train : '';
state.partnerId = USER_INFO ? USER_INFO.partnerId : 0 ;

// 修改状态的事件回调函数
const mutations = {
    
    // 设置店铺ID
    SET_SHOPID(state,id){
        state.shopId = id;
    },

    // 保存用户相关信息
    SET_USER_INFO(state,userData){
        state.hasLogin = 1;     // 保存登录状态为1
        state.train = userData.train;   // 保存车次
        state.partnerId = userData.partnerId;   // 保存店铺商家ID
        localStorage.setItem('LVTUDIANDIAN_USERINFO_HASLOGIN','1');  // 保存登录状态为1
        localStorage.setItem('LVTUDIANDIAN_USERINFO',JSON.stringify(userData)); // 保存用户信息
    },
    // 清空用户相关信息
    DEL_USER_INFO(state,userData){
        state.hasLogin = 0;     // 登录状态改为0，表示未登录
        state.shopId='';        // 清空店铺ID
        state.train='';         // 清空车次信息
        state.partnerId = 0;    // 清空商家ID
        localStorage.removeItem('LVTUDIANDIAN_USERINFO_HASLOGIN');  // 删除登录状态
        localStorage.removeItem('LVTUDIANDIAN_USERINFO');   // 删除用户信息
    },

    // 设置新消息提醒
    SET_NEW_MSG(state,num){
        state.hasNewMsg = num;
    },

    // 设置新订单的数量
    SET_NEW_ORDER(state,num){
        state.newOrder = num;
    },
    // 设置各个状态下的新订单
    SET_NEW_ORDERS(state,nums){
        state.newOrders = nums;
    },
    // 设置新补票信息
    SET_NEW_TICKET(state,num){
        state.newTicket = num;
    },
    // 设置新的退款信息
    SET_NEW_REFUND(state,num){
        state.newRefund = num;
    }
}

export default new Vuex.Store({
    state,
    mutations
})
