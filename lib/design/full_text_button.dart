import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

class FullTextButton extends StatefulWidget {
  final double buttonWidth;
  final double buttonHeight;
  final double buttonMarginLeft;
  final double buttonMarginTop;
  final double buttonMarginRight;
  final double buttonMarginBottom;

  FullTextButton({
    this.buttonWidth,
    this.buttonHeight,
    this.buttonMarginLeft,
    this.buttonMarginTop,
    this.buttonMarginRight,
    this.buttonMarginBottom,
  });

  @override
  _FullTextButtonState createState() => _FullTextButtonState();
}

class _FullTextButtonState extends State<FullTextButton> {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      margin: EdgeInsets.only(
          left: buttonMarginLeft,
          top: buttonMarginTop,
          right: buttonMarginRight,
          bottom: buttonMarginBottom),
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: button_click_color,
        child: Text(
          '确定',
          style: TextStyle(color: Colors.white,
              fontSize: ScreenUtil().setSp(32), fontWeight: FontWeight.w500),
        ),
        onPressed: () {
          print('点击了确定按钮 ... ');
        },
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5.0)),
        color: button_normal_color,
        disabledColor: button_click_color,
      ),
    );
  }
}
