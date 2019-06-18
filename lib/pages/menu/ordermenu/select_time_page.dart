import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_seekbar/flutter_seekbar.dart'
    show ProgressValue, SectionTextModel, SeekBar;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:work_station/colors.dart';
import 'package:work_station/helpclass/Toast.dart';
import 'package:work_station/pages/index_page.dart';
import 'package:work_station/pages/login_page.dart';
import 'package:work_station/pages/menu/ordermenu/order_advance_page.dart';
import 'package:work_station/service/service_method.dart';

//https://github.com/aleksanderwozniak/table_calendar/blob/master/example/lib/main.dart
class SelectTimePage extends StatefulWidget {
  @override
  _SelectTimePageState createState() => _SelectTimePageState();
}

class _SelectTimePageState extends State<SelectTimePage>
    with TickerProviderStateMixin {
  DateTime _selectedDay;
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _controller;
  SharedPreferences prefs;

  //-----------------Drag-------------------------
  List<SectionTextModel> sectionTexts = [];
  double v = 0;
  String userSelectDay = '';
  String selectYear = '';
  String selectMonth = '';
  String selectDay = '';
  int convertYear;

  int convertMonth;
  int convertDay;
  double dStart;
  double dEnd;
  double _lowerValue;
  double _upperValue;

  String startSelectTime = '';
  String endSelectTime = '';

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future initData() async {
    _selectedDay = DateTime.now();
    _events = {};
    _selectedEvents = _events[_selectedDay] ?? [];

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _controller.forward();

    //---------------------Drag----------------------------
    sectionTexts.add(
        SectionTextModel(position: 0, text: 'bad', progressColor: Colors.red));
    sectionTexts.add(SectionTextModel(
        position: 2, text: 'good', progressColor: Colors.yellow));
    sectionTexts.add(SectionTextModel(
        position: 4, text: 'great', progressColor: Colors.green));
    //---------------------初始化开始时间----------------------
    var now = new DateTime.now();
    print('初始化当前时间:${now}');
    List<String> convert = now.toString().split('-');
    convertYear = int.parse(convert[0]);
    convertMonth = int.parse(convert[1]);
    convertDay = int.parse(convert[2].substring(0, 2));
    print(
        '初始化时间:convertYear:${convertYear},convertMonth:${convertMonth},convertDay:${convertDay}');

    //线条的初始时间
    dStart = new DateTime(convertYear, convertMonth, convertDay, 7, 30)
        .millisecondsSinceEpoch
        .toDouble();
    dEnd = new DateTime(convertYear, convertMonth, convertDay, 19, 30)
        .millisecondsSinceEpoch
        .toDouble();
    print('这一天的开始时间为:${dStart},这一天的结束时间为:${dEnd}');

    if (DateTime.now().millisecondsSinceEpoch.toDouble() <
        DateTime(convertYear, convertMonth, convertDay, 7, 30)
            .millisecondsSinceEpoch) {
      _lowerValue = dStart;
    } else if (DateTime.now().millisecondsSinceEpoch.toDouble() > dEnd) {
      _lowerValue = dStart;
    } else {
      _lowerValue = DateTime.now().millisecondsSinceEpoch.toDouble();
    }
//
//    if (DateTime.now().millisecondsSinceEpoch.toDouble() >
//        DateTime(convertYear, convertMonth, convertDay, 19, 30)
//            .millisecondsSinceEpoch) {
//      _upperValue = dEnd;
//    } else {
//
//    }

    _upperValue = dEnd;
    print('_lowerValue:${_lowerValue},_upperValue:${_upperValue}');
  }

  bool isCalenderSelect = false;
  bool selectTimeCalender = false;

  void _onDaySelected(DateTime day, List events) {
    isCalenderSelect = true;
    selectTimeCalender = true;
    startSelectTime = '';
    endSelectTime = '';
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
    userSelectDay = day.toString().substring(0, 10);
    selectYear = userSelectDay.substring(0, 4);
    selectMonth = userSelectDay.substring(5, 7);
    selectDay = userSelectDay.substring(8, 10);
    //1.选择日历时间
    convertYear = int.parse(selectYear);
    convertMonth = int.parse(selectMonth);
    convertDay = int.parse(selectDay);

    //更新时间范围
    dStart = new DateTime(convertYear, convertMonth, convertDay, 7, 30)
        .millisecondsSinceEpoch
        .toDouble();
    dEnd = new DateTime(convertYear, convertMonth, convertDay, 19, 30)
        .millisecondsSinceEpoch
        .toDouble();

    _lowerValue = dStart;
    _upperValue = dEnd;

    startLong = dStart.toInt();
    endLong = dEnd.toInt();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择预约时间段'),
        centerTitle: true,
        elevation: 0,
        leading: _back(),
      ),
      backgroundColor: Color(0xffF7F7F7),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildTableCalendar(),
            _rangeTime(),
            _orderButton(),
          ],
        ),
      ),
    );
  }

  String getHour(double value) {
    var format = new DateFormat('yyyy/MM/dd HH:mm');
    var date = new DateTime.fromMillisecondsSinceEpoch(value.toInt());
    String time = format.format(date);
    String data = time.split(' ')[1];
    return data;
  }

  void onChangeData(newLowerValue, newUpperValue) {
    startLong = newLowerValue.toInt();
    endLong = newUpperValue.toInt();
    //获取用户选择的时间段
    startSelectTime = getHour(newLowerValue);
    endSelectTime = getHour(newUpperValue);

    List<String> startText = startSelectTime.split(':');
    int startHour = int.parse(startText[0]);
    int startMinits = int.parse(startText[1]);
//    print('当前的Hour:${startHour},Minits:${startMinits}');

    List<String> endText = endSelectTime.split(':');
    int endHour = int.parse(endText[0]);
    int endMinits = int.parse(endText[1]);
//    print('当前的Hour:${endHour},Minits:${endMinits}');

    startLong = new DateTime(
            convertYear, convertMonth, convertDay, startHour, startMinits)
        .millisecondsSinceEpoch
        .toDouble()
        .toInt();
    endLong =
        new DateTime(convertYear, convertMonth, convertDay, endHour, endMinits)
            .millisecondsSinceEpoch
            .toDouble()
            .toInt();
  }

  Widget _rangeTime() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(28),
          left: ScreenUtil().setWidth(31),
          right: ScreenUtil().setWidth(34)),
      height: ScreenUtil().setHeight(212),
      width: ScreenUtil().setWidth(685),
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(10),
          right: ScreenUtil().setWidth(10)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: EdgeInsets.only(top:ScreenUtil().setHeight(100)),
            width: ScreenUtil().setWidth(2500),
            child: Column(
              children: <Widget>[
                RangeSlider(
                  min: dStart,
                  max: dEnd,
                  lowerValue: _lowerValue,
                  upperValue: _upperValue,
                  divisions: 24,
                  showValueIndicator: true,
                  valueIndicatorMaxDecimals: 1,
                  valueIndicatorFormatter: (int index, double value) {
                    String data = getHour(value);
                    return '$data';
                  },
                  onChanged: (double newLowerValue, double newUpperValue) {
                    setState(() {
                      _lowerValue = newLowerValue;
                      _upperValue = newUpperValue;
                    });
                    onChangeData(newLowerValue, newUpperValue);
                  },
                  onChangeStart:
                      (double startLowerValue, double startUpperValue) {
                    print(
                        'Started with values: $startLowerValue and $startUpperValue');
                  },
                  onChangeEnd: (double newLowerValue, double newUpperValue) {
                    onChangeData(newLowerValue, newUpperValue);
                  },
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        '7:30',
                        style: TextStyle(
                            color: Color(0xff171717),
                            fontSize: ScreenUtil().setSp(26)),
                      ),
                    ),
//                    Expanded(
//                        flex: 1,
//                        child: Text(
//                          '${startSelectTime}',
//                          style: TextStyle(
//                              color: button_normal_color,
//                              fontSize: ScreenUtil().setSp(26)),
//                        )),
//                    Expanded(
//                        flex: 1,
//                        child: Text(
//                          '${endSelectTime}',
//                          style: TextStyle(
//                              color: button_normal_color,
//                              fontSize: ScreenUtil().setSp(26)),
//                        )),
                    Text(
                      '19:30',
                      style: TextStyle(
                          color: Color(0xff171717),
                          fontSize: ScreenUtil().setSp(26)),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  // 日历
  Widget _buildTableCalendar() {
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(28),
          ScreenUtil().setHeight(50), ScreenUtil().setWidth(32), 0),
      width: ScreenUtil().setWidth(690),
      height: ScreenUtil().setHeight(700),
      color: Colors.white,
      child: TableCalendar(
        initialCalendarFormat: CalendarFormat.month,
        locale: 'zh_CN',
        formatAnimation: FormatAnimation.slide,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableGestures: AvailableGestures.horizontalSwipe,
        headerStyle: HeaderStyle(
          centerHeaderTitle: true,
          formatButtonVisible: false,
        ),
        calendarStyle: CalendarStyle(
          selectedColor: Colors.blue[400],
          todayColor: Colors.orange[200],
          markersColor: Colors.brown[700],
        ),
        onDaySelected: _onDaySelected,
      ),
    );
  }

  //登陆按钮
  Widget _orderButton() {
    String btnName = '下一步';
    Color isClick = button_normal_color;
    return Container(
      margin: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(10), top: ScreenUtil().setHeight(60)),
      height: ScreenUtil().setHeight(90),
      width: ScreenUtil().setWidth(600),
      child: FlatButton(
        child: Text(
          btnName,
          style: TextStyle(fontSize: ScreenUtil().setSp(32)),
        ),
        color: button_normal_color,
        highlightColor: button_click_color,
        splashColor: Colors.transparent,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          isClick = button_click_color;

          if (startLong - DateTime.now().millisecondsSinceEpoch < 1800000) {
            Toast.show(context, '时间输入错误，必须提前30分钟预约!');
            return;
          }
          _saveData();

          _JudgeTimeFromServer(endLong, startLong);

          setState(() {
            isClick;
            print('按钮边框的颜色:${isClick}');
          });
        },
      ),
    );
  }

  void _JudgeTimeFromServer(endTime, startTime) {
    var formData = {"endTime": endTime, "startTime": startTime};
    seatRequest(context, 'getWorkSeat', formData: formData).then((val) {
      print('工位预定接收到的参数为:${val.toString()}');

      String data = val['msg'];
      if (data.contains('成功')) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => OrderAdvancePage()));
      } else if (data.contains('异常')) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => route == null);
        return;
      } else {
        Toast.show(context, data);
      }
    });
  }

  String starTime = '点击选择开始时间';
  String endTime = '点击选择结束时间';

  //开始时间和结束时间戳
  int startLong = 0;
  int endLong = 0;

  Widget _selectStartTimeButton() {
    String selectTime = '';
    int startHour;
    int startMin;
    int startMill;

    return FlatButton(
        onPressed: () {
          selectTimeCalender = false;
          if (convertDay == null || convertYear == null || convertDay == null) {
            Toast.show(context, '请先选择上面的日历!');
            return;
          }
          DatePicker.showTimePicker(context, showTitleActions: true,
              onChanged: (date) {
            print('change $date');
          }, onConfirm: (date) {
            print('confirm $date');
            selectTime = date.toString();
            setState(() {
              starTime = '${selectTime.toString().substring(11, 19)}';
              print('startTime:${starTime}');

              startHour = int.parse(starTime.substring(0, 2));
              startMin = int.parse(starTime.substring(3, 5));
              startMill = int.parse(starTime.substring(6, 8));
//              print(
//                  '当前时间为:${convertYear},${convertMonth},${convertDay},${startHour},${startMin},${startMill}');
              var now = new DateTime(convertYear, convertMonth, convertDay,
                  startHour, startMin, startMill);
//              print('起始时间为戳:${now.millisecondsSinceEpoch}');
              startLong = now.millisecondsSinceEpoch;
            });

            if (endTime.contains('时间')) {
              // 一秒以后将任务添加至event队列
              new Future.delayed(const Duration(seconds: 1), () {
                //任务具体代码
                print('isCalenderSelect:${isCalenderSelect}');
                if (isJump && !selectTimeCalender) {
                  //表示需要自动弹出结束时间
                  Toast.show(context, '请选择结束的时间!');
//              _selectEndTimeButton();
                  selectEndTime();
                }
              });
            }
          },
              currentTime:
                  DateTime(convertYear, convertMonth, convertDay, 07, 30, 00),
              locale: LocaleType.zh);
        },
        child: Text(
          '$starTime',
          style: TextStyle(color: Colors.blue),
        ));
  }

  String selectTime = '';
  int endHour;
  int endMin;
  int endMill;

  bool isJump = true; //是否自动弹出结束时间，true表示自动弹出，false表示不弹出。

  void selectEndTime() {
    DatePicker.showTimePicker(context, showTitleActions: true,
        onChanged: (date) {
      print('end time change : $date');
    }, onConfirm: (date) {
      print('end time confirm : $date');
      selectTime = date.toString();
      setState(() {
        endTime = '${selectTime.toString().substring(11, 19)}';
        print('endTime:${endTime}');
        endHour = int.parse(endTime.substring(0, 2));
        endMin = int.parse(endTime.substring(3, 5));
        endMill = int.parse(endTime.substring(6, 8));
//              print(
//                  '当前时间为:${convertYear},${convertMonth},${convertDay},${endHour},${endMin},${endMill}');
        var now = new DateTime(
            convertYear, convertMonth, convertDay, endHour, endMin, endMill);
        var lineTime =
            new DateTime(convertYear, convertMonth, convertDay, 19, 30, 0);
        var upTime =
            new DateTime(convertYear, convertMonth, convertDay, 7, 30, 0);
        endLong = now.millisecondsSinceEpoch;
        int currentTime = new DateTime.now().millisecondsSinceEpoch;
        if (startLong - currentTime < 1800000) {
          Toast.show(context, '时间输入错误，预定时间必须大于30分钟,请重新选择!');
          starTime = '点击选择开始时间';
          endTime = '点击选择结束时间';
          return;
        }
        if (endLong > lineTime.millisecondsSinceEpoch ||
            startLong < upTime.millisecondsSinceEpoch) {
          Toast.show(context, '预定座位必须在早7：30到晚7：30分!');
          starTime = '点击选择开始时间';
          endTime = '点击选择结束时间';
          return;
        }
        if (endLong - startLong < 1800000 || startLong == 0) {
          Toast.show(context, '时间输入错误，间隔时间必须大于30分钟,请重新选择!');
          starTime = '点击选择开始时间';
          endTime = '点击选择结束时间';
          return;
        }
        print('终止时间为戳:${now.millisecondsSinceEpoch}');
        _saveData();
      });
    },
        currentTime:
            DateTime(convertYear, convertMonth, convertDay, 19, 30, 00),
        locale: LocaleType.zh);
//    setState(() {
//      print('自动选择的结束时间为:${endTime}');
//      endTime;
//    });
  }

  Future _saveData() async {
    prefs = await SharedPreferences.getInstance();
    print('用户输入的开始时间为:${startLong},结束时间为:${endLong}');
    await prefs.setInt('endTime', endLong);
    await prefs.setInt('startTime', startLong);
  }
}
