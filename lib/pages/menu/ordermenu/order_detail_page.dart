import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_station/design/CustomButton.dart';
import 'package:work_station/helpclass/Toast.dart';
import 'package:work_station/pages/index_page.dart';
import 'package:work_station/pages/login_page.dart';
import 'package:work_station/service/service_method.dart';

class OrderDetailPage extends StatefulWidget {
  var fullName;

  OrderDetailPage(this.fullName);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  String localPhoneNumber = '';
  String localCount = '';
  String localSeatName = '';
  String localStartTime = '';
  String localEndTime = '';
  String returnData = '';
  String year = '';
  String showTime = '';
  String orderId = '';
  String address = '';
  bool refreshFlag = true; //true表示需要刷新，false表示不需要刷新
  int status = 1001;
  SharedPreferences prefs;

  //获取订单数据
  Future _getOrderDetailData() async {
//    print('开始获取订单数据  .....   ');
    prefs = await SharedPreferences.getInstance();
    String seatName = prefs.getString('seatName');
    String address = prefs.getString('address');
    int endTime = prefs.getInt('endTime');
    int startTime = prefs.getInt('startTime');
    String userName = prefs.getString('fullName');
    print('订单详情获取到的userName : ${userName}');
    String phone = prefs.getString("tel").toString();
    String orderId = prefs.getString('orderId').toString();
    status = prefs.getInt("status");
    String returnData =
        '${seatName}_${endTime}_${startTime}_${userName}_${phone}_${orderId}_${address}';

    return returnData;
  }

  void _refreshDetailData() {
    _getOrderDetailData().then((val) {
      returnData = val.toString();
      List<String> data = returnData.split('_');
      localSeatName = data[0];
      localEndTime = data[1];
      localStartTime = data[2];
      String formatData = readTimestamp(int.parse(localStartTime));
      List<String> startTime = formatData.split(' ');
      year = startTime[0];
      String time = startTime[1];
      List<String> endTime = readTimestamp(int.parse(localEndTime)).split(' ');
      String emm = endTime[1];
      showTime = '${time} - ${emm}';
      localCount = data[3];
      localPhoneNumber = data[4];
      orderId = data[5];
      address = data[6];
//      print('getOrderDetailData:${address.toString()}');
      if (refreshFlag) {
        setState(() {
          print('refreshFlag刷新页面:${refreshFlag}');
          localSeatName.toString();
          localEndTime.toString();
          localStartTime.toString();
          localCount.toString();
          localPhoneNumber.toString();
          orderId.toString();
          address.toString();
          status;
          print('刷新的status:${status}');
        });
        refreshFlag = false;
      }
    });
  }

  String readTimestamp(int timestamp) {
    var format = new DateFormat('yyyy-MM-dd HH:mm');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    var time = '';
    time = format.format(date); // Doesn't get called when it should be
    return time;
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

  @override
  Widget build(BuildContext context) {
    _refreshDetailData();

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            leading: _back(),
            title: Text(
              '查看详情',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _detailCard(),
                _abolishButton(),
              ],
            ),
          ),
        ),
        onWillPop: () {
          prefs.setInt('status', 1001);
          Navigator.pop(context);
        });
  }

  Widget _detailCard() {
    return Container(
      height: ScreenUtil().setHeight(810),
      width: ScreenUtil().setWidth(700),
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(24),
          ScreenUtil().setHeight(29),
          ScreenUtil().setWidth(26),
          ScreenUtil().setHeight(78)),
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(
          'images/order_detail_bg.png',
        ),
      )),
      child: Column(
        children: <Widget>[
          _title(),
          _address(),
          _street(),
          _time(),
          _name(),
          _phone(),
        ],
      ),
    );
  }

  //标题
  Widget _title() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(89)),
      child: Text(
        '订单详情',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(36),
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //位置
  Widget _address() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(70),
                top: ScreenUtil().setHeight(68)),
            child: Text(
              '位置',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(38),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(50),
              right: ScreenUtil().setHeight(70)),
          child: Text(
            localSeatName,
            style: TextStyle(
              fontSize: 19,
            ),
          ),
        ),
      ],
    );
  }

  //地址
  Widget _street() {
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60),
          ScreenUtil().setHeight(120), ScreenUtil().setWidth(20), 0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: ScreenUtil().setWidth(30),
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
              child: Text(
                '地点',
                maxLines: 1,
                style: TextStyle(color: Color(0xffA0A0A0), fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(50)),
            child: Text(
              address,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xffA0A0A0),
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }

  //时间
  Widget _time() {
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60),
          ScreenUtil().setWidth(50), ScreenUtil().setWidth(20), 0),
      alignment: Alignment.topLeft,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
              child: Text(
                '时间',
                style: TextStyle(color: Color(0xffA0A0A0), fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(50)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    year,
                    style: TextStyle(color: Color(0xffA0A0A0), fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    showTime,
                    style: TextStyle(color: Color(0xffA0A0A0), fontSize: 16),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //姓名
  Widget _name() {
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60),
          ScreenUtil().setWidth(50), ScreenUtil().setWidth(20), 0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
              child: Text(
                '姓名',
                style: TextStyle(color: Color(0xffA0A0A0), fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(50)),
            child: Text(
              widget.fullName,
              style: TextStyle(color: Color(0xffA0A0A0), fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  //联系方式
  Widget _phone() {
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60),
          ScreenUtil().setWidth(50), ScreenUtil().setWidth(20), 0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
              child: Text(
                '联系方式',
                style: TextStyle(color: Color(0xffA0A0A0), fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(50)),
            child: Text(
              localPhoneNumber,
              style: TextStyle(color: Color(0xffA0A0A0), fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  //取消预约按钮
  Widget _abolishButton() {
    String btnName = '取消预约';
    if (status == 1001) {
      return Container(
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
        child: HeavenButton(
          heavenName: btnName,
          buttonWidth: ScreenUtil().setWidth(600),
          buttonHeight: ScreenUtil().setHeight(90),
          marginBottom: ScreenUtil().setHeight(10),
          marginLeft: ScreenUtil().setWidth(10),
          marginRight: ScreenUtil().setWidth(10),
          marginTop: ScreenUtil().setHeight(10),
          onTap: () {
            var formData = {"orderId": orderId};
            seatRequest(context, 'orderCancel', formData: formData).then((val) {
              if (val['code'] == -4) {
//                Toast.show(context,'登陆过期，请重新登陆!');
                Navigator.of(context).pushAndRemoveUntil(
                    new MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => route == null);
              } else if (val['code'] == 0) {
                Toast.show(context,'取消订单成功!');
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => IndexPage()),
                    (route) => route == null);
              } else {
                Toast.show(context,'取消订单失败!');
                print('取消订单Code:${val['code']}');
              }
            });
          },
        ),
      );
    } else {
      return Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(1)));
    }
  }
}
