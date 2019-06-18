import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_station/helpclass/Toast.dart';
import 'package:work_station/model/ParseDetailData.dart';
import 'package:work_station/model/ParseMarkModel.dart';
import 'package:work_station/pages/index_page.dart';
import 'package:work_station/pages/login_page.dart';
import 'package:work_station/pages/menu/ordermenu/order_detail_page.dart';
import 'package:work_station/service/service_method.dart';

class OrderMarkPage extends StatefulWidget {
  final length;

  OrderMarkPage({this.length});

  @override
  _OrderMarkPageState createState() => _OrderMarkPageState();
}

class _OrderMarkPageState extends State<OrderMarkPage> {
  List list = [];
  SharedPreferences prefs;
  int page = 2;
  bool _saving = false;
  GlobalKey<RefreshFooterState> _footerkey =
      new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    _getOrderMarkData();
    super.initState();
  }

  void _getOrderMarkData() async {
    var formData = {
      "pageNum": 1,
      "pageSize": 10,
    };
    await seatRequest(context, 'orderList', formData: formData).then((val) {
      if (val['code'] == -4) {
//        Toast.show(context, '登陆过期，请重新登陆!');
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => route == null);
      }
//      print('预约记录请求结果:${val.toString()}');
      ParseMarkModel parseMarkModel = ParseMarkModel.fromJson(val);
      list = parseMarkModel.data.list;

      setState(() {
        list = parseMarkModel.data.list;
        _saving = false;
      });
    });
  }

  Widget _listInkWell(int index) {
    return InkWell(
      onTap: () {
        String fullName = list[index].fullName;
        _saveOnTapData(index).then((value) async {
          await getPhone(orderId);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OrderDetailPage(fullName)));
        });
      },
      child: _singleOrderMark(index),
    );
  }

  String orderId = '';

  Future _saveOnTapData(int index) async {
    prefs = await SharedPreferences.getInstance();
    String seatName = list[index].orderBookSeats[0].seatName;
    String address = list[index].orderBookSeats[0].address;
    orderId = list[index].orderId;
    int startTime = list[index].startTime;
    int endTime = list[index].endTime;
    String username = list[index].username;
    prefs.setString('orderId', orderId);
    prefs.setInt('startTime', startTime);
    prefs.setInt('endTime', endTime);
    prefs.setString('username', username);
    prefs.setString('seatName', seatName);
    prefs.setString('address', address);
  }

  Future<String> getPhone(orderId) async {
    var formData = {'orderId': orderId};
    await seatRequest(context, 'orderDetail', formData: formData)
        .then((val) async {
//      print('获取手机val:${val.toString()}');
      if (val['code'] == 0) {
        var detailData = val;
        ParseDetailData parseDetailData =
            ParseDetailData.fromJson(detailData['data']);
        await prefs.setString('tel', parseDetailData.tel);
        await prefs.setInt('status', parseDetailData.status);
        return parseDetailData.tel;
      }
    });
  }

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

  Widget _icon() {
    return Container(
      child: Image.asset(
        'images/order_mark_icon.png',
        width: ScreenUtil().setWidth(150),
        height: ScreenUtil().setHeight(150),
      ),
    );
  }

  Widget _errortext() {
    return Container(
      child: Text(
        '您还没有预约记录',
        style: TextStyle(
            color: Color(0xFF999999), fontSize: ScreenUtil().setSp(34)),
      ),
    );
  }

  Widget _refreshtext() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        child: Text(
          '立即预约',
          style: TextStyle(
              color: Color(0xFF1792E5), fontSize: ScreenUtil().setSp(32)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if (list.length == 0 ) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: _back(),
          title: Text(
            '预约记录',
            style: TextStyle(
                color: Colors.white, fontSize: ScreenUtil().setSp(34)),
          ),
          centerTitle: true,
        ),
        body: ModalProgressHUD(
          child: Container(
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(1000),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _icon(),
                _errortext(),
                _refreshtext(),
              ],
            ),
          ),inAsyncCall: _saving,
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xffF7F7F7),
        appBar: AppBar(
          leading: _back(),
          title: Text(
            '预约记录',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: EasyRefresh(
          refreshFooter: ClassicsFooter(
            key: _footerkey,
            bgColor: Colors.white,
            textColor: Colors.blue,
            moreInfoColor: Colors.blue,
            showMore: true,
            noMoreText: '',
            moreInfo: '加载中 ... ',
            loadReadyText: '上拉加载',
          ),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return _listInkWell(index);
            },
          ),
          loadMore: () async {
            print('开始加载更多.....');
            var refreshData = {
              "pageNum": page,
              "pageSize": 10,
            };
            await seatRequest(context, 'orderList', formData: refreshData)
                .then((val) {
//            print('currentPage:${page},接收到的数据:${val}');
              if (val['code'] == -4) {
//                Toast.show(context, '登陆过期，请重新登陆!');
                Navigator.of(context).pushAndRemoveUntil(
                    new MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => route == null);
              } else if (val['code'] == -1) {
                Toast.show(context, '--我是有底线的--');
                setState(() {
                  list;
                });
              } else {
//              print('currentPage:${page},接收到的数据:${val}');
                ParseMarkModel parseMarkModel = ParseMarkModel.fromJson(val);
                List refreshList = parseMarkModel.data.list;
                print('返回结果:${refreshList.length}');
                setState(() {
                  list.addAll(refreshList);
                  page++;
                });
              }
            });
          },
        ),
      );
    }
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
            ),
          ),
          Image.asset(
            imageUrl,
            height: ScreenUtil().setHeight(85),
            width: ScreenUtil().setWidth(85),
          ),
        ],
      ),
    );
  }

  //单个预约条目的灰色细线
  Widget _singleThrought() {
    return Container(
      width: 345,
      height: 1,
      color: Color(0xffEEEEEE),
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
}
