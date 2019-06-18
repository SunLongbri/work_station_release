import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_station/colors.dart';
import 'package:work_station/helpclass/Toast.dart';
import 'package:work_station/model/AirStatusModel.dart';
import 'package:work_station/pages/index_page.dart';
import 'package:work_station/pages/login_page.dart';
import 'package:work_station/pages/menu/conditionmenu/condition_state_page.dart';
import 'package:work_station/service/service_method.dart';

class AirControlPage extends StatefulWidget {
  final deviceDesc;
  final floorName;
  final Temp_RM;
  final Temp_SP;
  final ModelStatus;
  final ON_OFFStatus;
  final controlBg;
  final deviceId;

  AirControlPage(this.deviceDesc, this.floorName, this.deviceId, this.Temp_RM,
      this.Temp_SP, this.ModelStatus, this.ON_OFFStatus, this.controlBg);

  @override
  _AirControlPageState createState() => _AirControlPageState();
}

class _AirControlPageState extends State<AirControlPage> {
  var topProgressHeight = ScreenUtil().setHeight(450);
  var topProgressWidth = ScreenUtil().setWidth(500);
  var btnUrl;

  var btnCoolUrl;
  var btnHotUrl;
  var btnWindUrl;
  var btnHumidityUrl;

  var btnClickCoolUrl;
  var btnClickHotUrl;
  var btnClickWindUrl;
  var btnClickHumidityUrl;

  //当前页面得主题颜色
  var primaryColor;

  //图标文字颜色
  var textCoolColor;
  var textHotColor;
  var textHumidifyColor;
  var textWindColor;

  //顶部背景颜色
  var topBg;

  var airOnOff;

  var tempSp = 'Temp_SP';
  var onOffControl = 'ON_OFFControl';
  var modeStatus = 'ModelStatus';

  int airMode;

  var mode;
  var tempRoom;
  var tempSetTem;
  var modelStatus;
  var mon_OFFStatus;
  var mControlBg;

  String btnName;

  @override
  void initState() {
    btnStatus = widget.ON_OFFStatus;
    isRefresh = true;
    num = 0;
    //页面上所展示的信息
    tempRoom = widget.Temp_RM;
    modelStatus = widget.ModelStatus;
    mon_OFFStatus = widget.ON_OFFStatus;
    mControlBg = widget.controlBg;
    tempSetTem = widget.Temp_SP;
    userOnTap = true;
    circleGetData();
    refreshPage();
    super.initState();
  }

