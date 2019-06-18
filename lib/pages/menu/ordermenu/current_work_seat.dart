import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_station/helpclass/Toast.dart';
import 'package:work_station/helpclass/Utils.dart';
import 'package:work_station/model/CurrentWorkModel.dart';
import 'package:work_station/model/LightingModel.dart';
import 'package:work_station/model/ParseSeatModel.dart';
import 'package:work_station/service/service_method.dart';

class CurrentWorkSeat extends StatefulWidget {
  @override
  _CurrentWorkSeatState createState() => _CurrentWorkSeatState();
}

class _CurrentWorkSeatState extends State<CurrentWorkSeat> {
  List currentList;

  Future getCurrentWorkSeat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('counter');
    await getUserInfo(context, 'currentWorkSeat', token).then((val) {
      if (val == null) {
//        Toast.show(context, '数据访问连接超时,正在重新请求 ... ');
        getUserInfo(context, 'currentWorkSeat', token).then((val) {
          if (val['code'] == 0) {
            print('每五秒开始执行刷新任务 ....... ');
            CurrentWorkModelList currentWorkModelList =
                CurrentWorkModelList.fromJson(val['data']);
            currentList = currentWorkModelList.list;
          }
        });
      } else {
        print('空间页面获取到的数据为：${val.toString()}');
        if (val['code'] == 0) {
          print('每五秒开始执行刷新任务 ....... ');
          CurrentWorkModelList currentWorkModelList =
              CurrentWorkModelList.fromJson(val['data']);
          currentList = currentWorkModelList.list;
        }
      }
//      currentWorkModelList.list
//          .forEach((item) => print('空间页面解析到的数据为：${item.name}'));
    });
    setState(() {
      currentList;
    });
  }

  Future getLightingWorkSeat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('count');
    var formData = {"floorId": 4};
    seatRequest(context, 'lightingWorkSeat', formData: formData).then((val) {
//      print('空间页面获取到的数据为：${val.toString()}');

      PersonPoint personPoint =
          PersonPoint.fromJson(val['extend']['F4']['personPoint']);
      print('解析到的pt01的数据为:${personPoint.pt01}');

      Map<String, dynamic> data =
          PersonPoint.fromJson(val['extend']['F4']['personPoint']).toJson();
      String pt01 = data['pt01'];
      print('解析到的pt01的数据为:${pt01}');
    });
  }

  Future circleGetData() async {
    while (isRefresh) {
      // 一秒以后将任务添加至event队列
      await Future.delayed(const Duration(seconds: 10), () {
        //任务具体代码
        getCurrentWorkSeat();
      });
    }
  }

  bool isRefresh;

  @override
  void initState() {
    isRefresh = true;
    getCurrentWorkSeat();
    //循环请求数据
//    circleGetData();
//    setAirStatus();
    super.initState();
  }

  @override
  void dispose() {
    isRefresh = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('空间'),
        elevation: 0,
        centerTitle: true,
        //去掉返回按钮
        leading: Text(''),
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

  int endTime = 0;
  int startTime = 0;
  ParseSeatModelListModel list;
  SharedPreferences prefs;
  bool refreshFlag = true; //true表示刷新，false表示不刷新
  double screenSize = 0.5;

  //当前预定的状态信息
  Widget _orderInfo() {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(1010),
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
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(120), top: 400),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Toast.show(context,'请进入预约界面进行预约');
        },
        child: Image.asset(
          'images/small_desk_all.png',
          width: ScreenUtil().setWidth(200),
          height: ScreenUtil().setHeight(200),
          fit: BoxFit.contain,
        ),
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
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
//        GenderChooseDialog();
        Toast.show(context,'请进入预约界面进行预约');
      },
      child: Container(
        margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(470),
          top: ScreenUtil().setHeight(400),
        ),
        child: Image.asset(
          'images/big_desk_all.png',
          width: ScreenUtil().setWidth(220),
          height: ScreenUtil().setHeight(220),
        ),
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
                '空闲',
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
                    '未知状态',
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
      children: generateWorkSeatList(currentList),
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
//      getCurrentWorkSeat();
      return listWidget;
    }
