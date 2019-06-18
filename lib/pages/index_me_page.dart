import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_station/colors.dart';
import 'package:work_station/pages/login_page.dart';
import 'package:work_station/pages/menu/aboutmemenu/about_me.dart';
import 'package:work_station/pages/menu/bindmenu/bind_phone_page.dart';
import 'package:work_station/pages/modify_password.dart';
import 'package:work_station/service/service_method.dart';

import '../helpclass/Toast.dart';
import 'menu/lightingmenu/lighting_lookcalendar_page.dart';

class HomeMePage extends StatefulWidget {
  @override
  _HomeMePageState createState() => _HomeMePageState();
}

class _HomeMePageState extends State<HomeMePage> {
  //我的界面顶部蓝色背景和我的文字
  Widget _homeBg() {
    return Container(
      color: Color(0xff1792E5),
      height: ScreenUtil().setHeight(209),
      width: ScreenUtil().setWidth(1334),
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(68), 0, 0),
        child: Text(
          '我的',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(34),
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  String userName = '';
  String phoneNumber = '';
  String companyName = '';
  String userUiAuthority = '';

  void _getUserInfo() async {
    prefs = await SharedPreferences.getInstance();

    String token = prefs.get('counter');

    getUserInfo(context, 'getUserInfo', token).then((val) {
      print('IndexMePage:获取到的用户信息:${val.toString()}');
      if (val['code'] == 0) {
        setState(() {
          userName = val['data']['fullName'];
          userUiAuthority = val['data']['userUiAuthority'];
          prefs.setString('userUiAuthority', userUiAuthority.trim().toString());
          prefs.setString('userName', userName);
          print('我的界面获取到的用户权限为:${userUiAuthority}');
          if (userName == null) {
            userName = ' ';
          }

          phoneNumber = val['data']['tel'];

          prefs.setString('tel', phoneNumber.toString());
          if (phoneNumber == null) {
            phoneNumber = ' ';
          }
          prefs.setString('phoneNumber', phoneNumber);
          companyName = val['data']['companyName'];
          if (companyName == null) {
            companyName = ' ';
          }
          prefs.setString('companyName', companyName);
        });
      }
    });
    print(
        '我的界面:${userName.toString()},${phoneNumber.toString()},${companyName.toString()},');
  }

  //我的界面名片卡片
  Widget _homeMeCard() {
    return Container(
      alignment: Alignment.center,
      color: Color(0xffFFFFFF),
      height: ScreenUtil().setHeight(149),
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(33),
          ScreenUtil().setHeight(128), ScreenUtil().setWidth(37), 0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(32),
              ),
              child: Text(
                '${userName}',
                style: TextStyle(
                    color: Color(0xff000000), fontSize: ScreenUtil().setSp(46)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setWidth(40),
                bottom: ScreenUtil().setWidth(0)),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(5, 0, ScreenUtil().setWidth(20), 0),
                  child: Text(
                    '${phoneNumber}',
                    style: TextStyle(
                        color: Color(0xff4C4C4C),
                        fontSize: ScreenUtil().setSp(30)),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(5, ScreenUtil().setWidth(20),
                        ScreenUtil().setWidth(20), 0),
                    child: Text(
                      '${companyName}',
                      style: TextStyle(
                          color: Color(0xff4C4C4C),
                          fontSize: ScreenUtil().setSp(30)),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  //绑定手机按钮
  Widget _bindPhone() {
    return Container(
      decoration: BoxDecoration(
        //边界
        border: Border.all(width: 2.0, color: Color(0xffeeeeee)),
      ),
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(34),
          ScreenUtil().setHeight(43), ScreenUtil().setWidth(36), 0),
      height: ScreenUtil().setHeight(100),
      child: InkWell(
        onTap: () {
          print('进入绑定手机界面! ');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BindPhonePage()));
        },
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Image.asset(
                'images/index_me_phone.png',
                height: 22,
                width: 22,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(
                  '绑定手机',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(50)),
              child: Image.asset(
                'images/home_arrow.png',
                height: 16,
                width: 9,
              ),
            )
          ],
        ),
      ),
    );
  }

  //修改密码按钮
  Widget _editPassword() {
    return Container(
      decoration: BoxDecoration(
        //边界
        border: Border.all(width: 2.0, color: Color(0xffeeeeee)),
      ),
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(34),
          ScreenUtil().setHeight(21), ScreenUtil().setWidth(36), 0),
      height: ScreenUtil().setHeight(100),
      child: InkWell(
        onTap: () {
          print('进入修改密码界面! ');
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ModifyPasswordPage()));
        },
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Image.asset(
                'images/index_me_lock.png',
                height: 22,
                width: 22,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(
                  '修改密码',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(50)),
              child: Image.asset(
                'images/home_arrow.png',
                height: 16,
                width: 9,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _abortMe() {
    return Container(
      decoration: BoxDecoration(
        //边界
        border: Border.all(width: 2.0, color: Color(0xffeeeeee)),
      ),
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(34),
          ScreenUtil().setHeight(21), ScreenUtil().setWidth(36), 0),
      height: ScreenUtil().setHeight(100),
      child: InkWell(
        onTap: () {
          print('进入修改密码界面! ');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AboutMePage()));
        },
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Image.asset(
                'images/abort_me.png',
                height: 22,
                width: 22,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(
                  '关于我们',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(50)),
              child: Image.asset(
                'images/home_arrow.png',
                height: 16,
                width: 9,
              ),
            )
          ],
        ),
      ),
    );
  }

  //第一层：顶部我的文字和自我介绍的卡片
  Widget _firstFloor() {
    return Stack(
      children: <Widget>[
        _homeBg(),
        _homeMeCard(),
      ],
    );
  }

  Widget _secondFloor() {
    return Column(
      children: <Widget>[
        _bindPhone(),
        _editPassword(),
        _abortMe(),
      ],
    );
  }

  //用户登出，清除token
  SharedPreferences prefs;

  Future clearToken() async {
    await prefs.setString('counter', '');
  }

  Widget _exitButton() {
    String username = '';
    String password = '';
    String btnName = '退出';
    Color isClick = button_normal_color;
    return Container(
      height: ScreenUtil().setHeight(90),
      width: ScreenUtil().setWidth(700),
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(107),
          left: ScreenUtil().setWidth(34),
          right: ScreenUtil().setWidth(36)),
      child: FlatButton(
        onPressed: () {
          isClick = button_click_color;
          seatRequest(context, 'logOut').then((val) {
            if (val['code'] == 0) {
              Toast.show(context, '退出系统成功!');
              clearToken();
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => route == null);
            } else if (val['code'] == -4) {
//              Toast.show(context, '登陆过期，请重新登陆!');
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => route == null);
            } else {
              Toast.show(context, '登出异常!');
            }
          });
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
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  void initState() {
    _getUserInfo();
    initData();
    super.initState();
  }

  Future initData() async {
    prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName');
    phoneNumber = prefs.getString('phoneNumber');
    companyName = prefs.getString('companyName');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Color(0xffFbFbFb),
        body: Column(
          children: <Widget>[
            _firstFloor(),
            _secondFloor(),
            _exitButton(),
          ],
        ),
      ),
      onWillPop: () {
//        Toast.show(context, '请不要关闭我，把我最小化吧!');
        exit(0);
//        AndroidBackTop.BackDeskTop;
      },
    );
  }
}
