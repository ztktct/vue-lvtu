$(document).ready(function() {

    //回车后登录  
    document.onkeydown = function(e) {
        var ev = document.all ? window.event: e;
        if (ev.keyCode == 13) {
            login();
        }
    };
    
    //判断之前是否有设置cookie，如果有，则设置【记住账号】选择框  
    if (($.cookie('h8h_bup_account') !== null) && ($.cookie('h8h_bup_account') !== '') ) {
        $("#rememberMe").attr("checked", true);
    } else {
        $("#rememberMe").attr("checked", false);
    }
    
    //读取cookie  
    if ($('#rememberMe:checked').length > 0) {
        $('#account').val($.cookie('h8h_bup_account'));
    }

    //监听【记住账号】事件  
    $("#rememberMe").click(function() {
        setOrRemoveCookies();
    });

    $("#submitButton").click(function() {
        login();
    });
});



//登录  
function login() {
	setOrRemoveCookies();

    var account = $('#account').val().replace(/\s+/g, "");
    var password = $('#password').val().replace(/\s+/g, "");
    var msg = "";
    
    if (account === '') {
        msg = new $.zui.Messager('账号不能为空！', {type: 'danger', placement: 'top'});
        msg.show();
        $('#account').focus();
        return;
    }
    
    if (password === '') {
        msg = new $.zui.Messager('密码不能为空！', {type: 'danger', placement: 'top'});
        msg.show();
        $('#password').focus();
        return;
    }

    $.ajax({
        type: "POST",
        url: "login.h8h?action=login",
        data: "account=" + account + "&password=" + hex_md5(password) + "&r=" + Math.random(),
        dataType: "json",
        error: function () {
            var msg = new $.zui.Messager('网络超时，请稍后再试', {type: 'danger', placement: 'top'});
        	msg.show();
        },
        success: function(data, textStatus) {
        	console.log("data="+JSON.Stringify(data));
            var tip = "登录不成功！";
            var type = 'danger';
            switch (data.result) {
            case "disable":
            	tip = "账号被停用！"; 
            	break;
            case "input":
                tip = "账号或密码错误！";
                break;
            case "success":
                tip = "正在进入商家平台，请稍候...";
                type = 'success';
                var indexUrl = "sp/index.h8h?action=index";
                var appPath = "/" + location.pathname.split("/")[1] + "/";
                window.location.href = appPath + indexUrl;
                break;
            }
            var msg = new $.zui.Messager(tip, {type: type, placement: 'top'});
        	msg.show();
        },
        beforeSend: function(formData, jqForm, options) {
            
        },
        async: false
    });
}

//判断是否勾选了【记住账号】选择框，进行设置或清除Cookie  
function setOrRemoveCookies() {
    if ($('#rememberMe:checked').length > 0) { //设置cookie  
        $.cookie('h8h_bup_account', $('#account').val());
    } else { //清除cookie  
        $.removeCookie('h8h_bup_account');
    }
}
