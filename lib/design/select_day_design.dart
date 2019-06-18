import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectDayDesign extends StatefulWidget {
  final String day;

  SelectDayDesign(this.day);

  @override
  _SelectDayDesignState createState() => _SelectDayDesignState();
}

class _SelectDayDesignState extends State<SelectDayDesign> {
  Color bgColor;
  Color fontColor;
  int num;

  @override
  void initState() {
    bgColor = Colors.white;
    fontColor = Colors.grey;
    num = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(63),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          num = num + 1;
          if (num % 2 == 1) {
            fontColor = Colors.white;
            bgColor = Colors.blue;
          } else {
            bgColor = Colors.white;
            fontColor = Colors.grey;
          }
          print('点击了圆形按钮 .... ');

          setState(() {
            bgColor;
            fontColor;
            print('当前颜色为:${bgColor}');
          });
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(10),
                right: ScreenUtil().setWidth(10),
                top: ScreenUtil().setHeight(7),
                bottom: ScreenUtil().setHeight(10)),
            child: Text(
              widget.day,
              style: TextStyle(color: fontColor),
            )),
      ),
      decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(
              color: bgColor == Colors.blue ? Colors.blue : fontColor),
          borderRadius: BorderRadius.circular(1000)),
    );
  }
}