//    circleGetData();
    for (int i = 0; i < list.length; i++) {
      double top = list[i].seatY * 1.0;
      double left = list[i].seatX * 1.0;

      int statusCode = list[i].status;
      String seatName = list[i].name;

      if (statusCode == 0) {
        _judgeSeatState(seatName, listWidget, left, top, i);
      } else if (statusCode == 1) {
        _judgeSeatGrayState(seatName, listWidget, left, top, i);
      } else if (statusCode == 2) {
        _judgeSeatYellowState(seatName, listWidget, left, top, i);
      } else if (statusCode == 5) {
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
      _setSeatLocation(
          listWidget, left, top, 'images/pt04_1001.png', i, screenPt03);
//      _setSeatDeskLocation(
//          listWidget, left, top, "images/pt04_1001.png", i, screenPt03);
    } else if (seatName == 'pt13') {
      pt13top = top;
      pt13left = left;
//      _setSeatDeskLocation(
//          listWidget, left, top, "images/pt13_1001.png", i, screenPt13);
    } else if (seatName == 'pt14') {
      pt14left = left;
      pt14top = top;
//      _setSeatDeskLocation(
//          listWidget, left, top, "images/pt14_1001.png", i, screenPt14);
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
  double screenPt03 = 1.1;
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
      _setSeatLocation(
          listWidget, left, top, 'images/pt04_1002.png', i, screenPt03);
    } else if (seatName == 'pt13') {
      pt13top = top;
      pt13left = left;
    } else if (seatName == 'pt14') {
      pt14left = left;
      pt14top = top;
    } else if (seatName == 'pt15') {
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
      _setSeatLocation(
          listWidget, left, top, 'images/pt04_1003.png', i, screenPt01);
    } else if (seatName == 'pt13') {
      pt13top = top;
      pt13left = left;
    } else if (seatName == 'pt14') {
      pt14left = left;
      pt14top = top;
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
      _setSeatLocation(
          listWidget, left, top, 'images/pt04_1004.png', i, screenPt01);
    } else if (seatName == 'pt13') {
      pt13left = left;
      pt13top = top;
    } else if (seatName == 'pt14') {
      pt14left = left;
      pt14top = top;
    } else if (seatName == 'pt15') {
    } else if (seatName == 'pt18') {
      pt18left = left;
      pt18top = top;
    } else if (seatName == 'pt16') {
      pt16left = left;
      pt16top = top;
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
//            Toast.show(context, '抱歉，当前座位不可预约!');
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
          Toast.show(context, '您选择了${clickSeatName.toString()}一个座位!');

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

  //底部预定座位的状态信息
  Widget _bottomWorkInfo() {
    return Container(
      width: ScreenUtil().setWidth(1334),
      height: ScreenUtil().setHeight(70),
      color: Colors.white,
      child: Column(
        children: <Widget>[_bottomWorkFirst()],
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

//一般桌子点击状态
//  void _setSeatDeskLocation(listWidget, left, top, imageUrl, i, screenSize) {
//    bool isClick = true;
//    isClick = (index == i) ? true : false;
////    print('index:${index},i:${i},isClick:${isClick}');
//    listWidget.add(Padding(
//      padding: EdgeInsets.fromLTRB(left, top, 0, 0),
//      child: InkWell(
//        onTap: () {
//          String clickAble = imageUrl.toString();
//          if (clickAble.contains('1004') ||
//              clickAble.contains('1104') ||
//              clickAble.contains('1003') ||
//              clickAble.contains('1103') ||
//              clickAble.contains('1002') ||
//              clickAble.contains('1102')) {
//            Toast.show(context, '抱歉，当前座位不可预约!');
//            print('当前座位:${clickSeatName = list.data[i].seatName}');
//            return;
//          } else {
//            isClick = true;
//            clickSeatName = list.data[i].seatName;
////            print("当前位置的名字:${clickSeatName}");
//            if (clickSeatName.contains('pt03') ||
//                clickSeatName.contains('pt04')) {
//              BCDUrl = 'images/pt04_1002.png';
//            } else if (clickSeatName.contains('D02') ||
//                clickSeatName.contains("D04")) {
//              BCDUrl = 'images/desk_d_02_1002.png';
//            } else if (clickSeatName.contains('C01') ||
//                clickSeatName.contains("C02") ||
//                clickSeatName.contains('B01') ||
//                clickSeatName.contains("B02")) {
//              BCDUrl = 'images/desk_c_01_1002.png';
//            } else if (clickSeatName.contains('C03') ||
//                clickSeatName.contains("C04") ||
//                clickSeatName.contains('B03') ||
//                clickSeatName.contains("B04")) {
//              BCDUrl = 'images/desk_c_03_1002.png';
//            }
//          }
//          clickSeatName = list.data[i].seatName;
//          Toast.show(context, '您选择了${clickSeatName.toString()}一个座位!');
//
//          setState(() {
//            clickSeatName;
//            index = i;
//          });
//        },
//        child: Container(
//          child: Image.asset(
//            isClick ? BCDUrl : imageUrl,
//            width: ScreenUtil().setWidth(73) * screenSize,
//            height: ScreenUtil().setHeight(70) * screenSize,
//            fit: BoxFit.contain,
//          ),
//        ),
//      ),
//    ));
//  }

}
