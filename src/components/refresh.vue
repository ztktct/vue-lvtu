<template>
    <!-- 下拉刷新 -->
    <div class="weui-pull-to-refresh-layer">
        <div class='pull-to-refresh-arrow'></div>
        <div class='pull-to-refresh-preloader'></div>
        <div class="down">{{down}}</div>
        <div class="up">{{up}}</div>
        <div class="refresh">{{reing}}</div>
    </div>
</template>

<script>

    export default{
        data(){
            return {
                down:'下拉刷新',
                up:'释放刷新',
                reing:'正在刷新'
            }
        }
    }
</script>