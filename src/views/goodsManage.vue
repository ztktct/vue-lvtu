<template>
	
	<div class="page-header">
		<lt-header v-on:child-shopid="changeShop" page_title="商品管理"></lt-header>
		<header class="goods-manage-hd">
			<h2>商品管理</h2>
			<div class="rarea">
				<span class="search" @click="toggleSearch"><i class="icon-search"></i> 商品搜索</span>
				<a v-link="{name:'add_goods'}" class="add-goods">+添加菜品</a>
			</div>
		</header>
		<section class="goods-manage-tit">
			<!--菜品分类-->
			<div class="goods-select-wrap">
				<select name="" class="goods-select form-control" v-model="currentGoodsType">
					<option :value="option.productClassId" v-for="option in goodsType">{{option.productClassName}}</option>
				</select>
			</div>
			<!--操作-->
			<div class="coo">
				<input type="button" class="btn btn-primary btn-change" value="批量修改" @click="toggleEdit" v-if="!editable">
				<input type="button" class="btn btn-danger btn-edit" value="保存修改" @click="submitChange " v-else>
			</div>
		</section>
	</div>

	<main class="goods-manage-bd02 page-main">
		
		<table>
		    <thead>
		        <tr>
		            <th>菜品名称</th>
		            <th>库存</th>
		            <th>排序</th>
		            <th>操作</th>
		        </tr>
		    </thead>
		    <tbody>
		        <tr class="goods-item" v-for="goods in dataGoods" track-by="$index">
		            <td><span>{{goods.shop_goods_name}}</span></td>
		            <td>
		                <input type="tel" name="" :value="goods.shop_goods_store" v-model="goods.shop_goods_store" @change="changeGoodsFn(goods)" class="input-text input-stock" :disabled="!editable">
		            </td>
		            <td>
		                <input type="tel" name="" :value="goods.shop_goods_sort" v-model="goods.shop_goods_sort" @change="changeGoodsFn(goods)" class="input-text input-sort" :disabled="!editable">
		            </td>
		            <td>
						<!--暂定0为上架状态，1为下架状态-->
		                <input type="button" value="下架" class="btn-coo btn-orange btn-shelve" :disabled="editable" @click="changeSellStatus(goods)" v-if="goods.shop_goods_is_shelve==1">
		                <input type="button" value="上架" class="btn-coo btn-dgrey btn-shelf" :disabled="editable" @click="changeSellStatus(goods)" v-if="goods.shop_goods_is_shelve==0">
		                <input type="button" value="删除" class="btn-coo btn-lgrey btn-delete" :disabled="editable" @click="deleteGoods(goods)" v-if="goods.shop_goods_is_shelve==0">
		            </td>
		        </tr>
		    </tbody>
		</table>
		<infinite v-show="dataLoading"></infinite>
	</main>
	<lt-footer></lt-footer>
	<lt-search :show-search.sync="showSearch" v-on:child-search="searchGoods"></lt-search>
</template>

