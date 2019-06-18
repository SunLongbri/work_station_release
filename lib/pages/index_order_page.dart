import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_station/design/index_order_menu.dart';
import 'package:work_station/helpclass/Toast.dart';
import 'package:work_station/model/ParseMarkModel.dart';
import 'package:work_station/pages/login_page.dart';
import 'package:work_station/pages/menu/conditionmenu/condition_state_page.dart';
import 'package:work_station/pages/menu/lightingmenu/lighting_list_page.dart';
import 'package:work_station/pages/menu/markmenu/order_mark_page.dart';
import 'package:work_station/pages/menu/ordermenu/current_order.dart';
import 'package:work_station/pages/menu/ordermenu/select_time_page.dart';
import 'package:work_station/service/service_method.dart';

class IndexOrderPage extends StatefulWidget {
  @override
  _IndexOrderPageState createState() => _IndexOrderPageState();
}

class _IndexOrderPageState extends State<IndexOrderPage> {
  var author;

  @override
  void initState() {
    getOrderPageInfo();
    _getUnUsedkData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBFBFB),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _topView(),
            _orderRectangle(),
          ],
        ),
      ),
    );
  }

  //首页当前预约情况可按钮
  Widget _detailText() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(54), ScreenUtil().setHeight(138), 0, 0),
      height: ScreenUtil().setHeight(300),
//      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
            child: Text(
              '当前已有${unUsedNumber}个预约',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(44), color: Colors.white),
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(65),
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(5),
                top: ScreenUtil().setHeight(10)),
            child: RaisedButton(
              child: Text(
                '点击查看',
                style: new TextStyle(
                    fontSize: ScreenUtil().setSp(28), color: Colors.blue),
              ),
              color: Colors.white,
              onPressed: () {
                if (unUsedNumber == 0) {
                  Toast.show(context, '请先预约座位!');
                  return;
                }
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CurrentOrderPage()));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //首页背景图片
  Widget _topView() {
    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        new Container(
          child: Image.asset('images/home_page_top.png'),
        ),
        _detailText(),
      ],
    );
  }

  //我要预约和预约记录长形按钮
  Widget _orderRectangle() {
    return Column(
      children: <Widget>[
        //我要预约Container
        _selectOrder(),

        //预约记录
        _orderMark(),

        //等控开关
        _controlLighting(),

        //空调开关
        _controlCondition(),
      ],
    );
  }

  //我要预约
  Widget _selectOrder() {
    return OrderMenu(() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SelectTimePage()));
    }, 'images/home_order_icon.png', '我要预约');
  }

  //预约记录
  Widget _orderMark() {
    return OrderMenu(() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => OrderMarkPage()));
    }, 'images/home_order_mark.png', '预约记录');
  }

  //灯控开关
  Widget _controlLighting() {
    return OrderMenu(() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LightingListPage()));

    }, 'images/index_lighting_icon.png', '灯控开关');
  }

  //空调开关
  Widget _controlCondition() {
    String currentOrder = author.toString().split(':')[0];
    if (currentOrder.contains('0')) {
      return Container(
        width: ScreenUtil().setWidth(10),
        height: ScreenUtil().setHeight(10),
      );
    } else if (currentOrder.contains('1')) {
      return OrderMenu(() {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ConditionStatePage()));
      }, 'images/order_air.png', '空调开关');
    } else {
      return Container(
        width: ScreenUtil().setWidth(10),
        height: ScreenUtil().setHeight(10),
      );
    }
  }

  Future getOrderPageInfo() async {
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('counter');
    getUserInfo(context, 'getUserInfo', token).then((val) async {
      if (val == -4) {
//        Toast.show(context, '登陆过期，请重新登陆!');
      }
      if (val['code'] == 0) {
        author = val['data']['userUiAuthority'];
        print('---------------------->:IndexOrder页面initState获取到的权限：${author}');
        setState(() {
          author;
          print('IndexOrderPage页面更新了author的值：${author}');
        });
      }
    });
  }

  List list = [];
  int unUsedNumber = 0;
  SharedPreferences prefs;

  //获取当前预约没有使用座位的信息列表
  void _getUnUsedkData() async {
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
      } else {
        ParseMarkModel parseMarkModel = ParseMarkModel.fromJson(val);

        if (parseMarkModel.data != null) {
          list = parseMarkModel.data.list;
          unUsedNumber = parseMarkModel.data.total;
          setState(() {
            list = parseMarkModel.data.list;
            unUsedNumber;
          });
        }
      }
    });
  }
}
