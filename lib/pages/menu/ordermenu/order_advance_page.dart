import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_station/colors.dart';
import 'package:work_station/helpclass/Toast.dart';
import 'package:work_station/model/ParseSeatModel.dart';
import 'package:work_station/pages/login_page.dart';
import 'package:work_station/pages/menu/ordermenu/order_success_page.dart';
import 'package:work_station/pages/menu/ordermenu/select_time_page.dart';
import 'package:work_station/service/service_method.dart';

class OrderAdvancePage extends StatefulWidget {
  @override
  _OrderAdvancePageState createState() => _OrderAdvancePageState();
}

class _OrderAdvancePageState extends State<OrderAdvancePage> {
  int endTime = 0;
  int startTime = 0;
  ParseSeatModelListModel list;
  SharedPreferences prefs;
  bool refreshFlag = true; //true表示刷新，false表示不刷新
  double screenSize = 0.5;

  Future _loadData() async {
//    print('开始初始化页面数据 ... ');
    prefs = await SharedPreferences.getInstance();
    endTime = prefs.getInt('endTime');
    startTime = prefs.getInt('startTime');
    var formData = {"endTime": endTime, "startTime": startTime};
    seatRequest(context, 'getWorkSeat', formData: formData).then((val) {
      print('工位预定接收到的参数为:${val.toString()}');
      if (val['code'] == -4) {
//        Toast.show(context,'登陆过期，请重新登陆!');
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => route == null);
      }
      var data = val;
      list = ParseSeatModelListModel.formJson(data['data']);
      if (refreshFlag) {
        setState(() {
          list;
        });
        refreshFlag = false;
      }

//      print('解析到的座位名称为:');
//      list.data.forEach((item) => print(
//          '${item.seatName}---->seatX:${item.seatX},seatY:${item.seatY},seatStatus:${item.status}'));
    });
  }

  Widget _back() {
    return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SelectTimePage()));
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
    _loadData();
    return Scaffold(
      appBar: AppBar(
        leading: _back(),
        title: Text(
          '我要预约',
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
            _orderInfo(),
            _bottomWorkInfo(),
          ],
        ),
      ),
    );
  }

  //当前预定的状态信息
  Widget _orderInfo() {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(1028),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/order_advance_bg.png'))),
        ),
        _currentSeatState(),
        _firstDesk(),
        _secondDesk(),
        _thirdDesk(),
        _smallRound(),
        _bigRound(),
      ],
    );
  }

  //小圆桌子
  Widget _smallRound() {
    return Container(
      margin:
          EdgeInsets.only(left: leastleftsmallRound, top: leastTopsmallRound),
      child: Image.asset(
        'images/small_desk.png',
        width: diameter,
        height: diameter,
        fit: BoxFit.contain,
      ),
    );
  }

  //第一张桌子
  Widget _firstDesk() {
    return Container(
      margin: EdgeInsets.only(left: leastLeftFirstDesk, top: leastTopFirstDesk),
      child: Image.asset(
        'images/first_rectangle_desk.png',
        width: ScreenUtil().setWidth(240),
        height: deskHeight,
        fit: BoxFit.fill,
      ),
    );
  }

  //第二张桌子
  Widget _secondDesk() {
    return Container(
      margin:
          EdgeInsets.only(left: leastLeftFirstDesk, top: leastTopSecondDesk),
      child: Image.asset(
        'images/second_rectangle_desk.png',
        width: ScreenUtil().setWidth(240),
        height: deskHeight,
        fit: BoxFit.fill,
      ),
    );
  }

  //第三张桌子
  Widget _thirdDesk() {
    return Container(
      margin: EdgeInsets.only(left: leastleftThirdDesk, top: leastTopThirdDesk),
      child: Image.asset(
        'images/third_rectangle_desk.png',
        width: deskHeight,
        height: ScreenUtil().setWidth(240),
        fit: BoxFit.fill,
      ),
    );
  }

  //大圆桌子
  Widget _bigRound() {
    return Container(
      margin: EdgeInsets.only(
        left: leastleftbigRound,
        top: leastTopbigRound,
      ),
      child: Image.asset(
        'images/big_desk.png',
        width: bigDiameter,
        height: bigDiameter,
      ),
    );
  }

  //座位颜色指示
  Widget _seatState() {
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(53), 0,
                      ScreenUtil().setWidth(15), 0),
                  child: Container(
                    width: ScreenUtil().setWidth(24),
                    height: ScreenUtil().setHeight(22),
                    color: Colors.blue,
                  )),
              Text(
                '可预约',
                style: TextStyle(fontSize: 11, color: Color(0xff898989)),
              )
            ]),
          ),
          Expanded(
            flex: 1,
            child: Row(children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0,
                      ScreenUtil().setWidth(15), 0),
                  child: Container(
                    width: ScreenUtil().setWidth(24),
                    height: ScreenUtil().setHeight(22),
                    color: Colors.orange,
                  )),
              Text(
                '已预约',
                style: TextStyle(fontSize: 11, color: Color(0xff898989)),
              )
            ]),
          ),
          Expanded(
            flex: 1,
            child: Row(children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), 0,
                      ScreenUtil().setWidth(15), 0),
                  child: Container(
                    width: ScreenUtil().setWidth(24),
                    height: ScreenUtil().setHeight(22),
                    color: Colors.red,
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(5), 0,
                      ScreenUtil().setWidth(15), 0),
                  child: Text(
                    '已占用',
                    style: TextStyle(fontSize: 11, color: Color(0xff898989)),
                  )),
            ]),
          ),
          Expanded(
            flex: 1,
            child: Row(children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), 0,
                      ScreenUtil().setWidth(15), 0),
                  child: Container(
                    width: ScreenUtil().setWidth(24),
                    height: ScreenUtil().setHeight(22),
                    color: Colors.grey,
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(5), 0,
                      ScreenUtil().setWidth(10), 0),
                  child: Text(
                    '不可预约',
                    style: TextStyle(fontSize: 11, color: Color(0xff898989)),
                  )),
            ]),
          ),
        ],
      ),
    );
  }

  //当前办公室座位的状态信息
  Widget _currentSeatState() {
    return Stack(
      children: generateWorkSeatList(list),
    );
  }

  String clickSeatName = '未选择';
  String imageName = 'images/order_advance_empty.png';

  List<Widget> generateWorkSeatList(list) {
    List<Widget> listWidget = [];
    if (list == null) {
      listWidget.add(Container(
        width: ScreenUtil().setHeight(700),
        height: ScreenUtil().setWidth(700),
        alignment: Alignment.center,
        child: Text('正在加载数据 ... '),
      ));
      return listWidget;
    }

    for (int i = 0; i < list.data.length; i++) {
      double top = list.data[i].seatY * 1.0;
      double left = list.data[i].seatX * 1.0;

      int statusCode = list.data[i].status;
      String seatName = list.data[i].seatName;

      if (statusCode == 1001) {
        _judgeSeatState(seatName, listWidget, left, top, i);
      } else if (statusCode == 1002) {
        _judgeSeatGrayState(seatName, listWidget, left, top, i);
      } else if (statusCode == 1003) {
        _judgeSeatYellowState(seatName, listWidget, left, top, i);
      } else if (statusCode == 1004) {
        //已占用
        _judgeSeatRedState(seatName, listWidget, left, top, i);
      }

      heavenCount();
    }
    return listWidget;
  }

  double screenSizeD = 1.1;
  double screenSizeC = 1.0;
  double screenSizeB = 0.98;
  double screenE02 = 1.0;
  double screenE03 = 1.0;
  double smallLeft = 0;
  double smallTop = 0;
  double bigLeft = 0;
  double bigTop = 0;

  double pt11top = 0;
  double pt11left = 0;
  double pt12top = 0;
  double pt12left = 0;
  double leastLeftFirstDesk = 0;
  double leastTopFirstDesk = 0;

  double pt09top = 0;
  double pt09left = 0;
  double pt10top = 0;
  double pt10left = 0;
  double leastLeftSecondtDesk = 0;
  double leastTopSecondDesk = 0;
  double deskHeight = 0;

  double pt07top = 0;

  double pt03top = 0;
  double pt03left = 0;
  double leastTopThirdDesk = 0;
  double leastleftThirdDesk = 0;

  double pt13top = 0;
  double pt13left = 0;
  double pt14top = 0;
  double pt14left = 0;
  double leastTopsmallRound = 0;
  double leastleftsmallRound = 0;

  double diameter = 0;

  double pt16top = 0;
  double pt16left = 0;
  double pt18top = 0;
  double pt18left = 0;
  double bigDiameter = 0;
  double leastTopbigRound = 0;
  double leastleftbigRound = 0;

  void heavenCount() {
    //计算第一张桌子的位置
    double xfirst = pt12left - pt11left;
    double cfirst = xfirst / 3;
    leastLeftFirstDesk = pt11left - cfirst;
    double cc = xfirst / 2;
    leastTopFirstDesk = pt11top + cc;
//    print('第一张桌子，pt11top:${pt11top}');
    deskHeight = (pt09top - pt11top) - (cfirst / 0.65);
    print('deskHeight:${deskHeight}');

    //计算第二张桌子的位置
    leastTopSecondDesk = pt07top + cc;

    //计算第三张桌子的位置
    leastTopThirdDesk = pt03top - xfirst - (cc / 1.5);
    leastleftThirdDesk = pt03left - xfirst + (cc / 6);

    //计算小圆桌子的位置
    diameter = (pt14left - pt13left) / 1.4;
    leastTopsmallRound = pt13top + (diameter / 5);
    leastleftsmallRound = pt13left + (diameter / 1.8);

    //计算大圆桌子的位置
    bigDiameter = (pt18left - pt16left) / 1.3;
    leastTopbigRound = pt16top + (bigDiameter) / 6;
    leastleftbigRound = pt16left + (bigDiameter) / 2.5;
  }

  //判断各个椅子可预约状态
  void _judgeSeatState(seatName, listWidget, left, top, i) {
    if (seatName == 'pt11' ||
        seatName == 'pt12' ||
        seatName == 'pt07' ||
        seatName == 'pt17' ||
        seatName == 'pt08') {
      smallLeft = left;
      smallTop = top;
      if (seatName == 'pt07') {
        pt07top = top;
      }
      //获取pt11的位置坐标
      if (seatName == 'pt11') {
        pt11top = top;
        pt11left = left;
        print('pt11top:${pt11top}');
      }

      if (seatName == 'pt12') {
        pt12top = top;
        pt12left = left;
      }

      _setSeatLocation(
          listWidget, left, top, 'images/pt11_1001.png', i, screenPt07);
    } else if (seatName == 'pt09' ||
        seatName == 'pt10' ||
        seatName == 'pt05' ||
        seatName == 'pt20' ||
        seatName == 'pt06') {
      if (seatName == 'pt09') {
        pt09top = top;
        pt09left = left;
      }
      _setSeatLocation(
          listWidget, left, top, 'images/pt09_1001.png', i, screenPt09);
    } else if (seatName == 'pt01' || seatName == 'pt02') {
      _setSeatLocation(
          listWidget, left, top, 'images/pt02_1001.png', i, screenPt01);
    } else if (seatName == 'pt03' || seatName == 'pt04') {
      if (seatName == 'pt03') {
        pt03left = left;
        pt03top = top;
      }
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt04_1001.png", i, screenPt03);
    } else if (seatName == 'pt13') {
      pt13top = top;
      pt13left = left;
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt13_1001.png", i, screenPt13);
    } else if (seatName == 'pt14') {
      pt14left = left;
      pt14top = top;
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt14_1001.png", i, screenPt14);
    } else if (seatName == 'pt15') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt15_1001.png", i, screenPt15);
    } else if (seatName == 'pt18') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt18_1001.png", i, screenPt18);
    } else if (seatName == 'pt19') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt19_1001.png", i, screenPt19);
    } else if (seatName == 'pt21') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt21_1001.png", i, screenPt21);
    } else if (seatName == 'pt16') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt16_1001.png", i, screenPt16);
    } else if (seatName == 'B01') {
      _setSeatDeskLocation(listWidget, left, top,
          "images/desk_c_rignt_1101.png", i, screenSizeB);
    } else if (seatName == 'B02') {
      _setSeatDeskLocation(listWidget, left, top,
          "images/desk_c_rignt_1101.png", i, screenSizeB);
    } else if (seatName == 'B03') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/desk_c_left_1101.png", i, screenSizeB);
    } else if (seatName == 'B04') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/desk_c_left_1101.png", i, screenSizeB);
    } else if (seatName == 'A01') {
      bigLeft = left;
      bigTop = top;
      print('传参：当前bigLeft:${bigLeft},bigTop:${bigTop}');
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_01_1101.png", i, screenPt18);
    } else if (seatName == 'A02') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_02_1101.png", i, screenA02);
    } else if (seatName == 'A03') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_03_1101.png", i, screenA03);
    } else if (seatName == 'A04') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_04_1101.png", i, screenA04);
    } else if (seatName == 'A05') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_05_1101.png", i, screenA05);
    } else if (seatName == 'A06') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_06_1101.png", i, screenA06);
    } else {
      _setSeatLocation(
          listWidget, left, top, 'images/order_advance_empty.png', i, screenA);
    }
  }

  double screenA03 = 0.95;
  double screenA02 = 1.0;
  double screenA04 = 1.1;
  double screenA05 = 1.0;
  double screenA06 = 1.15;
  double screenA = 1.0;

  double screenPt01 = 1.1;
  double screenPt18 = 0.78;
  double screenPt09 = 1.09;
  double screenPt03 = 0.68;
  double screenPt13 = 0.9;
  double screenPt14 = 0.9;
  double screenPt15 = 0.9;
  double screenPt19 = 0.78;
  double screenPt21 = 0.78;
  double screenPt16 = 0.78;
  double screenPt07 = 1.1;

  //判断各个椅子已预约的状态
  void _judgeSeatYellowState(seatName, listWidget, left, top, i) {
    if (seatName == 'pt11' ||
        seatName == 'pt12' ||
        seatName == 'pt07' ||
        seatName == 'pt17' ||
        seatName == 'pt08') {
      smallLeft = left;
      smallTop = top;
      if (seatName == 'pt07') {
        pt07top = top;
      }
      //获取pt11的位置坐标
      if (seatName == 'pt11') {
        pt11top = top;
        pt11left = left;
      }

      if (seatName == 'pt12') {
        pt12top = top;
        pt12left = left;
      }
      _setSeatLocation(
          listWidget, left, top, 'images/pt11_1002.png', i, screenPt01);
    } else if (seatName == 'pt09' ||
        seatName == 'pt10' ||
        seatName == 'pt05' ||
        seatName == 'pt20' ||
        seatName == 'pt06') {
      if (seatName == 'pt09') {
        pt09top = top;
        pt09left = left;
      }
      _setSeatLocation(
          listWidget, left, top, 'images/pt09_1002.png', i, screenPt09);
    } else if (seatName == 'pt01' || seatName == 'pt02') {
      _setSeatLocation(
          listWidget, left, top, 'images/pt02_1002.png', i, screenPt01);
    } else if (seatName == 'pt03' || seatName == 'pt04') {
      if (seatName == 'pt03') {
        pt03left = left;
        pt03top = top;
      }
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt04_1002.png", i, screenPt03);
    } else if (seatName == 'pt13') {
      pt13top = top;
      pt13left = left;
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt13_1002.png", i, screenPt13);
    } else if (seatName == 'pt14') {
      pt14left = left;
      pt14top = top;
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt14_1002.png", i, screenPt14);
    } else if (seatName == 'pt15') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt15_1002.png", i, screenPt15);
    } else if (seatName == 'pt18') {
      bigLeft = left;
      bigTop = top;
      _setSeatLocation(
          listWidget, left, top, "images/pt18_1002.png", i, screenPt18);
    } else if (seatName == 'pt19') {
      _setSeatLocation(
          listWidget, left, top, "images/pt19_1002.png", i, screenPt19);
    } else if (seatName == 'pt21') {
      _setSeatLocation(
          listWidget, left, top, "images/pt21_1002.png", i, screenPt21);
    } else if (seatName == 'pt16') {
      _setSeatLocation(
          listWidget, left, top, "images/pt16_1102.png", i, screenPt16);
    } else if (seatName == 'A05') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_05_1002.png", i, screenA05);
    } else if (seatName == 'A06') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_06_1002.png", i, screenA06);
    } else {
      _setSeatLocation(
          listWidget, left, top, 'images/desk_f_01_1002.png', i, screenA);
    }
  }

  //判断各个椅子已占用的状态
  void _judgeSeatRedState(seatName, listWidget, left, top, i) {
    if (seatName == 'pt11' ||
        seatName == 'pt12' ||
        seatName == 'pt07' ||
        seatName == 'pt17' ||
        seatName == 'pt08') {
      smallLeft = left;
      smallTop = top;
      if (seatName == 'pt07') {
        pt07top = top;
      }
      //获取pt11的位置坐标
      if (seatName == 'pt11') {
        pt11top = top;
        pt11left = left;
      }

      if (seatName == 'pt12') {
        pt12top = top;
        pt12left = left;
      }
      _setSeatLocation(
          listWidget, left, top, 'images/pt11_1003.png', i, screenPt01);
    } else if (seatName == 'pt09' ||
        seatName == 'pt10' ||
        seatName == 'pt05' ||
        seatName == 'pt20' ||
        seatName == 'pt06') {
      if (seatName == 'pt09') {
        pt09top = top;
        pt09left = left;
      }
      _setSeatLocation(
          listWidget, left, top, 'images/pt09_1003.png', i, screenPt09);
    } else if (seatName == 'pt01' || seatName == 'pt02') {
      _setSeatLocation(
          listWidget, left, top, 'images/pt02_1003.png', i, screenPt01);
    } else if (seatName == 'pt03' || seatName == 'pt04') {
      if (seatName == 'pt03') {
        pt03left = left;
        pt03top = top;
      }
      _setSeatDeskLocation(
          listWidget, left, top, "imagespt04_1003.png", i, screenPt03);
    } else if (seatName == 'pt13') {
      pt13top = top;
      pt13left = left;
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt13_1003.png", i, screenPt13);
    } else if (seatName == 'pt14') {
      pt14left = left;
      pt14top = top;
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt14_1003.png", i, screenPt14);
    } else if (seatName == 'pt15') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt15_1003.png", i, screenPt15);
    } else if (seatName == 'pt18') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt18_1003.png", i, screenPt18);
    } else if (seatName == 'pt19') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt19_1003.png", i, screenPt19);
    } else if (seatName == 'pt21') {
      bigLeft = left;
      bigTop = top;
      _setSeatLocation(
          listWidget, left, top, "images/pt21_1003.png", i, screenPt21);
    } else if (seatName == 'pt16') {
      _setSeatLocation(
          listWidget, left, top, "images/pt16_1103.png", i, screenPt16);
    } else if (seatName == 'A03') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_03_1003.png", i, screenA03);
    } else if (seatName == 'A04') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_04_1003.png", i, screenA04);
    } else if (seatName == 'A05') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_05_1003.png", i, screenA05);
    } else if (seatName == 'A06') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_06_1003.png", i, screenA06);
    } else {
      _setSeatLocation(
          listWidget, left, top, 'images/desk_f_01_1003.png', i, screenA);
    }
  }

  //判断各个椅子不可预约的状态
  void _judgeSeatGrayState(seatName, listWidget, left, top, i) {
    if (seatName == 'pt11' ||
        seatName == 'pt12' ||
        seatName == 'pt07' ||
        seatName == 'pt17' ||
        seatName == 'pt08') {
      smallLeft = left;
      smallTop = top;
      if (seatName == 'pt07') {
        pt07top = top;
      }
      //获取pt11的位置坐标
      if (seatName == 'pt11') {
        pt11top = top;
        pt11left = left;
      }

      if (seatName == 'pt12') {
        pt12top = top;
        pt12left = left;
      }
      _setSeatLocation(
          listWidget, left, top, 'images/pt11_1004.png', i, screenPt07);
    } else if (seatName == 'pt09' ||
        seatName == 'pt10' ||
        seatName == 'pt05' ||
        seatName == 'pt20' ||
        seatName == 'pt06') {
      if (seatName == 'pt09') {
        pt09top = top;
        pt09left = left;
      }
      _setSeatLocation(
          listWidget, left, top, 'images/pt09_1004.png', i, screenPt09);
    } else if (seatName == 'pt01' || seatName == 'pt02') {
      _setSeatLocation(
          listWidget, left, top, 'images/pt02_1004.png', i, screenPt01);
    } else if (seatName == 'pt03' || seatName == 'pt04') {
      if (seatName == 'pt03') {
        pt03left = left;
        pt03top = top;
      }
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt04_1004.png", i, screenPt03);
    } else if (seatName == 'pt13') {
      pt13left = left;
      pt13top = top;
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt13_1004.png", i, screenPt13);
    } else if (seatName == 'pt14') {
      pt14left = left;
      pt14top = top;
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt14_1004.png", i, screenPt14);
    } else if (seatName == 'pt15') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt15_1004.png", i, screenPt15);
    } else if (seatName == 'pt18') {
      pt18left = left;
      pt18top = top;
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt18_1004.png", i, screenPt18);
    } else if (seatName == 'pt19') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt19_1004.png", i, screenPt19);
    } else if (seatName == 'pt21') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt21_1004.png", i, screenPt21);
    } else if (seatName == 'pt16') {
      pt16left = left;
      pt16top = top;
      _setSeatDeskLocation(
          listWidget, left, top, "images/pt16_1104.png", i, screenPt16);
    } else if (seatName == 'B01') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/desk_c_01_1004.png", i, screenSizeB);
    } else if (seatName == 'B02') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/desk_c_01_1004.png", i, screenSizeB);
    } else if (seatName == 'B03') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/desk_c_03_1004.png", i, screenSizeB);
    } else if (seatName == 'B04') {
      _setSeatDeskLocation(
          listWidget, left, top, "images/desk_c_03_1004.png", i, screenSizeB);
    } else if (seatName == 'A01') {
      bigLeft = left;
      bigTop = top;
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_01_1004.png", i, screenPt18);
    } else if (seatName == 'A02') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_02_1004.png", i, screenA02);
    } else if (seatName == 'A03') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_03_1004.png", i, screenA03);
    } else if (seatName == 'A04') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_04_1004.png", i, screenA04);
    } else if (seatName == 'A05') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_05_1004.png", i, screenA05);
    } else if (seatName == 'A06') {
      _setSeatLocation(
          listWidget, left, top, "images/desk_a_06_1004.png", i, screenA06);
    } else {
      _setSeatLocation(
          listWidget, left, top, 'images/desk_f_01_1004.png', i, screenA);
    }
  }

  var roundUrl = '';
  var index = -1;

  //圆桌子点击状态
  void _setSeatLocation(listWidget, left, top, imageUrl, i, screenWidth) {
    double width = ScreenUtil().setWidth(45) * screenWidth;
    bool isClick = true;
    isClick = (index == i) ? true : false;
    listWidget.add(Padding(
      padding: EdgeInsets.fromLTRB(left, top, 0, 0),
      child: InkWell(
        onTap: () {
          String clickAble = imageUrl.toString();
          if (clickAble.contains('1004') ||
              clickAble.contains('1104') ||
              clickAble.contains('1003') ||
              clickAble.contains('1103') ||
              clickAble.contains('1002') ||
              clickAble.contains('1102')) {
            print('当前座位:${clickSeatName = list.data[i].seatName}');
            Toast.show(context,'座位使用中不可预约!');
            return;
          } else {
            isClick = true;
            clickSeatName = list.data[i].seatName;
//            print("当前圆桌子的名字:${clickSeatName}");
            if (clickSeatName.contains('pt11') ||
                clickSeatName.contains('pt12') ||
                clickSeatName.contains('pt07') ||
                clickSeatName.contains('pt08')) {
              roundUrl = 'images/pt11_1002.png';
            } else if (clickSeatName.contains('pt09') ||
                clickSeatName.contains('pt10') ||
                clickSeatName.contains('pt05') ||
                clickSeatName.contains('pt06')) {
              roundUrl = 'images/pt09_1002.png';
            } else if (clickSeatName.contains('pt02') ||
                clickSeatName.contains('pt01')) {
              roundUrl = 'images/pt02_1002.png';
            } else if (clickSeatName.contains('pt03') ||
                clickSeatName.contains('pt04')) {
              roundUrl = 'images/pt04_1002.png';
              print('捕获到的图片:${roundUrl}');
            } else if (clickSeatName.contains('A02')) {
              roundUrl = 'images/desk_a_02_1002.png';
            } else if (clickSeatName.contains('A03')) {
              roundUrl = 'images/desk_a_03_1002.png';
            } else if (clickSeatName.contains('A04')) {
              roundUrl = 'images/desk_a_04_1002.png';
            } else if (clickSeatName.contains('A05')) {
              roundUrl = 'images/desk_a_05_1002.png';
            } else if (clickSeatName.contains('A06')) {
              roundUrl = 'images/desk_a_06_1002.png';
            } else {
              roundUrl = 'images/desk_f_01_1002.png';
            }
          }
          clickSeatName = list.data[i].seatName;
          Toast.show(context,'您选择了${clickSeatName.toString()}一个座位!');

          setState(() {
            clickSeatName;
            index = i;
          });
        },
        child: Image.asset(
          isClick ? roundUrl : imageUrl,
          width: width,
//          height: ScreenUtil().setHeight(43),
          fit: BoxFit.contain,
        ),
      ),
    ));
  }

