import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provide/provide.dart';
import 'package:work_station/design/lighting_control_design.dart';
import 'package:work_station/design/loading.dart';
import 'package:work_station/helpclass/Toast.dart';
import 'package:work_station/helpclass/publish_topic.dart';
import 'package:work_station/model/LightingDevide.dart';
import 'package:work_station/model/LightingFourStatus.dart';
import 'package:work_station/provide/mqtt_message.dart';
import 'package:work_station/routers/application.dart';
import 'package:work_station/service/service_method.dart';

import '../../../colors.dart';
import 'lighting_lookcalendar_page.dart';

class LightingControlPage extends StatefulWidget {
  final String lightingMac;
  final int lightingNumber;
  final String lightingName;
  final String percent;
  final String temperature;
  final String power;

  LightingControlPage(this.lightingMac, this.lightingNumber, this.lightingName,
      this.percent, this.temperature, this.power);

  @override
  _LightingControlPageState createState() => _LightingControlPageState();
}

class _LightingControlPageState extends State<LightingControlPage> {
  List<int> addrs_list = [];
  LightingDevice lightingDevice;
  int lighting1;
  int lighting2;
  int lighting3;
  int lighting4;

  //是否加载等待框  true:等待，false:消失
  bool isWaiting;

  bool switchOn = true;

  @override
  void initState() {
    isWaiting = true;
    Loading.lightingUrl1 = 'images/lighting_detail_off.png';
    Loading.lightingUrl2 = 'images/lighting_detail_off.png';
    Loading.lightingUrl3 = 'images/lighting_detail_off.png';
    Loading.lightingUrl4 = 'images/lighting_detail_off.png';

    postLightingStatusByHttp();
    super.initState();
  }

  void postLightingStatusByHttp() {
    var formData = {'mac': '240ac49b73b4'};
    postRequest('postLightingStatus', formData, Loading.sessionId).then((val){
      print('postLightingStatusByHttp接收到的数据为:${val.toString()}');
    });
  }

  void getLightingControlStatus() {
    int mac1 = _hexToInt(widget.lightingMac.trim().substring(0, 2));
    int mac2 = _hexToInt(widget.lightingMac.trim().substring(2, 4));
    int mac3 = _hexToInt(widget.lightingMac.trim().substring(4, 6));
    int mac4 = _hexToInt(widget.lightingMac.trim().substring(6, 8));
    int mac5 = _hexToInt(widget.lightingMac.trim().substring(8, 10));
    int mac6 = _hexToInt(widget.lightingMac.trim().substring(10, 12));
    print('当前Mac地址 : ${mac1}:${mac2}:${mac3}:${mac4}:${mac5}:${mac6}');
    addrs_list = [mac1, mac2, mac3, mac4, mac5, mac6];

    try {
      lightingDevice = LightingDevice.fromParams(
          request: 'get_device_info', addrs_list: addrs_list);
    } catch (e) {
      print('解析出现异常:${e}');
    }

    String content = lightingDevice.toString();
    PublishTopic.pubisher(Loading.control, content).send();
  }

