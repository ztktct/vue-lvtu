
let _partnerId = 0;
let _train = '';
let _vm = {};
let _audio = null;

// 设备准备完毕后调用
var onDeviceReady = function () {
    console.log("JPushPlugin:Device ready!");
    initiateUI();
};

// 获得唯一的设备标识
var getRegistrationID = function () {
    window.plugins.jPushPlugin.getRegistrationID(onGetRegistrationID);
};

// 获得设备标识后的回调
var onGetRegistrationID = function (data) {
    try {
        console.log("JPushPlugin:registrationID is " + data);
        if (data.length == 0) {
            var t1 = window.setTimeout(getRegistrationID, 1000);
        }
    } catch (exception) {
        console.log(exception);
    }
};

// 当设备别名或tag改变后触发
var onTagsWithAlias = function (event) {
    
    try {
        var result = "result code:" + event.resultCode + " ";
        result += "tags:" + event.tags + " ";
        result += "alias:" + event.alias + " ";
        console.log(result);
    } catch (exception) {
        console.log(exception);
    }
};

// 点击通知进入应用程序时会调用该方法
var onOpenNotification = function (event) {
    try {
        var alertContent;
        if (device.platform == "Android") {
            alertContent = event.alert;
        } else {
            alertContent = event.aps.alert;
        }
        $.toptip(alertContent, 'success');
    } catch (exception) {
        console.log("JPushPlugin:onOpenNotification" + exception);
    }
};

// 收到通知时会调用该方法
var onReceiveNotification = function (event) {
    
    try {
        var alertContent;
        if (device.platform == "Android") {
            alertContent = event.alert;
        } else {
            alertContent = event.aps.alert;
        }
        if (_audio.paused || _audio.ended) {
            $.toptip(alertContent, 'success');
            // _vm.setNewMsg(1);	// 提醒其他页面有新数据，该刷新了
            _audio.play();
        }
    } catch (exception) {
        console.log(exception);
    }
};

var initiateUI = function () {
    try {
        window.plugins.jPushPlugin.init();	// 插件初始化
        getRegistrationID();				// 获得ID
        window.plugins.jPushPlugin.resumePush();        // 尝试重新启动服务(如果曾经退出过)

        if (device.platform != "Android") {
            window.plugins.jPushPlugin.setDebugModeFromIos();
            window.plugins.jPushPlugin.setApplicationIconBadgeNumber(0);
             window.plugins.jPushPlugin.setAlias('ios_'+_partnerId + _train);	// 设置IOS设备别名
        } else {
            window.plugins.jPushPlugin.setDebugMode(true);		// 调试模式
            window.plugins.jPushPlugin.setStatisticsOpen(true);	// 统计
            window.plugins.jPushPlugin.setAlias(_partnerId + _train);	// 设置Android设备别名
        }
    } catch (exception) {
        console.log(exception);
    }
};

// 通过Jpush极光推送插件
function queryNewMessage(vm, audio) {
    _partnerId = vm.partnerId;
    _train = vm.train;
    _vm = vm;
    _audio = audio;
    
    // 只有当登录后,并且获得了商家ID与车次号后再去查询
    if (vm.hasLogin == 0 && _partnerId == 0 && _train == ''){
        return false;
    }
    // 设备准备完毕
    document.addEventListener("deviceready", onDeviceReady, false);
    // 监听设备别名设置
    document.addEventListener("jpush.setTagsWithAlias", onTagsWithAlias, false);
    // 点击通知进入应用程序时会触发该事件
    document.addEventListener("jpush.openNotification", onOpenNotification, false);
    // 收到通知时会触发该事件
    document.addEventListener("jpush.receiveNotification", onReceiveNotification, false);
    // 收到自定义消息时触发这个事件，推荐使用事件的方式传递。
    // document.addEventListener("jpush.receiveMessage", onReceiveMessage, false);

    return true;
    
}

// 取消接收新消息
function cancleReceiver(){
    try{
        // 取消接收,安卓通过调用stopPush()停止接收，IOS通过清空别名暂停接收消息
        if (device.platform == "Android") {
            window.plugins.jPushPlugin.stopPush();  
        }else{
            // 清空别名，任然会收到全局消息
         window.plugins.jPushPlugin.setAlias('');
        }
        

    }catch(err){
        console.log(err);
    }
}

export {queryNewMessage , cancleReceiver};
