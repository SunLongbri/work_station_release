import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provide/provide.dart';
import 'package:work_station/design/LightingCart.dart';
import 'package:work_station/design/loading.dart';
import 'package:work_station/helpclass/publish_topic.dart';
import 'package:work_station/model/LightingListModel.dart';
import 'package:work_station/model/LightingNumber.dart';
import 'package:work_station/pages/menu/lightingmenu/lighting_control_page.dart';
import 'package:work_station/provide/mqtt_message.dart';
import '../../../colors.dart';
import '../../../service/service_method.dart';

class LightingListPage extends StatefulWidget {
  @override
  _LightingListPageState createState() => _LightingListPageState();
}

class _LightingListPageState extends State<LightingListPage> {
  int lightingNum;
  String lightingMac;

  @override
  void initState() {
    print('initState --- > 开始获取灯的数量');
    lightingNum = 0;
    lightingMac = '';
    getLightingNumber();
    getLightingListByHttp();

    super.initState();
  }

  void getLightingListByHttp() {
    getRequest('getLightingList', '96D82B3EFEB2D5647B26AA43F8295DDC')
        .then((val) {
      print('通过http获取到的设备列表为:${val.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: _back(),
          title: Text(
            '开关',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(child: Provide<MqttPublisher>(
          builder: (context, child, mqttPublisher) {
            var lightingList = mqttPublisher.val;
            if (lightingList.trim().isEmpty) {
              return Container(
                width: 10,
                height: 10,
              );
            }
            print('lighting list 接收到的数据列表为:${lightingList}');
            List<String> response = lightingList.split('@');
            String topic = response[0];
            print('LightingListPage: ${lightingList}');
            //todo:此处仅为，当第一次建立连接时，获取到根节点的rootId
            if ((topic.contains(Loading.response) ||
                    topic.contains(Loading.status)) &&
                lightingList.contains('Mesh-Node-Mac')) {
              String content = response[1];
              print('第一次建立连接，获取到的根节点为:${content}');
              var data = json.decode(content.toString());
              LightingListModel lightingListModel =
                  LightingListModel.fromJson(data);
              lightingNum = lightingListModel.meshNodeNum;
              lightingMac = lightingListModel.meshNodeMac;
            }
            if (lightingNum == 0) {
              return Container(
                color: Colors.white,
                child: SpinKitHourGlass(color: work_station_prime_color),
              );
            } else {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: lightingNum,
                  itemBuilder: (context, index) {
                    return LightingCart(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LightingControlPage(
                              lightingMac.split(',')[index],
                              4,
                              '${lightingMac.split(',')[index]}',
                              '70%',
                              '24',
                              '2000')));
                    }, '${lightingMac.split(',')[index]}',
                        'images/lighting_list_four_icon.png');
                  });
            }
          },
        )));
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

  void getLightingNumber() {
    List<int> rootId = [0x24, 0x0a, 0xc4, 0x9b, 0x73, 0xb4];
//    List<int> rootId = [0x30, 0xae, 0xa4, 0x80, 0x04, 0x7c];
    LightingNumber lightingNumber =
        LightingNumber.fromParams(request: 'mesh_info', addrs_list: rootId);
    PublishTopic.pubisher(Loading.control, lightingNumber.toString()).send();
  }
}