  void refreshPage() {
    topBg = mControlBg;

    temp = int.parse(tempSetTem.toString().split('.')[0]);
    btnCoolUrl = 'images/air_control_click_cool.png';
    btnHotUrl = 'images/air_control_click_hot.png';
    btnWindUrl = 'images/air_control_click_wind.png';
    btnHumidityUrl = 'images/air_control_click_humidity.png';
    if (mon_OFFStatus.toString().contains('false')) {
      btnClickCoolUrl = 'images/air_control_close_click_cool.png';
      btnClickHotUrl = 'images/air_control_close_click_hot.png';
      btnClickWindUrl = 'images/air_control_close_click_wind.png';
      btnClickHumidityUrl = 'images/air_control_close_click_wind.png';
      btnName = '一键开启';
      primaryColor = air_close;
      mode = '关闭';
      airOnOff = 'false';
      topBg = 'images/air_control_close.png';
    } else if (mon_OFFStatus.toString().contains('true')) {
      btnName = '一键关闭';
      airOnOff = 'true';
      if (modelStatus.toString().contains('Heating')) {
        btnClickCoolUrl = 'images/air_control_hot_click_cool.png';
        btnClickHotUrl = 'images/air_control_hot_click_hot.png';
        btnClickWindUrl = 'images/air_control_hot_click_wind.png';
        btnClickHumidityUrl = 'images/air_control_hot_click_humidity.png';
        primaryColor = air_hot;
        mode = '制热';
        index = 1;
        textHotColor = primaryColor;
        topBg = 'images/air_control_topbg_hot.png';
      } else if (modelStatus.toString().contains('Cooling')) {
        btnClickCoolUrl = 'images/air_control_cool_click_cool.png';
        btnClickHotUrl = 'images/air_control_cool_click_hot.png';
        btnClickWindUrl = 'images/air_control_cool_click_wind.png';
        btnClickHumidityUrl = 'images/air_control_cool_click_humidity.png';
        primaryColor = air_cool;
        mode = '制冷';
        index = 0;
        textCoolColor = primaryColor;
        topBg = 'images/air_control_topbg_cool.png';
      } else if (modelStatus.toString().contains('Air')) {
        btnClickCoolUrl = 'images/air_control_wind_click_cool.png';
        btnClickHotUrl = 'images/air_control_wind_click_hot.png';
        btnClickWindUrl = 'images/air_control_wind_click_wind.png';
        btnClickHumidityUrl = 'images/air_control_wind_click_humidity.png';
        primaryColor = air_wind;
        mode = '通风';
        index = 3;
        textWindColor = primaryColor;
        topBg = 'images/air_control_topbg_wind.png';
      } else if (modelStatus.toString().contains('Humidity')) {
        btnClickCoolUrl = 'images/air_control_humidity_click_cool.png';
        btnClickHotUrl = 'images/air_control_humidity_click_hot.png';
        btnClickWindUrl = 'images/air_control_humidity_click_wind.png';
        btnClickHumidityUrl = 'images/air_control_humidity_click_humidity.png';
        primaryColor = air_humidity;
        mode = '除湿';
        index = 2;
        textHumidifyColor = primaryColor;
        topBg = 'images/air_control_topbg_humidity.png';
      }
    }
    if (index == 0) {
      textWindColor = air_grey;
      textHotColor = air_grey;
      textHumidifyColor = air_grey;
      textCoolColor = primaryColor;
    } else if (index == 1) {
      textWindColor = air_grey;
      textHotColor = primaryColor;
      textHumidifyColor = air_grey;
      textCoolColor = air_grey;
    } else if (index == 2) {
      textWindColor = air_grey;
      textHotColor = air_grey;
      textHumidifyColor = primaryColor;
      textCoolColor = air_grey;
    } else if (index == 3) {
      textWindColor = primaryColor;
      textHotColor = air_grey;
      textHumidifyColor = air_grey;
      textCoolColor = air_grey;
    } else {
      textCoolColor = air_grey;
      textHotColor = air_grey;
      textHumidifyColor = air_grey;
      textWindColor = air_grey;
    }
  }

  bool isRefresh;
  bool userOnTap;

  Future circleGetData() async {
    while (true && isRefresh) {
      // 一秒以后将任务添加至event队列
      await Future.delayed(const Duration(seconds: 10), () {
        //任务具体代码
        if (userOnTap = false) {
          getAirStatus('空调模式刷新成功');
        }
        userOnTap = true;
      });
    }
  }

  int num;

  List currentList;

  //开关原来的状态
  String btnStatus;

