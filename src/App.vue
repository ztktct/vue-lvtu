<template>
	<div id="app">
		<router-view></router-view>
		<audio src="static/456.mp3" preload id="tip_voice"></audio>
	</div>
</template>

<script>

import store from './vuex/store';
import {setNewMsg} from './vuex/action';
import {queryNewMessage , cancleReceiver} from './lib/Jpush-lib.js';

export default{
	store,
	vuex:{
		getters:{
			websit: state => state.websit,
			hasLogin : state => state.hasLogin,
			partnerId: state => state.partnerId,
            hasNewMsg: state => state.hasNewMsg,
			train: state => state.train
		},
		actions:{
			setNewMsg
		}
	},
	ready(){
		let _self = this;

		// 主动加载提示音
        let audio = document.getElementById('tip_voice');
        document.addEventListener('touchstart',loadAudio);
		
        function loadAudio(){
            audio.load();
			document.removeEventListener('touchstart',loadAudio);
        }
		
		// 开始查询新消息
        //  queryNewData(_self,audio);
        //  setInterval(function(){
		// 	 if(_self.hasLogin)  queryNewData(_self,audio);
        //  },30000);

		let timer = setInterval(function(){
			if(!queryNewMessage(_self,audio)){
				queryNewMessage(_self,audio);
			}else{
				clearInterval(timer);
			}
		},1000);
        
	}
};

	// 查询是否有新订单,只在登录状态下查询(暂时不用)
    function queryNewData(vm,audio){
		
    	if(!vm.hasLogin){
    		return;
    	}
        vm.$http.post(vm.websit + 'orderManage.action',{
            action:"scanOrderRemind",
            "model.partnerId":vm.partnerId
        }).then( results =>{
            let data = results.data;
            
            // 如果有新消息，播放提示音，并改变vm.hasNewMsg,表示有新消息，其他页面根据此变量自动加载新数据
            if( data.result == 'SKsuccessMessages' ){
				vm.setNewMsg(1);	// 提醒其他页面有新数据，该刷新了
                if(audio.paused || audio.ended){
                    $.toptip(data.msg, 'success');
                    audio.play();
                }
            }
        });
    }



</script>

<style lang="scss" scoped>
	.ios:not(.ios-6){
		#app{
			margin-top:20px;
			height:-webkit-calc(100% - 20px);
			height:calc(100% - 20px);
		}
	}
	
</style>