<script>
	import ltFooter from '../components/footer';
	import ltSearch from '../components/search';
	import infinite from '../components/infinite';
	import ltHeader from '../components/header';
	import Promise from 'bluebird';

	export default{
		data(){
			return{
				showSearch:false,		// 是否显示搜索
				editable:false,			// 是否编辑菜品
				dataLoading:true,		// 数据是否加载中
				dataGoods:[],			// 菜品数据
				goodsType:[],			// 菜品分类
				currentGoodsType:'',	// 当前菜品分类
				changeGoods:[],			// 保存修改过的菜品(库存，排序修改)
			}
		},
		components:{
			ltFooter,
			ltSearch,
			infinite,
			ltHeader
		},
		vuex:{
			getters:{
				websit: state => state.websit,
				shopId: state => state.shopId
			}
		},
		watch:{
			currentGoodsType:function(){
				// 获取菜品数据
				getGoodsLists(this,this.shopId,this.currentGoodsType);
			}
		},
		methods:{
			// 切换搜索
			toggleSearch:function(){
				this.showSearch = !this.showSearch;
			},
			// 切换编辑状态
			toggleEdit:function(){
				this.editable = !this.editable;
			},
			// 当切换店铺时重新加载数据
			changeShop:function(){
				// 获取菜品数据
				getGoodsLists(this,this.shopId,this.currentGoodsType);
			},

			// 商品上下架
			changeSellStatus:function(goods){
				let _self = this;
				let pass = true; 	// 条件是否通过

				// 如果商品当前是上架状态，询问是否下架
				if(goods.shop_goods_is_shelve == 1){
					if(confirm('下架会删除所有购物车里包含此商品的项目,是否确认下架？')){
						pass = true;
					}else{
						pass = false;
					}
				}
				
				// 如果店铺没有选择，不通过
				if( _self.shopId == '' || _self.shopId == null){
					$.toast("请先选择店铺!", "cancel");
					pass = false;
				}
				// 如果商品当前是下架状态，检测其库存是否为0
				if(goods.shop_goods_is_shelve == 0 && goods.shop_goods_store == 0){
					$.toast("库存为0!", "cancel");
					pass = false;
				}

				// 如果不通过，则退出
				if(!pass){
					return;
				}

				// 上下架操作
				_self.$http.post(_self.websit + 'shopproduct.action',{
					action:"changeSellStatus",
					"model.shop_goods_id":goods.shop_goods_id,
					"model.shop_partner_shop_id":_self.shopId
				}).then( result =>{
					if(result.data.error == 0){
						$.toast(result.data.desc);

						if(goods.shop_goods_is_shelve == 0){
							goods.shop_goods_is_shelve =1;
						}else if(goods.shop_goods_is_shelve == 1){
							goods.shop_goods_is_shelve =0;
						}
					}
				});
			},

			// 删除商品
			deleteGoods:function(goods){
				let _self = this;

				if(_self.shopId =='' || _self.shopId == null){
					$.toast("请先选择店铺!", "cancel");
					return;
				}
				$.confirm("删除商品", "确认删除?", function() {
					// 删除商品请求
					_self.$http.post(_self.websit + 'shopproduct.action',{
						action:"deleteShopProductById",
						shopProductId:goods.shop_goods_id,
						partnerId:goods.partnerId,
						shop:_self.shopId
					}).then( results =>{
						if(results.data.error == 0){
							$.toast(results.data.desc);
							_self.dataGoods.$remove(goods);
						}
						
					});
				});
				
			},

			// 库存、排序修改
			changeGoodsFn:function(goods){
				let item ={
					id:goods.shop_goods_id,
					stocks:goods.shop_goods_store,
					sorts:goods.shop_goods_sort
				};
				let hasAlready = false;
				for(let i=0,j=this.changeGoods.length;i<j;i++){
					if( this.changeGoods[i].id == item.id ){
						hasAlready= true;
						this.changeGoods[i] = item;
					}
				}
				if(!hasAlready){
					this.changeGoods.push(item);
				}
			},

			// 提交修改
			submitChange(){
				if(this.changeGoods.length<1){
					$.toast("未修改数据", "cancel");
					this.editable = false;
					return;
				}
				this.$http.post(this.websit + 'shopproduct.action',{
					action:"updateShopProduct",
					"model.shop_partner_shop_id":this.shopId,
					"model.goodsStr":JSON.stringify(this.changeGoods)
				}).then( results =>{

					$.toast(results.data.desc);
					this.editable = false;
				});
			},

			// 搜索商品
			searchGoods(params){
				$('.weui-infinite-scroll').show();

				this.$http.post(this.websit + 'shopproduct.action',{
					action:"queryProductListByData",
					"model.shop_partner_shop_id":this.shopId,
					"model.queryProductDateBeg":params.startTime,
					"model.queryProductDateEnd":params.endTime,
					"model.shop_goods_name":params.goodsName,
					"model.shop_goods_is_shelve":params.selected

				}).then( results =>{

					$('.weui-infinite-scroll').hide();
					let data = results.data;
					if(data.error == 0){
						let goods = JSON.parse(data.datas);
						this.dataGoods = goods;
					}else{
						 $.toast(data.desc, "cancel");
					}

					this.showSearch = false;
				})
			}
		},
		ready(){
			let _self =this;

			// 获取菜品分类
			_self.$http.post(_self.websit + 'shopproduct.action',{
				action:"getAllClassList"
			}).then( results =>{
				let data = results.data;
				if(data.desc == "获取成功"){

					_self.goodsType = data.retData;
					// 设置当前菜品分类
					_self.currentGoodsType = _self.goodsType[0].productClassId;

				}else{
					$.toptip('获取菜品分类失败',1000, 'error');
				}
			}).then(()=>{
				// 获取菜品数据
				getGoodsLists(_self,_self.shopId,_self.currentGoodsType);
			});
		}
	}

	// 查询商品列表,读取数据并渲染
	function getGoodsLists(vm,shopId,classId){
		$('.weui-infinite-scroll').show();

		vm.$http.post(vm.websit + 'shopproduct.action',{
			action:"queryProductListOfAll",
			"model.shop_partner_shop_id":shopId,	// 店铺ID
			"model.shop_goods_class_id":classId		// 商品分类ID

		}).then( results =>{

			$('.weui-infinite-scroll').hide();
			let data = results.data;

			if(data.error == 0){
				vm.dataGoods = JSON.parse(data.datas);
			}else if(data.error == 1){
				vm.dataGoods = [];
				$.toast(data.desc, "cancel");
			}

		}).catch(()=>{
			$('.weui-infinite-scroll').hide();
			$.toptip('获取失败',1000, 'error');
		});
	}
</script>

<style lang="scss" scoped>
	.billing-header{
		height:auto;
		padding:10px;
	}
	.goods-manage-hd{
		margin-top:0;
		padding:10px;
		height:auto;
	}
	.page-main{
		padding-top:155px;
	}
	.goods-manage-tit{
		display:flex;
		padding:10px;
		justify-content:space-between;
		align-items:center;
		background:#fff;
		border-bottom:1px solid #ccc;

	}
	.goods-manage-tit .goods-select{
		display:inline-block;
		width:auto;
	}
	.goods-manage-bd02{
		padding-bottom:1.5rem;
	}
</style>