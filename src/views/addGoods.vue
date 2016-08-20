<template>
	<div class="page" transition="slide-left">
		<div class="page-header">
			<header class="order-md-hd">
				<h2>菜品列表</h2>
				<a v-link="{name:'goods'}"><i class="icon-back"></i>返回上级</a>
			</header>
			<section class="goods-manage-tit">
				<div class="goods-select-wrap">
					<select name="" class="goods-select form-control" v-model="currentGoodsType" @change="toggleType">
						<option :value="option.productClassId" v-for="option in goodsType" track-by="productClassId">{{option.productClassName}}</option>
					</select>
				</div>
				
				<div class="coo">
					<input type="button" class="btn btn-primary btn-change" value="添加" @click="saveGoods">
				</div>
			</section>
		</div>
		
		<main class="goods-manage-bd page-main">
			<!-- 一个菜品 -->
			<div class="goods-manage-item" v-for="goods in goodsData" :class="{selected:goods._selected}" @click="toggleSelect(goods)">
				<div class="wrap">
					<img :src="imgsrc + goods.comGoodsImgOss" alt="{{goods.comGoodsName}}">
					<h3>{{goods.comGoodsName}}</h3>
					<p>价格：{{goods.comGoodsPrice}}</p>
					<p>折扣价：{{goods.comGoodsPriceDiscount}}</p>
				</div>
			</div>
		</main>
	</div>
	
</template>

<script>
	import ltFooter from '../components/footer';

	// 图片存放路径
	const IMG_PREFIX ="http://lvtudiandian.img-cn-hangzhou.aliyuncs.com/";

	export default{
		data(){
			return{
				imgsrc: IMG_PREFIX,
				goodsType:[],			// 菜品分类
				currentGoodsType:'',	// 当前选择的分类
				goodsData:[],			// 存放当前菜品数据
				selectGoodsId:[]		// 选中的菜品ID
			}
		},
		vuex:{
			getters:{
				websit : state => state.websit,
				shopId : state => state.shopId
			}
		},
		methods:{

			// 切换分类
			toggleType(){
				getGoodsData(this,this.shopId,this.currentGoodsType);
				this.selectGoodsId =[];
			},

			// 选中与不选中
			toggleSelect(goods){
				goods._selected = !goods._selected;
				
				// 如果选中，就加入
				if(goods._selected){
					this.selectGoodsId.push(goods.comGoodsId);
				}else{
					this.selectGoodsId.$remove(goods.comGoodsId);
				}
			},

			// 添加选中的菜品
			saveGoods(){
				this.$http.post(this.websit + 'shopproduct.action',{
					action:"spmAddShopProduct",
					shop:this.shopId,
					productIds:this.selectGoodsId.join(',')
				}).then( results =>{

					if(results.data.error == '0'){
						$.toast(results.data.desc);
					}
					this.$router.go('/goods_manage');
				})
			}
		},
		ready(){

			let _self = this;

			// 获取菜品分类
			_self.$http.post(_self.websit+'shopproduct.action',{
				action:"getAllClassList"
			}).then( results =>{
				let data = results.data;
				if(data.error == 0){
					
					_self.goodsType = data.retData;
					// 设置默认菜品分类
					_self.currentGoodsType = _self.goodsType[0].productClassId;
				}else{
					$.toast(data.desc, "cancel");
				}
			}).then(()=>{
				getGoodsData(_self,_self.shopId,_self.currentGoodsType); 
			})
		}
	}

	// 获得需要添加的菜品的数据
	function getGoodsData(vm,shopId,classId){
		vm.$http.post(vm.websit +'shopproduct.action',{
			action:"getAllProductList",
			classId:classId,
			shop:shopId
		}).then( results =>{
			let data = results.data;
			if(data.error == 0){
				// 为每个菜品对象添加新属性._selected，是否被选中
				let newData = [];

				data.retData.forEach( goods =>{
					goods._selected=false;
					newData.push(goods);
				});

				vm.goodsData = newData;
				
			}else{
				$.toast('暂无商品!', "cancel");
				vm.goodsData = [];
			}
			
		});
		
	}
</script>

<style lang="scss" scoped>
	.page{
		z-index:55;
		background:#f2f2f2;
	}
	.order-md-hd{
		padding:10px;
	}
	.order-md-hd h2{
		font-size:15px;
	}
	.goods-manage-tit{
		display:flex;
		justify-content:space-between;
		background:#fff;
		padding:5px 10px;
		align-items:center;
		border-bottom:1px solid #ccc;
	}
	.goods-manage-bd{
		height:auto;
		max-height:100%;
		.goods-manage-item{
			width:49%;
			box-sizing:border-box;
			background:transparent;
			padding:10px 0 0px 10px;
			&.selected{
				.wrap{
					background:#fff url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA4RpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNS1jMDIxIDc5LjE1NTc3MiwgMjAxNC8wMS8xMy0xOTo0NDowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDplYzZlNTY2Yy03MGFhLTllNDQtOWM1NC01NDZjNDgyZGM4ZGMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6QTFBRTgyMTA4NkI5MTFFNTlFMUQ4ODFDODQ4MUY5NTQiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6QTFBRTgyMEY4NkI5MTFFNTlFMUQ4ODFDODQ4MUY5NTQiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKFdpbmRvd3MpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MDUzM2E0ZjEtMmY3Yi03ZDQ3LWI5OTItNzBmODllNDM0MzNmIiBzdFJlZjpkb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6ZTBlOTM3NzYtODJlZC0xMWU1LWIzODgtOGZkYzU0OGZhY2FiIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+59b91wAAAXJJREFUeNpi/P//PwOtwMtwzf9MtDQcRDPR0nCaWIBsONUtQDecqhZgM5xqFuAynCoW4DOcYgsIGU6RBcQYTrYFxBpOlgWkGE6yBfgMZxaRZOCJLGRgZGVHEWcktrDDZzgjOweDUNMyBhYFTYbfdy8zfGhPZ/j3+T3xPiAULHwZrWDDwT4RFAOaykR8EBEynMs3iYHDygvM/v/nN8OH3jyGfx/fEmcBuuGMLKwMfFntDKzKumA+m74NA29UEVz+8+wGht93LqGYwUK0yxkZGfgL+hnYTZ0ZOMzdGD4v6mDgjS4FOpEZLP1t+2KG7wfWYZjDQmywMLKwMTAJS0DYHFwMfGlNcLlfV08yfF7cSVwyxRXm/3//ZHjfFM/w68oJFPG/r58yfJwADKa/fwlbQChC/3//CkyCaQw/jm2H8H/+YPgIitRP73DqYSE1h4JSysdJJQx/3zxj+HP/KsPv+9fwqgdnNFKzP0lFBS0NBwGAAAMAAnOYu2S6K/MAAAAASUVORK5CYII=) no-repeat right bottom;
				}
			}
			.wrap{
				background:#fff;
				padding:10px;
				border:1px solid #ccc;
				height: 100%;
    			box-sizing: border-box;
				img{
					margin-bottom:5px;
				}
				h3{
					white-space:nowrap;
					overflow:hidden;
					text-overflow:ellipsis;
				}
			}
		}
	}
</style>