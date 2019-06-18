import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_station/design/lighting_calendar_card.dart';

import '../../../colors.dart';
import 'lighting_setcalendar_page.dart';

class LookCalendarPage extends StatefulWidget {
  @override
  _LookCalendarPageState createState() => _LookCalendarPageState();
}

class _LookCalendarPageState extends State<LookCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: work_station_prime_color,
        leading: _back(),
        title: Text(
          '查看日历',
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
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(1180),
          child: Stack(
            children: <Widget>[
              ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return LightingCalendarCard();
                  }),
              Align(
                alignment: FractionalOffset(0.5, 0.98),
                child: FloatingActionButton(
                  backgroundColor: Color(0xFF1792E5),
                    child: Icon(
                      Icons.add,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LightingSetCalendarPage()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
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
}
