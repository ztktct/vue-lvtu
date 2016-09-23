<template>
	<lt-header page_title="订单查询"></lt-header>
	<div class="query-order">
		<div class="form-group">
			<label for="">订单进度</label>
			<select class="form-control" v-model="step" name="select1">
			    <option value="1">已支付状态</option>
			    <option value="3">配送状态</option>
			    <option value="4">未接单状态</option>
			    <option value="5">未配送状态</option>
			    <option selected value="6">已完成状态</option>
			</select>
		</div>
		<div class="form-group">
			<label for="">添加时间</label>
			<input type="text" v-model="startTime" readonly placeholder="请选择开始时间" id="start" class="form-control">
		</div>
		<div class="form-group">
			<label for="">至</label>
			<input type="text" v-model="endTime" readonly placeholder="请选择终止时间" id="end" class="form-control">
		</div>
		<div class="form-group">
			<input type="button" class="btn-primary" @click="setBody" value="查询订单">
		</div>
	</div>
</template>

<script>
	
	import ltHeader from '../components/header';
	import {setQueryOrderBody} from '../vuex/action';

	export default{
		data(){
			return{
				startTime:'',
				endTime:'',
				step:6
			}
		},
		vuex:{
			getters:{
				shopId: state => state.shopId
			},
			actions:{
				setQueryOrderBody
			}
		},
		methods:{
			setBody(){
				// if(!this.startTime){
				// 	$.alert('请选择开始时间');
				// 	return false;
				// }
				// if(!this.endTime){
				// 	$.alert('请选择终止时间');
				// 	return false;
				// }
				let body ={
					startTime : this.startTime,
					endTime : this.endTime,
					step : this.step,
					shopId : this.shopId
				};
				this.setQueryOrderBody(body);
				this.$router.go({name:'table'});
			}
		},
		components:{
			ltHeader
		},
		ready(){
			$("#start").datetimePicker();
			$("#end").datetimePicker();
		}
	}

</script>

<style lang="scss" scoped>
	.query-order{
		padding:30px 10px;
		.form-group{
			display:flex;
			align-items:center;
			margin-bottom:10px;
			&:last-child{
				justify-content:flex-end;
				.btn-primary{
					margin-right: 10px;
				}
			}
		}
		label{
			width:105px;
			text-align:center;
			font-size:14px;
		}
		.form-control{
			flex:1;
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
			box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
			transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
		}
		select.form-control{
			height:40px;
		}
	}
</style>