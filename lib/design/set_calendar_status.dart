import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//设置日历界面，设置状态的按钮
class SetCalendarStatus extends StatefulWidget {
  final String lightingStatusImageUrl;

  SetCalendarStatus(this.lightingStatusImageUrl);

  @override
  _SetCalendarStatusState createState() => _SetCalendarStatusState();
}

class _SetCalendarStatusState extends State<SetCalendarStatus> {
  String lightingStatusImageUrl = 'images/lighting_radio_on.png';
  bool isOn = true;

  @override
  void initState() {
    lightingStatusImageUrl = widget.lightingStatusImageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _singleCheckBox();
  }

  Widget _singleCheckBox() {
    return Container(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: (){
              setState(() {
                isOn = !isOn;
              });
            },
            child: Column(
              children: <Widget>[
                Image.asset(
                  isOn
                      ? 'images/lighting_radio_on.png'
                      : 'images/lighting_radio_off.png',
                  width: ScreenUtil().setWidth(65),
                  height: ScreenUtil().setHeight(65),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(2)),
                  child: Text('ON'),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                isOn = !isOn;
              });
            },
            child: Column(
              children: <Widget>[
                Image.asset(
                  isOn
                      ? 'images/lighting_radio_off.png'
                      : 'images/lighting_radio_on.png',
                  width: ScreenUtil().setWidth(65),
                  height: ScreenUtil().setHeight(65),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(2)),
                  child: Text("OFF"),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
