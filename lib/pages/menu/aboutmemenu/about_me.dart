import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_station/helpclass/Utils.dart';

class AboutMePage extends StatefulWidget {
  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
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
        elevation: 0,
        leading: _back(),
        title: Text(
          '关于软件',
          style:
              TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(34)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _version(),
            _line(),
            _refreshtext(),
            _line(),
          ],
        ),
      ),
    );
  }

  Widget _version() {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(60),
          right: ScreenUtil().setWidth(60),
          top: ScreenUtil().setHeight(80)),
      width: ScreenUtil().setWidth(750),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              '版本号',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(35), color: Colors.grey),
            ),
          ),
          Text(
            'V 1.0',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(30), color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(1),
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(20), left: ScreenUtil().setWidth(60), right: ScreenUtil().setWidth(60)),
      color: Colors.grey,
    );
  }

  Widget _refreshtext() {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(60),
          right: ScreenUtil().setWidth(60),
          top: ScreenUtil().setHeight(60)),
      width: ScreenUtil().setWidth(750),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              '检测更新',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(35), color: Colors.grey),
            ),
          ),
          Text(
            '已是最新版本',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(30), color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
