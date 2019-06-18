import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_station/model/ParseMarkModel.dart';
import 'package:work_station/pages/index_page.dart';
import 'package:work_station/pages/login_page.dart';
import 'package:work_station/pages/menu/ordermenu/order_detail_page.dart';
import 'package:work_station/service/service_method.dart';

class CurrentOrderPage extends StatefulWidget {
  @override
  _CurrentOrderPageState createState() => _CurrentOrderPageState();
}

class _CurrentOrderPageState extends State<CurrentOrderPage> {
  SharedPreferences prefs;
  List list = [];

  void _getUnUsedkData() async {
    prefs = await SharedPreferences.getInstance();
    var formData = {
      "pageNum": 1,
      "pageSize": 100,
      "status": 1001,
    };
    await seatRequest(context, 'orderList', formData: formData).then((val) {
      if (val['code'] == -4) {
//        Toast.show(context,'登陆过期，请重新登陆!');
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => route == null);
      }
      print('CurrentOrderPage  -------- >  请求到的数据:${val.toString()}');
      ParseMarkModel parseMarkModel = ParseMarkModel.fromJson(val);
      list = parseMarkModel.data.list;
      print('当前未使用的座位为:${parseMarkModel.data.total}');
      setState(() {
        list = parseMarkModel.data.list;
      });
    });
  }

  @override
  void initState() {
    _getUnUsedkData();
    super.initState();
  }

  Widget _back() {
    return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => IndexPage(currentIndex: 1,)));
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
          backgroundColor: Color(0xffF7F7F7),
          appBar: AppBar(
            leading: _back(),
            title: Text(
              '当前预约',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return _listInkWell(index);
            },
          ),
        ),
        onWillPop: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => IndexPage(currentIndex: 1,)));
        });
  }

  Widget _listInkWell(int index) {
    return InkWell(
      onTap: () {
        String fullName = list[index].fullName;
        _saveOnTapData(index).then((value) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => OrderDetailPage(fullName)));
        });
      },
      child: _singleOrderMark(index),
    );
  }

  //单个预约条目样式
  Widget _singleOrderMark(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(33),
          ScreenUtil().setHeight(15),
          ScreenUtil().setWidth(33),
          ScreenUtil().setHeight(5)),
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(345),
      height: ScreenUtil().setHeight(217),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _singleTitle(index),
          _singleThrought(),
          _singleAddressTime(index),
        ],
      ),
    );
  }

  Widget _singleAddressTime(int index) {
    return Container(
      alignment: Alignment.topLeft,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(30),
                top: ScreenUtil().setWidth(10)),
            height: ScreenUtil().setHeight(50),
            child: Text(
              '位置: ${list[index].orderBookSeats[0].seatName}',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(30),
                bottom: ScreenUtil().setWidth(10)),
            height: ScreenUtil().setHeight(60),
            child: Text(
              '时间: ${_getTime(index)}',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  //对时间进行截取，得到所需的时间
  String _getTime(int index) {
    String firstTime = readTimestamp(list[index].startTime);
    List<String> startTime = firstTime.split(' ');
    String year = startTime[0];
    String time = startTime[1];
    List<String> endTime = readTimestamp(list[index].endTime).split(' ');
    String emm = endTime[1];
    String showTime = '${year}  ${time} - ${emm}';
    return showTime;
  }

  String readTimestamp(int timestamp) {
    var format = new DateFormat('yyyy-MM-dd HH:mm');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    var time = '';
    time = format.format(date); // Doesn't get called when it should be
    return time;
  }

  //单个预约条目的标题
  Widget _singleTitle(int index) {
    String imageUrl = '';
    if (list[index].status == 1001) {
      //未使用
      imageUrl = 'images/order_mark_unuse.png';
    } else if (list[index].status == 1002) {
      //已取消
      imageUrl = 'images/order_mark_cancel.png';
    } else if (list[index].status == 1003) {
      //使用中
      imageUrl = 'images/order_mark_allow.png';
    } else if (list[index].status == 1004) {
      //已完成
      imageUrl = 'images/order_mark_complete.png';
    }
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                width: ScreenUtil().setWidth(600),
                height: ScreenUtil().setHeight(50),
                child: Text(
                  '地点: ${list[index].orderBookSeats[0].address}',
                  style: TextStyle(fontSize: 14, color: Color(0xff808080)),
                ),
              )),
          Image.asset(
            imageUrl,
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(80),
          ),
        ],
      ),
    );
  }

  Future _saveOnTapData(int index) async {
    prefs = await SharedPreferences.getInstance();
    String seatName = list[index].orderBookSeats[0].seatName;
    String address = list[index].orderBookSeats[0].address;
    String orderId = list[index].orderId;
    int startTime = list[index].startTime;
    int endTime = list[index].endTime;
    String username = list[index].username;
    String fullName = list[index].fullName;
    prefs.setString('orderId', orderId);
    prefs.setInt('startTime', startTime);
    prefs.setInt('endTime', endTime);
    prefs.setString('username', username);
    prefs.setString('fullName', fullName);
    print('订单列表页面存储的:seatName:${seatName},startTime:${startTime},fullName:${fullName}');
    prefs.setString('seatName', seatName);
    prefs.setString('address', address);
  }

  //单个预约条目的灰色细线
  Widget _singleThrought() {
    return Container(
      width: 345,
      height: 1,
      color: Color(0xffEEEEEE),
    );
  }
}
