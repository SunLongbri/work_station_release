import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_station/colors.dart';
import 'package:work_station/helpclass/Toast.dart';

class SunButton extends StatefulWidget {
  final onTap;
  final sunName;

  SunButton({Key key, this.onTap, this.sunName}) : super(key: key);

  @override
  _SunButtonState createState() => _SunButtonState();
}

class _SunButtonState extends State<SunButton> {
  Color clickColor = sun_normal_color;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      clickColor = sun_click_color;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      clickColor = sun_normal_color;
    });
  }

  void _handleTapCancel() {
    setState(() {});
  }

  void _onDoubleTap() {
    setState(() {
      Toast.show(context,'点击了两下!');
    });
  }

//  void _handleTap() {
//    widget.onChanged(!widget.active);
//  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
//      onDoubleTap: _onDoubleTap,
      onTapUp: _handleTapUp,

      child: Container(
        width: ScreenUtil().setWidth(600),
        height: ScreenUtil().setHeight(85),
        alignment: Alignment.center,
        margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(76), right: ScreenUtil().setWidth(74)),
        child: Text(
          widget.sunName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(32), color: clickColor, fontWeight: FontWeight.w500),
        ),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: clickColor,
              spreadRadius: 0.5,
              offset: Offset(0.1, 0.1),
            ),
          ],
        ),
      ),
//      decoration:BoxDecoration(),
//      highlightColor: Colors.white,
//      splashFactory: InkSplash.splashFactory,
//      borderRadius: BorderRadius.circular(5),
      onTap: widget.onTap,
    );
  }
}

class HeavenButton extends StatefulWidget {
  final onTap;
  final heavenName;
  final buttonWidth;
  final buttonHeight;
  final marginTop;
  final marginLeft;
  final marginRight;
  final marginBottom;

  HeavenButton(
      {Key key,
      this.onTap,
      this.heavenName,
      this.buttonWidth,
      this.buttonHeight,
      this.marginTop,
      this.marginLeft,
      this.marginRight,
      this.marginBottom})
      : super(key: key);

  @override
  _HeavenButtonState createState() => _HeavenButtonState();
}

class _HeavenButtonState extends State<HeavenButton> {
  Color isClick = button_normal_color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.buttonWidth,
//          widget.buttonWidth ? widget.buttonWidth : ScreenUtil().setWidth(600),
      height: widget.buttonHeight,
//          widget.buttonHeight ? widget.buttonHeight : ScreenUtil().setWidth(90),
      margin: EdgeInsets.only(
        top: widget.marginTop,
//              ? widget.marginTop : ScreenUtil().setHeight(50),
        right: widget.marginRight,
//              ? widget.marginRight
//              : ScreenUtil().setHeight(50),
        bottom: widget.marginBottom,
//              ? widget.marginBottom
//              : ScreenUtil().setHeight(50),
        left: widget.marginLeft,
      ),
//              ? widget.marginLeft
//              : ScreenUtil().setHeight(50)),
      child: FlatButton(
          child: Text(
            widget.heavenName,
            style: TextStyle(fontSize: ScreenUtil().setSp(32)),
          ),
          color: button_normal_color,
          highlightColor: button_click_color,
          splashColor: Colors.transparent,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8)),
          onPressed: widget.onTap),
    );
  }
}
