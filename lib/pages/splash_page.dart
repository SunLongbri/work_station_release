import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_station/design/loading.dart';
import 'package:work_station/helpclass/Toast.dart';
import 'package:work_station/pages/index_page.dart';
import 'package:work_station/service/mqtt_connect_server.dart';
import 'package:work_station/service/service_method.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    Loading.sessionId = '96D82B3EFEB2D5647B26AA43F8295DDC';
    _mqttConnect();
    return Scaffold(
      body: Container(
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(1334),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(436)),
              child: Image.asset(
                'images/splash_logo.png',
                width: ScreenUtil().setWidth(168),
                height: ScreenUtil().setHeight(169),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(31)),
              child: Text(
                '工位预定',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(40), color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(550)),
              child: Text(
                '寻 找 您 的 专 属 位 置',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28), color: Colors.white),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("images/splash_page1.png"))),
      ),
    );
  }

  void _mqttConnect() {
    List<String> topics = new List();
    Loading.control =
        '/sirui/iot/define/touchpad_realy_mesh/mesh_id/control/json';
    Loading.response =
        '/sirui/iot/define/touchpad_realy_mesh/mesh_id/response/json';
    Loading.status = '/sirui/iot/shadow/touchpad_realy_mesh/mesh_id/status';
    //订阅发送信息到设备之后，设备返回给我的信息
    topics.add(Loading.response);
    //订阅接收设备发出的信息
    topics.add(Loading.status);
//    mqttConnect(Loading.ctx, 'ws://192.168.1.129', 'clientIt', 8084, 'test',
//        'password', topics);

    //通信猫连接方式
    mqttConnect(Loading.ctx, 'ws://mq.tongxinmao.com', 'clientIt', 18832, '',
        '', topics);
  }

  @override
  void initState() {
    super.initState();
    countDown();
  }

  // 倒计时
  void countDown() {
    var _duration = new Duration(seconds: 3);
    new Future.delayed(_duration, go2HomePage);
  }

  void go2HomePage() {
    isAutoLogin();
  }

  SharedPreferences prefs;

  Future isAutoLogin() async {
    prefs = await SharedPreferences.getInstance();
    checkToken().then((val) {
      print('用户存储的Token为:${val.toString()}');

      if (val.toString().isNotEmpty) {
        getOrderPageInfo(val);
      } else {
        Navigator.of(context).pushReplacementNamed('/LoginPage');
      }
    });
  }

  //检测用户是否存有token，如果有，则直接登陆到主界面
  Future checkToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('counter') ?? '';
    return token;
  }

  //获取用户信息并进行本地化存储
  Future getOrderPageInfo(token) {
    getUserInfo(context, 'getUserInfo', token).then((val) async {
      print('获取用户信息并进行本地化存储：${val}');
      if (val['code'] == -4) {
//        Toast.show(context, '登陆过期，请重新登陆!');
        Navigator.of(context).pushReplacementNamed('/LoginPage');
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
        }
        print('splash_page开始跳转页面了 ...... ');
        Navigator.of(context).pushReplacementNamed('/IndexPage');
//        Toast.show(context, 'Token没有过期，自动登陆!');
//        Navigator.of(context).pushAndRemoveUntil(
//            new MaterialPageRoute(builder: (context) => IndexPage()),
//                (route) => route == null);
      }
    });
  }
}