  //获取空调信息
  Future getAirStatus(message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('counter');
//    print('getAirStatus的token：${token.toString()}');
    getUserInfo(context, 'getAirStatus', token).then((val) {
//      print('获取到的参数为:${val}');
      if (val == null) {
        Toast.show(context, '联网超时');
        num++;
        if (num == 5) {
          Toast.show(context, '网络已断开，请连接网络后登录!');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => IndexPage()),
              (route) => route == null);
        }
        return;
      } else if (val['msg'].toString().contains('异常')) {
        Toast.show(context, '登录异常，请重新登录!');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => IndexPage()),
            (route) => route == null);
      }
      AirStatusModelList airStatusModelList =
          AirStatusModelList.fromJson(val['data']);
      currentList = airStatusModelList.list;
      for (int i = 0; i < currentList.length; i++) {
        if (currentList[i].deviceDesc == widget.deviceDesc) {
          print('当前刷新的房间为:${currentList[i].deviceDesc}');
          //房间名称
          String mDeviceDesc = currentList[i].deviceDesc;
          //第几层
          String mFloorName = currentList[i].floorName;
          //室内温度
          String mTemp_RM = currentList[i].tempRM;
          //室内设定温度
          String mTemp_SP = currentList[i].tempSP;
          //当前空调运转模式
          String mModelStatus = currentList[i].modelStatus;
          //空调开关
          String mON_OFFStatus = currentList[i].oNOFFStatus;
          //空调的Id
          String mDeviceId = currentList[i].deivceId;
          if (mDeviceDesc.contains(widget.deviceDesc) &&
              (
//                  !mTemp_RM.contains(widget.Temp_RM) ||
                  !mModelStatus.contains(widget.ModelStatus) ||
                      !mON_OFFStatus.contains(btnStatus))) {
            tempRoom = mTemp_RM;
            modelStatus = mModelStatus;
            mon_OFFStatus = mON_OFFStatus;
            tempSetTem = mTemp_SP;
            refreshPage();

            print(
                '原温度:${widget.Temp_RM},当前温度:${mTemp_RM},设定温度:${!mTemp_RM.contains(widget.Temp_RM)},空调模式:${!mModelStatus.contains(widget.ModelStatus)},空调开关:${!mON_OFFStatus.contains(widget.ON_OFFStatus)}');
            setState(() {
              //更新top背景色
              topBg;
              //更改室内温度的进度条
              tempSetTem;
              btnName;
              btnClickCoolUrl;
              btnClickHotUrl;
              btnClickWindUrl;
              btnClickHumidityUrl;
              primaryColor;
              textCoolColor;
              textHotColor;
              textHumidifyColor;
              textWindColor;
              index;
            });

            if (!mON_OFFStatus.contains(btnStatus)) {
              print('开关原来的状态:${btnStatus},开关当前的状态:${mON_OFFStatus}');
              setState(() {
                //用户控制空调开关是否成功判断
                selectFlag = false;
                _saving = false;
                btnStatus = mON_OFFStatus;
                refreshPage();
              });
              Toast.show(context, message);
            }
          }
        }
      }
