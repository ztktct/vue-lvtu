<%@ page contentType="text/html; charset=UTF-8"%>
<script src="<%=request.getContextPath()%>/framework/js/md5.js"></script>
<%-- <script src="<%=request.getContextPath()%>/framework/js/zepto.min.js"></script> --%>
<script type="text/javascript">

	var audio ;
window.onload = function(){
	initAudio();
}





var initAudio = function(){
	//audio =  document.createElement("audio")
	//audio.src='Never Say Good Bye.ogg'
	audio = document.getElementById('aaa');
	window.addEventListener('touchstart', loadAudio, false);
	audio.addEventListener('play', function() {

        window.removeEventListener('touchstart', loadAudio, false);
    }, false);
}
function getCurrentTime(id){			
	alert(parseInt(audio.currentTime) + '：秒');
}
 function loadAudio(){
	audio.load()
}
function playOrPaused(id,obj){
	if(audio.paused){
		audio.play();
		if(obj)
		{
			obj.innerHTML='暂停';
		}
		return;
	}
	audio.pause();
	obj.innerHTML='播放';
}

function hideOrShowControls(id,obj){
	if(audio.controls){
		audio.removeAttribute('controls');
		obj.innerHTML = '显示控制框'
		return;
	}
	audio.controls = 'controls';
	obj.innerHTML = '隐藏控制框'
	return;
}
function vol(id,type , obj){
	if(type == 'up'){
		var volume = audio.volume  + 0.1;
		if(volume >=1 ){
			volume = 1 ;
		
		}
		audio.volume =  volume;
	}else if(type == 'down'){
		var volume = audio.volume  - 0.1;
		if(volume <=0 ){
			volume = 0 ;
		}
		audio.volume =  volume;
	}
	document.getElementById('nowVol').innerHTML = returnFloat1(audio.volume);
}
function muted(id,obj){
	if(audio.muted){
		audio.muted = false;
		obj.innerHTML = '开启静音';
	}else{
		audio.muted = true; 
		obj.innerHTML = '关闭静音';
	}
}
 //保留一位小数点

function returnFloat1(value) {    
	value = Math.round(parseFloat(value) * 10) / 10;
	if (value.toString().indexOf(".") < 0){
		value = value.toString() + ".0";
	}
	return value;
}
</script>
<!--<div class="navbar navbar-fixed-top" id="navbar" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">
			<img src="<%=request.getContextPath()%>/framework/image/logo.png" height="40px" />
			<span>商家平台</span>
			</a>
		</div>
		<div class="collapse navbar-collapse">
			<div class="navbar-text navbar-right">您好, <%=train.trainSide.base.util.BupUserUtil.getUserInfo(request).getUserName()%>&nbsp;&nbsp;
				<a data-toggle="modal" data-position="200px" href="#changePsw">[更改密码]</a>&nbsp;&nbsp;
				<a data-toggle="modal" data-position="200px" href="#loginOut">[退出]</a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a href="">商家帮助</a>
				<a href="javascript:void(0);" onclick="playOrPaused('firefox',this);">播放</a>
			</div>
		</div>
	</div>
</div>-->




<!-- 更改密码（changePsw） -->
<div class="modal fade" id="changePsw" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><i class="icon icon-times"></i></button>
            	<h4 class="modal-title">更改密码</h4>
			</div>
         	<div class="modal-body">
	         	<div class="form-horizontal">
					<div class="form-group">
		      			<label class="col-xs-3 control-label">原密码：</label>
		      			<div class="col-xs-8">
			      			<input type="password" id="old_password" class="form-control" />
						</div>
		      		</div>
					<div class="form-group">
		      			<label class="col-xs-3 control-label">新密码：</label>
		      			<div class="col-xs-8">
			      			<input type="password" id="new_psw" class="form-control" />
						</div>
		      		</div>
		      		<div class="form-group">
		      			<label class="col-xs-3 control-label">确认新密码：</label>
		      			<div class="col-xs-8">
			      			<input type="password" id="new_repsw" class="form-control" />
						</div>
		      		</div>
	      		</div>
		 	</div>
         	<div class="modal-footer">
         		<button type="button" tabindex="1" class="btn btn-primary" id="changePsw_ok">确定</button>
            	<button type="button" tabindex="2" class="btn btn-default" data-dismiss="modal">取消</button>
         	</div>
      	</div>
   	</div>
</div>
<audio id="aaa" src="<%=request.getContextPath()%>/framework/js/456.mp3"      ></audio>


<!-- 退出登录（loginOut） -->
<!-- <div class="modal fade" id="loginOut" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal"><i class="icon icon-times"></i></button>
				<h4 class="modal-title">系统提示</h4>
         	</div>
         	<div class="modal-body">确定退出登录？</div>
         	<div class="modal-footer">
         		<button type="button" tabindex="1" class="btn btn-primary" id="loginOut_ok">确定</button>
            	<button type="button" tabindex="2" class="btn btn-default" data-dismiss="modal">取消</button>
         	</div>
      	</div>
   	</div>
