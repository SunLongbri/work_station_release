import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_station/pages/index_page.dart';
import 'package:work_station/pages/menu/bindmenu/bind_phone_page.dart';
import 'package:work_station/pages/menu/forgetpassmenu/forget_password_page.dart';
import 'package:work_station/service/service_method.dart';

import '../colors.dart';
import '../helpclass/Toast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  //获取用户名和密码的controller
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  //按钮是否禁用事件Boolean   true 可点击，false：不可点击
  bool _isButtonDisabled;

  @override
  void initState() {
    _isButtonDisabled = true;

    isAutoLogin();
    super.initState();
  }

  SharedPreferences prefs;

  Future isAutoLogin() async {
    prefs = await SharedPreferences.getInstance();
    checkToken().then((val) {
      print('用户存储的Token为:${val.toString()}');

      if (val.toString().isNotEmpty) {
        getOrderPageInfo(val);
      } else {
//        Toast.show(context,'  请登录 ... ');
      }
    });
  }

  //获取用户信息并进行本地化存储
  Future getOrderPageInfo(token) {
    getUserInfo(context, 'getUserInfo', token).then((val) async {
      print('获取用户信息并进行本地化存储：${val}');
      if (val['code'] == -4) {
//        Toast.show(context,'登陆过期，请重新登陆!');
      } else {
        if (val['code'] == 0) {
          String userName = val['data']['username'];
          String phoneNumber = val['data']['tel'];
          String companyName = val['data']['companyName'];
          String userUiAuthority = val['data']['userUiAuthority'];
          print(
              'getOrderPageInfo:userName:${userName.toString()},phoneNumber:${phoneNumber.toString()},companyName:${companyName.toString()},userUiAuthority:${userUiAuthority.toString()}');
          await prefs.setString('userName', userName);
          await prefs.setString('phoneNumber', phoneNumber);
          await prefs.setString('companyName', companyName);
          await prefs.setInt('status', 1001);
          await prefs.setString('userUiAuthority', userUiAuthority);
          print('登录页面当前用户存储的用户权限为:${userUiAuthority}');
          print('获取到的用户手机号为:${phoneNumber}');
          if (phoneNumber != null) {
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => IndexPage()),
                (route) => route == null);
          }
        }
//        Toast.show(context, 'Token没有过期，自动登陆!');
      }
    });
  }

  //检测用户是否存有token，如果有，则直接登陆到主界面
  Future checkToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('counter') ?? '';
    return token;
  }

  var gorgetColor = black_color;

  @override
  Widget build(BuildContext context) {
    //顶部的背景
    Widget _loginTopBg() {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new Container(
            height: ScreenUtil().setHeight(500),
            width: ScreenUtil().setWidth(750),
            child: Image.asset(
              'images/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          new Container(
            height: ScreenUtil().setHeight(140),
            child: Center(
              child: Image.asset('images/home_icon.png'),
            ),
          ),
        ],
      );
    }

    //登陆用户名框
    Widget _loginName() {
      return Container(
        margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(74),
            right: ScreenUtil().setWidth(76),
            top: ScreenUtil().setHeight(110)),
        child: TextField(
          controller: userController,
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
              hintText: '请输入手机号/用户名',
              hintStyle: TextStyle(
                  color: Color(0xff808080), fontSize: ScreenUtil().setSp(32))),
          autofocus: false,
        ),
      );
    }

    //登陆密码框
    Widget _loginPass() {
      return Container(
        margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(74),
            right: ScreenUtil().setWidth(76),
            top: ScreenUtil().setHeight(46)),
        child: TextField(
          controller: passController,
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
          obscureText: true, //是否隐藏输入内容
          autofocus: false,
        ),
      );
    }

    Widget _forgetPass() {
      return Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(219)),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              child: Text(
                '忘记密码？',
                style: TextStyle(color: gorgetColor),
              )),
          onTapCancel: () {
            setState(() {
              gorgetColor = black_color;
              print('onTapCancel:${gorgetColor}');
            });
          },
          onTap: () {
            setState(() {
              gorgetColor = button_click_color;
              print('onLongPress:${gorgetColor}');
            });
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ForgetPasswordPage()));
          },
        ),
      );
    }

    //用户登陆验证
    Future checkLoginState(username, password) async {
      _isButtonDisabled = true;
      print('userController:${userController.text}');
      if (userController.text.isEmpty ||
          passController.text.isEmpty ||
          userController.text.length > 20 ||
          passController.text.length > 20) {
        Toast.show(context, '手机号或密码输入不合格,长度不能为0或者超过20!');
        return;
      } else {
        username = userController.text.trim();
        password = passController.text.trim();

        print(
            '当前登陆:username:${username.toString()},password:${password.toString()}');
      }
      var formData = {"username": username, "password": password};
      request(context, 'loginPageContent', formData).then((val) async {
        print('loginpage:从服务器端返回的数据为:${val}');
        if (val['code'] == 0) {
//          if (val['data']['token'].toString().isNotEmpty) {
//            //根据用户的token来获取OrderPage的相关信息
//            await getOrderPageInfo(val['data']['token'].toString());
//          }
          Toast.show(context, '登陆成功!');
          print('从服务器端返回的token是:${val['data']['token']}');
          await prefs.setString('counter', val['data']['token']);
          _isButtonDisabled = false;

          //跳转页面之后，销毁当前页面
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => IndexPage()),
              (route) => route == null);
        } else if (val['code'] == -1) {
          Toast.show(context, '用户名或密码错误!');
          _isButtonDisabled = true;
        } else if (val['code'] == -2) {
//          Toast.show(context, '用户未绑定手机号!');
          await prefs.setString('counter', val['data']['token']);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BindPhonePage(
                    password: password,
                  )));
          _isButtonDisabled = true;
        } else if (val['code'] == -3) {
//          Toast.show(context,'登陆过期，请重新登陆!');
          _isButtonDisabled = true;
        } else if (val['code'] == -4) {
          Toast.show(context, 'token异常!');
          _isButtonDisabled = true;
        }
      });
    }

    Widget _loginButton() {
      String username = '';
      String password = '';
      String btnName = '登录';
      return Container(
        height: ScreenUtil().setHeight(90),
        width: ScreenUtil().setWidth(600),
        margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(107),
            left: ScreenUtil().setWidth(76),
            right: ScreenUtil().setWidth(74)),
        child: FlatButton(
          onPressed: () {
            print('当前按钮的状态:${_isButtonDisabled}');
            checkLoginState(username, password);
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

    return Scaffold(
      backgroundColor: home_background_color,
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _loginTopBg(),
            _loginName(),
            _loginPass(),
            _loginButton(),
            _forgetPass()
          ],
        )),
      ),
    );
  }
}
