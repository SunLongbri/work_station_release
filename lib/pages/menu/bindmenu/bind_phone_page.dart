import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_station/colors.dart';
import 'package:work_station/helpclass/CenterToast.dart';
import 'package:work_station/helpclass/Toast.dart';
import 'package:work_station/helpclass/Utils.dart';
import 'package:work_station/pages/index_page.dart';
import 'package:work_station/pages/login_page.dart';
import 'package:work_station/service/service_method.dart';

class BindPhonePage extends StatefulWidget {
  final password;

  BindPhonePage({this.password});

  @override
  _BindPhonePageState createState() => _BindPhonePageState();
}

class _BindPhonePageState extends State<BindPhonePage> {

  Widget _back() {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(40),
          height: ScreenUtil().setHeight(40),
          child: Image.asset(
            'images/back.png',
            height: ScreenUtil().setHeight(30),
            fit: BoxFit.fitHeight,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: AppBar(
        leading: _back(),
        title: Text(
          '绑定手机',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _inputPhone(),
            _inputCode(),
            _inputPassword(),
            _bindButton(),
          ],
        ),
      ),
    );
  }

  //手机号控制器
  TextEditingController phoneController = TextEditingController();

  //绑定手机号输入框
  Widget _inputPhone() {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(74),
          right: ScreenUtil().setWidth(76),
          top: ScreenUtil().setHeight(60)),
      child: TextField(
        maxLength: 11,
        buildCounter: _counter,
        controller: phoneController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(15),
                ScreenUtil().setHeight(30),
                ScreenUtil().setWidth(15),
                ScreenUtil().setHeight(15)),
            prefixIcon: Container(
              alignment: Alignment.center,
              height: ScreenUtil().setHeight(36),
              width: ScreenUtil().setWidth(4),
              margin: EdgeInsets.only(
                  bottom: ScreenUtil().setHeight(30),
                  top: ScreenUtil().setHeight(30)),
              child: Image.asset(
                'images/forget_pass_phone.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            hintText: '请输入手机号',
            hintStyle: TextStyle(
                color: Color(0xff808080), fontSize: ScreenUtil().setSp(32))),
        autofocus: false,
      ),
    );
  }

  /// TextField 字符统计显示
  Widget _counter(
    BuildContext context, {
    int currentLength,
    int maxLength,
    bool isFocused,
  }) {
    return Container();
  }

  //验证码控制器
  TextEditingController codeController = TextEditingController();

  Widget _inputCode() {
    Color clickColor = button_normal_color;
    String imageUrl = 'images/forget_pass_code.png';
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(73),
              right: ScreenUtil().setWidth(77),
              top: ScreenUtil().setHeight(30)),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: codeController,
            maxLength: 6,
            buildCounter: _counter,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(15),
                    ScreenUtil().setHeight(30),
                    ScreenUtil().setWidth(15),
                    ScreenUtil().setHeight(15)),
                prefixIcon: Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(36),
                  width: ScreenUtil().setWidth(4),
                  margin: EdgeInsets.only(
                      bottom: ScreenUtil().setHeight(30),
                      top: ScreenUtil().setHeight(30)),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                hintText: '请输入验证码',
                hintStyle: TextStyle(
                    color: Color(0xff808080),
                    fontSize: ScreenUtil().setSp(32))),
            autofocus: false,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(430),
            top: ScreenUtil().setHeight(35),
          ),
          child: InkWell(
              splashColor: Colors.white,
              highlightColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(25),
                    left: ScreenUtil().setWidth(20),
                    bottom: ScreenUtil().setHeight(25),
                    right: ScreenUtil().setWidth(20)),
                child: Text(
                  _codeCountdownStr,
                  style: new TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: clickColor,
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  clickColor = button_click_color;
                  print('更改之后文字颜色的状态：${clickColor}');
                });
                getValidCode();
              }),
        )
      ],
    );
  }

  //获取验证码
  void getValidCode() {
    if (!_codeCountdownStr.contains('验证码')) {
      CenterToast.show(context,'请稍后再试');
      return;
    }
    if (Utils.isChinaPhoneLegal(phoneController.text.trim())) {
      reGetCountdown();
      print('获取的手机号码为:${phoneController.text.trim()}');
      var formData = {"tel": '${phoneController.text.trim()}'};
      request(context, 'getValidCode', formData).then((val) {
        print('获取到的数据:${val.toString()}');
        if (val['code'] == 0) {
          CenterToast.show(context,"验证发发送成功,请注意查收!");
        } else if (val['code'] == -1) {
          CenterToast.show(context,"验证发发送失败,请重新发送!");
        }
      });
    } else {
      CenterToast.show(context,"请输入正确的手机号!");
    }
  }

  //------------------倒计时功能---------------------------------

  Timer _countdownTimer;
  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;

  void reGetCountdown() {
    setState(() {
      if (_countdownTimer != null) {
        return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _codeCountdownStr = '${_countdownNum--}秒重新获取';
      _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownNum > 0) {
            _codeCountdownStr = '${_countdownNum--}秒重新获取';
          } else {
            _codeCountdownStr = '获取验证码';
            _countdownNum = 59;
            _countdownTimer.cancel();
            _countdownTimer = null;
          }
        });
      });
    });
  }

  // 不要忘记在这里释放掉Timer
  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

