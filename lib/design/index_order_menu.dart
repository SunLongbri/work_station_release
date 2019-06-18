import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderMenu extends StatefulWidget {
  final onTap;
  final String iconUrl;
  final String menuName;

  OrderMenu(this.onTap, this.iconUrl, this.menuName);

  @override
  _OrderMenuState createState() => _OrderMenuState();
}

class _OrderMenuState extends State<OrderMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(36),
          ScreenUtil().setHeight(43), ScreenUtil().setWidth(34), 0),
      decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Color(0xffeeeeee))),
      height: ScreenUtil().setHeight(100),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Image.asset(
                  widget.iconUrl,
                  height: 22,
                  width: 22,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    widget.menuName,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(50)),
                child: Image.asset(
                  'images/home_arrow.png',
                  height: 16,
                  width: 9,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
