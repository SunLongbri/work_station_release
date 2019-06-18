import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_station/design/full_text_button.dart';
import 'package:work_station/design/oval_text_button.dart';
import 'package:work_station/design/select_day_design.dart';
import 'package:work_station/design/set_calendar_lighting.dart';
import 'package:work_station/design/set_calendar_status.dart';

import '../../../colors.dart';

class LightingSetCalendarPage extends StatefulWidget {
  @override
  _LightingSetCalendarPageState createState() =>
      _LightingSetCalendarPageState();
}

class _LightingSetCalendarPageState extends State<LightingSetCalendarPage> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: work_station_prime_color,
        leading: _back(),
        title: Text(
          '设置日历',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(34),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: ScreenUtil().setWidth(750),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _selectTime(),
              _selectDay(),
              _selectSwitch(),
              _setStatus(),
              _button(),
            ],
          ),
        ),
      ),
    );
  }

  //选择日历的时间
  Widget _selectTime() {
    return Container(
      height: ScreenUtil().setHeight(342),
      width: ScreenUtil().setWidth(750),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //横向向左对齐
        children: <Widget>[
          _selectTimeTitle(),
          _selectTimeContent(),
        ],
      ),
    );
  }

  //选择时间的标题
  Widget _selectTimeTitle() {
    return Padding(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(30),
            top: ScreenUtil().setHeight(37),
            bottom: ScreenUtil().setHeight(42)),
        child: Text(
          '选择时间',
          style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(32),
              fontWeight: FontWeight.w500),
        ));
  }

  //选择时间的内容
  Widget _selectTimeContent() {
    return Container(
      width: ScreenUtil().setWidth(750),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _selectTimeStartContent(),
          Text(
            '到',
            style: TextStyle(
                color: Color(0xFFCCCDD0), fontSize: ScreenUtil().setSp(28)),
          ),
          _selectTimeEndContent(),
        ],
      ),
    );
  }

  //选择开始时间的内容
  Widget _selectTimeStartContent() {
    return Container(
      width: ScreenUtil().setWidth(200),
      height: ScreenUtil().setHeight(220),
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time, //日期时间模式，此处为时间模式
        onDateTimeChanged: (dateTime) {
          if (dateTime == null) {
            return;
          }
          print(
              '当前选择了：${dateTime.hour}时${dateTime.minute}分${dateTime.second}秒');
        },
        initialDateTime: DateTime.now(),
        use24hFormat: true, // 是否使用24小时格式，此处使用
      ),
    );
  }

  //选择开始时间的内容
  Widget _selectTimeEndContent() {
    return Container(
      width: ScreenUtil().setWidth(200),
      height: ScreenUtil().setHeight(220),
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time, //日期时间模式，此处为时间模式
        onDateTimeChanged: (dateTime) {
          if (dateTime == null) {
            return;
          }
          print(
              '当前选择了：${dateTime.hour}时${dateTime.minute}分${dateTime.second}秒');
        },
        initialDateTime: DateTime.now(),
        use24hFormat: true, // 是否使用24小时格式，此处使用
      ),
    );
  }

  //选择天数
  Widget _selectDay() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _selectDayTitle(),
          _selectDayContent(),
        ],
      ),
    );
  }

  //选择天数标题
  Widget _selectDayTitle() {
    return Container(
      width: ScreenUtil().setWidth(750),
      child: Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(29),
              bottom: ScreenUtil().setHeight(40)),
          child: Text(
            '重复日期',
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(32),
                fontWeight: FontWeight.w500),
          )),
    );
  }

  //选择天数中的内容
  Widget _selectDayContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SelectDayDesign('一'),
        SelectDayDesign('二'),
        SelectDayDesign('三'),
        SelectDayDesign('四'),
        SelectDayDesign('五'),
        SelectDayDesign('六'),
        SelectDayDesign('日'),
      ],
    );
  }

  //选择开关
  Widget _selectSwitch() {
    return Container(
      height: ScreenUtil().setHeight(550),
      width: ScreenUtil().setWidth(750),
      child: Column(
        children: <Widget>[
          _selectSwitchTitle(),
          _selectSwitchContent(),
        ],
      ),
    );
  }

  //选择开关的标题
  Widget _selectSwitchTitle() {
    return Container(
      width: ScreenUtil().setWidth(750),
      child: Padding(
        padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(54),
          left: ScreenUtil().setWidth(29),
        ),
        child: Text(
          '选择开关',
          style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(32),
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _selectSwitchContent() {
    return Container(
      height: ScreenUtil().setHeight(453),
      width: ScreenUtil().setWidth(750),
      child: Stack(children: <Widget>[
        //name1
        Align(
          alignment: FractionalOffset(0.25, 0.2),
          child: SetCalendarLighting('images/lighting_switch_on.png'),
        ),
        //name2
        Align(
          alignment: FractionalOffset(0.75, 0.2),
          child: SetCalendarLighting('images/lighting_switch_on.png'),
        ),
        //name3
        Align(
          alignment: FractionalOffset(0.25, 0.8),
          child: SetCalendarLighting('images/lighting_switch_on.png'),
        ),
        //name4
        Align(
          alignment: FractionalOffset(0.75, 0.8),
          child: SetCalendarLighting('images/lighting_switch_on.png'),
        ),
      ]),
    );
  }

  //设置状态
  Widget _setStatus() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(223),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _setStatusTitle(),
          _setStatusContent(),
        ],
      ),
    );
  }

  //设置状态标题栏
  Widget _setStatusTitle() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(29)),
      child: Text(
        '设置状态',
        style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(32),
            fontWeight: FontWeight.w600),
      ),
    );
  }

  //设置状态内容
  Widget _setStatusContent() {
    return Container(
      width: ScreenUtil().setWidth(750),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SetCalendarStatus('images/lighting_radio_on.png'),
        ],
      ),
    );
  }

  Widget _button() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          OvalTextButton(
            buttonWidth: ScreenUtil().setWidth(290),
            buttonHeight: ScreenUtil().setHeight(80),
            buttonMarginBottom: ScreenUtil().setHeight(40),
          ),
          FullTextButton(
            buttonWidth: ScreenUtil().setWidth(290),
            buttonHeight: ScreenUtil().setHeight(80),
            buttonMarginBottom: ScreenUtil().setHeight(40),
          ),
        ],
      ),
    );
  }

  Widget _back() {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        splashColor: Colors.transparent,
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
}
