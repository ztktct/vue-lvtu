/*
* 下拉加载组件，配合jquery-weiui使用
* props:['loading']
* 接受父组件loading的值，控制其是否启用下拉加载
*/

<template>
    <!-- 上拉加载 -->
    <div class="weui-infinite-scroll" v-show="loading">
        <div class="infinite-preloader"></div>
        正在加载
    </div>
</template>

<script>
    import Vue from 'vue';

    export default{
        props:['loading'],
        watch:{
            'loading':function(){
                // 监听loading变化
                // 如果loading==true,表示正在加载，则显示
                // 如果loading==false,表示加载完毕，则隐藏
                if(this.loading){
                    $('.order-manage-bd').infinite();
                }else{ 
                    $('.order-manage-bd').destroyInfinite()
                }
            }
        }
    }
</script>