  @override
  Widget build(BuildContext context) {
    getLightingControlStatus();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: work_station_prime_color,
          leading: _back(),
          title: Text(
            widget.lightingName,
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(34),
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LookCalendarPage()));
              },
              icon: Image.asset(
                'images/lighting_detail_setting.png',
                width: ScreenUtil().setWidth(36),
                height: ScreenUtil().setHeight(34),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          width: ScreenUtil().setWidth(750),
          child: Column(
            children: <Widget>[
              _lightingStatus(),
              _lightingInformation(),
              _line(),
              _title(),
              _titleContent(),
            ],
          ),
        ));
  }

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

  //顶部灯亮灭的展示
  Widget _lightingStatus() {
    LightingFourStatus lightingFourStatus;

    return Container(
      color: work_station_prime_color,
      height: ScreenUtil().setHeight(426),
      width: ScreenUtil().setWidth(750),
      child: Provide<MqttPublisher>(
        builder: (context, child, mqttPublisher) {
          var lightingList = mqttPublisher.val;

          List<String> response = lightingList.split('@');
          String topic = response[0];

          if (lightingList.contains('realy_test')) {
            print(
                '    --------------------------->   realy_test: ${lightingList.toString()}');
            getLightingControlStatus();
          }

          print('LightingControlPage: ${lightingList.toString()}');
          if ((topic.contains(Loading.response)) &&
              lightingList.contains('characteristics')) {
            isWaiting = false;
            String content = response[1];
            var data = json.decode(content.toString());
            lightingFourStatus = LightingFourStatus.fromJson(data);
            lighting1 = lightingFourStatus.characteristics[0].value;
            lighting2 = lightingFourStatus.characteristics[1].value;
            lighting3 = lightingFourStatus.characteristics[2].value;
            lighting4 = lightingFourStatus.characteristics[3].value;
            print(
                '解析到四个灯的状态:${lighting1}  ${lighting2}  ${lighting3}  ${lighting4}');

            Provide.value<MqttPublisher>(context).havePublish(true);
            if (lighting1 == 0) {
              Loading.lightingUrl1 = 'images/lighting_detail_on.png';
            } else {
              Loading.lightingUrl1 = 'images/lighting_detail_off.png';
            }
            if (lighting2 == 0) {
              Loading.lightingUrl2 = 'images/lighting_detail_on.png';
            } else {
              Loading.lightingUrl2 = 'images/lighting_detail_off.png';
            }
            if (lighting3 == 0) {
              Loading.lightingUrl3 = 'images/lighting_detail_on.png';
            } else {
              Loading.lightingUrl3 = 'images/lighting_detail_off.png';
            }
            if (lighting4 == 0) {
              Loading.lightingUrl4 = 'images/lighting_detail_on.png';
            } else {
              Loading.lightingUrl4 = 'images/lighting_detail_off.png';
            }
            print(
                'lightingUrl1:${Loading.lightingUrl1},lightingUrl2:${Loading.lightingUrl2},lightingUrl3:${Loading.lightingUrl3},lightingUrl4:${Loading.lightingUrl4},');
          }

          if (isWaiting||lightingFourStatus==null) {
            return Container(
              color: work_station_prime_color,
              child: SpinKitHourGlass(color: Colors.white),
            );
          } else {

            return Container(
              child: Stack(children: <Widget>[
                //name1
                Align(
                  alignment: FractionalOffset(0.25, 0.2),
//          child: _singleLighting('images/lighting_detail_on.png', 'name1'),
                  child: LightingControlDesign(
                      addrs_list,
                      lightingFourStatus.characteristics[0].value,
                      lightingFourStatus.characteristics[0].name,
                      0),
                ),
                //name2
                Align(
                  alignment: FractionalOffset(0.75, 0.2),
//          child: _singleLighting('images/lighting_detail_off.png', 'name2'),
                  child: LightingControlDesign(
                      addrs_list,
                      lightingFourStatus.characteristics[1].value,
                      lightingFourStatus.characteristics[1].name,
                      1),
                ),
                //name3
                Align(
                  alignment: FractionalOffset(0.25, 0.8),
                  child: LightingControlDesign(
                      addrs_list,
                      lightingFourStatus.characteristics[2].value,
                      lightingFourStatus.characteristics[2].name,
                      2),
                ),
                //name4
                Align(
                  alignment: FractionalOffset(0.75, 0.8),
                  child: LightingControlDesign(
                      addrs_list,
                      lightingFourStatus.characteristics[3].value,
                      lightingFourStatus.characteristics[3].name,
                      3),
                ),
              ]),
            );
          }
        },
      ),
    );
  }

  //顶部显示灯的各种信息
  Widget _lightingInformation() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(127),
      color: Color(0xd01792E5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 1, child: _singleInformation('使用率', widget.percent, true)),
          Expanded(
              flex: 1,
              child:
                  _singleInformation('室内温度', '${widget.temperature}℃', true)),
          Expanded(
              flex: 1,
              child: _singleInformation('当前毫安', '${widget.power}mA', false)),
        ],
      ),
    );
  }

  Widget _singleInformation(String title, String number, bool flag) {
    return Container(
      height: ScreenUtil().setHeight(88),
      width: ScreenUtil().setWidth(249),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: ScreenUtil().setSp(22)),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
            child: Text(
              number,
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(38)),
            ),
          ),
        ],
      ),
      decoration: flag
          ? BoxDecoration(
              border: Border(right: BorderSide(color: Color(0x0fffffff))))
          : BoxDecoration(border: Border()),
    );
  }

  //灰色细线
  Widget _line() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(14),
      color: Color(0xFFF4F4F4),
    );
  }

  //定时标题栏及其开关按钮
  Widget _title() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(95),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: FractionalOffset(0.0, 0.5),
            child: Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(42)),
              child: Text(
                '定时',
                style: TextStyle(
                    color: Color(0xFF303030),
                    fontSize: ScreenUtil().setSp(30),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Align(
            alignment: FractionalOffset(1.0, 0.5),
            child: Padding(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(39)),
              child: Switch(
                value: switchOn,
                onChanged: (newValue) {
                  setState(() {
                    isWaiting = true;
                    switchOn = newValue;
                  });
                },
                activeColor: Color(0xFF1792E5),
                activeTrackColor: Color(0x261792E5),
                inactiveThumbColor: Color(0xFFCCCCCC),
                inactiveTrackColor: Color(0x50CCCCCC),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0x3F999999)))),
    );
  }

  Widget _titleContent() {
    if (switchOn) {
      return Container(
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(500),
        child: Column(
          children: <Widget>[
            _setAlarm(),
            _setAlarm(),
            _setAlarm(),
            _setAlarm(),
          ],
        ),
      );
    } else {
      return Container(
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(500),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/clock_all_alarm.png',
              width: ScreenUtil().setWidth(150),
              height: ScreenUtil().setHeight(102),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(27)),
              child: Text(
                '定时已经全部关闭',
                style: TextStyle(
                    color: Color(0xFF8A8787), fontSize: ScreenUtil().setSp(22)),
              ),
            )
          ],
        ),
      );
    }
  }

  //单个设置日历的样式
  Widget _setAlarm() {
    return Container(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Toast.show(context, '预留位置，临时跳转到登录界面!');
          Application.router.navigateTo(context, '/login_page');
        },
        child: Column(
          children: <Widget>[
            _singleSetAlarm(),
            Container(
              width: ScreenUtil().setWidth(677),
              height: ScreenUtil().setHeight(1),
              color: Color(0xFF999999),
            ),
          ],
        ),
      ),
    );
  }

  Widget _singleSetAlarm() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(110),
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(34), right: ScreenUtil().setWidth(39)),
      child: Row(
        children: <Widget>[
          Expanded(flex: 1, child: _showTime()),
          Text(
            'name1,name2,name3',
            style: TextStyle(
                color: Color(0xFF575757), fontSize: ScreenUtil().setSp(20)),
          ),
        ],
      ),
    );
  }

  Widget _showTime() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //横向向左对齐
        mainAxisAlignment: MainAxisAlignment.center, //竖直水平对齐
        children: <Widget>[
          Text(
            '定时 11：25-4:20',
            style: TextStyle(
                color: Color(0xFF303030), fontSize: ScreenUtil().setSp(26)),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
            child: Text(
              '重复 日 一 二 三 四 五',
              style: TextStyle(
                  color: Color(0xFF8C8B8A), fontSize: ScreenUtil().setSp(22)),
            ),
          ),
        ],
      ),
    );
  }

  int _hexToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }
}