//      airStatusModelList.list
//          .forEach(if(item.deviceDesc == widget.deviceDesc){}(item) => print('遍历解析到空调的数据名为：${item.deviceDesc}'));
    });
    setState(() {
      currentList;
    });
  }

  //设置空调值
  void setAirStatus() {
    var formData = {
      "attrName": "in",
      "attrValue": "${temp}",
      "floorName": "${widget.floorName}",
      "pointName": "${tempSp}${widget.deviceId}"
    };
    seatRequest(context, 'setAirStatus', formData: formData).then((val) {
      print('设置空调值返回状态:${val.toString()}');
      if (val['msg'].toString().contains('异常')) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => route = null);
        Toast.show(context, '登录过期');
      }
      Toast.show(context, '${val['msg']}');
    });
  }

  //设置空调开关
  void setAirOnOff() {
    var formData = {
      "attrName": "in",
      "attrValue": "${airOnOff}",
      "floorName": "${widget.floorName}",
      "pointName": "${onOffControl}${widget.deviceId}"
    };

    seatRequest(context, 'setAirStatus', formData: formData).then((val) {
      print('设置空调值返回状态:${val.toString()}');
      if (val['msg'].toString().contains('异常')) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => route = null);
      }
      Toast.show(context, '正在设置,请稍后 ... ');

      _saving = true;
      setState(() {
        _saving;
      });
      selectStatus();
//      Toast.show(context, '${val['msg']}');
    });
  }

  bool selectFlag = true;
  int selectNumb = 0;
  bool _saving = false;

  void selectStatus() async {
    while (selectFlag) {
      await Future.delayed(Duration(seconds: 3), () {
        print('每三秒开始反查数据 ...第${selectNumb}次 ');
        if (selectNumb > 5) {
          selectFlag = false;
          _saving = false;
          setState(() {
            selectFlag = false;
            _saving = false;
          });
          Toast.show(context, '空调设置失败');
          return;
        }

        getAirStatus('设置空调成功');
        selectNumb++;
      });
    }
  }

  //设置空调模式  0-Air ,1-Heating, Cooling-2, Dehumi-7
  void setAirMode() {
    var formData = {
      "attrName": "in",
      "attrValue": "${airMode}",
      "floorName": "${widget.floorName}",
      "pointName": "${modeStatus}${widget.deviceId}"
    };
    seatRequest(context, 'setAirStatus', formData: formData).then((val) {
      print('设置空调模式值返回状态:${val.toString()}');
      if (val['msg'].toString().contains('异常')) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => route = null);
      }
      Toast.show(context, '${val['msg']}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: ModalProgressHUD(
            progressIndicator: CircularProgressIndicator(backgroundColor: air_hot,),

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _TopArea(),
                  _ControlArea(),
                ],
              ),
            ),
            inAsyncCall: _saving,
          ),
        ),
        onWillPop: () {
          isRefresh = false;
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ConditionStatePage()));
        });
  }

  Widget _ControlArea() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(87)),
      child: Column(
        children: <Widget>[
          _controlMode(),
          _controlBtn(),
        ],
      ),
    );
  }

  Widget _controlBtn() {
    Color isClick = primaryColor;

    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(85),
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(91),
          left: ScreenUtil().setWidth(100),
          right: ScreenUtil().setWidth(100)),
      child: FlatButton(
        onPressed: () {
          if (airOnOff.toString().contains('false')) {
            airOnOff = 'true';
//            btnName = '一键关闭';
//            primaryColor = air_wind;
            userOnTap = false;
//            mode = '${modelStatus}';
//            if (mode.toString().contains('Air')) {
//              btnClickCoolUrl = 'images/air_control_wind_click_cool.png';
//              btnClickHotUrl = 'images/air_control_wind_click_hot.png';
//              btnClickWindUrl = 'images/air_control_wind_click_wind.png';
//              btnClickHumidityUrl =
//                  'images/air_control_wind_click_humidity.png';
//              primaryColor = air_wind;
//              mode = '通风';
//              index = 3;
//              topBg = 'images/air_control_topbg_wind.png';
//            } else if (mode.toString().contains('Heating')) {
//              btnClickCoolUrl = 'images/air_control_hot_click_cool.png';
//              btnClickHotUrl = 'images/air_control_hot_click_hot.png';
//              btnClickWindUrl = 'images/air_control_hot_click_wind.png';
//              btnClickHumidityUrl = 'images/air_control_hot_click_humidity.png';
//              primaryColor = air_hot;
//              mode = '制热';
//              index = 1;
//              textHotColor = primaryColor;
//              topBg = 'images/air_control_topbg_hot.png';
//            } else if (mode.toString().contains('Cooling')) {
//              btnClickCoolUrl = 'images/air_control_cool_click_cool.png';
//              btnClickHotUrl = 'images/air_control_cool_click_hot.png';
//              btnClickWindUrl = 'images/air_control_cool_click_wind.png';
//              btnClickHumidityUrl =
//                  'images/air_control_cool_click_humidity.png';
//              primaryColor = air_cool;
//              mode = '制冷';
//              index = 0;
//              topBg = 'images/air_control_topbg_cool.png';
//            } else if (mode.toString().contains('Humidity')) {
//              btnClickCoolUrl = 'images/air_control_humidity_click_cool.png';
//              btnClickHotUrl = 'images/air_control_humidity_click_wind.png';
//              btnClickWindUrl = 'images/air_control_humidity_click_wind.png';
//              btnClickHumidityUrl = 'images/air_control_humidity_click_hot.png';
//              primaryColor = air_humidity;
//              mode = '除湿';
//              index = 2;
//              textHumidifyColor = primaryColor;
//              topBg = 'images/air_control_topbg_humidity.png';
//            }
//
//            if (index == 0) {
//              textWindColor = air_grey;
//              textHotColor = air_grey;
//              textHumidifyColor = air_grey;
//              textCoolColor = primaryColor;
//            } else if (index == 1) {
//              textWindColor = air_grey;
//              textHotColor = primaryColor;
//              textHumidifyColor = air_grey;
//              textCoolColor = air_grey;
//            } else if (index == 2) {
//              textWindColor = air_grey;
//              textHotColor = air_grey;
//              textHumidifyColor = primaryColor;
//              textCoolColor = air_grey;
//            } else if (index == 3) {
//              textWindColor = primaryColor;
//              textHotColor = air_grey;
//              textHumidifyColor = air_grey;
//              textCoolColor = air_grey;
//            }
          } else if (airOnOff.toString().contains('true')) {
            airOnOff = 'false';
//            btnName = '一键开启';
//            primaryColor = air_close;
//            topBg = 'images/air_control_close.png';
            userOnTap = false;
//            mode = '关闭';

//            btnClickCoolUrl = 'images/air_control_close_click_cool.png';
//            btnClickHotUrl = 'images/air_control_close_click_hot.png';
//            btnClickWindUrl = 'images/air_control_close_click_wind.png';
//            btnClickHumidityUrl = 'images/air_control_close_click_wind.png';

//            if (index == 0) {
//              textWindColor = air_grey;
//              textHotColor = air_grey;
//              textHumidifyColor = air_grey;
//              textCoolColor = primaryColor;
//            } else if (index == 1) {
//              textWindColor = air_grey;
//              textHotColor = primaryColor;
//              textHumidifyColor = air_grey;
//              textCoolColor = air_grey;
//            } else if (index == 2) {
//              textWindColor = air_grey;
//              textHotColor = air_grey;
//              textHumidifyColor = primaryColor;
//              textCoolColor = air_grey;
//            } else if (index == 3) {
//              textWindColor = primaryColor;
//              textHotColor = air_grey;
//              textHumidifyColor = air_grey;
//              textCoolColor = air_grey;
//            }
          }

          isClick = Color(0xFFc9c7c7);
          setState(() {
            selectNumb = 0;
            selectFlag = true;
//            btnName;
            isClick;
//            topBg;
//            primaryColor;

//            btnClickCoolUrl;
//            btnClickHotUrl;
//            btnClickWindUrl;
//            btnClickHumidityUrl;
//
//            textWindColor;
//            textHotColor;
//            textHumidifyColor;
//            textCoolColor;
            print('按钮边框的颜色:${isClick}');
          });
          setAirOnOff();
        },
        child: Text(
          btnName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(38),
              color: Colors.white,
              fontWeight: FontWeight.w400),
        ),
