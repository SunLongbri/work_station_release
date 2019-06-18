import 'package:flutter/material.dart';

class MqttPublisher with ChangeNotifier {
  String val = '';

  publicMessage(String msg) {
    val = msg;
    notifyListeners();
  }

  bool publish = false;

  havePublish(bool flag) {
    publish = flag;
    notifyListeners();
  }
}