//--------------------倒计时功能代码结束-----------------------------

  //手机号控制器
  TextEditingController passController = TextEditingController();

  //绑定手机号输入框
  Widget _inputPassword() {
    if (widget.password != null) {
      return Container(
        width: ScreenUtil().setWidth(10),
        height: ScreenUtil().setHeight(10),
      );
    }
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(74),
          right: ScreenUtil().setWidth(76),
          top: ScreenUtil().setHeight(40)),
      child: TextField(
        maxLength: 12,
        buildCounter: _counter,
        controller: passController,
        obscureText: true,
        //是否隐藏输入内容
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(15),
                ScreenUtil().setHeight(30),
                ScreenUtil().setWidth(15),
                ScreenUtil().setHeight(15)),
            prefixIcon: Container(
              alignment: Alignment.center,
              height: ScreenUtil().setHeight(36),
              width: ScreenUtil().setWidth(4),
              margin: EdgeInsets.only(
                  bottom: ScreenUtil().setHeight(30),
                  top: ScreenUtil().setHeight(30)),
              child: Image.asset(
                'images/forget_pass_lock.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            hintText: '请输入密码',
            hintStyle: TextStyle(
                color: Color(0xff808080), fontSize: ScreenUtil().setSp(32))),
        autofocus: false,
      ),
    );
  }

  //修改密码按钮
  Widget _bindButton() {
    String username = '';
    String password = '';
    String btnName = '确认';
    Color isClick = button_normal_color;
    return Container(
      height: ScreenUtil().setHeight(90),
      width: ScreenUtil().setWidth(600),
      margin: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(20), top: ScreenUtil().setWidth(80)),
      child: FlatButton(
        onPressed: () {
          var password;
          print(
              '获取到的手机号:${phoneController.text.trim()},验证码：${codeController.text.trim()},用户密码:${passController.text.trim().toString()}');
          if (passController.text.trim().isEmpty) {
            password = widget.password;
          } else {
            password = passController.text.trim();
          }
          var formData = {
            'code': '${codeController.text.trim()}',
            'tel': '${phoneController.text.trim()}',
            'password': '${password}',
          };
          seatRequest(context, 'bindPhone', formData: formData).then((val) {
            print('绑定手机号:${val.toString()}');
            if (val['code'] == 0) {
              CenterToast.show(context,"绑定手机号成功!");
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => IndexPage()),
                  (route) => route == null);
            } else if (val['code'] == -1) {
              CenterToast.show(context,"${val['msg']}");
            } else if (val['code'] == -4) {
//              CenterToast.show(context,"登陆过期，请重新登陆!");
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => route == null);
            } else {
              CenterToast.show(context,"${val['msg']}");
            }
          });
        },
        child: Text(
          btnName,
          style: TextStyle(fontSize: ScreenUtil().setSp(32)),
        ),
        color: button_normal_color,
        highlightColor: button_click_color,
        splashColor: Colors.transparent,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