//        color: button_normal_color,
        color: primaryColor,
//        highlightColor: button_click_color,
        highlightColor: air_close,
        splashColor: Colors.transparent,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(25)),
      ),
    );
  }

  Widget _controlMode() {
    return Container(
      width: ScreenUtil().setWidth(750),
      child: Row(
        children: generateIconList(),
      ),
    );
  }

  List<Widget> generateIconList() {
    List<Widget> listWidget = [];
    for (int i = 0; i < 4; i++) {
      _judgeState(listWidget, i);
    }
    return listWidget;
  }

  var index = -1;
  var imageUrl = 'images/air_control_cool_click_cool.png';

  void _judgeState(listWidget, i) async {
    bool isClick = false;
    isClick = (index == i) ? true : false;
//    print('isClick:${isClick}');
    if (i == 0) {
      listWidget.add(Expanded(
          flex: 1,
          child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                //todo:这里将点击事件禁止了
                return;
                airMode = 2;
//                setAirMode();

                setState(() {
                  index = i;
                  textCoolColor = primaryColor;
                  textHotColor = air_close;
                  textHumidifyColor = air_close;
                  textWindColor = air_close;
                  airMode;
                });
              },
              child: Column(
                children: <Widget>[
                  Image.asset(
                    isClick ? btnClickCoolUrl : btnCoolUrl,
                    width: ScreenUtil().setWidth(120),
                    height: ScreenUtil().setHeight(99),
                    fit: BoxFit.fitHeight,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(7),
                    ),
                    child: Text(
                      '制冷',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          color: textCoolColor),
                    ),
                  ),
                ],
              ))));
    } else if (i == 1) {
      listWidget.add(Expanded(
          flex: 1,
          child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                //todo:这里将点击事件禁止了
                return;
                airMode = 1;
                setAirMode();
                setState(() {
                  index = i;
                  airMode;
                  textHotColor = primaryColor;
                  textCoolColor = air_close;
                  textHumidifyColor = air_close;
                  textWindColor = air_close;
                });
              },
              child: Column(
                children: <Widget>[
                  Image.asset(
                    isClick ? btnClickHotUrl : btnHotUrl,
                    width: ScreenUtil().setWidth(120),
                    height: ScreenUtil().setHeight(99),
                    fit: BoxFit.fitHeight,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(7),
                    ),
                    child: Text(
                      '制热',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          color: textHotColor),
                    ),
                  ),
                ],
              ))));
    } else if (i == 2) {
      listWidget.add(Expanded(
          flex: 1,
          child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                //todo:这里将点击事件禁止了
                return;
                airMode = 0;
                setAirMode();
                setState(() {
                  index = i;
                  airMode;
                  textHumidifyColor = primaryColor;
                  textCoolColor = air_close;
                  textHotColor = air_close;
                  textWindColor = air_close;
                });
              },
              child: Column(
                children: <Widget>[
                  Image.asset(
                    isClick ? btnClickHumidityUrl : btnHumidityUrl,
                    width: ScreenUtil().setWidth(120),
                    height: ScreenUtil().setHeight(99),
                    fit: BoxFit.fitHeight,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(7),
                    ),
                    child: Text(
                      '除湿',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          color: textHumidifyColor),
                    ),
                  ),
                ],
              ))));
    } else if (i == 3) {
      listWidget.add(Expanded(
          flex: 1,
          child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                //todo:这里将点击事件禁止了
                return;
                airMode = 0;
                setAirMode();
                setState(() {
                  index = i;
                  airMode;
                  //设置字体颜色
                  textWindColor = primaryColor;
                  textCoolColor = air_close;
                  textHotColor = air_close;
                  textHumidifyColor = air_close;
                });
              },
              child: Column(
                children: <Widget>[
                  Image.asset(
                    isClick ? btnClickWindUrl : btnWindUrl,
                    width: ScreenUtil().setWidth(120),
                    height: ScreenUtil().setHeight(99),
                    fit: BoxFit.fitHeight,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(7),
                    ),
                    child: Text(
                      '通风',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          color: textWindColor),
                    ),
                  ),
                ],
              ))));
    }
    setState(() {
      listWidget;
    });
  }

  Widget _TopArea() {
    return Stack(
      children: <Widget>[
        _topBg(),
        _title(),
        _progressZero(),
//        _progressFull(),
        _currentTemperature(),
        _controlTemp(),
        _airMode(),
        _showText(),
      ],
    );
  }

  Widget _back() {
    return InkWell(
        onTap: () {
          isRefresh = false;
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ConditionStatePage()));
        },
        child: Container(
          margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(40), top: ScreenUtil().setHeight(30)),
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

  Widget _title() {
    return Container(
      color: Colors.transparent,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      child: Row(
        children: <Widget>[
          _back(),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(35)),
              alignment: Alignment.center,
              child: Text(
                '${widget.deviceDesc}    ',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(50)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///todo:当前温度范围16 ---> 32度
  Widget _showText() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(450),
              left: ScreenUtil().setWidth(110)),
          child: Text(
            '冷',
            style: TextStyle(color: Colors.white),
          ),
        ),
//        Padding(
//          padding: EdgeInsets.only(
//              top: ScreenUtil().setHeight(230),
//              left: ScreenUtil().setWidth(330)),
//          child: Text(
//            '舒适',
//            style: TextStyle(color: Colors.white),
//          ),
//        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(450),
              left: ScreenUtil().setWidth(600)),
          child: Text(
            '热',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  //顶部背景色
  Widget _topBg() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(890),
      child: Image.asset(
        topBg,
        fit: BoxFit.fill,
      ),
    );
  }

  var progressURL = 'images/air_control_progress_zero.png';

  Widget _progressZero() {
    String temRm = tempRoom.toString().split('.')[0];
    if (temRm.contains('15')) {
      progressURL = 'images/air_control_progress15.png';
    } else if (temRm.toString().contains('16')) {
      progressURL = 'images/air_control_progress16.png';
    } else if (temRm.toString().contains('17')) {
      progressURL = 'images/air_control_progress17.png';
    } else if (temRm.toString().contains('18')) {
      progressURL = 'images/air_control_progress18.png';
    } else if (temRm.toString().contains('19')) {
      progressURL = 'images/air_control_progress19.png';
    } else if (temRm.toString().contains('20')) {
      progressURL = 'images/air_control_progress20.png';
    } else if (temRm.toString().contains('21')) {
      progressURL = 'images/air_control_progress21.png';
    } else if (temRm.toString().contains('22')) {
      progressURL = 'images/air_control_progress22.png';
    } else if (temRm.toString().contains('23')) {
      progressURL = 'images/air_control_progress23.png';
    } else if (temRm.toString().contains('24')) {
      progressURL = 'images/air_control_progress24.png';
    } else if (temRm.toString().contains('25')) {
      progressURL = 'images/air_control_progress25.png';
    } else if (temRm.toString().contains('26')) {
      progressURL = 'images/air_control_progress26.png';
    } else if (temRm.toString().contains('27')) {
      progressURL = 'images/air_control_progress27.png';
    } else if (temRm.toString().contains('28')) {
      progressURL = 'images/air_control_progress28.png';
    } else if (temRm.toString().contains('29')) {
      progressURL = 'images/air_control_progress29.png';
    } else if (temRm.toString().contains('30')) {
      progressURL = 'images/air_control_progress30.png';
    }

    return Container(
//      color:Colors.grey,
      width: topProgressWidth,
      height: topProgressHeight,
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(220), left: ScreenUtil().setWidth(125)),

      child: Image.asset(
        progressURL,
      ),
    );
  }

  var temp;

  Widget _currentTemperature() {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(420), left: ScreenUtil().setWidth(300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '${widget.Temp_RM.toString().split('.')[0]}',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(90)),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                child: Text(
                  'ºC',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(50)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _controlTemp() {
    return Container(
      width: ScreenUtil().setWidth(500),
      height: ScreenUtil().setHeight(70),
      margin: EdgeInsets.only(
        left: ScreenUtil().setWidth(140),
        top: ScreenUtil().setHeight(660),
      ),
      child: Row(
        children: <Widget>[
          _reduceProgress(),
          _addShowTemperature(),
          _addProgress(),
        ],
      ),
    );
  }

  Widget _reduceProgress() {
    return Container(
      child: InkWell(
        onTap: () {
          print('用户点击了减号');
          if (temp <= 15) {
            Toast.show(context, '已经到最小值了!');
            return;
          }
          temp = temp - 1;
          setAirStatus();
          setState(() {
            temp;
          });
        },
        child: CircleAvatar(
          child: Image.asset(
            'images/air_control_reduce_progress.png',
            width: ScreenUtil().setWidth(50),
            height: ScreenUtil().setHeight(66),
          ),
          radius: 30.0,
          foregroundColor: Colors.transparent,
          backgroundColor: Color(0x5fffffff),
        ),
      ),
    );
  }

  Widget _addProgress() {
    return Container(
      child: InkWell(
        onTap: () {
          print('用户点击了加号');
          if (temp >= 30) {
            Toast.show(context, '已经到最大值了!');
            return;
          }
          temp = temp + 1;

          setAirStatus();
          setState(() {
            temp;
            print('当前temp:${temp}');
          });
        },
        child: CircleAvatar(
          child: Image.asset(
            'images/air_control_add_progress.png',
            width: ScreenUtil().setWidth(40),
            height: ScreenUtil().setHeight(40),
          ),
          radius: 30.0,
          foregroundColor: Colors.transparent,
          backgroundColor: Color(0x5fffffff),
        ),
      ),
    );
  }

  Widget _addShowTemperature() {
    return Container(
      child: Container(
        width: ScreenUtil().setWidth(250),
        height: ScreenUtil().setHeight(60),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(70)),
              child: Text(
                '${temp}',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(60)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
              child: Text(
                'ºC',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(40)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _airMode() {
    return Container(
        margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(280), top: ScreenUtil().setHeight(510)),
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: ScreenUtil().setWidth(194),
            height: ScreenUtil().setHeight(41),
            alignment: Alignment.center,
            child: Text(
              '${mode}',
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(24)),
            ),
          ),
          borderRadius: BorderRadius.circular(20.0),
        ));
  }
}
