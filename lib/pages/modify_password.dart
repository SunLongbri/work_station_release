import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_station/colors.dart';
import 'package:work_station/helpclass/CenterToast.dart';
import 'package:work_station/helpclass/Toast.dart';
import 'package:work_station/helpclass/Utils.dart';
import 'package:work_station/pages/index_page.dart';
import 'package:work_station/pages/login_page.dart';
import 'package:work_station/service/service_method.dart';

class ModifyPasswordPage extends StatefulWidget {
  @override
  _ModifyPasswordPageState createState() => _ModifyPasswordPageState();
}

class _ModifyPasswordPageState extends State<ModifyPasswordPage> {
  Widget _back() {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => IndexPage(
                    currentIndex: 2,
                  )));
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
      backgroundColor: Color(0xffFbFbFb),
      appBar: AppBar(
        leading: _back(),
        title: Text(
          '修改密码',
          style:
              TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(40)),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _inputPassword(),
            _inputNewPassword(),
            _inputReNewPassword(),
            _modifyButton(),
          ],
        ),
      ),
    );
  }

  //原密码控制器
  TextEditingController rePassController = TextEditingController();

  //原密码输入框
  Widget _inputPassword() {
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(70),
          ScreenUtil().setHeight(80), ScreenUtil().setWidth(80), 0),
      height: ScreenUtil().setHeight(150),
      child: TextField(
        obscureText: true,
        //是否隐藏输入内容
        controller: rePassController,
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
            hintText: '请再次输入原密码',
            hintStyle: TextStyle(
                color: Color(0xff808080), fontSize: ScreenUtil().setSp(32))),
        autofocus: false,
      ),
    );
  }

  //新密码控制器
  TextEditingController newPassController = TextEditingController();

  //新密码输入框
//  Widget _inputNewPassword() {
//    return Container(
//      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(70),
//          ScreenUtil().setHeight(50), ScreenUtil().setWidth(80), 0),
//      height: ScreenUtil().setHeight(150),
//      alignment: Alignment.topLeft,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(15),left: ScreenUtil().setWidth(10)),
//            child: Text(
//              '请输入新密码',
//              style: TextStyle(color: Color(0xff4D4D4D), fontSize: 12),
//            ),
//          ),
//          Container(
//            width: ScreenUtil().setWidth(600),
//            height: ScreenUtil().setHeight(90),
//            margin: EdgeInsets.fromLTRB(
//                ScreenUtil().setWidth(10),
//                ScreenUtil().setHeight(0),
//                ScreenUtil().setWidth(10),
//                ScreenUtil().setHeight(10)),
//            decoration: BoxDecoration(
//              color: Color(0xffffffff),
//              boxShadow: [
//                BoxShadow(
//                  color: Color(0xffeeeeee),
//                  spreadRadius: 2.0,
//                  offset: Offset(0.3, 0.3),
//                ),
//              ],
//            ),
//            child: TextField(
//              controller: newPassController,
//              decoration: InputDecoration(
//                fillColor: Colors.white,
//                filled: true,
//                border: InputBorder.none,
//                hintText: '请输入新密码',
//              ),
//              obscureText: true, //是否隐藏输入内容
//              autofocus: false,
//            ),
//          ),
//        ],
//      ),
//    );
//  }

  Widget _inputNewPassword() {
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(70),
          ScreenUtil().setHeight(1), ScreenUtil().setWidth(80), 0),
      height: ScreenUtil().setHeight(150),
      child: TextField(
        obscureText: true,
        //是否隐藏输入内容
        controller: newPassController,
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

  //再次输入新密码控制器
  TextEditingController reNewPassController = TextEditingController();

  //再次输入新密码输入框
  Widget _inputReNewPassword() {
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(70),
          ScreenUtil().setHeight(1), ScreenUtil().setWidth(80), 0),
      height: ScreenUtil().setHeight(150),
      child: TextField(
        obscureText: true,
        //是否隐藏输入内容
        controller: reNewPassController,
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

  //修改密码按钮

  Widget _modifyButton() {
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
            CenterToast.show(context, '必须有一个数字和小写字母，长度为6到12位!');
            return;
          } else if (rePassController.text.trim().isEmpty) {
            CenterToast.show(context, '原密码不能为空!');
            return;
          } else if (reNewPassController.text.trim() !=
                  newPassController.text.trim() ||
              newPassController.text.length !=
                  reNewPassController.text.length) {
            CenterToast.show(context, '两次密码不一致!');
            return;
          }
          var formData = {
            'newPassword': newPassController.text.trim(),
            'oldPassword': rePassController.text.trim()
          };
          seatRequest(context, 'resetPassWord', formData: formData)
              .then((value) {
            if (value['code'] == -4) {
//              CenterToast.show(context, '登陆过期，请重新登陆!');
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => route == null);
            } else if (value['code'] == 0) {
              CenterToast.show(context, '密码重置成功!');
              Navigator.pop(context);
            } else {
              CenterToast.show(context, '${value['msg']}');
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
