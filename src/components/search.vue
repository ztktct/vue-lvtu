<!-- 搜索 -->
<template>
    <div class="manage-filter form-lists" @click="toggleSearch" v-show="showSearch" transition="slide-left" :class="{show:showSearch}">
		<div class="wrap">
			<div class="form-item" @click.stop>
				<label>出售状态</label>
				<div class="input-wrap">
					<select name="" v-model="selected">
						<option value="" selected>--请选择出售状态--</option>
						<option value="1">在售</option>
						<option value="0">下架</option>
					</select>
				</div>
			</div>
			<div class="form-item" @click.stop>
				<label>添加时间</label>
				<div class="input-wrap">
					<input type="text" id="start_time" v-model="startTime" placeholder="请选择开始时间">
				</div>
				<i class="icon-arrow-down"></i>
			</div>
			<div class="form-item" @click.stop>
				<label>至</label>
				<div class="input-wrap">
					<input type="text" id="end_time" v-model="endTime" placeholder="请选择终止时间">
				</div>
				<i class="icon-arrow-down"></i>
			</div>
			<div class="form-item" @click.stop>
				<label>菜名</label>
				<div class="input-wrap">
					<input type="text" v-model="goodsName" placeholder="请输入菜名">
				</div>
			</div>
			
			<div class="form-item form-item-btns">
				<input type="reset" value="重置" @click.stop="reset" class="btn-reset">
				<input type="submit" value="搜索" @click="search" class="btn-search btn-orange">
			</div>
		</div>
	</div>
</template>

<script>
    export default{
        data(){
            return{
                selected:'',
                startTime:'',
                endTime:'',
                goodsName:'',
                
            }
        },
        props:['showSearch'],
        methods:{
            toggleSearch:function(){
				this.showSearch = !this.showSearch;
			},
			// 重置
			reset(){
				this.selected="";
                this.startTime="";
                this.endTime="";
                this.goodsName="";
			},

			// 搜索
			search(){
				let params={
					selected:this.selected,
					startTime:this.startTime,
					endTime:this.endTime,
					goodsName:this.goodsName
				};

				this.$dispatch('child-search',params);
				this.selected="";
                this.goodsName="";
				this.toggleSearch();
			}
        },
        ready(){
            $("#start_time").datetimePicker({
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
	