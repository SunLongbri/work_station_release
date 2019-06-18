import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AirControlBtn extends StatefulWidget {
  //点击之前的图片
  final normalUrl;

  //点击之后的图片
  final clickUrl;

  //按钮当前的颜色
  final btnUrl;

  final onTap;

  AirControlBtn(this.normalUrl, this.clickUrl, this.btnUrl, this.onTap);

  @override
  _AirControlBtnState createState() => _AirControlBtnState();
}

class _AirControlBtnState extends State<AirControlBtn> {
  String normalBtnUrl;

  String clickBtnUrl;

  String btnUrl;

  @override
  void initState() {
    normalBtnUrl = widget.normalUrl;
    clickBtnUrl = widget.clickUrl;
    btnUrl = widget.btnUrl;
    print('initState--->接收到的参数btnUrl:${btnUrl}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
        print('initState--->接收到的参数btnUrl:${btnUrl}');
        setState(() {
          print('开始更改按钮颜色  ......   ');
          btnUrl = widget.btnUrl;
          print("更改之后的按钮URL:${btnUrl}");
        });
      },
      child: Column(
        children: <Widget>[
          Image.asset(
            btnUrl,
            width: ScreenUtil().setWidth(108),
            height: ScreenUtil().setHeight(108),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(7),
            ),
            child: Text(
              '制冷',
              style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Color(0xFFB1B1B1)),
            ),
          ),
        ],
      ),
    );
  }
}
