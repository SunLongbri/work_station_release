import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_station/design/AirCart.dart';
import 'package:work_station/helpclass/Toast.dart';
import 'package:work_station/model/AirStatusModel.dart';
import 'package:work_station/pages/index_page.dart';
import 'package:work_station/pages/menu/conditionmenu/air_control_page.dart';
import 'package:work_station/service/service_method.dart';

class ConditionStatePage extends StatefulWidget {
  @override
  _ConditionStatePageState createState() => _ConditionStatePageState();
}

class _ConditionStatePageState extends State<ConditionStatePage> {
  List currentList;
  int num = 0;

  //获取空调信息
  Future getAirStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('counter');
//    print('getAirStatus的token：${token.toString()}');
    getUserInfo(context, 'getAirStatus', token).then((val) {
//      print('获取到的参数为:${val}');
      if (val == null) {
        Toast.show(context, '联网超时');
        num++;
        if (num == 5) {
          Toast.show(context, '网络已断开，请连接网络后登录!');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => IndexPage()),
              (route) => route == null);
        }
        return;
      } else if (val['msg'].toString().contains('异常')) {
        Toast.show(context, '登录异常，请重新登录!');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => IndexPage()),
            (route) => route == null);
      }
      AirStatusModelList airStatusModelList =
          AirStatusModelList.fromJson(val['data']);
      currentList = airStatusModelList.list;
      _saving = false;
//      airStatusModelList.list
//          .forEach((item) => print('遍历解析到空调的数据名为：${item.deivceId}'));
    });
    setState(() {
      currentList;
      _saving;
    });
  }

  @override
  void initState() {
    _saving = true;
    getAirStatus();
    super.initState();
  }

  bool _saving = false;

  Widget _back() {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => IndexPage(
                    currentIndex: 1,
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
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '空调设置',
            style: TextStyle(
                color: Colors.white, fontSize: ScreenUtil().setSp(34)),
          ),
          leading: _back(),
          centerTitle: true,
          elevation: 0,
        ),
        body: ModalProgressHUD(
          child: SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(40)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: generateAirStateList(currentList),
                  ))),
          inAsyncCall: _saving,
        ),
      ),
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => IndexPage(
                      currentIndex: 1,
                    )),
            (route) => route == null);
      },
    );
  }

  List<Widget> generateAirStateList(list) {
    List<Widget> listWidget = [];
    if (list == null) {
      listWidget.add(Container(
        width: ScreenUtil().setHeight(700),
        height: ScreenUtil().setWidth(700),
        alignment: Alignment.center,
        child: Text('正在加载数据 ... '),
      ));
      getAirStatus();
      return listWidget;
    }

    for (int i = 0; i < list.length; i++) {
      String floorName = list[i].floorName;
      String deviceId = list[i].deivceId;
      String deviceDesc = list[i].deviceDesc;
      String ON_OFFControl = list[i].oNOFFControl;
      String ON_OFFStatus = list[i].oNOFFStatus;
      String ModelStatus = list[i].modelStatus;
      String Temp_RM = list[i].tempRM;
      String Temp_SP = list[i].tempSP;
      String airName = '${floorName.substring(2, 5)}${deviceId}';
//      print(
//          'floorName:${floorName},deviceId:${deviceId},deviceDesc:${deviceDesc},ON_OFFControl:${ON_OFFControl},ON_OFFStatus:${ON_OFFStatus},ModelStatus:${ModelStatus},Temp_RM:${Temp_RM},Temp_SP:${Temp_SP},airName:${airName},');
      if (ON_OFFStatus.contains('false')) {
        listWidget.add(AirCartClose(
          'images/air_cool_icon.png',
          deviceDesc,
          '设定${Temp_SP.toString()}°c',
          () {
            print('用户点击了关着的卡片...');
            jumpToAirControl(deviceDesc, floorName, deviceId, Temp_RM, Temp_SP,
                ModelStatus, ON_OFFStatus, 'images/air_control_close.png');
          },
          'images/air_close.png',
        ));
      } else if (ON_OFFStatus.contains('true')) {
        if (ModelStatus.contains('Heating')) {
          listWidget.add(AirCard(
              'images/air_cool_icon.png',
              deviceDesc,
              '设定${Temp_SP.toString()}°c',
              Temp_RM,
              'AUTO模式  制热',
              'images/air_hot.png', () {
            print('用户点击了制热卡片...');
            jumpToAirControl(deviceDesc, floorName, deviceId, Temp_RM, Temp_SP,
                ModelStatus, ON_OFFStatus, 'images/air_control_topbg_hot.png');
          }));
        } else if (ModelStatus.contains('Cooling')) {
          listWidget.add(AirCard(
              'images/air_cool_icon.png',
              deviceDesc,
              '设定${Temp_SP.toString()}°c',
              Temp_RM,
              'AUTO模式  制冷',
              'images/air_cool.png', () {
            print('用户点击了制冷卡片...');
            jumpToAirControl(deviceDesc, floorName, deviceId, Temp_RM, Temp_SP,
                ModelStatus, ON_OFFStatus, 'images/air_control_topbg_cool.png');
          }));
        } else if (ModelStatus.contains('Air')) {
          listWidget.add(AirCard(
              'images/air_cool_icon.png',
              deviceDesc,
              '设定${Temp_SP.toString()}°c',
              Temp_RM,
              'AUTO模式  通风',
              'images/air_wind.png', () {
            print('用户点击了通风卡片...');
            jumpToAirControl(deviceDesc, floorName, deviceId, Temp_RM, Temp_SP,
                ModelStatus, ON_OFFStatus, 'images/air_control_topbg_wind.png');
          }));
        } else if (ModelStatus.contains('Dehumi')) {
          listWidget.add(AirCard(
              'images/air_cool_icon.png',
              deviceDesc,
              '设定${Temp_SP.toString()}°c',
              Temp_RM,
              'AUTO模式  除湿',
              'images/air_humidity.png', () {
            print('用户点击了除湿卡片...');
            jumpToAirControl(
                deviceDesc,
                floorName,
                deviceId,
                Temp_RM,
                Temp_SP,
                ModelStatus,
                ON_OFFStatus,
                'images/air_control_topbg_humidity.png');
          }));
        }
      }
    }
    return listWidget;
  }

  void jumpToAirControl(deviceDesc, floorName, deviceId, Temp_RM, Temp_SP,
      ModelStatus, ON_OFFStatus, controlBg) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AirControlPage(deviceDesc, floorName, deviceId,
            Temp_RM, Temp_SP, ModelStatus, ON_OFFStatus, controlBg)));
  }
}