//  var index = -1;
  var BCDUrl = '';

  //一般桌子点击状态
  void _setSeatDeskLocation(listWidget, left, top, imageUrl, i, screenSize) {
    bool isClick = true;
    isClick = (index == i) ? true : false;
//    print('index:${index},i:${i},isClick:${isClick}');
    listWidget.add(Padding(
      padding: EdgeInsets.fromLTRB(left, top, 0, 0),
      child: InkWell(
        onTap: () {
          String clickAble = imageUrl.toString();
          if (clickAble.contains('1004') ||
              clickAble.contains('1104') ||
              clickAble.contains('1003') ||
              clickAble.contains('1103') ||
              clickAble.contains('1002') ||
              clickAble.contains('1102')) {
            Toast.show(context,'座位使用中不可预约!');
            print('当前座位:${clickSeatName = list.data[i].seatName}');
            return;
          } else {
            isClick = true;
            clickSeatName = list.data[i].seatName;
//            print("当前位置的名字:${clickSeatName}");
            if (clickSeatName.contains('pt03') ||
                clickSeatName.contains('pt04')) {
              BCDUrl = 'images/pt04_1002.png';
            } else if (clickSeatName.contains('D02') ||
                clickSeatName.contains("D04")) {
              BCDUrl = 'images/desk_d_02_1002.png';
            } else if (clickSeatName.contains('C01') ||
                clickSeatName.contains("C02") ||
                clickSeatName.contains('B01') ||
                clickSeatName.contains("B02")) {
              BCDUrl = 'images/desk_c_01_1002.png';
            } else if (clickSeatName.contains('C03') ||
                clickSeatName.contains("C04") ||
                clickSeatName.contains('B03') ||
                clickSeatName.contains("B04")) {
              BCDUrl = 'images/desk_c_03_1002.png';
            }
          }
          clickSeatName = list.data[i].seatName;
          Toast.show(context,'您选择了${clickSeatName.toString()}一个座位!');

          setState(() {
            clickSeatName;
            index = i;
          });
        },
        child: Container(
          child: Image.asset(
            isClick ? BCDUrl : imageUrl,
            width: ScreenUtil().setWidth(73) * screenSize,
            height: ScreenUtil().setHeight(70) * screenSize,
            fit: BoxFit.contain,
          ),
        ),
      ),
    ));
  }

  //底部预定座位的状态信息
  Widget _bottomWorkInfo() {
    return Container(
      width: ScreenUtil().setWidth(1334),
      height: ScreenUtil().setHeight(180),
      color: Colors.white,
      child: Column(
        children: <Widget>[_bottomWorkFirst(), _bottomWorkSecond()],
      ),
    );
  }

  //底部信息栏，第一层布局
  Widget _bottomWorkFirst() {
    return Container(
      child: _seatState(),

//      Row(
//        children: <Widget>[
//          _bottomTempure(),
//          _bottomHumidity(),
//          _bottomPM(),
//          _bottomOcupy()
//        ],
//      ),
    );
  }

  //底部信息栏，第二层布局
  Widget _bottomWorkSecond() {
    Color isClick = button_normal_color;
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(40),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40), 0, 0, 0),
            child: Text('您选择的工位：'),
          ),
          Expanded(
            child: Text(
              clickSeatName,
              style: TextStyle(color: Colors.blue),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(254),
            height: ScreenUtil().setHeight(70),
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
            child: FlatButton(
              onPressed: () {
                isClick = button_click_color;
                int endTime = prefs.getInt('endTime');
                int startTime = prefs.getInt('startTime');
                var workName = {"name": clickSeatName};
                var workList = [workName];
                var formData = {
                  "endTime": endTime,
                  "seatList": workList,
                  "startTime": startTime
                };
                seatRequest(context, 'bookSeat', formData: formData)
                    .then((val) {
                  if (val['code'] == -4) {
//                    Toast.show(context,'登陆过期，请重新登陆!');
                    Navigator.of(context).pushAndRemoveUntil(
                        new MaterialPageRoute(
                            builder: (context) => LoginPage()),
                        (route) => route == null);
                  } else if (val['code'] == -1) {
                    Toast.show(context,val['msg']);
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrderSuccessPage()));
                    print('订单编号为:${val['data']['orderId']}');
                    prefs.setString('orderId', val['data']['orderId']);
                    prefs.setString('workName', clickSeatName);
                  }
                });
                setState(() {
                  isClick;
                  print('按钮边框的颜色:${isClick}');
                });
              },
              child: Text(
                '确认',
                style: TextStyle(fontSize: ScreenUtil().setSp(32)),
              ),
              color: button_normal_color,
              highlightColor: button_click_color,
              splashColor: Colors.transparent,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  //底部状态栏，温度状态
  Widget _bottomTempure() {
    return Expanded(
        flex: 1,
        child: Container(
          width: ScreenUtil().setWidth(50),
          height: ScreenUtil().setHeight(100),
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(50),
              bottom: ScreenUtil().setHeight(25)),
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/order_advance_temperature.png',
                width: 11,
                height: 21,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  '温度12C',
                  style: TextStyle(fontSize: 11, color: Color(0xff808080)),
                ),
              ),
            ],
          ),
        ));
  }

  //底部状态栏，湿度状态
  Widget _bottomHumidity() {
    return Expanded(
        flex: 1,
        child: Container(
          width: ScreenUtil().setWidth(50),
          height: ScreenUtil().setHeight(100),
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(50),
              bottom: ScreenUtil().setHeight(25)),
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/order_advance_humidity.png',
                width: 13,
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  '湿度75%',
                  style: TextStyle(fontSize: 11, color: Color(0xff808080)),
                ),
              ),
            ],
          ),
        ));
  }

  //底部状态栏，PM状态
  Widget _bottomPM() {
    return Expanded(
        flex: 1,
        child: Container(
          width: ScreenUtil().setWidth(50),
          height: ScreenUtil().setHeight(100),
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(50),
              bottom: ScreenUtil().setHeight(25)),
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/order_advance_pm.png',
                width: 19,
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Text(
                  'PM2.5 3ug/m3',
                  style: TextStyle(fontSize: 11, color: Color(0xff808080)),
                ),
              ),
            ],
          ),
        ));
  }

  //底部状态栏，座位占用率
  Widget _bottomOcupy() {
    return Expanded(
        flex: 1,
        child: Container(
          width: ScreenUtil().setWidth(50),
          height: ScreenUtil().setHeight(100),
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(50),
              bottom: ScreenUtil().setHeight(25)),
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/order_advance_ocupy.png',
                width: 19,
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  '占用 36%',
                  style: TextStyle(fontSize: 11, color: Color(0xff808080)),
                ),
              ),
            ],
          ),
        ));
  }
}
