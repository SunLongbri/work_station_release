import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_station/colors.dart';
import 'package:work_station/design/CustomButton.dart';
import 'package:work_station/helpclass/CenterToast.dart';
import 'package:work_station/helpclass/Toast.dart';
import 'package:work_station/helpclass/Utils.dart';
import 'package:work_station/pages/login_page.dart';
import 'package:work_station/service/service_method.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  //请输入手机号控制器
  TextEditingController phoneController = TextEditingController();

  //验证码控制器
  TextEditingController codeController = TextEditingController();

  //新密码控制器
  TextEditingController newPassController = TextEditingController();

  //确认新密码控制器
  TextEditingController reNewPassController = TextEditingController();

  //请输入手机号
  Widget _loginName() {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(73),
          right: ScreenUtil().setWidth(77),
          top: ScreenUtil().setHeight(40)),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: phoneController,
        maxLength: 11,
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

  //忘记密码的验证码
  String imageUrl = 'images/forget_pass_code.png';

  //请输入验证码
//  Widget _loginCode() {
//    return Stack(
//      children: <Widget>[
//        Container(
//          width: ScreenUtil().setWidth(600),
//          height: ScreenUtil().setHeight(100),
//          margin:
//              EdgeInsets.fromLTRB(35.0, ScreenUtil().setHeight(45), 35.0, 10.0),
//          decoration: BoxDecoration(
//            color: Color(0xffffffff),
//            boxShadow: [
//              BoxShadow(
//                color: Color(0xffeeeeee),
//                spreadRadius: 2.0,
//                offset: Offset(0.3, 0.3),
//              ),
//            ],
//          ),
//          child: TextField(
//            keyboardType: TextInputType.number,
//            maxLength: 6,
//            buildCounter: _counter,
//            controller: codeController,
//            decoration: InputDecoration(
//              fillColor: Colors.white,
//              filled: true,
//              border: InputBorder.none,
//              contentPadding: EdgeInsets.fromLTRB(
//                  ScreenUtil().setWidth(15),
//                  ScreenUtil().setHeight(30),
//                  ScreenUtil().setWidth(10),
//                  ScreenUtil().setHeight(15)),
//              prefixIcon: Container(
//                height: ScreenUtil().setHeight(16),
//                width: ScreenUtil().setWidth(14),
//                child: Image.asset(
//                  imageUrl,
//                  fit: BoxFit.fitHeight,
//                ),
//                padding: EdgeInsets.fromLTRB(
//                    ScreenUtil().setWidth(20),
//                    ScreenUtil().setHeight(35),
//                    ScreenUtil().setWidth(20),
//                    ScreenUtil().setHeight(20)),
//              ),
//              hintText: '请输入验证码',
//            ),
//
////        onChanged: _textFieldChanged,
//            autofocus: false,
//          ),
//        ),
//        Padding(
//          padding: EdgeInsets.fromLTRB(213, ScreenUtil().setHeight(50), 40, 8),
//          child: RaisedButton(
//              color: Colors.white,
//              child: Text(
//                _codeCountdownStr,
//                style: new TextStyle(fontSize: 12.0, color: Colors.blue),
//              ),
//              shape: RoundedRectangleBorder(
//                  side: BorderSide(
//                color: Colors.blue,
//              )),
//              onPressed: () {
//                if (!Utils.isChinaPhoneLegal(phoneController.text)) {
//                  Toast('请输入正确的手机号!');
//                  return;
//                }
//                if (!_codeCountdownStr.contains('验证码')) {
//                  Toast('请稍后再试!');
//                  return;
//                }
//                reGetCountdown();
//                var formData = {"tel": '${phoneController.text}'};
//                request(context, 'getValidCode', formData).then((val) {
//                  print('获取到的数据:${val.toString()}');
//                  if (val['code'] == 0) {
//                    Toast('验证发发送成功,请注意查收!');
//                  } else if (val['code'] == -1) {
//                    Toast('验证发发送失败,请重新发送!');
//                  }
//                });
//              }),
//        )
//      ],
//    );
//  }

  Widget _loginCode() {
    Color clickColor = button_normal_color;
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
                if (!Utils.isChinaPhoneLegal(phoneController.text)) {
                  CenterToast.show(context, '请输入正确的手机号!');
                  return;
                }
                if (!_codeCountdownStr.contains('验证码')) {
                  CenterToast.show(context, '请稍后再试!');
                  return;
                }
                reGetCountdown();
                var formData = {"tel": '${phoneController.text}'};
                request(context, 'getValidCode', formData).then((val) {
                  print('获取到的数据:${val.toString()}');
                  if (val['code'] == 0) {
                    CenterToast.show(context, '验证发发送成功,请注意查收!');
                  } else if (val['code'] == -1) {
                    CenterToast.show(context, '验证发发送失败,请重新发送!');
                  }
                });
              }),
        )
      ],
    );
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

  Widget _loginPass() {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(73),
          right: ScreenUtil().setWidth(77),
          top: ScreenUtil().setHeight(30)),
      child: TextField(
        obscureText: true,
        //是否隐藏输入内容
        controller: newPassController,
        maxLength: 11,
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
                'images/forget_pass_lock.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            hintText: '请输入新密码',
            hintStyle: TextStyle(
                color: Color(0xff808080), fontSize: ScreenUtil().setSp(32))),
        autofocus: false,
      ),
    );
  }

  Widget _loginRePass() {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(73),
          right: ScreenUtil().setWidth(77),
          top: ScreenUtil().setHeight(10)),
      child: TextField(
        obscureText: true,
        //是否隐藏输入内容
        controller: reNewPassController,
        maxLength: 11,
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
                'images/forget_pass_lock.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            hintText: '请再次输入新密码',
            hintStyle: TextStyle(
                color: Color(0xff808080), fontSize: ScreenUtil().setSp(32))),
        autofocus: false,
      ),
    );
  }

  //确认按钮
  Widget _okButton() {
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
          if (!Utils.rexCheckPassword(newPassController.text.trim())) {
            print(
                "密码匹配规则结果:${Utils.rexCheckPassword(newPassController.text.trim())}");
            Toast.show(context, '必须包含一个数字和一个小写字母，长度为6到12位!');
            return;
          } else if (newPassController.text.trim() !=
                  reNewPassController.text.trim() ||
              newPassController.text.length !=
                  reNewPassController.text.length) {
            Toast.show(context, '两次密码不一致!');
            return;
          } else if (newPassController.text.trim().isEmpty ||
              reNewPassController.text.trim().isEmpty) {
            Toast.show(context, '密码不能为空!');
            return;
          }
          var formData = {
            "code": codeController.text.trim(),
            "newPassword": newPassController.text.trim(),
            "tel": phoneController.text.trim()
          };
          request(context, 'forgetPassWord', formData).then((val) {
            print("从服务器端收到的数据:${val.toString()}");
            if (val['code'] == 0) {
              print('密码修改成功!');
              Toast.show(context, '密码修改成功!');
              Navigator.pop(context);
            } else {
              print("修改密码:${val.toString()}");
              Toast.show(context, '${val['msg']}');
            }
          });
          isClick = button_click_color;
          setState(() {
            isClick;
            print('按钮边框的颜色:${isClick}');
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

  /// TextField 字符统计显示
  Widget _counter(
    BuildContext context, {
    int currentLength,
    int maxLength,
    bool isFocused,
  }) {
    return Container();
  }

  Widget _back() {
    return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginPage()));
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: _back(),
        title: Text(
          '忘记密码',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(ScreenUtil().setWidth(20))),
            _loginName(),
            _loginCode(),
            _loginPass(),
            Padding(padding: EdgeInsets.all(ScreenUtil().setWidth(20))),
            _loginRePass(),
            _okButton(),
          ],
        ),
      ),
    );
  }
}
