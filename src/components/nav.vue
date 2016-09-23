<template>
    <!-- 导航 -->
    <div>
        <div class="mask" v-show="showNav" transition="opacity"></div>
        <section class="billing-nav" @click="toggleNav" v-show="showNav" transition="slide-right">
            <nav @click.stop>
                <ul class="first-level">
                    <li>
                        <a v-link="{name:'home'}" @click="toggleNav" title=""><i class="icon-bill-05"></i>订单管理</a>
                    </li>
                    <li>
                        <a v-link="{name:'goods'}" @click="toggleNav" title=""><i class="icon-bill-06"></i>店铺商品管理</i></a>
                    </li>
                    <li>
                        <a v-link="{name:'refund'}" @click="toggleNav" title=""><i class="icon-bill-04"></i>退款申请</i></a>
                    </li>
                    <li>
                        <a v-link="{name:'tickets'}" @click="toggleNav" title=""><i class="icon-bill-08"></i>补票延长</a>
                    </li>
                    <li>
                        <a v-link="{name:'query'}" @click="toggleNav" title=""><i class="icon-bill-10"></i>订单查询</a>
                    </li>
                </ul>
                <input type="button" class="exit-login" @click="logout" value="退出登录">
            </nav>
        </section>
    </div>
   
</template>

<script>
    import {delUserInfo} from '../vuex/action';

    export default{
        vuex:{
            actions:{
                delUserInfo
            }
        },
        props:['showNav'],
        methods:{
            toggleNav(){
                this.showNav = !this.showNav;
            },
            logout(){
                this.delUserInfo();
                this.$router.go({name:'login'});
            }
        }
    }
</script>

<style scoped>
    .mask{
        position:fixed;
        z-index:5;
        top:0;
        right:0;
        bottom:0;
        left:0;
        background:rgba(0,0,0,.5)
    }
    .billing-nav{
        z-index:10;
        padding-top:1.125rem;
    }
    .billing-nav nav{
        padding-top:1rem;
    }
</style>