import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//设置日历的灯控按钮
class SetCalendarLighting extends StatefulWidget {
  final String lightingImageUrl;

  SetCalendarLighting(this.lightingImageUrl);

  @override
  _SetCalendarLightingState createState() => _SetCalendarLightingState();
}

class _SetCalendarLightingState extends State<SetCalendarLighting> {
  String lightingImageUrl;

  @override
  void initState() {
    lightingImageUrl = 'images/lighting_switch_on.png';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _singleSwitch();
  }

  Widget _singleSwitch() {
    return InkWell(
      onTap: () {
        setState(() {
          if (lightingImageUrl.contains('on')) {
            lightingImageUrl = 'images/lighting_switch_off.png';
          } else {
            lightingImageUrl = 'images/lighting_switch_on.png';
          }
          print('lightingImageUrl:${lightingImageUrl}');
        });
      },
      child: Container(
        width: ScreenUtil().setWidth(123),
        height: ScreenUtil().setHeight(160),
        child: Column(
          children: <Widget>[
            Image.asset(
              lightingImageUrl,
              width: ScreenUtil().setWidth(123),
              height: ScreenUtil().setHeight(123),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(2)),
              child: Text(
                'name1',
                style: TextStyle(
                    color: lightingImageUrl.contains('on')
                        ? Colors.blue
                        : Color(0xFFB3B2B2),
                    fontSize: ScreenUtil().setSp(30)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
