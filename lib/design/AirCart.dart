import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AirCard extends StatefulWidget {
  //卡片的图标
  final cartIcon;

  //卡片中的哪个区
  final cartArea;

  //卡片中哪个区下方的文字
  final cartAreaTemper;

  //卡片中右侧显示的温度
  final cartBigTemper;

  //卡片中空调的模式
  final cartModel;

  //卡片的背景
  final cartBgUrl;

  final cardOnTap;

  AirCard(this.cartIcon,
      this.cartArea,
      this.cartAreaTemper,
      this.cartBigTemper,
      this.cartModel,
      this.cartBgUrl,
      this.cardOnTap,);

  @override
  _AirCardState createState() => _AirCardState();
}

class _AirCardState extends State<AirCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(15),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[InkWell(
            onTap:widget.cardOnTap,
            child: _SingleAirCard(),
          )
          ],
        ));
  }

  Widget _SingleAirCard() {
    return Stack(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(690),
          height: ScreenUtil().setHeight(226),
          child: Image.asset(widget.cartBgUrl),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(77),
              left: ScreenUtil().setWidth(28),
              bottom: ScreenUtil().setHeight(73)),
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(76),
          child: Image.asset(widget.cartIcon),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(72),
              left: ScreenUtil().setWidth(153)),
          child: Text(
            widget.cartArea,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(30), color: Colors.white),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(125),
              left: ScreenUtil().setWidth(153)),
          child: Text(
            widget.cartAreaTemper,
            style: TextStyle(
                color: Colors.white, fontSize: ScreenUtil().setSp(30)),
          ),
        ),
        Container(
//          color: Colors.white30,
          margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(42),
            left: ScreenUtil().setWidth(420),
          ),
          child: Row(
//            crossAxisAlignment: CrossAxisAlignment.,
            children: <Widget>[
              Text(
                widget.cartBigTemper,
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(98)),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                child: Text(
                  '°c',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(60)),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(460),
              top: ScreenUtil().setHeight(139)),
          child: Row(
            children: <Widget>[
              Text(
                widget.cartModel,
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(26)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AirCartClose extends StatefulWidget {
  //卡片的图标
  final cartIcon;

  //卡片中的哪个区
  final cartArea;

  //卡片中哪个区下方的文字
  final cartAreaTemper;

  final btnClose;

  //卡片的背景
  final cartBgUrl;

  AirCartClose(this.cartIcon,
      this.cartArea,
      this.cartAreaTemper,
      this.btnClose,
      this.cartBgUrl,);

  @override
  _AirCartCloseState createState() => _AirCartCloseState();
}

class _AirCartCloseState extends State<AirCartClose> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(15),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[_A_FirstFloor()],
        ));
  }

  Widget _A_FirstFloor() {
    return Stack(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(690),
          height: ScreenUtil().setHeight(226),
          child: Image.asset(widget.cartBgUrl,),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(77),
              left: ScreenUtil().setWidth(28),
              bottom: ScreenUtil().setHeight(73)),
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(76),
          child: Image.asset(widget.cartIcon),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(72),
              left: ScreenUtil().setWidth(153)),
          child: Text(
            widget.cartArea,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(30), color: Colors.white),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(125),
              left: ScreenUtil().setWidth(153)),
          child: Text(
            widget.cartAreaTemper,
            style: TextStyle(
                color: Colors.white, fontSize: ScreenUtil().setSp(30)),
          ),
        ),
        Container(
//          color: Colors.white30,
          margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(60),
            left: ScreenUtil().setWidth(538),
          ),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: widget.btnClose,
                child: Image.asset(
                  'images/air_btn.png',
                  width: ScreenUtil().setWidth(84),
                  height: ScreenUtil().setHeight(84),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              child:Text('未开启',style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(30)),),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
