const serviceUrl = 'http://101.132.42.189:8899';
//const serviceUrl = 'http://192.168.1.133:8080';
const lightingUrl = 'http://192.168.1.129:3001';
const servicePath = {
  "loginPageContent": serviceUrl + "/user/login", //登陆请求
  'getUserInfo': serviceUrl + '/user/get_info', //获取用户详细信息
  'getWorkSeat': serviceUrl + '/seat/info', //获取工位当前状态
  'bookSeat': serviceUrl + '/order/book_seat', //工位订单
  'orderCancel': serviceUrl + '/order/cancel', //取消订单
  'orderDetail': serviceUrl + '/order/detail', //订单详情
  'orderList': serviceUrl + '/order/list', //预约记录
  'getValidCode': serviceUrl + '/user/valid_code',//获取验证码
  'bindPhone' : serviceUrl + '/user/bind_tel',//绑定手机号
  'forgetPassWord' : serviceUrl + '/user/reset_password_by_forget',//用户未登录，忘记密码，重置密码
  'resetPassWord' : serviceUrl + '/user/reset_password',//登陆成功，重置密码
  'logOut' : serviceUrl + '/user/logout',//用户登出
  'currentWorkSeat' : serviceUrl + '/inner/list_seat_status',//获取工位占用状态 0-无人 1-有人 5-超时
  'lightingWorkSeat' : serviceUrl + '/inner/list_light_status',//获取灯控人是否离开
  'getAirStatus' : serviceUrl + '/inner/list_air_conditioner_status',//获取空调信息
  'setAirStatus' : serviceUrl + '/inner/set_air_conditioner',//设置空调值

  'getLightingList' : lightingUrl + '/api/touchpad/get/device/list',//获取设备列表
  'postLightingStatus' : lightingUrl + '/api/touchpad/get/light/info',//获取设备列表
};
