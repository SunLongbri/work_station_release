import 'package:flutter/material.dart';
import 'package:work_station/pages/index_order_page.dart';
import 'package:work_station/pages/menu/ordermenu/current_work_seat.dart';

import '../colors.dart';
import 'index_me_page.dart';

//用户登陆之后的第一个界面，默认页面为预约界面
class IndexPage extends StatefulWidget {
  final currentIndex;

  IndexPage({Key key, this.title, this.currentIndex}) : super(key: key);

  final String title;

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int currentIndex;

  var currentPage;

  final List<Widget> tabBodies = [
    CurrentWorkSeat(),
    IndexOrderPage(),
    HomeMePage()
  ];

  @override
  void initState() {
    print('当前返回的页面为:${widget.currentIndex.toString()}');
    if (widget.currentIndex != null) {
      currentIndex = widget.currentIndex;
    } else {
      currentIndex = 0;
    }
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> bottomTabs = [
      BottomNavigationBarItem(
          activeIcon: Image.asset(
            'images/index_orical_click.png',
            width: 22,
            height: 22,
          ),
          icon: Image.asset(
            'images/index_orical.png',
            width: 22,
            height: 22,
          ),
          title: Text("空间")),
      BottomNavigationBarItem(
          activeIcon: Image.asset(
            'images/home_order_select.png',
            width: 22,
            height: 22,
          ),
          icon: Image.asset(
            'images/home_order_unselected.png',
            width: 22,
            height: 22,
          ),
          title: Text("预约")),
      BottomNavigationBarItem(
          activeIcon: Image.asset(
            'images/home_me_selected.png',
            width: 22,
            height: 22,
          ),
          icon: Image.asset('images/home_order_me.png', width: 22, height: 22),
          title: Text("我的")),
    ];

    return Scaffold(
      backgroundColor: home_background_color,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
}
