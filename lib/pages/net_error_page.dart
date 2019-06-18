import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_station/helpclass/Utils.dart';

class NetErrorPage extends StatefulWidget {
  @override
  _NetErrorPageState createState() => _NetErrorPageState();
}

class _NetErrorPageState extends State<NetErrorPage> {
  Widget _back() {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(40),
          height: ScreenUtil().setHeight(40),
          child: Image.asset(
            'images/back.png',
            height: ScreenUtil().setHeight(30),
            fit: BoxFit.fitHeight,
          ),
        ));
  }

  @override
  void initState() {
    Utils.errorNumber++;

    super.initState();
    print('错误提示页数:${Utils.errorNumber}');
    if (Utils.errorNumber >= 2) {
      print('不再进入网络错误页面:${Utils.errorNumber}');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: _back(),
        elevation: 0,
        title: Text(
          '加载失败',
          style:
              TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(34)),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(1000),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            _icon(),
            _errortext(),
            _refreshtext(),
          ],
        ),
      ),

    );
  }

  Widget _icon() {
    return Container(
      child: Image.asset(
        'images/net_work_error.png',
        width: ScreenUtil().setWidth(150),
        height: ScreenUtil().setHeight(150),
      ),
    );
  }

  Widget _errortext() {
    return Container(
      child: Text(
        '数据获取失败，请检查网络 ... ',
        style: TextStyle(
            color: Color(0xFF999999), fontSize: ScreenUtil().setSp(34)),
      ),
    );
  }

  Widget _refreshtext() {
    return InkWell(
      onTap: () {
        print('用户点击了刷新页面 ..... ');
        Navigator.pop(context);
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        child: Text(
          '点击重新加载',
          style: TextStyle(
              color: Color(0xFF1792E5), fontSize: ScreenUtil().setSp(32)),
        ),
      ),
    );
  }
}
