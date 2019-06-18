import 'package:flutter/material.dart';

class SelectDayCustom extends StatefulWidget {
  @override
  _SelectDayCustomState createState() => _SelectDayCustomState();
}

class _SelectDayCustomState extends State<SelectDayCustom> {
  Color bgColor;
  Color fontColor;
  int num;

  @override
  void initState() {
    bgColor = Colors.grey;
    fontColor = Colors.white;
    num = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
        width: 88.0,
        height: 88.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.red,
          borderRadius: BorderRadius.circular(10.0),
        ));
  }
}
