import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:work_station/helpclass/publish_topic.dart';
import 'package:work_station/model/LightingFourStatus.dart';
import 'package:work_station/model/LightingSetStatusModel.dart';
import 'package:work_station/provide/mqtt_message.dart';

import '../colors.dart';
import 'loading.dart';

//单个灯控的模型
class LightingControlDesign extends StatefulWidget {
  //当前设备的Mac地址
  final List<int> lightingMac;

  //灯控图片的本地路径
  final int lightingUrl;

  //灯控的名字
  final String lightingName;

  //第几个灯
  final int lightingNum;

  LightingControlDesign(
      this.lightingMac, this.lightingUrl, this.lightingName, this.lightingNum);

  @override
  _LightingControlDesignState createState() => _LightingControlDesignState();
}

class _LightingControlDesignState extends State<LightingControlDesign> {
  String lightingUrl;
  String lightingName;
  int lightingValue;
  List<int> lightingMac;
  int lightingNum;

  bool click;
  int num = 0;
  Color clickTextColor;
  Color normalTextColor;

  //0为开，1为关
  int clickValue;
  int normalValue;

  @override
  void initState() {
    if (widget.lightingUrl == 0) {
      lightingUrl = 'images/lighting_detail_on.png';
    } else {
      lightingUrl = 'images/lighting_detail_off.png';
    }
    lightingName = widget.lightingName;
    lightingMac = widget.lightingMac;
    lightingNum = widget.lightingNum;
    super.initState();
  }

  LightingFourStatus lightingFourStatus;

  @override
  Widget build(BuildContext context) {
    return Provide<MqttPublisher>(
      builder: (context, child, publishFlag) {
        print('publishFlag : ${publishFlag.val}');
        if (publishFlag.val.contains('characteristics')) {
          num++;
          print('num : --------------------  ${num}');
          if (num > 2) {
            String content = publishFlag.val.split("@")[1];
            click = false;
            var data = json.decode(content.toString());
            lightingFourStatus = LightingFourStatus.fromJson(data);

            if (lightingName.contains('1')) {
              if (lightingFourStatus.characteristics[0].value == 0) {
                lightingUrl = 'images/lighting_detail_on.png';
              } else {
                lightingUrl = 'images/lighting_detail_off.png';
              }
            }
            if (lightingName.contains('2')) {
              if (lightingFourStatus.characteristics[1].value == 0) {
                lightingUrl = 'images/lighting_detail_on.png';
              } else {
                lightingUrl = 'images/lighting_detail_off.png';
              }
            }
            if (lightingName.contains('3')) {
              if (lightingFourStatus.characteristics[2].value == 0) {
                lightingUrl = 'images/lighting_detail_on.png';
              } else {
                lightingUrl = 'images/lighting_detail_off.png';
              }
            }
            if (lightingName.contains('4')) {
              if (lightingFourStatus.characteristics[3].value == 0) {
                lightingUrl = 'images/lighting_detail_on.png';
              } else {
                lightingUrl = 'images/lighting_detail_off.png';
              }
            }
          }
        }
        return Container(
          width: ScreenUtil().setWidth(100),
          height: ScreenUtil().setHeight(150),
          child: InkWell(
            onTap: () {

              print('初始化  onTap : ${lightingUrl}');
              click = true;

              if (lightingUrl.contains('on')) {
                clickTextColor = lighting_off_color;
                lightingUrl = 'images/lighting_detail_off.png';
                clickValue = 1;
              } else {
                clickTextColor = lighting_on_color;
                lightingUrl = 'images/lighting_detail_on.png';
                clickValue = 0;
              }

              ControlSwith controlSwith = ControlSwith.fromParams(
                  cid: widget.lightingNum,
                  value: click ? clickValue : normalValue);
              List<ControlSwith> characteristics = [controlSwith];

              LightingSetStatus lightingSetStatus =
                  LightingSetStatus.fromParams(
                      request: 'set_status',
                      addrs_list: widget.lightingMac,
                      characteristics: characteristics);

              //发布主题
              PublishTopic publishTopic = PublishTopic.pubisher(
                  Loading.control, lightingSetStatus.toString());
              publishTopic.send();

              print('点击了灯控开关所发送的内容:${lightingSetStatus.toString()}');

              print(
                  'lightingUrl : ${lightingUrl} --- > value  :  ${clickValue}');

              setState(() {
                num = 1;
                lightingUrl;
                clickTextColor;
                normalTextColor;
                print(
                    'setState --- :  lightingUrl :${lightingUrl} , textColor :${clickTextColor} ');
              });
            },
            child: Column(
              children: <Widget>[
                Image.asset(
                  lightingUrl,
                  width: ScreenUtil().setWidth(64),
                  height: ScreenUtil().setHeight(74),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                  child: Text(
                    widget.lightingName.split('_')[0],
                    style: TextStyle(
                        color: lightingUrl.contains('on')
                            ? lighting_on_color
                            : lighting_off_color,
//                       color: click ? clickTextColor : normalTextColor,
                        fontSize: ScreenUtil().setSp(30)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
