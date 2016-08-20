<!--筛选-->
<template>
    <!-- 筛选 -->
	<div class="manage-filter form-lists" v-show="showfilter" @click="toggleFilter" :class="{show:showfilter}" transition="slide-left">
		<div class="wrap" >
			<div class="form-item" @click.stop>
				<label>订单号</label>
				<div class="input-wrap">
					<input type="text" placeholder="请输入搜索订单号" v-model="order">
				</div>
			</div>
			<div class="form-item" @click.stop>
				<label>下单时间</label>
				<div class="input-wrap">
					<input type="text" class="beginTime" id="begin_time" v-model="beginTime" placeholder="请选择开始时间"  >
				</div>
				<i class="icon-arrow-down"></i>
			</div>
			<div class="form-item" @click.stop>
				<label>至</label>
				<div class="input-wrap">
					<input type="text" class="endTime" id="end_time" v-model="endTime"  placeholder="请选择终止时间">
				</div>
				<i class="icon-arrow-down"></i>
			</div>
			<div class="form-item" @click.stop>
				<label>乘客姓名</label>
				<div class="input-wrap">
					<input type="text" placeholder="请输入乘客姓名" v-model="user">
				</div>
			</div>
			<div class="form-item" @click.stop>
				<label>乘客手机</label>
				<div class="input-wrap">
					<input type="tel" placeholder="请输入乘客手机" v-model="phone">
				</div>
			</div>
			<div class="form-item form-item-btns" @click.stop>
				<input type="reset" value="重置" class="btn-reset" @click="resetfn">
				<input type="submit" value="搜索" @click="filter" class="btn-search btn-orange">
			</div>
		</div>
	</div>
</template>

<script>

    export default{
        data(){
            return{
                order:'',
                beginTime:'',
                endTime:'',
                train:'',
                user:'',
                phone:''
            }
        },
        props: ['showfilter'],
        methods:{
            // 切换筛选
            toggleFilter(){
                this.showfilter = !this.showfilter;
            },
            // 重置
            resetfn(){
                this.order="";
                this.beginTime="";
                this.endTime="";
                this.user="";
                this.phone="";
            },

			// 筛选
			filter(){
				let params={
					orderNo : this.order,
					queryOrderDateBeg : this.beginTime,
					queryOrderDateEnd : this.endTime,
					orderMemberName : this.user,
					orderMemberPhone : this.phone
				}
				this.$dispatch('child-order-filter',params);
				this.showfilter = false;
				this.order="";
                this.user="";
                this.phone="";
			}
        },
		ready(){
			$("#begin_time").datetimePicker({
                // min: "2012-12-12",
                // max: "2022-12-12 12:12"
            });
            $("#end_time").datetimePicker({
                // min: "2012-12-12",
                // max: "2022-12-12 12:12"
            });
		}
    }

</script>