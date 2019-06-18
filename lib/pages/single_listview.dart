import 'package:flutter/material.dart';

class SingleListView extends StatefulWidget {
  @override
  _SingleListViewState createState() => _SingleListViewState();
}

class _SingleListViewState extends State<SingleListView> {
  @override
  Widget build(BuildContext context) {
    return _singleOrderMark();
  }
}


//单个预约条目样式
Widget _singleOrderMark() {
  return Container(
    margin: EdgeInsets.fromLTRB(16, 22, 16, 10),
    width: 345,
    height: 117,
    child: Column(
      children: <Widget>[
        _singleTitle(),
        _singleThrought(),
        _singleAddressTime(),
      ],
    ),
  );
}

  //单个预约条目的标题
  Widget _singleTitle() {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(13, 0, 119, 0),
            child: Text(
              '地点：仁和楼视频会议室',
              style: TextStyle(fontSize: 14, color: Color(0xff808080)),
            ),
          ),
          Image.asset(
            'images/order_mark_allow.png',
            height: 42,
            width: 42,
          ),
        ],
      ),
    );
  }

  //单个预约条目的灰色细线
  Widget _singleThrought() {
    return Container(
      width: 345,
      height: 1,
      color: Color(0xffEEEEEE),
    );
  }

  Widget _singleAddressTime() {
    return Container(
      alignment: Alignment.topLeft,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(14, 16, 150, 8),
            child: Text(
              '位置:高中部仁和楼302室',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14, 0, 115, 13),
            child: Text(

              '时间：2019-03-12 10:00-12:00',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

