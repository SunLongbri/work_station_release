import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_station/design/CustomButton.dart';
import 'package:work_station/helpclass/Toast.dart';
import 'package:work_station/model/ParseDetailData.dart';
import 'package:work_station/pages/index_page.dart';
import 'package:work_station/pages/login_page.dart';
import 'package:work_station/pages/menu/ordermenu/order_detail_page.dart';
import 'package:work_station/service/service_method.dart';

class OrderSuccessPage extends StatefulWidget {
  @override
  _OrderSuccessPageState createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  String localphoneNumber;
  String orderId;
  SharedPreferences prefs;

  Future _getPhoneNumber() async {
    prefs = await SharedPreferences.getInstance();
    String phoneNumber = prefs.getString("phoneNumber").toString();
    String orderId = prefs.getString('orderId').toString();
    String returnData = '${phoneNumber}_${orderId}';
    return returnData;
  }

  @override
  void initState() {
    super.initState();
    _getPhoneNumber().then((val) {
      String subData = val.toString();
      List<String> data = subData.split('_');
      localphoneNumber = data[0];
      orderId = data[1];
      setState(() {
        localphoneNumber.toString();
        orderId.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              '预约成功',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            centerTitle: true, elevation: 0,
            //去掉返回按钮
            leading: Text(''),
          ),
          body: Column(
            children: <Widget>[
              _orderSuccessBg(),
              _orderSuccessText(),
              _sendPhoneText(),
              _detailButton(),
              _BackButton(),
            ],
          ),
        ),
        onWillPop: () {
//          Toast.show(context, '别按物理返回键了，这个Bug已经修复了 ....   !');
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => IndexPage()),
              (route) => route == null);
        });
  }

  //预约成功背景图片
  Widget _orderSuccessBg() {
    return Container(
      width: ScreenUtil().setWidth(175),
      height: ScreenUtil().setHeight(176),
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(288),
          ScreenUtil().setHeight(153),
          ScreenUtil().setWidth(287),
          ScreenUtil().setHeight(53)),
      child: Image.asset('images/order_success_bg.png'),
    );
  }

  Widget _orderSuccessText() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        '恭喜您，预约成功！',
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(32)),
      ),
    );
  }

  //小文字内容
  Widget _sendPhoneText() {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(600),
      height: ScreenUtil().setHeight(100),
      margin: EdgeInsets.fromLTRB(50, 12, 50, 0),
      child: Column(
        children: <Widget>[
          Text(
            '请按时间前往您所预约的场馆',
            style: TextStyle(color: Color(0xff808080), fontSize: 12),
          ),
          Text(
            '预约成功的短信已发送至手机${localphoneNumber.toString()}',
            style: TextStyle(color: Color(0xff808080), fontSize: 12),
          )
        ],
      ),
    );
  }

  //查看详情按钮
  Widget _detailButton() {
    String btnName = '查看详情';
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(76)),
      child: HeavenButton(
        heavenName: btnName,
        buttonWidth: ScreenUtil().setWidth(600),
        buttonHeight: ScreenUtil().setHeight(90),
        marginBottom: ScreenUtil().setHeight(10),
        marginLeft: ScreenUtil().setWidth(10),
        marginRight: ScreenUtil().setWidth(10),
        marginTop: ScreenUtil().setHeight(10),
        onTap: () {
//          Toast.show(context, '进入到查看详情页面 ... ');
          var formData = {'orderId': orderId};
          seatRequest(context, 'orderDetail', formData: formData).then((val) {
            if (val['code'] == -4) {
//              Toast.show(context,'登陆过期，请重新登陆!');
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => route == null);
            } else if (val['code'] == 0) {
              //请求订单详情成功
              var detailData = val;
              ParseDetailData parseDetailData =
                  ParseDetailData.fromJson(detailData['data']);
              //todo:需要优化的代码
              print(
                  'orderId:${parseDetailData.orderId},startTime:${parseDetailData.startTime},endTime:${parseDetailData.endTime},username:${parseDetailData.username},tel:${parseDetailData.tel},orderBookSeats:${parseDetailData.orderBookSeats}');
              prefs.setString('orderId', parseDetailData.orderId);
              prefs.setInt('startTime', parseDetailData.startTime);
              prefs.setInt('endTime', parseDetailData.endTime);
              prefs.setString('username', parseDetailData.username);
              prefs.setString('tel', parseDetailData.tel);
              prefs.setString('fullName', parseDetailData.fullName);
//              print('点击进入详情页获得的服务端数据:${detailData.toString()}');
              String nameAndaddress = parseDetailData.orderBookSeats.toString();
              nameAndaddress =
                  nameAndaddress.substring(1, nameAndaddress.length - 1);
              print(nameAndaddress);
              List<String> splitData = nameAndaddress.split('address:');
              String seatName =
                  splitData[0].substring(10, splitData[0].length - 2);
              String address =
                  splitData[1].substring(1, splitData[1].length - 1);
              print(
                  'seatName:${seatName.toString()},address:${address.toString()}');
              prefs.setString('seatName', seatName);
              prefs.setString('address', address);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      OrderDetailPage(parseDetailData.fullName)));
            } else {
              print('请求订单详情失败，返回数据code为:${val['code']}');
              Toast.show(context, '请求订单失败，code:${val['code']}');
            }
          });
        },
      ),
    );
  }

  //返回主页按钮
  Widget _BackButton() {
    String btnName = '返回首页';
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
      child: SunButton(
        sunName: btnName,
        onTap: () {
          Toast.show(context,'返回主页页面 ... ');
          //跳转页面之后，销毁当前页面
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => IndexPage()),
              (route) => route == null);
        },
      ),
    );
  }
}
