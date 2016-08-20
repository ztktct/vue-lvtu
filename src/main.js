require('../static/css/weui.min.css');
require('../static/css/jquery-weui.min.css');
require('../static/css/style.css');

import Vue from 'vue';
import App from './App';
import vueResource from 'vue-resource';
import VueRouter from 'vue-router';
import routerMap from './router';

Vue.use(vueResource);
Vue.use(VueRouter);

// 以form data的形式发送请求
Vue.http.options.emulateJSON = true;

//实例化VueRouter
let router = new VueRouter({
    hashbang: true,
    history: false,
    // saveScrollPosition: true,  // 记录滚动位置
    transitionOnLoad: true
});

//登录中间验证，页面需要登录而没有登录的情况直接跳转登录
router.beforeEach((transition) => {
	
    if (transition.to.auth) {
		// 检测用户的登录状态
        if (!!localStorage.getItem('LVTUDIANDIAN_USERINFO_HASLOGIN')) {
            transition.next();
        } else {
            transition.redirect('/login');
        }
    } else {
        transition.next();
    }
});

routerMap(router);

// App组件会用来创建这个应用的根组件
router.start(App, "#app");

