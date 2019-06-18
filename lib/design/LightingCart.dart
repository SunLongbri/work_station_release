import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_station/colors.dart';

class LightingCart extends StatefulWidget {
  //点击事件
  final onTap;

  final deviceName;

  //Lighting是哪个插座类型
  final iconUrl;

  LightingCart(this.onTap, this.deviceName, this.iconUrl);

  @override
  _LightingCartState createState() => _LightingCartState();
}

class _LightingCartState extends State<LightingCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(32), right: ScreenUtil().setWidth(32)),
      child: Column(
        children: <Widget>[
          _lightingCart(),
          _lightingLine(),
        ],
      ),
    );
  }

  //卡片整体布局
  Widget _lightingCart() {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _lightingIcon(),
          Expanded(
            flex: 1,
            child: _lightingContent(),
          ),
          _lightingWiFiIcon(),
          _lightingBackIcon(),
        ],
      ),
    );
  }

  //Lighting 前面的图标
  Widget _lightingIcon() {
    return Container(
      width: ScreenUtil().setWidth(74),
      height: ScreenUtil().setHeight(74),
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(41),
          right: ScreenUtil().setWidth(20),
          bottom: ScreenUtil().setHeight(33)),
      child: Image.asset(widget.iconUrl),
    );
  }

  //Lighting中部的内容
  Widget _lightingContent() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(7)),
      height: ScreenUtil().setHeight(74),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //横向向左对齐
//        mainAxisAlignment: MainAxisAlignment.center, //竖直水平对齐
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _lightingNameDetail(),
          Text(
            '70% 24℃ 2000mA',
            style:
                TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(22)),
          ),
        ],
      ),
    );
  }

  //Lighting的名称和当前的用量
  Widget _lightingNameDetail() {
    return Row(
      children: <Widget>[
        Text(
          widget.deviceName,
          style:
              TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(28)),
        ),
        Container(
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
          width: ScreenUtil().setWidth(156),
          height: ScreenUtil().setHeight(35),
          alignment: Alignment.center,
          child: Text(
            '用量达2000mA',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(20), color: Colors.orange),
          ),
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.orange, width: ScreenUtil().setWidth(1)),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ],
    );
  }

  //Lighting的WiFi信号强度图标
  Widget _lightingWiFiIcon() {
    return Container(
      width: ScreenUtil().setWidth(29),
      height: ScreenUtil().setHeight(21),
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(26)),
      child: Image.asset('images/lighting_list_wifi_level4.png'),
    );
  }

  //Lighting的返回按钮
  Widget _lightingBackIcon() {
    return Container(
      width: ScreenUtil().setWidth(14),
      height: ScreenUtil().setHeight(22),
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(23)),
      child: Image.asset('images/lighting_list_back.png'),
    );
  }

  //卡片下的灰色细线
  Widget _lightingLine() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(1),
      color: lighting_color,
    );
  }
}
