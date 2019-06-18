import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LightingCalendarCard extends StatefulWidget {
  @override
  _LightingCalendarCardState createState() => _LightingCalendarCardState();
}

class _LightingCalendarCardState extends State<LightingCalendarCard> {
  //是否展开卡片，true表示展开，false表示关闭
  bool isExtend = false;

  //单个日历详情卡片
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(750),
      child: _singleWidgetCart(),
    );
  }

  Widget _singleWidgetCart() {
    print('isExtend:${isExtend}');
    return Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
        width: ScreenUtil().setWidth(670),
        child: ExpansionTile(
          backgroundColor: Colors.white,
          initiallyExpanded: isExtend,
          title: _titleWidget(),
          onExpansionChanged: (bool) {
            print('当前的状态:${bool}');
            setState(() {
              isExtend = bool;
            });
          },
          trailing: Container(
            child: Column(
              children: <Widget>[
                Switch(
                  value: switchOn,
                  onChanged: (newValue) {
                    setState(() {
                      switchOn = newValue;
                    });
                  },
                  activeColor: Color(0xFF1792E5),
                  activeTrackColor: Color(0x261792E5),
                  inactiveThumbColor: Color(0xFFCCCCCC),
                  inactiveTrackColor: Color(0x50CCCCCC),
                ),
                isExtend
                    ? Container(
                        width: 1,
                        height: 1,
                      )
                    : Image.asset(
                        'images/arrow_down.png',
                        width: ScreenUtil().setWidth(22),
                        height: ScreenUtil().setHeight(12),
                      ),
              ],
            ),
          ),
          children: <Widget>[
            ListTile(
                title: Container(
                  width: ScreenUtil().setWidth(670),
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(34)),
                    child: Text(
                      '   灯  name3 name3 name3',
                      style: TextStyle(
                          color: Colors.grey, fontSize: ScreenUtil().setSp(26)),
                    ),
                  ),
                ),
                subtitle: Container(
                  width: ScreenUtil().setWidth(670),
                  height: ScreenUtil().setHeight(80),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: new FractionalOffset(0.0, 0.0),
                        child: Container(
                          width: ScreenUtil().setWidth(670),
                          height: ScreenUtil().setHeight(1),
                          color: Color(0xFFDADADA),
                        ),
                      ),
                      Align(
                        child: InkWell(
                          onTap: () {
                            print('点击了删除按钮 ... ');
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(50),
                            height: ScreenUtil().setHeight(50),
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(8),
                                right: ScreenUtil().setWidth(8),
                                top: ScreenUtil().setHeight(8),
                                bottom: ScreenUtil().setHeight(8)),
                            child: Image.asset(
                              'images/lighting_delete.png',
                              width: ScreenUtil().setWidth(34),
                              height: ScreenUtil().setHeight(34),
                            ),
                          ),
                        ),
                        alignment: new FractionalOffset(0.0, 0.5),
                      ),
                      Align(
                        child: InkWell(
                          onTap: () {
                            print('点击了向上的箭头');
//                            setState(() {
//                              isExtend = false;
//                            });
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(50),
                            height: ScreenUtil().setHeight(50),
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(10),
                                right: ScreenUtil().setWidth(10),
                                top: ScreenUtil().setHeight(19),
                                bottom: ScreenUtil().setHeight(19)),
                            child: Image.asset(
                              'images/arrow_up.png',
                              width: ScreenUtil().setWidth(22),
                              height: ScreenUtil().setHeight(12),
                            ),
                          ),
                        ),
                        alignment: new FractionalOffset(0.93, 0.5),
                      ),
                    ],
                  ),
                ))
          ],
        ),
        decoration: isExtend
            ? BoxDecoration(
                color: Colors.white,
                border: Border(
                  left: BorderSide(color: Color(0xFFE6E6E6)),
                  right: BorderSide(color: Color(0xFFE6E6E6)),
                ))
            : BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
                border: Border(
                  left: BorderSide(color: Color(0xFFE6E6E6)),
                  right: BorderSide(color: Color(0xFFE6E6E6)),
                  top: BorderSide(color: Color(0xFFE6E6E6)),
                  bottom: BorderSide(color: Color(0xFFE6E6E6)),
                )));
  }

  bool switchOn = true;

  //单个日历的标题
  Widget _titleWidget() {
    return Container(
      height: ScreenUtil().setHeight(165),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '定时 11：25：56-4:20:40',
            style: TextStyle(
                color: Colors.black, fontSize: ScreenUtil().setSp(32)),
          ),
          Container(
            width: ScreenUtil().setWidth(670),
            child: Text(
              '重复  日 一 二 三 四 五 ',
              style: TextStyle(
                  color: Colors.grey, fontSize: ScreenUtil().setSp(26)),
            ),
          ),
        ],
      ),
    );
  }
}
