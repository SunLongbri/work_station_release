import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_station/helpclass/Toast.dart';

import '../colors.dart';

class OvalTextButton extends StatefulWidget {
  final double buttonWidth;
  final double buttonHeight;
  final double buttonMarginLeft;
  final double buttonMarginTop;
  final double buttonMarginRight;
  final double buttonMarginBottom;

  OvalTextButton({
    this.buttonWidth,
    this.buttonHeight,
    this.buttonMarginLeft,
    this.buttonMarginTop,
    this.buttonMarginRight,
    this.buttonMarginBottom,
  });

  @override
  _OvalTextButtonState createState() => _OvalTextButtonState();
}

class _OvalTextButtonState extends State<OvalTextButton> {
  Color clickColor = sun_normal_color;
  double buttonWidth;
  double buttonHeight;
  double buttonMarginLeft;
  double buttonMarginTop;
  double buttonMarginRight;
  double buttonMarginBottom;

  @override
  void initState() {
    buttonWidth = widget.buttonWidth == null ? 10 : widget.buttonWidth;
    buttonHeight = widget.buttonHeight == null ? 10 : widget.buttonHeight;
    buttonMarginLeft =
        widget.buttonMarginLeft == null ? 1 : widget.buttonMarginLeft;
    buttonMarginTop =
        widget.buttonMarginTop == null ? 1 : widget.buttonMarginTop;
    buttonMarginRight =
        widget.buttonMarginRight == null ? 1 : widget.buttonMarginRight;
    buttonMarginBottom =
        widget.buttonMarginBottom == null ? 1 : widget.buttonMarginBottom;
    clickColor = button_normal_color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
//      onDoubleTap: _onDoubleTap,
      onTapUp: _handleTapUp,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        alignment: Alignment.center,
        margin: EdgeInsets.only(
            left: buttonMarginLeft,
            top: buttonMarginTop,
            right: buttonMarginRight,
            bottom: buttonMarginBottom),
        child: Text(
          '取消',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              color: clickColor,
              fontWeight: FontWeight.w500),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.white,
          border:
              Border.all(color: clickColor, width: ScreenUtil().setWidth(2)),
        ),
      ),

      onTap: () {
        print('按钮的点击事件 ... ');
      },
    );
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      clickColor = Colors.grey;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      clickColor = button_normal_color;
    });
  }

  void _handleTapCancel() {
    setState(() {});
  }

  void _onDoubleTap() {
    setState(() {
      Toast.show(context, '点击了两下!');
    });
  }
}