</div> -->

<script type="text/javascript">

function  searchFlag()
{
	
	//window.write("<audio id=\"aaa\" src=\"123.mp3\" autoplay controls></audio>")
	var rData={
		action:"scanOrderFromLast"
	};
	$.post("orderManage.action",rData,function(retMsg){
		console.log("newOrder="+retMsg.newOrder);
		console.log("newTicket="+retMsg.newTicket);
		console.log("newRefund="+retMsg.newRefund);
		if(parseInt(retMsg.newOrder)==1||parseInt(retMsg.newTicket)==2||parseInt(retMsg.newRefund)==3)
		{
			msg = new $.zui.Messager("您有新的消息请查看！", {type: 'warning', placement: 'top',time:0,close:true});
			msg.show();
			playOrPaused();
		}
		/* console.log("newTicket="+retMsg.newTicket);
		if(parseInt(retMsg.newTicket)==2){
			$.zui.messager.show("您有新的补票订单请刷新",{type:"danger",time:0,close:true});
			playOrPaused();
		}
		console.log("newRefund="+retMsg.newRefund);
		if(parseInt(retMsg.newRefund)==3){
			$.zui.messager.show("您有新的退款申请请刷新",{type:"danger",time:0,close:true});
			playOrPaused();
		} */
	},"json");
}
function playSound()
{
	var isReady=false;
	var audio = document.getElementById('aaa');
	audio.addEventListener("canplaythrough", function () {
		isReady=true;
	}, false);
	return isReady;
}
var runCycle="<%=com.h8h.framework.utils.ParaUtil.getParaValue("RunCycle")%>";

$(function(){

	setInterval("searchFlag()",parseInt(runCycle)>0?parseInt(runCycle)*1000:1000)
	///setInterval("searchFlag()",parseInt(runCycle)>0?parseInt(runCycle):1);
	
	searchFlag();
	
	$('#changePsw_ok').click(function(){
		var oldPassword = $('#old_password').val().replace(/\s+/g, "");
		var newPassword = $('#new_psw').val().replace(/\s+/g, "");
		var newRepassword = $('#new_repsw').val().replace(/\s+/g, "");
		
		var message = '';
		if(oldPassword === ''){
			message = '原密码不能为空！';
	        $('#old_password').focus();
		} else if(newPassword === ''){
    		message = '新密码不能为空！';
	        $('#new_psw').focus();
    	} else if(newRepassword === ''){
    		message = '确认新密码不能为空！';
	        $('#new_repsw').focus();
    	} else if(newPassword != newRepassword){
    		message = '两次密码输入不相同！';
	        $('#new_psw').val('');
	        $('#new_repsw').val('');
	        $('#new_psw').focus();
    	} else if(newPassword.length < 6){
    		message = "密码长度最少6位！";
    		$('#new_psw').val('');
	        $('#new_repsw').val('');
	        $('#new_psw').focus();
    	}
    	if(message.length > 0){	
	    	msg = new $.zui.Messager(message, {type: 'danger', placement: 'top'});
	        msg.show();
	    	return;
    	}
    	
    	oldPassword = hex_md5(oldPassword);
		newPassword = hex_md5(newPassword);
    	
		$.ajax({
	        type: "POST",
	        url: "user.action?action=changePassword",
	       	data: { 'model.oldPassword': oldPassword,
  		        	'model.pass': newPassword
  		    },
	        dataType: "json",
	        success: function(data, textStatus) {
	            if(data.result=='SKsuccessMessages'){
	            	msg = new $.zui.Messager(data.msg, {type: 'success', placement: 'top'});
	        		msg.show();
	        		$('#changePsw').modal('hide');
	            }
	            if(data.result=='SKerrorMessages'){
	            	msg = new $.zui.Messager(data.msg, {type: 'danger', placement: 'top'});
	        		msg.show();
	            }
	        },
	        beforeSend: function(formData, jqForm, options) {
	            
	        },
	        async: false
	    });
	});

	$('#loginOut_ok').click(function(){
		$.post("login.action",{action:"loginOut"},function(retMsg){
			window.location.href = "login.action?action=init";
		},"json");
	});

	
	   /*  var bill_nav=$('.billing-nav'); // 左侧导航

        // 左侧导航显示 
        $('.billing-header .icon-bill-01').on('tap',function(e){
        	e.stopPropagation();
        	slideModule(bill_nav);
        });

		bill_nav.on('tap',function(){
        	$(this).removeClass('show');
        });
		function slideModule(o){
        	if(o.hasClass('show')){
        		o.removeClass('show');
        	}else{
        		o.addClass('show');
        	}
        }
        function showModule(o){
        	o.addClass('show');
        }

        
		 function hideModule(o){
        	o.removeClass('show');
        }
 */

});

</script>
