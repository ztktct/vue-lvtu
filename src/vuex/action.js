// Actions: 组件内部用来分发 mutations 事件的函数

// 设置店铺ID
export const setShopId = ({ dispatch },data) =>{
	dispatch('SET_SHOPID',data);
}
// 保存信息
export const setUserInfo = ({ dispatch },data) =>{
	dispatch('SET_USER_INFO',data);
}
// 清空信息
export const delUserInfo = ({ dispatch },data) =>{
	dispatch('DEL_USER_INFO',data);
}

// 设置新消息提醒
export const setNewMsg = ({ dispatch },data )=>{
	dispatch('SET_NEW_MSG',data);
}

// 设置新订单的数量
export const setNewOrder = ({ dispatch },data) =>{
	dispatch('SET_NEW_ORDER',data);
}
// 设置各个状态下的新订单
export const setNewOrders = ({ dispatch },data) =>{
	dispatch('SET_NEW_ORDERS',data);
}
// 设置新补票信息
export const setNewTicket = ({ dispatch },data) =>{
	dispatch('SET_NEW_TICKET',data);
}
export const setNewRefund = ({ dispatch },data) =>{
	dispatch('SET_NEW_REFUND',data);
}

