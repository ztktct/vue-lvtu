<template>
    <loading v-if="showLoaing"></loading>
    <div class="weui_header">
		<img :src="logo" style="width:22%;" alt="">
	</div>
	<!-- 登陆 -->
    <div class="weui_cells weui_cells_form">
        <div class="weui_cell">
            <div class="weui_cell_hd">
                <label class="weui_label">账　号：</label>
            </div>
            <div class="weui_cell_bd weui_cell_primary">
                <input class="weui_input" v-model="account" type="text" placeholder="用户名/手机/邮箱" @focus="showAccount" @blur="hideAccount">
                <ul class="tip" v-show="showAccounts">
                    <li v-for="accountItem in accounts" @touchstart="selectAccount(accountItem)" track-by="$index">{{accountItem}}</li>
                </ul>
            </div>
        </div>
        <div class="weui_cell weui_cell_primary">
            <div class="weui_cell_hd">
                <label class="weui_label">密　码：</label>
            </div>
            <div class="weui_cell_bd weui_cell_primary">
                <input class="weui_input" v-model="password" type="password" placeholder="请输入密码">
            </div>
        </div>
    </div>

    <div class="weui_btn_area">
        <a class="weui_btn weui_btn_primary" href="javascript:;" @click="login()">登录</a>
    </div>
</template>
	
<script>

    import hex_md5 from '../lib/md5.js';
    import loading from '../components/loading';
    import {setUserInfo,delUserInfo} from '../vuex/action';
    import {queryNewMessage , cancleReceiver} from '../lib/Jpush-lib.js';

    let logo = require('../assets/images/logo.png');

    export default{
        data(){
            return {
                logo:logo,
                showLoaing:false,
                password:'',
                account:'',         // 当前帐号
                accounts:[],        // 所有保存账号
                showAccounts:false  // 提示所有已保存账号
            }
        },
        components:{
            loading
        },
        vuex:{
			getters:{
				websit : state => state.websit,
				hasLogin: state=> state.hasLogin,
                partnerId:state => state.partnerId,
                train: state => state.train
			},
            actions:{
                setUserInfo,
                delUserInfo
            }
		},
        methods:{
            // 显示账号
            showAccount:function(){
                this.showAccounts = true;
            },
            // 隐藏账号
            hideAccount:function(){
                this.showAccounts = false;
            },
            // 选择账号
            selectAccount:function(acc){
                this.account = acc;
                this.showAccounts = false;
            },
            // 登陆
            login:function(){
                let _self = this;
                // 验证账号密码
                if(this.account === ''){
                    $.toast("请输入账号！", "cancel");
                    return;
                }else if(this.password === ''){
                    $.toast("请输入密码！", "cancel");
                    return;
                }
                this.showLoaing = true;

                this.$http.post(this.websit+"train/login.action?action=login",{
                    account:this.account,
                    password:hex_md5(this.password),
                    r:Math.random()
                }).then( results => {
                    let data = JSON.parse(results.data);
                    let tip = "登录不成功！";
                    let type = 'forbidden';
                    this.showLoaing = false;

                    switch (data.result) {
                        case "disable":
                            tip = "账号被停用！"; 
                            $.toast(tip, type);
                            break;
                        case "input":
                            tip = "账号或密码错误！";
                            $.toast(tip, type);
                            break;
                        case "success":
                            tip = "正在进入商家平台，请稍候...";
                            type = 'success';
                            $.toptip(tip, 'success');
                            
                            // 用户登录状态为已登录，保存用户登陆信息
                            this.setUserInfo(data.user);

                            // 登陆成功，查询新信息
                            let audio = document.getElementById('tip_voice');
                            queryNewMessage(_self,audio);

                            // 保存账号
                            this.accounts.forEach( (account ,i)=>{
                                if(account === this.account){
                                    this.accounts.$remove(account);
                                    return;
                                }
                            });
                             this.accounts.splice(0,0,this.account);

                            localStorage.setItem('LVTUDIANDIAN_USERACCOUNTS',JSON.stringify(this.accounts));

                            // 登陆成功后跳转到订单列表页
                            setTimeout(()=>{
                                _self.$route.router.go('/home');
                            },1000);
                            break;
                    }
                }).catch(()=>{
                    this.showLoaing = false;
                    $.toptip('请检查网络连接', 'error');
                });
            }
        },
        ready(){
            // 当处于登陆页时，默认清空所有用户数据
            this.delUserInfo();
            this.accounts = JSON.parse(localStorage.getItem('LVTUDIANDIAN_USERACCOUNTS')) || [];
            this.account = this.accounts[0];
            cancleReceiver();   // 取消接收消息
        }
    }

    
</script>

<style lang="scss" scoped>
    .weui_cells{
        overflow:visible;
    }
   .weui_btn_primary{
       background:#ef574a;
   } 
   .weui_btn_primary:not(.weui_btn_disabled):active {
        color: hsla(0,0%,100%,.4);
        background-color: darken(#ef574a,4%);
    }
    .weui_cell_primary{
        position:relative;
    }
    .weui_btn_area{
        margin-top:3em;
    }
    .tip{
        background:#fff;
        position:absolute;
        z-index:5;
        box-shadow:0 0 5px rgba(#333,.5);
        width:100%;
        top:130%;
        li{
            padding:5px;
            position:relative;
            &:not(:last-child){
                &:after{
                    content:'';
                    position:absolute;
                    bottom:0;
                    left:0;
                    right:0;
                    height:1px;
                    background:#ccc;
                    transform:scaleY(.5);
                }
            }
            &:hover{
                background:#f5f5f5;
            }
        }
    }
</style>

